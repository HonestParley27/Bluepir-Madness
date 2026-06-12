SMODS.ConsumableType {
    key = "bpm_zodiac",
    default = "c_bpm_gemini",
    shop_rate = 0,
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
        if G.GAME.zodiac.aries then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.aries = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_aries",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Aries", G.C.RED, card)
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
            if G.GAME.current_round.hands_played == 0 then
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
        if G.GAME.zodiac.taurus then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.taurus = true
        local ncard = SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_taurus",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Taurus", G.C.GREEN, card)
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
        if G.GAME.zodiac.gemini then
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

        BPMadness.TextPopup("Gemini", G.C.YELLOW, card)
    end
}

SMODS.Consumable {
    key = "cancer",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac.cancer then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.cancer = true
        G.E_MANAGER:add_event(Event({
            func = function()
                local ncard = SMODS.add_card({
                    set = "Joker",
                    area = G.jokers,
                    key = "j_mr_bones",
                    edition = "e_negative",
                    allow_duplicates = true,
                    skip_materialize = true
                })
                ncard:juice_up(0.6, 0.1)
                return true
            end
        }))
        BPMadness.TextPopup("Cancer", G.C.BLUE, card)
    end
}

SMODS.Consumable {
    key = "leo",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac.leo then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.leo = true
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_leo",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Leo", G.C.ORANGE, card)
    end
}

SMODS.Voucher {
    key = "leo",
    unlocked = true,
    discovered = false,
    no_collection = true,
    config = {
        extra = {
            xmult = 3
        }
    },
    calculate = function(self, card, context)
        if context.debuff_card then
            if context.debuff_card.base.id and context.debuff_card.base.id < 11 and context.debuff_card.config.center.key ~= "m_stone" then
                return {
                    debuff = true
                }
            end
        end

        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card.base.id >= 11 and context.other_card.base.id <= 13 then
                return {
                    xmult = self.config.extra.xmult
                }
            end
        end
    end
}

SMODS.Consumable {
    key = "virgo",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac.virgo then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.virgo = true
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_virgo",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Virgo", HEX('8d6238'), card)
    end
}

SMODS.Voucher {
    key = "virgo",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calculate = function(self, card, context)
        if context.discard then
            return {
                dollars = -1
            }
        end
        if context.initial_scoring_step then
            return {
                mult = #G.deck.cards
            }
        end
    end
}

SMODS.Consumable {
    key = "libra",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            hands = 1,
            discards = 1
        }
    },
    can_use = function(self, card)
        if G.GAME.zodiac.libra then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.libra = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_libra",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Libra", HEX('ff7aac'), card)
    end
}

SMODS.Voucher {
    key = "libra",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                balance = true
            }
        end
    end
}

SMODS.Consumable {
    key = "scorpius",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac.scorpius then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.scorpius = true -- For the record; Tried 'G.GAME.current_round.most_played_poker_hand' but it would always return High Card
        local selectedHand = BPMadness.mostUsedPokerHand(G.GAME.hand_usage)

        level_up_hand(card, selectedHand, false, 5)
        G.GAME.zodiac.scorpius_hand = selectedHand
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_scorpius",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Scorpius", G.C.DARK_EDITION, card)
    end
}

SMODS.Voucher {
    key = "scorpius",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calculate = function(self, card, context)
        if context.debuff_hand then
            if context.scoring_name ~= G.GAME.zodiac.scorpius_hand then
                return {
                    debuff = true,
                    debuff_text = ("Must play " .. G.GAME.zodiac.scorpius_hand)
                }
            end
        end
    end
}

SMODS.Consumable {
    key = "sagittarius",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac.sagittarius then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.sagittarius = true
        G.hand:change_size(-2)
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_sagittarius",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Sagittarius", G.C.PURPLE, card)
    end
}

SMODS.Voucher {
    key = "sagittarius",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = 1,
                denominator = 1
            }
        end
    end
}

SMODS.Consumable {
    key = "capricornus",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },
    can_use = function(self, card)
        if G.GAME.zodiac.capricornus then
            return false
        end
        if not G.jokers then
            return false
        end
        if G.jokers and #G.jokers.cards < 1 then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.capricornus = true
        local total_sell = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].ability.eternal then
                    total_sell = total_sell + G.jokers.cards[i].sell_cost
                end
            end
            SMODS.destroy_cards(G.jokers.cards, false, false, false)
        end
        G.GAME.zodiac.capricornus_mult = total_sell
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_capricornus",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Capricornus", HEX('808080'), card)
    end
}

SMODS.Voucher {
    key = "capricornus",
    unlocked = true,
    discovered = false,
    no_collection = true,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                xmult = G.GAME.zodiac.capricornus_mult
            }
        end
    end
}
SMODS.Consumable {
    key = "aquarius",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            percent = -25
        }
    },
    can_use = function(self, card)
        if G.GAME.zodiac.aquarius then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.aquarius = true
        local selectedHand = BPMadness.mostUsedPokerHand(G.GAME.hand_usage)
        G.GAME.zodiac.aquarius_hand = selectedHand
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_aquarius",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Aquarius", G.C.CHIPS, card)
    end
}


SMODS.Voucher {
    key = "aquarius",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calculate = function(self, card, context)
        if context.evaluate_poker_hand then
            if context.scoring_name ~= G.GAME.zodiac.aquarius_hand then
                return {
                    replace_scoring_name = G.GAME.zodiac.aquarius_hand
                }
            end
        end
    end
}

SMODS.Consumable {
    key = "pisces",
    set = "bpm_zodiac",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        if G.GAME.zodiac_pisces then
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac_pisces = true
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(-G.GAME.round_resets.ante)
                return true
            end
        }))
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = 0

        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_pisces",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Pisces", HEX('77cda3'), card)
    end
}

SMODS.Voucher {
    key = "pisces",
    unlocked = true,
    discovered = false,
    no_collection = true,

    calc_dollar_bonus = function(self, card)
        local money = math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 2)
        return -money, {
            text = "Pisces"
        }
    end
}
