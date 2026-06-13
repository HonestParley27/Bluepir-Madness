SMODS.ConsumableType { -- Zodiac ConsumableType
    key = "bpm_zodiac",
    default = "c_bpm_gemini",
    shop_rate = 0,
    collection_rows = { 4, 4, 4 },
    primary_colour = G.C.YELLOW,
    secondary_colour = G.C.PURPLE
}

SMODS.DrawStep {
    key = "zodiac",
    order = 10,
    func = function(self)
        if self.ability.set == "bpm_zodiac" and self:should_draw_base_shader() and not self.config.center.disable_shine then
            self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' }
}

local function never_in_pool(self, args) -- Logic Vouchers can't appear in shop
    return false, {
        allow_duplicates = false
    }
end

SMODS.Consumable { -- Aries: +2 hands per round. First hand every round must be a High Card.
    key = "aries",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 0, y = 1 },

    config = {
        extra = {
            hands = 2
        }
    },

    can_use = function(self, card)
        if G.GAME.zodiac.aries then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.aries = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands -- Increase hands on reset
        ease_hands_played(card.ability.extra.hands)                                      -- Change hands immediately
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_aries",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Aries", G.C.RED, card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "aries",
    unlocked = false,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.debuff_hand then
            if G.GAME.current_round.hands_played == 0 then  -- If it's your first hand
                if context.scoring_name ~= "High Card" then -- And it isn't a High Card
                    return {
                        debuff = true,                      -- Hand will not score: Must play a High Card
                        debuff_text = "Must play a High Card."
                    }
                end
            end
        end
    end
}

SMODS.Consumable { -- Taurus: $10 at end of round. 2X blind size.
    key = "taurus",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 1, y = 1 },

    can_use = function(self, card)
        if G.GAME.zodiac.taurus then -- Can't use it if you have already used it before
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
        BPMadness.TextPopup("Taurus", G.C.GREEN, card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "taurus",
    unlocked = false,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.setting_blind then -- When starting a new Blind
            return { xblindsize = 2 } -- X2 Blind size
        end
    end,

    calc_dollar_bonus = function(self, card) -- At the end of round, when giving money
        return 10, {                         -- Add 10 extra money
            text = "Taurus"
        }
    end
}



SMODS.Consumable { -- Gemini: +2 consumable slots. -1 joker slot.
    key = "gemini",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 2, y = 1 },
    config = { -- No voucher needed so all config goes here
        extra = {
            joker_slots = 1,
            consum_slots = 2
        }
    },
    can_use = function(self, card)
        return true -- Allowed to use multiple times cuz we need a zodiac fallback for the boosters
    end,

    use = function(self, card, area, copier)
        if G.jokers then
            if G.jokers.config.card_limit > 0 then -- If you have any joker slots
                G.jokers.config.card_limit = G.jokers.config.card_limit -
                    card.ability.extra
                    .joker_slots -- Remove a joker slot
            end
        end

        if G.consumeables then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit +
                card.ability.extra
                .consum_slots -- Add two consumable slots
        end

        BPMadness.TextPopup("Gemini", G.C.YELLOW, card) -- TextPopup
    end
}

SMODS.Consumable { -- Cancer: Creates a negative copy of Mr. Bones. You can no longer skip blinds.
    key = "cancer",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 0, y = 2 },

    can_use = function(self, card)
        if G.GAME.zodiac.cancer then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.cancer = true -- Effect handled in overrides.lua
        G.E_MANAGER:add_event(Event({
            func = function()
                local ncard = SMODS.add_card({ -- Add a Negative-edition Mr. Bones
                    set = "Joker",
                    area = G.jokers,
                    key = "j_mr_bones",
                    edition = "e_negative",
                    allow_duplicates = true,
                    skip_materialize = true
                })
                ncard:juice_up(0.6, 0.1) -- juice.
                return true
            end
        }))
        BPMadness.TextPopup("Cancer", G.C.BLUE, card) -- TextPopup
    end
}

