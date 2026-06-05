function BPMadness.ValdeckLookup(lookupVal, card, context) -- Looks up a card in deck
    local cardTable = {                                    -- Gives value to the unnumbered cards
        ["King"] = 13,
        ["Queen"] = 12,
        ["Jack"] = 11,
        ["Ace"] = 14
    }

    if type(lookupVal) ~= "number" then  -- if you didn't input a number
        lookupVal = cardTable[lookupVal] -- search up the actual number in the table
    end
    local deck

    if G.deck then
        deck = G.deck.cards -- Get cards from deck
    end

    local total = 0                            -- Total cards founds
    if deck then
        for _, card in ipairs(deck) do         -- For each numbered card in deck
            if card:get_id() == lookupVal then -- If the card ID is equal to the value set
                total = total + 1              -- add one to the total
            end
        end
    end
    return total -- and return the total
end
