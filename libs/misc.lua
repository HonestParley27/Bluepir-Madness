-- Random Misc Functions that could be useful across different places

-- Current Deck Lookup at that given moment

-- Looks up how many of a specific rank there 
function BPMadness.ValdeckLookup(lookupVal, card, context)
    local cardTable = {
        ["King"] = 13,
        ["Queen"] = 12,
        ["Jack"] = 11,
        ["Ace"] = 14
    }

    if type(lookupVal) ~= "number" then
        lookupVal = cardTable[lookupVal]
    end
    local deck = G.deck.cards
    local total = 0
    for _, card in ipairs(deck) do
        if card:get_id() == lookupVal then
            total = total + 1
        end
    end
    
    return total
end