SMODS.Consumable { -- Leo: All your face cards give X3 mult. All numbered cards are debuffed.
    key = "leo",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 1, y = 2 },

    can_use = function(self, card)
        if G.GAME.zodiac.leo then -- Can't use it if you have already used it before
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
        BPMadness.TextPopup("Leo", G.C.ORANGE, card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "leo",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    config = {
        extra = {
            xmult = 3
        }
    },
    calculate = function(self, card, context)
        if context.debuff_card then
            if context.debuff_card.base.id and context.debuff_card.base.id < 11 and context.debuff_card.config.center.key ~= "m_stone" then -- Get the card ID, check if it's less than a Jack, and if not a stone card
                return {
                    debuff = true                                                                                                           -- Then debuff
                }
            end
        end

        if context.individual and context.cardarea == G.play then                                                -- When playing cards
            if context.other_card and context.other_card.base.id >= 11 and context.other_card.base.id <= 13 then -- If it's a Jack, Queen or King
                return {
                    xmult = self.config.extra
                        .xmult -- X3 Mult
                }
            end
        end
    end
}

SMODS.Consumable { -- Virgo: +1 mult for every remaining card in deck. Every discard costs $2.
    key = "virgo",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 2, y = 2 },

    can_use = function(self, card)
        if G.GAME.zodiac.virgo then -- Can't use it if you have already used it before
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
        BPMadness.TextPopup("Virgo", HEX('8d6238'), card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "virgo",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.discard then -- When discarding
            return {
                dollars = -1    -- -$1 per discarded card
            }
        end
        if context.initial_scoring_step then -- After the cards have scored
            return {
                mult = #G.deck.cards         -- Add mult equal to the deck size
            }
        end
    end
}

SMODS.Consumable { -- Libra: Chips and Mult get balanced at end of hand. -1 hand and discard.
    key = "libra",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 0, y = 3 },
    config = {
        extra = {
            hands = 1,
            discards = 1
        }
    },
    can_use = function(self, card)
        if G.GAME.zodiac.libra then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.libra = true
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands          -- -1 hand
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards -- -1 discard
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_libra",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Libra", HEX('ff7aac'), card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "libra",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.final_scoring_step then -- If on final scoring before checkout
            return {
                balance = true             -- Balance as plasma deck
            }
        end
    end
}

SMODS.Consumable { -- Scorpius: Level up your most played hand by 5 levels. Only your most played hand will score.
    key = "scorpius",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 1, y = 3 },

    can_use = function(self, card)
        if G.GAME.zodiac.scorpius then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.scorpius = true                                       -- For the record; Tried 'G.GAME.current_round.most_played_poker_hand' but it would always return High Card
        local selectedHand = BPMadness.mostUsedPokerHand(G.GAME.hand_usage) -- Check your most used poker hand
        level_up_hand(card, selectedHand, false, 5)                         -- Level up said hand
        G.GAME.zodiac.scorpius_hand = selectedHand                          -- Lock the hand so you can't change it
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_scorpius",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Scorpius", G.C.DARK_EDITION, card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "scorpius",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.debuff_hand then
            if context.scoring_name ~= G.GAME.zodiac.scorpius_hand then -- If you're not playing your locked hand
                return {
                    debuff = true,                                      -- Hand will not score: Must play {poker hand}
                    debuff_text = ("Must play " .. G.GAME.zodiac.scorpius_hand)
                }
            end
        end
    end
}

SMODS.Consumable { -- All probability effects are guaranteed. -2 hand size.
    key = "sagittarius",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 2, y = 3 },

    can_use = function(self, card)
        if G.GAME.zodiac.sagittarius then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.sagittarius = true
        G.hand:change_size(-2) -- -2 hand size
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_sagittarius",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Sagittarius", G.C.PURPLE, card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "sagittarius",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then -- When calculating *all* probabilities
            return {
                numerator = 1,
                denominator = 1
            } -- 1/1 = Every effect will be guaranteed: Jokers, Lucky or Glass Cards, Wheel of Fortune, etc.
        end
    end
}

