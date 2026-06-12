SMODS.Atlas { -- sprite for cloud seal
    key = "test_seal",
    path = "TestSeal.png",
    px = 71,
    py = 95
}

SMODS.Atlas { -- sprite for witch seal
    key = "test_seal2",
    path = "TestSeal2.png",
    px = 71,
    py = 95
}

SMODS.Seal {
    key          = "cloud",
    badge_colour = G.C.CHIPS,
    atlas        = "test_seal",
    pos          = { x = 0, y = 0 },

    config       = { extra = {
        repeatTimes = 2 -- repeat two times
    } },

    loc_vars     = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.repeatTimes
            }
        }
    end,
    loc_txt      = {
        label = "Cloud Seal",
        name = "Cloud Seal",
        text = {
            "If Played hand is a {C:attention}Two Pair{}",
            "Retrigger this card #1# times"
        }
    },
    calculate    = function(self, card, context)
        if context.repetition and context.scoring_name == "Two Pair" then -- if the scoring hand is a two pair
            return {
                repetitions = self.config.extra.repeatTimes,              -- repeat #repeatTimes
                card = card                                               -- the card played
            }
        end
    end
}

SMODS.Seal {
    key          = "witch",
    badge_colour = G.C.PURPLE,
    atlas        = "test_seal2",
    pos          = { x = 0, y = 0 },
    config       = {
        extra = {
        }
    },
    loc_txt      = {
        label = "Witch Seal",
        name = "Witch Seal",
        text = {
            "If held in hand by end of round,",
            "apply a {C:attention}random enhancement{} to a random {E:1}Joker{}."
        }
    },
    calculate    = function(self, card, context)
        if context.end_of_round and context.cardarea == G.hand and context.other_card == card then
            local random_joker = nil
            local random_edition = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                    if #editionless_jokers > 0 then
                        local editions = {}
                        for _, edition in ipairs(G.P_CENTER_POOLS["Edition"]) do
                            if edition.in_shop then
                                editions[#editions + 1] = edition.key
                            end
                        end
                        random_joker = pseudorandom_element(editionless_jokers, "Witch Seal")
                        random_edition = pseudorandom_element(editions, "Witch Seal")
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if random_joker then
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    if random_joker and random_edition then
                        random_joker:set_edition(random_edition, true)
                    end
                    return true
                end
            }))
        end
    end
}
