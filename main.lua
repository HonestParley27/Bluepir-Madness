local modPath = "" .. SMODS.current_mod.path

if not BPMadness then
    BPMadness = {}
end

-- All mod content is located within the ./items and ./libs folders

-- Load all items :3
local files = NFS.getDirectoryItems(modPath .. "items")
for _, file in ipairs(files) do
    print("[BluePir Madness] Loading file " .. file)
    assert(SMODS.load_file("items/" .. file))()
end

-- Load all silly functions
files = NFS.getDirectoryItems(modPath .. "libs")
for _, file in ipairs(files) do
    print("[BluePir Madness] Loading file" .. file)
    assert(SMODS.load_file("libs/" .. file))()
end
