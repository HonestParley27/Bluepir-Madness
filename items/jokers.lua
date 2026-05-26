SMODS.Atlas {
    key = "TestJoker",
    path = "test_joker.png",
    px = 71,
    py = 95

}

-- Need to Re-format the text / descriptions.

-- Blue Pairs
SMODS.Joker {
    key = "blue_pairs",

    config = {
        extra = {
            xMult = 1,
            xMultgain = 0.25
        }
    },
    rarity = 2,
    atlas = "TestJoker",
    pos = { x = 0, y = 0},
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xMult,
                card.ability.extra.xMultgain
        
            }
        }
    end,
    loc_txt = {
        name = "Blue Pairs",
        text = {
            "{X:mult,C:white} X#1# {} Mult when ",
            "{C:attention,E:2}Two Pair{} is played",
            "Gains {X:mult,C:white} X#2# {} Mult",
            "when {C:attention,E:2}Two Pair{} is played."
        }
    },

    calculate = function (self, card, context)
        if context.joker_main then
            if context.scoring_name == 'Two Pair' then
                return {
                    xmult = card.ability.extra.xMult
                }
            end
        end

        if context.before and context.scoring_name == "Two Pair" and not context.blueprint_card then
            card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMultgain
            return {
                message = "Upgraded!"
            }
        end
    end
}

-- Lucky Cloud
SMODS.Joker {
    key = "lucky_cloud",
    rarity = 2,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    cost = 6,
    config = { extra = {
        lvChance = 3
    } },
    loc_vars = function (self, info_queue, card)
        local num, dem = SMODS.get_probability_vars(card, 1, card.ability.extra.lvChance, "Lucky Cloud")
        return {
            vars = {
                num,
                dem
            }
        }
    end,
    loc_txt = {
        name = "Lucky Cloud",
        text = {
            "{C:green,E:1}#1# in #2#{} chance to level up poker hand,",
            "when {C:attention,E:2}Two Pair{} is played."
        }
    },
    
    calculate = function (self, card, context)
        if context.before and context.scoring_name == "Two Pair" then
            if SMODS.pseudorandom_probability(card, "Lucky Cloud", 1, card.ability.extra.lvChance) then
                SMODS.upgrade_poker_hands({
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

-- Skip a Lime
SMODS.Joker {
    key = "skip_a_lime",
    cost = 3,
    config = { extra = {
        sellValGain = 3,
        originalSellVal = 0,
        plusMult = 1
    } },
    rarity = 1,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        local mu = 0
        if card.cost/2 < 1 then
            mu = 1
        else
            mu = math.floor(card.cost/2)
        end
        card.ability.extra.originalSellVal = mu
        return{
            vars = {
                card.ability.extra.sellValGain,
                card.ability.extra.plusMult
            }
        }
    end,
    loc_txt = {
        name = "Skip A Lime",
        text = {
            "Gains {C:money}$#1#{} per blind skipped.",
            "{X:mult,C:white} +#2# {} Mult",
            "where Mult is equal to Sell Value of Joker"
        }
    },
    calculate = function (self, card, context)
        if context.skip_blind and not context.blueprint_card then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.sellValGain
            card.ability.extra.plusMult = card.ability.extra.originalSellVal + card.ability.extra_value
            card:set_cost()

            return {
                message = "Upgraded!"
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.plusMult
            }
        end
    end
}

-- Short Circut
SMODS.Joker {
    key = "short_circut",
    config = { extra = {
        speedmult = 4,
        originalGameSpeed = 1,
        enabled = true
    } },
    rarity = 3,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.speedmult
            }
        }
    end,
    loc_txt = {
        name = "Short Circut",
        text = {
            "Sets Gamespeed to x#1#",
            "adds {C:white,X:mult} x#1# {} Mult"
        }
    },
    calculate = function(self, card, context)

        if G.SETTINGS.GAMESPEED ~= 4 and card.ability.extra.enabled and not context.blueprint_card  then
            G.SETTINGS.GAMESPEED = 4
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.speedmult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        
        card.ability.extra.originalGameSpeed = G.SETTINGS.GAMESPEED

    end,
    remove_from_deck = function (self, card, from_debuff)
        G.SETTINGS.GAMESPEED = card.ability.extra.originalGameSpeed
    end

}


-- Vanium's Curse
SMODS.Joker {
    key = "vanium_curse",
    config = {
        extra = {
            MultX = 0.67,
            scored6 = false,
            scored7 = false
        }
    },
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.MultX
            }
        }
    end,
    loc_txt = {
        name = "Vanium's Curse",
        text = {
            "{C:white,X:mult} x#1# {} Mult if played hand",
            "has scoring {C:attention} 6 and 7 {}",
        }
    },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 6 then
                card.ability.extra.scored6 = true
            end
            if context.other_card:get_id() == 7 then
                card.ability.extra.scored7 = true
            end
        end

        if context.joker_main then
            if card.ability.extra.scored6 and card.ability.extra.scored7 then
                return {
                    xmult = card.ability.extra.MultX
                }
            end
            card.ability.extra.scored6 = false
            card.ability.extra.scored7 = false
        end
    end
}

