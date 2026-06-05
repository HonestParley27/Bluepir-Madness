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

local evalHand = evaluate_poker_hand -- Original game function
function evaluate_poker_hand(hand)
    local ret = evalHand(hand)       -- LocalThunk why do you hate yourself this much

    if BPMadness.doubleVisionCheck then
        if #ret["Pair"] > 0 and #ret["Two Pair"] == 0 then -- If there's a least a pair but no two pairs...
            ret["Two Pair"] = ret["Pair"]                  -- then set the two pairs as the pairs
        end
    end
    return ret -- and return the madness back
end

local cardEval = eval_card -- Original game function
function eval_card(card, context)
    local ret, post = cardEval(card, context)
    return ret, post
end
