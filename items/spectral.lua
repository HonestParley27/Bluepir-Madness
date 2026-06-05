SMODS.Atlas { -- sprite for hydration
    key = "testHydration",
    path = "testHydration.png",
    px = 71,
    py = 95

}

SMODS.Consumable {
    key = "hydration",
    set = "Spectral",
    atlas = "testHydration",
    pos = { x = 0, y = 0 },
    config = { extra = { seal = "bpm_cloud" }, max_highlighted = 1, mod_conv = "bpm_cloud" }, -- sets seal as cloud seal
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end,
    loc_txt = {
        name = "Hydration",
        text = { "Adds {C:blue}Cloud{} Seal to",
            "{C:attention}#1#{} selected card ", -- #number# = returned val number
        }
    },
    use = function(self, card, area, copier)
        local conCard = G.hand.highlighted[1] -- get the selected card
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')    -- play tarot sound
                card:juice_up(0.3, 0.5) -- juice. (animate the card)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conCard:set_seal(card.ability.extra.seal, nil, true) -- sets the seal in the selected card
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all() -- unhighlight the card after applying the seal
                return true
            end
        }))
    end
}
