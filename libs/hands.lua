function BPMadness.randPokerHand (prevHand, seed)
    local pokerHands = {}

    for i, v in pairs(G.GAME.hands) do
        if v.visible and i ~= prevHand then
            pokerHands[#pokerHands + 1] = i
        end
    end
    local ret = pseudorandom_element(pokerHands, pseudoseed(seed))
    return ret
end