-- Wheeeee, Angelic jokers (end me)

--[[

Gonna plan out the proccess here rq

Spectral Card -> Checks which hand is greatest ->

]]

SMODS.Atlas { -- Sprite for all test jokers
    key = "TestJoker",
    path = "test_joker.png",
    px = 71,
    py = 95

}

SMODS.Rarity {
    key = "angelic",
    loc_txt = {
        name = "Angelic"
    },
    badge_colour = G.C.SECONDARY_SET.Planet,
    default_weight = 0
}


SMODS.Joker {
    key = "hands_of_god",
    atlas = "TestJoker",
    pos = { x = 0, y = 0 },
    rarity = "bpm_angelic",
    cost = 30,
    config = { extra = {
        godHand = "None"
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = "handsOfGod_ab1",
            set = "Other",
            vars = {card.ability.extra.godHand}
        }
        return {
            vars = {
                card.ability.extra.godHand
            }
        }
    end,
    loc_txt = {
        name = "Hands Of God",
        text = {"aaaa"}
    }
}