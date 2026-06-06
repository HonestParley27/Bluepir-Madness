SMODS.Challenge {
    key = "orange_pairless",
    rules = {
        custom = {
            { id = 'no_pairs' }
        }
    },
    consumeables = {
        {
            id = "c_hanged_man"
        },
        {
            id = "c_hanged_man"
        }

    },
    vouchers = {
        {
            id = "v_telescope"
        }
    },
    restrictions = {
        banned_other = {
            {
                id = "bl_eye",
                type = "blind"
            }
        }
    },
    calculate = function(self, context)
        if context.debuff_hand and G.GAME.modifiers.no_pairs then
            local ret = evaluate_poker_hand(context.full_hand)
            if #ret["Pair"] > 0 then
                return {
                    debuff = true,
                    debuff_text = "No Pairs!"
                }
            end
        end
    end
}

SMODS.Challenge {
    key = "bluepairs_challenge",
    rules = {
        custom = {
            { id = "only_two_pairs" }
        }
    },
    consumeables = {
        {
            id = "c_death"
        },
        {
            id = "c_death"
        }

    },
    vouchers = {
        {
            id = "v_magic_trick"
        }
    },
    restrictions = {
        banned_other = {
            {
                id = "bl_eye",
                type = "blind"
            }
        }
    },

    calculate = function(self, context)
        if context.debuff_hand and G.GAME.modifiers.only_two_pairs then
            if context.scoring_name ~= "Two Pair" then
                return {
                    debuff = true,
                    debuff_text = "Only Two Pairs!"
                }
            end
        end
    end
}
