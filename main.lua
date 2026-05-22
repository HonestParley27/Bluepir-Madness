local modPath = "".. SMODS.current_mod.path

local files = NFS.getDirectoryItems(modPath.. "lib")
-- All Added Content should be within the lib folder, to ensure it's loaded.

for _,file in ipairs(files) do
	print("[BluePir Madness] Loading file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) --Steamodded actually does a really good job of displaying this info! So we don't need to do anything else.
	end
end

