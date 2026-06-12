SMODS.Atlas { -- Sprite for all test jokers
    key = "BlueJoker",
    path = "BluePirsJokers.png",
    px = 71,
    py = 95

}

SMODS.Joker {   -- Lucky Cloud
    key = "lucky_cloud",
    rarity = 2, -- uncommon
    atlas = "BlueJoker",
    pos = { x = 1, y = 0 },
    cost = 6,        -- cost in shop
    config = { extra = {
        lvChance = 3 -- num/3 chance
    } },
    loc_vars = function(self, info_queue, card)
        local num, dem = SMODS.get_probability_vars(card, 1, card.ability.extra.lvChance, "Lucky Cloud") -- 1 in 3 chance to upgrade
        return {
            vars = {
                num,
                dem
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Two Pair" then                                   -- before scoring, if played a two pair
            if SMODS.pseudorandom_probability(card, "Lucky Cloud", 1, card.ability.extra.lvChance) then -- if gambling hits
                SMODS.upgrade_poker_hands({                                                             -- upgrade two pair
                    hands = { 'Two Pair' },
                    level_up = 1,
                    from = card,
                    instant = false
                })
                return {
                    message = "Upgraded!"
                }
            end
        end
    end
}

SMODS.Joker { -- Blue Pairs
    key = "blue_pairs",
    config = {
        extra = {
            xMult = 1,       -- Original mult
            xMultgain = 0.25 -- Gain per condition
        }
    },
    rarity = 2, -- uncommon
    atlas = "BlueJoker",
    pos = { x = 2, y = 0 },
    cost = 5, -- card cost in shop
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xMult,
                card.ability.extra.xMultgain

            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then                     -- if on joker context
            if context.scoring_name == 'Two Pair' then -- and played hand is a two pair
                return {
                    xmult = card.ability.extra.xMult   -- adds mult
                }
            end
        end

        if context.before and context.scoring_name == "Two Pair" and not context.blueprint_card then -- if two pair scores but not a blueprint
            card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMultgain       -- add more mult
            return {
                message = "Upgraded!"
            }
        end
    end
}


SMODS.Joker { -- Skip a Lime
    key = "skip_a_lime",
    cost = 3,
    config = { extra = {
        sellValGain = 3,     -- gain sell value
        originalSellVal = 0, -- original sell value
        plusMult = 1         -- additional mult
    } },
    rarity = 1,              -- common
    atlas = "BlueJoker",
    pos = { x = 3, y = 0 },
    loc_vars = function(self, info_queue, card)
        local mu = 0
        if card.cost / 2 < 1 then
            mu = 1                              -- card mult can't be lower than 1
        else
            mu = math.floor(card.cost / 2)      -- mult will be half the cost
        end
        card.ability.extra.originalSellVal = mu -- sell value = mult
        return {
            vars = {
                card.ability.extra.sellValGain,
                card.ability.extra.plusMult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint_card then                                       -- when skipping a blind but not blueprint
            card.ability.extra_value = card.ability.extra_value + card.ability.extra
                .sellValGain                                                                            -- add to the sell value
            card.ability.extra.plusMult = card.ability.extra.originalSellVal + card.ability.extra_value -- add to mult
            card:set_cost()                                                                             -- set value

            return {
                message = "Upgraded!"
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.plusMult -- when on joker context, add mult
            }
        end
    end
}


SMODS.Joker { -- Short Circut
    key = "short_circut",
    config = { extra = {
        speedmult = 4,         -- game speed
        originalGameSpeed = 1, -- original game speed
        enabled = true
    } },
    rarity = 3, -- Rare
    atlas = "BlueJoker",
    pos = { x = 4, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.speedmult
            }
        }
    end,

    calculate = function(self, card, context)
        if G.SETTINGS.GAMESPEED ~= 4 and card.ability.extra.enabled and not context.blueprint_card then -- if game speed is not 4
            G.SETTINGS.GAMESPEED = 4                                                                    -- force to 4
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.speedmult -- xmult = gamespeed
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.originalGameSpeed = G.SETTINGS.GAMESPEED -- store original game speed
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.SETTINGS.GAMESPEED = card.ability.extra.originalGameSpeed -- restore original game speed
    end

}



SMODS.Joker { -- Vanium's Curse
    key = "vanium_curse",
    config = {
        extra = {
            MultX = 0.67,    -- x0.67 mult
            GoodMultX = 6.7, -- chance of x6.7 mult
            goodChance = 10, -- num in 10 chance
            scored6 = false, -- hand scored a 6
            scored7 = false  -- hand scored a 7
        }
    },
    atlas = "BlueJoker",
    pos = { x = 0, y = 1 },
    rarity = 1, -- Common
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local num, dem = SMODS.get_probability_vars(card, 1, card.ability.extra.goodChance, "Vanium's Curse") -- 1 in 10 chance
        return {                                                                                              -- Added the probarbility chance feature
            vars = {
                card.ability.extra.MultX,
                card.ability.extra.GoodMultX,
                num,
                dem
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then -- scoring each card
            if context.other_card:get_id() == 6 then
                card.ability.extra.scored6 = true
            end
            if context.other_card:get_id() == 7 then
                card.ability.extra.scored7 = true
            end -- set if 6 and 7 were played
        end

        if context.joker_main then
            if card.ability.extra.scored6 and card.ability.extra.scored7 then
                if SMODS.pseudorandom_probability(card, "Vanium's Curse", 1, card.ability.extra.goodChance) then -- gamble
                    return {
                        xmult = card.ability.extra
                            .GoodMultX -- gamble hit
                    }
                else
                    return {
                        xmult = card.ability.extra.MultX -- else
                    }
                end
            end
            card.ability.extra.scored6 = false
            card.ability.extra.scored7 = false -- reset default
        end
    end
}


SMODS.Joker { -- Ad Astra
    key = "ad_astra",
    atlas = "BlueJoker",
    rarity = 2, -- Uncommon
    cost = 5,
    pos = { x = 1, y = 1 },
    config = { extra = {
        MultX = 0.1 -- x0.1 mult
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.MultX -- xMult
            }
        }
    end,


    calculate = function(self, card, context)
        if context.joker_main then
            local totalMult = 1
            totalMult = G.GAME.hands["" .. context.scoring_name].played * card.ability.extra.MultX +
                totalMult -- totalmult is times hand played
            return {
                xmult = totalMult
            }
        end
    end
}


SMODS.Joker { -- Herbcat ( 'w' )
    key = "herb_cat",
    atlas = "BlueJoker",
    pos = { x = 2, y = 1 },
    cost = 3,
    rarity = 1,           -- Common
    config = { extra = {
        chipAdd = 25,     -- chips added per card
        totalChipAdd = 0, -- total chips added
    } },
    loc_vars = function(self, info_queue, card)
        local card2Count = BPMadness.ValdeckLookup(2)                                            -- check how many 2s are in deck
        local card7Count = BPMadness.ValdeckLookup(7)                                            -- check how many 7s are in check

        card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd -- total chips added
        return {
            vars = {
                card.ability.extra.chipAdd,
                card.ability.extra.totalChipAdd
            },
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        local card2Count = BPMadness.ValdeckLookup(2)
        local card7Count = BPMadness.ValdeckLookup(2)

        card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd -- same logic
    end,
    calculate = function(self, card, context)
        if context.before then
            local card2Count = BPMadness.ValdeckLookup(2)
            local card7Count = BPMadness.ValdeckLookup(7)

            card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd -- same logic
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.totalChipAdd -- return chips
            }
        end
    end
}

SMODS.Joker {   -- Australian Joker 🐨
    key = "australian_joker",
    rarity = 3, -- Rare
    cost = 7,
    atlas = "BlueJoker",
    pos = { x = 3, y = 1 },
    config = {},

    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                swap = true,         -- changed to the built-in swap function
                message = "Swapped!" -- and added a message
            }
        end
    end
}


SMODS.Joker {   -- Blind Joker
    key = "blind_joker",
    rarity = 3, -- Rare
    cost = 10,
    atlas = "BlueJoker",
    pos = { x = 4, y = 1 },
    config = { extra = {
        blindMult = 1,                -- original blind mult
        blindgain = 0.1,              -- gain blind
        blindred = 0.01,              -- reduce blind
        randomPokerHand = "High Card" -- first poker hand is always a high card
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.blindMult,
                card.ability.extra.blindgain,
                card.ability.extra.blindred,
                card.ability.extra.randomPokerHand
            },
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.randomPokerHand = BPMadness.randPokerHand(card.ability.extra.randomPokerHand, "Blind Joker") -- select a random poker hand
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint_card then                    -- on end of round
            card.ability.extra.randomPokerHand = BPMadness.randPokerHand(card.ability.extra.randomPokerHand, -- choose a new poker hand
                "Blind Joker")
            return {
                message = "Hand Changed!"
            }
        end

        if context.before and not context.blueprint_card then
            if context.scoring_name == card.ability.extra.randomPokerHand then -- if the hand is the same as the selected
                card.ability.extra.blindMult = card.ability.extra.blindMult +
                    card.ability.extra.blindgain                               -- add to blindmult
                return {
                    message = "Increase!",
                    colour = G.C.DYN_UI.DARK
                }
            elseif context.scoring_name ~= card.ability.extra.randomPokerHand and not context.blueprint_card then -- if not, reverse
                card.ability.extra.blindMult = card.ability.extra.blindMult - card.ability.extra.blindred
                return {
                    message = "Decrease!",
                    colour = G.C.DYN_UI.DARK
                }
            end
        end

        if context.setting_blind then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * card.ability.extra.blindMult) -- set the chips requirement
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            return {
                message = "Blind Up!",
                colour = G.C.DYN_UI.DARK
            }
        end
    end
}


SMODS.Joker {   -- Wood Chipper
    key = "wood_chipper",
    rarity = 3, -- Rare
    cost = 9,
    atlas = "BlueJoker",
    pos = { x = 0, y = 2 },
    config = { extra = {
        chipX = 1 -- times chip my beloved
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chipX
            }
        }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            if G.GAME.current_round.hands_played <= 0 and #context.full_hand == 1 then -- if it's the first hand and only a card
                card.ability.extra.chipX = card.ability.extra.chipX +
                    math.floor(context.destroy_card:get_id() / 4)                      -- add to xchip 1/4 of the played rank

                return {
                    message = "Upgraded!",
                    remove = true
                }
            end
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.chipX
            }
        end
    end
}

SMODS.Joker {   -- Angels
    key = "angels",
    rarity = 4, -- Legendary
    cost = 20,
    atlas = "BlueJoker",
    pos = { x = 2, y = 2 },
    config = {
        extra = {
            MultX = BPMadness.community_mult, -- from http.lua
            MultGain = 1,
        }
    },
    loc_vars = function(self, info_queue, card)
        BPMadness.update_community_mult() -- this one is for bluecord
        card.ability.extra.MultX = BPMadness.community_mult
        return {
            vars = {
                card.ability.extra.MultX,
                card.ability.extra.MultGain
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.MultX = BPMadness.community_mult -- set community_mult as xmult
            return {
                xmult = card.ability.extra.MultX
            }
        end
    end
}


SMODS.Joker { -- Double Vision
    key = "double_vision",
    atlas = "BlueJoker",
    pos = { x = 1, y = 2 },
    cost = 10,
    rarity = 3, -- Rare

    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:unhighlight_all() -- If selling, unhighlight all cards; Just in case.
                return true
            end
        }))
    end
}


SMODS.Joker { -- Snowball
    key = "snowball",
    atlas = "BlueJoker",
    pos = { x = 3, y = 2 },
    cost = 10,
    rarity = 3, -- Rare
    config = {
        extra = {
            xMult = 1,        -- original xmult
            xMultGain = 0.25, -- gain per hand
            lastPlayed = nil  -- last played hand
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xMult,
                card.ability.extra.xMultGain,
                card.ability.extra.lastPlayed or "None" -- if no last played then return string
            }
        }
    end,


    calculate = function(self, card, context)
        if context.before and not context.blueprint_card then
            if not card.ability.extra.lastPlayed then                                              -- if there's no previous hand
                card.ability.extra.lastPlayed = context
                    .scoring_name                                                                  -- save the current scored hand
            elseif card.ability.extra.lastPlayed == context.scoring_name then                      -- if there's a previous hand
                card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMultGain -- set xmult
            else                                                                                   -- if previous hand doesnt match
                if card.ability.extra.xMult == 1 then                                              -- if already x1 no need to reset anything
                    card.ability.extra.lastPlayed = context.scoring_name
                    return {}
                end
                card.ability.extra.xMult = 1 -- then reset
                card.ability.extra.lastPlayed = context.scoring_name
                return {
                    message = "Reset!"
                }
            end
            card.ability.extra.lastPlayed = context.scoring_name -- always save the last hand at the end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xMult -- apply xmult
            }
        end
    end
}

SMODS.Joker { -- Bluefrin
    key = "bluefrin",
    atlas = "BlueJoker",
    pos = { x = 4, y = 2 },
    cost = 20,
    rarity = 4,               -- Legendary
    blueprint_compat = false, -- Blueprint can't copy Bluefrin
    eternal_compat = false,   -- Eternal stickers can't spawn on Bluefrin
    config = {
        extra = {
            remainingSaves = 5 -- Times to preventh Death
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.remainingSaves
            }
        }
    end,

    calculate = function(self, card, context)                                             -- probably need to rewrite this into a proper event
        if context.end_of_round and context.game_over then                                -- if on end of round and on game over
            if context.scoring_name == 'Two Pair' then                                    -- if scored a two pair
                card.ability.extra.remainingSaves = card.ability.extra.remainingSaves - 1 -- remove one from counter

                if card.ability.extra.remainingSaves == 0 then                            -- if no more saves
                    SMODS.destroy_cards(card, nil, false)                                 -- destroy the card
                    return {
                        message = "Extinct!",                                             -- message
                        saved = "Saved by Bluefrin!",                                     -- save round

                    }
                end

                return {
                    message = (card.ability.extra.remainingSaves .. " remaining!"), -- number of saves remaining
                    saved = "Saved by Bluefrin!"                                    -- save round
                }
            end
        end
    end
}
