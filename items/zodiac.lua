SMODS.ConsumableType {
    key = "bpm_zodiac",
    default = "c_bpm_gemini",
    shop_rate = 1,
    collection_rows = { 4, 4, 4 },
    primary_colour = G.C.YELLOW,
    secondary_colour = G.C.PURPLE
}

-- Aries
SMODS.Consumable {
    key = "aries",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    config = {
        extra = {
            hands = 2
        }
    },

    can_use = function(self, card)
        if G.GAME.zodiac_aries then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac_aries = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_aries",
            skip_materialize = true,
            no_edition = true
        })
        TextPopup("Aries", G.C.BLUE, card)
    end
}

SMODS.Voucher {
    key = "aries",
    unlocked = false,
    discovered = false,
    no_collection = true,
    in_pool = function(self, args)
        return false, {
            allow_duplicates = false
        }
    end,
    calculate = function(self, card, context)
        if context.debuff_hand then
            if G.GAME.zodiac_aries and G.GAME.current_round.hands_played == 0 then
                if context.scoring_name ~= "High Card" then
                    return {
                        debuff = true,
                        debuff_text = "Must play a High Card."
                    }
                end
            end
        end
    end
}

-- Taurus
SMODS.Consumable {
    key = "taurus",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac_taurus then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac_taurus = true
        local ncard = SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_taurus",
            skip_materialize = true,
            no_edition = true
        })
        TextPopup("Taurus", G.C.RED, card)
    end
}

SMODS.Voucher {
    key = "taurus",
    unlocked = false,
    discovered = false,
    no_collection = true,
    in_pool = function(self, args)
        return false, {
            allow_duplicates = false
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            return { xblindsize = 2 }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return 10, {
            text = "Taurus"
        }
    end
}


-- Gemini
SMODS.Consumable {
    key = "gemini",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            joker_slots = 1,
            consum_slots = 2
        }
    },
    can_use = function(self, card)
        if G.GAME.zodiac_gemini then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        if G.jokers then
            if G.jokers.config.card_limit > 0 then
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
            end
        end

        if G.consumeables then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consum_slots
        end

        TextPopup("Gemini", G.C.YELLOW, card)
    end
}
