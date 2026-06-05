local succ, https = pcall(require, "SMODS.https") -- Library from SMODS

BPMadness.community_mult = 476                    -- Fallback in case you're playing without internet

if not succ then
    sendErrorMessage("HTTP module could not be loaded. " .. tostring(https), "BluePirMadness") -- Error message
end

local last_update = 0       -- Update timer
local initial_update = true -- First update bool

local function apply_community_mult(code, body, headers)
    if body then                                                            -- body being http response
        local discord = tonumber(string.match(body, '"discord"%s*:%s*(%d+)'))
        local twitch = tonumber(string.match(body, '"twitch"%s*:%s*(%d+)')) -- i hate regex
        if discord and twitch then                                          -- both values must be valid
            BPMadness.community_mult = discord + twitch                     -- and add the two
        end
    end
end

function BPMadness.update_community_mult()
    if https and https.asyncRequest then                           -- if the library exists
        if (os.time() - last_update >= 300) or initial_update then -- either timer or first update
            initial_update = false                                 -- no more first update
            last_update = os.time()                                -- queue the timer
            https.asyncRequest(
                "https://bluepirs.justnotsebas.com/",              -- oh hey its me
                apply_community_mult                               -- run the function
            )
        end
    end
end
