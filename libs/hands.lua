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