-- Ad Astra
SMODS.Joker {
    key = "ad_astra",
    atlas = "TestJoker",
    rarity = 2,
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = {
       MultX = 0.25 
    } },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.MultX
            }
        }
    end,
    loc_txt = {
        name = "Ad Astra",
        text = {
            "{X:mult,C:white} x#1# {} Mult for each time ",
            "{C:attention}poker hand{} has been played this run.",
        }
    },

    calculate = function(self, card, context)
        
        if context.joker_main then
            local totalMult = 1
            totalMult = G.GAME.hands["" .. context.scoring_name].played * card.ability.extra.MultX + 0.5
            
            if totalMult < 1 then
                totalMult = 1
            end

            return {
                xmult = totalMult
            }
        end
    end
}

-- Herbcat ( 'w' )
SMODS.Joker {
    key = "herb_cat",
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    cost = 3,
    rarity = 1,
    config = { extra = {
        chipAdd = 25,
        totalChipAdd = 0,
    } },
    loc_vars = function(self, info_queue, card)
        local card2Count = BPMadness.ValdeckLookup(2)
        local card7Count = BPMadness.ValdeckLookup(7)

        card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd
        return {
            vars = {
                card.ability.extra.chipAdd,
                card.ability.extra.totalChipAdd
            },
        }
    end,
    loc_txt = {
        name = "Herbcat",
        text = {
            "For every 2 and 7 still in deck",
            "Adds {C:chips}+#1#{} chips",
            "Currently {C:chips}+#2#{}"
        }
    },
    add_to_deck = function(self, card, from_debuff)
        local card2Count = BPMadness.ValdeckLookup(2)
        local card7Count = BPMadness.ValdeckLookup(2)

        card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd

    end,
    calculate = function(self, card, context)
        if context.before then
            local card2Count = BPMadness.ValdeckLookup(2)
            local card7Count = BPMadness.ValdeckLookup(7)

            card.ability.extra.totalChipAdd = (card2Count + card7Count) * card.ability.extra.chipAdd
        end
        
        if context.joker_main then
            return {
                chips = card.ability.extra.totalChipAdd
            }
        end
    end
}

-- Australian Joker
SMODS.Joker {
    key = "australian_joker",
    rarity = 3,
    cost = 7,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    config = {},
    loc_txt = {
        name = "Australian Joker",
        text = {"Swaps {C:mult}Mult{} and {C:chips}Chips{}","on hand played"}
    },
    calculate = function (self, card, context)
        if context.final_scoring_step then
            mult,hand_chips = hand_chips,mult
        end
    end
}

-- Blind Joker
SMODS.Joker {
    key = "blind_joker",
    rarity = 3,
    cost = 10,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    config = { extra = {
        blindMult = 1,
        blindgain = 0.1,
        blindred = 0.01,
        randomPokerHand = "High Card"
    } },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.blindMult,
                card.ability.extra.blindgain,
                card.ability.extra.blindred,
                card.ability.extra.randomPokerHand
            },
        }
    end,
    loc_txt = {
        name = "Blind Joker",
        text = {
            "Changes Blind Requirement by {X:blind,C:white}x#1#{}",
            "Gains {X:blind,C:white}x#2#{} if played hand is {C:attention}#4#{}",
            "Loses {X:blind,C:white}x#3#{} if played hand is not {C:attention}#4#{}",
            "{C:inactive,S:0.8}(Poker Hand changes each round){}"
        }
    },
    add_to_deck = function (self, card, from_debuff)
        card.ability.extra.randomPokerHand = BPMadness.randPokerHand(card.ability.extra.randomPokerHand,"Blind Joker")
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint_card then
            card.ability.extra.randomPokerHand = BPMadness.randPokerHand(card.ability.extra.randomPokerHand,
                "Blind Joker")
            return {
                message = "Hand Changed!"
            }
        end
        
        if context.before and not context.blueprint_card then
            if context.scoring_name == card.ability.extra.randomPokerHand then
                card.ability.extra.blindMult = card.ability.extra.blindMult + card.ability.extra.blindgain
                return {
                message = "Increase!",
                colour = G.C.DYN_UI.DARK
                }
            elseif context.scoring_name ~= card.ability.extra.randomPokerHand and not context.blueprint_card then
                card.ability.extra.blindMult = card.ability.extra.blindMult - card.ability.extra.blindred
                return {
                    message = "Decrease!",
                    colour = G.C.DYN_UI.DARK
                }
            end
        end

        if context.setting_blind then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * card.ability.extra.blindMult)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            return {
                message = "Blind Up!",
                colour = G.C.DYN_UI.DARK
            }
        end
    end
}

-- WoodChipper
SMODS.Joker {
    key = "wood_chipper",
    rarity = 3,
    cost = 9,
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    config = { extra = {
        chipX = 0
    } },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
            card.ability.extra.chipX
        }}
    end,
    loc_txt = {
        name = "Wood Chipper",
        text = {
            "If {C:attention}First Hand{} of round",
            "has only {C:attention}1{} card, Gains {C:attention}one-fourth{} of",
            "its rank as {X:chips,C:white}xChips{} and destroy card.",
            "Currently {X:chips,C:white}x#1#{} Chips"
        }
    },
    calculate = function (self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            if G.GAME.current_round.hands_played <= 0 and #context.full_hand == 1 then
                card.ability.extra.chipX = card.ability.extra.chipX + math.floor(context.destroy_card:get_id() / 4)

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