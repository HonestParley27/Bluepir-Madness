SMODS.Atlas {
    key = "normalBluester",
    path = "testNBluester.png",
    px = 71,
    py = 95

}
SMODS.Atlas {
    key = "jumboBluester",
    path = "testJBluester.png",
    px = 71,
    py = 95

}
SMODS.Atlas {
    key = "megaBluester",
    path = "testMBluester.png",
    px = 71,
    py = 95

}

SMODS.Booster {
    key = "bluster_pack",
    kind = "Bluesters",
    atlas = "normalBluester",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    cost = 6,
    weight = 0.75,
    create_card = function(self, card, i)
        return create_card("BPMadness_Jokers", G.pack_cards, nil, nil, true, false, nil, nil)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end
}

SMODS.Booster {
    key = "jumbo_bluster_pack",
    kind = "Bluesters",
    atlas = "jumboBluester",
    pos = { x = 0, y = 0 },
    config = { extra = 5, choose = 1 },
    cost = 8,
    weight = 0.55,
    create_card = function(self, card, i)
        return create_card("BPMadness_Jokers", G.pack_cards, nil, nil, true, false, nil, nil)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end
}


SMODS.Booster {
    key = "mega_bluster_pack",
    kind = "Bluesters",
    atlas = "megaBluester",
    pos = { x = 0, y = 0 },
    config = { extra = 5, choose = 2 },
    cost = 10,
    weight = 0.55,
    create_card = function(self, card, i)
        return create_card("BPMadness_Jokers", G.pack_cards, nil, nil, true, false, nil, nil)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end
}

SMODS.Booster {
    key = "zodiac_pack",
    kind = "Zodiacs",
    atlas = "normalBluester",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    cost = 6,
    weight = 1,
    create_card = function(self, card, i)
        return create_card("bpm_zodiac", G.pack_cards, nil, nil, true, false, nil, nil)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra
            }
        }
    end
}
