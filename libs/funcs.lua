function BPMadness.TextPopup(name, colour, card)
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

function BPMadness.randPokerHand(prevHand, seed) -- random poker hand
    local pokerHands = {}

    for i, v in pairs(G.GAME.hands) do      -- pairs takes key and value of each hand
        if v.visible and i ~= prevHand then -- if its not a previous hand
            pokerHands[#pokerHands + 1] = i -- add it to the poker list
        end
    end
    local ret = pseudorandom_element(pokerHands, pseudoseed(seed)) -- and throw it to gambling
    return ret                                                     -- and return the random hand
end

function BPMadness.mostUsedPokerHand(hand_usage)
    local poker_name, poker_count, tiebreak, seen = nil, -1, {}, {}
    if next(hand_usage) then
        for k, v in pairs(hand_usage) do
            if v.count == poker_count then
                table.insert(tiebreak, v.order)
                if poker_name and not seen[poker_name] then
                    table.insert(tiebreak, poker_name)
                    seen[poker_name] = true
                end
            end
            if v.count > poker_count then
                poker_name = v.order
                poker_count = v.count
                tiebreak, seen = {}, {}
            end
        end
        if #tiebreak > 0 then
            poker_name = tiebreak[math.random(#tiebreak)]
        end
    else
        poker_name = "High Card"
    end
    return poker_name
end
