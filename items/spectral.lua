SMODS.Atlas { -- sprite for hydration
    key = "Blue_SpectralZodiac",
    path = "BluePirsSpectralZodiacs.png",
    px = 64,
    py = 94

}

SMODS.Consumable {
    key = "hydration",
    set = "Spectral",
    atlas = "Blue_SpectralZodiac",
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

SMODS.Consumable {
    key = "spectrum",
    set = "Spectral",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 1, y = 0 },
    config = { extra = { seal = "bpm_witch" }, max_highlighted = 1, mod_conv = "bpm_witch" }, -- sets seal as Witch seal
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end,

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

SMODS.Consumable {
    key = "payroll",
    set = "Spectral",
    atlas = "Blue_SpectralZodiac",
    pos = { x = 2, y = 0 },
    config = { extra = { seal = "bpm_nitro" }, max_highlighted = 1, mod_conv = "bpm_nitro" }, -- sets seal as Nitro Seal
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end,

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
