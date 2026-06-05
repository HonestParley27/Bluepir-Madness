local function getModdedJoker(id, rarities)
    rarities = rarities or { 1, 2, 3 }
    id = id or "bpMadness" -- nill check

    print(rarities)
    print(id)

    local ret = {}
    for _, r in ipairs(rarities) do                      -- for each rarity
        for i, v in pairs(SMODS.Centers) do              -- for each object
            if v.set == "Joker" then                     -- if the object is a joker
                if v.rarity == r and v.mod.id == id then -- and the rarity and id match
                    ret[i] = true                        -- then its a bpmadness joker
                end
            end
        end
    end
    print(ret)
    return ret
end




SMODS.ObjectType({
    key = "BPMadness_Jokers",
    default = "j_jimbo",
    cards = getModdedJoker("bpMadness", { 1, 2, 3 })

})
