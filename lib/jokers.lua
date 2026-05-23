SMODS.Atlas {
    key = "TestJoker",
    path = "test_joker.png",
    px = 71,
    py = 95

}

-- Blue Pairs
SMODS.Joker {
    key = "blue_pairs",

    config = {
        extra = {
            xMult = 1,
            xMultgain = 0.5
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
            "{X:mult,C:white} X#1# {} Mult when {C:attention,E:2}Two Pair{} is played",
            "Gains {X:mult,C:white} X#2# {} Mult when {C:attention,E:2}Two Pair{} is played."
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
            "{C:green,E:1}#1# in #2#{} chance to level up played hand,",
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
            "{X:mult,C:white} +#2# {} Mult, where Mult is equal to Sell Value of Joker"
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
            "Sets Gamespeed to x#1#, adds {C:white,X:mult} x#1# {} Mult"
        }
    },
    calculate = function(self, card, context)
        
        if context.buying_self and not context.blueprint_card then
            card.ability.extra.originalGameSpeed = G.SETTINGS.GAMESPEED
            print(card.ability.extra.originalGameSpeed)
        end

        if G.SETTINGS.GAMESPEED ~= 4 and card.ability.extra.enabled and not context.blueprint_card  then
            G.SETTINGS.GAMESPEED = 4
        end

        if ((context.joker_type_destroyed and context.card == card) or (context.selling_card and context.card == card)) and not context.blueprint_card then
            card.ability.extra.enabled = false
            print(card.ability.extra.originalGameSpeed)
            G.SETTINGS.GAMESPEED = card.ability.extra.originalGameSpeed
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.speedmult
            }
        end
    end,

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
            "{C:white,X:mult} x#1# {} Mult if played hand has scoring {C:attention} 6 and 7 {}",
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
       MultX = 0.5 
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
        text = {"{X:mult,C:white} x#1# {} Mult for each time {C:attention}poker hand{} has been played this run."}
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