SMODS.Consumable { -- Capricornus: Gain XMult equal to the sum of sell value of all jokers. Destroy all jokers.
    key = "capricornus",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 0, y = 4 },
    can_use = function(self, card)
        if G.GAME.zodiac.capricornus then -- Can't use it if you have already used it before
            return false
        end
        if not G.jokers then -- Can't use it if the jokers zone doesn't exist
            return false
        end
        if G.jokers and #G.jokers.cards < 1 then -- Can't use it if you don't have jokers at all
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.capricornus = true
        local total_sell = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do                                 -- For every joker card you own
                if not G.jokers.cards[i].ability.eternal then             -- If it's not eternal
                    total_sell = total_sell + G.jokers.cards[i].sell_cost -- Store the total sell cost
                end
            end
            SMODS.destroy_cards(G.jokers.cards, false, false, false) -- Destroy all cards
        end
        G.GAME.zodiac.capricornus_mult = total_sell                  -- Set the total mult
        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_capricornus",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Capricornus", HEX('808080'), card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "capricornus",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.final_scoring_step then             -- If on final scoring step before checkout
            return {
                xmult = G.GAME.zodiac.capricornus_mult -- XMult for the sell value
            }
        end
    end
}
SMODS.Consumable { -- Aquarius: All hands will score as your most played poker hand. All cards and packs in shop are 25% more expensive.
    key = "aquarius",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 1, y = 4 },
    config = {           -- We do actually need some config here
        extra = {
            percent = 25 -- Price increase %
        }
    },
    can_use = function(self, card)
        if G.GAME.zodiac.aquarius then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.aquarius = true
        local selectedHand = BPMadness.mostUsedPokerHand(G.GAME.hand_usage) -- Get your most played poker hand
        G.GAME.zodiac.aquarius_hand = selectedHand                          -- Lock it
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent or
                    0 -- Failsafe if discount is none
                G.GAME.discount_percent = G.GAME.discount_percent -
                    card.ability.extra
                    .percent                            -- -25% of discount = 25% increase
                for _, v in pairs(G.I.CARD) do          -- For every card in shop
                    if v.set_cost then v:set_cost() end -- Increase the price
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
        BPMadness.TextPopup("Aquarius", G.C.CHIPS, card) -- TextPopup
    end
}


SMODS.Voucher {
    key = "aquarius",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calculate = function(self, card, context)
        if context.evaluate_poker_hand then                             -- When setting the poker hand
            if context.scoring_name ~= G.GAME.zodiac.aquarius_hand then -- If it ain't the locked hand
                return {
                    replace_scoring_name = G.GAME.zodiac.aquarius_hand  -- Set it as the locked hand
                }
            end
        end
    end
}

SMODS.Consumable { -- Pisces: Sets Ante to 0. Loses half your money at end of round.
    key = "pisces",
    set = "bpm_zodiac",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 2, y = 4 },

    can_use = function(self, card)
        if G.GAME.zodiac.pisces then -- Can't use it if you have already used it before
            return false
        end
        return true
    end,

    use = function(self, card, area, copier)
        G.GAME.zodiac.pisces = true
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(-G.GAME.round_resets.ante) -- Reset Ante back to 0
                return true
            end
        }))
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante -- Failsafe
        G.GAME.round_resets.blind_ante = 0                                                          -- Reset blinds back to 0

        SMODS.add_card({
            set = "Voucher",
            area = G.vouchers,
            key = "v_bpm_pisces",
            skip_materialize = true,
            no_edition = true
        })
        BPMadness.TextPopup("Pisces", HEX('77cda3'), card) -- TextPopup
    end
}

SMODS.Voucher {
    key = "pisces",
    unlocked = true,
    discovered = false,
    no_collection = true,
    in_pool = never_in_pool,
    calc_dollar_bonus = function(self, card)                                                -- When awarding money at end of round
        local money = math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / 2) -- Get half of your current money
        return -money, {                                                                    -- And remove it
            text = "Pisces"
        }
    end
}
