SMODS.Atlas {
    key = "BluePirsDeck",
    path = "BluePirsDeck.png",
    px = 71,
    py = 95
}

SMODS.Back {
    key = "Blue Pairs",
    atlas = "BluePirsDeck",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        if info_queue then
            info_queue[#info_queue + 1] = G.P_CENTERS['j_bpm_BluePairs']
        end
        return { vars = {} }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.consumeables and G.jokers then
                    local card = SMODS.create_card({
                        set = "Tarot",
                        area = G.consumeables,
                        key = "c_wheel_of_fortune"
                    })
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    card = SMODS.create_card({
                        set = "Tarot",
                        area = G.consumeables,
                        key = "c_wheel_of_fortune"
                    })
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    card = SMODS.create_card({
                        set = "Joker",
                        area = G.jokers,
                        key = "j_bpm_blue_pairs",
                        rarity = 'Uncommon'
                    })
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return true
                end
            end
        }))
    end

}
