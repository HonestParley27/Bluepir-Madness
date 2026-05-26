SMODS.Atlas {
    key = "test_seal",
    path = "TestSeal.png",
    px = 71,
    py = 95
}

SMODS.Seal {
    key = "cloud",
    badge_colour = G.C.CHIPS,
    atlas = "test_seal",
    pos = { x = 0, y = 0 },
    
    config = { extra = {
        repeatTimes = 2
    } },
    
    loc_vars  = function (self, info_queue, card)
        return {
            vars = {
                self.config.extra.repeatTimes
            }
        }
    end,
    loc_txt   = {
        label = "Cloud Seal",
        name = "Cloud Seal",
        text = {
            "If Played hand is a {C:attention}Two Pair{}",
             "Retrigger this card #1# times"
        }
    },
    calculate = function (self, card, context)
        if context.repetition and context.scoring_name == "Two Pair" then
            return {
                repetitions = 1,
                card = card
            }
        end    
    end
}