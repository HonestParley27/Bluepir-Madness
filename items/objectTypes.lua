local function getModdedJoker(id, rarities)
    rarities = rarities or { 1, 2, 3 }
    id = id or "bpMadness"

    print(rarities)
    print(id)

    local ret = {}
    for _, r in ipairs(rarities) do
        for i, v in pairs(SMODS.Centers) do
            if v.set == "Joker" then
                if v.rarity == r and v.mod.id == id then
                    ret[i] = true
                end
            end
        end
    end
    print(ret)
    return ret
end




SMODS.ObjectType ({
    key = "BPMadness_Jokers",
    default = "j_jimbo",
    cards = getModdedJoker("bpMadness",{1,2,3})

})