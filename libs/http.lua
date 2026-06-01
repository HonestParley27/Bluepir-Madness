local succ, https = pcall(require, "SMODS.https")

BPMadness.community_mult = 476

if not succ then
    sendErrorMessage("HTTP module could not be loaded. " .. tostring(https), "BluePirMadness")
end

local last_update = 0
local initial_update = true

local function apply_community_mult(code, body, headers)
    if body then
        local discord = tonumber(string.match(body, '"discord"%s*:%s*(%d+)'))
        local twitch = tonumber(string.match(body, '"twitch"%s*:%s*(%d+)'))
        if discord and twitch then
            BPMadness.community_mult = discord + twitch
        end
    end
end

function BPMadness.update_community_mult()
    if https and https.asyncRequest then
        if (os.time() - last_update >= 300) or initial_update then
            initial_update = false
            last_update = os.time()
            https.asyncRequest(
                "https://bluepirs.justnotsebas.com/",
                apply_community_mult
            )
        end
    end
end
