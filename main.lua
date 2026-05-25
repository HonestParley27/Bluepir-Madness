local modPath = "".. SMODS.current_mod.path


-- All Added Content should be within the two below specified folder, to ensure it's loaded.

if not BPMadness then
    BPMadness = {}
end

-- Load all Items :3
local files = NFS.getDirectoryItems(modPath.."items")
for _,file in ipairs(files) do
	print("[BluePir Madness] Loading file " .. file)
    assert(SMODS.load_file("items/"..file))()
end

-- Load all silly functions
files = NFS.getDirectoryItems(modPath.."libs")
for _,file in ipairs(files) do
    print("[BluePir Madness] Loading file" .. file)
    assert(SMODS.load_file("libs/"..file))()
end