local gameStart = Game.start_run
function Game:start_run(...)
    local ret = gameStart(self, ...)
    G.GAME.zodiac = G.GAME.zodiac or {}
    return ret
end

local upd = Game.update -- Save the original game functions
function Game:update(dt)
    upd(self, dt)

    if not BPMadness.memberDelay then
        BPMadness.memberDelay = 0 -- Set up the delay
    end
    if (BPMadness.memberDelay > 20) or not BPMadness.community_mult then
        if BPMadness.update_community_mult then
            BPMadness.update_community_mult() -- Update the community_mult for the Angels joker
            print(BPMadness.community_mult)
        end
        BPMadness.memberDelay = 0
    else
        BPMadness.memberDelay = BPMadness.memberDelay + dt -- Delayed on deltatime
    end
end

local evalHand = evaluate_poker_hand                       -- Original game function
function evaluate_poker_hand(hand)
    local ret = evalHand(hand)                             -- LocalThunk why do you hate yourself this much
    if SMODS.find_card('j_bpm_double_vision') and #SMODS.find_card('j_bpm_double_vision') > 0 then
        if #ret["Pair"] > 0 and #ret["Two Pair"] == 0 then -- If there's a least a pair but no two pairs...
            ret["Two Pair"] = ret["Pair"]                  -- then set the two pairs as the pairs
        end
    end
    if G.GAME.zodiac.aquarius then
        if #ret[G.GAME.zodiac.aquarius_hand] == 0 then
            table.insert(ret[G.GAME.zodiac.aquarius_hand], hand[1])
        end
    end
    if G.GAME.zodiac.scorpius then
        if #ret[G.GAME.zodiac.scorpius_hand] == 0 then
            table.insert(ret[G.GAME.zodiac.scorpius_hand], hand[1])
        end
    end
    return ret -- and return the madness back
end

local cardEval = eval_card -- Original game function
function eval_card(card, context)
    local ret, post = cardEval(card, context)
    return ret, post
end

local createBlindUI = create_UIBox_blind_tag
function create_UIBox_blind_tag(blind_choice, run_info)
    if G.GAME.zodiac.cancer then
        return nil
    end

    local blindUI = createBlindUI(blind_choice, run_info)
    return blindUI
end
