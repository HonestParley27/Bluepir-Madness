local modPath = "".. SMODS.current_mod.path

local files = NFS.getDirectoryItems(modPath.. "lib")
-- All Added Content should be within the lib folder, to ensure it's loaded.

for _,file in ipairs(files) do
	print("[BluePir Madness] Loading file " .. file)
    assert(SMODS.load_file("lib/"..file))()
end
