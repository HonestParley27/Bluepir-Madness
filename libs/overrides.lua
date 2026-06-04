local upd = Game.update
function Game:update(dt)
    upd(self, dt)
    if not BPMadness.memberDelay then
        BPMadness.memberDelay = 0
    end
    if (BPMadness.memberDelay > 20) or not BPMadness.community_mult then
        if BPMadness.update_community_mult then
            BPMadness.update_community_mult()
            print(BPMadness.community_mult)
        end -- i honestly hate nil checks like this, wish there was a shorthand
        BPMadness.memberDelay = 0
    else
        BPMadness.memberDelay = BPMadness.memberDelay + dt
    end
end

local evalHand = evaluate_poker_hand
function evaluate_poker_hand(hand)
    local ret = evalHand(hand)

    if BPMadness.doubleVisionCheck then
        if #ret["Pair"] > 0 and #ret["Two Pair"] == 0 then
            ret ["Two Pair"] = ret["Pair"]
        end
    end


    return ret
end

local cardEval = eval_card
function eval_card(card, context)
    local ret = cardEval(card, context)
    print(ret)
    return ret
end