function TextPopup(name, colour, card)
    colour = colour or G.C.YELLOW

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.3,
        func = function()
            attention_text({
                text = (name .. " Activated!"),
                scale = 0.7,
                hold = 1.0,
                backdrop_colour = colour, -- OI MATE IM AN AUSTRALIAN EXTREMIST
                align = 'tm',
                major = card,
                offset = { x = 0, y = -0.05 * G.CARD_H }
            })
            card:juice_up(0.6, 0.1)
            play_sound('generic1', 1, 1)
            return true
        end
    }))
end
