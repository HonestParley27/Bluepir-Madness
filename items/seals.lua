SMODS.Atlas { -- sprite for cloud seal
    key = "Blue_Seal",
    path = "BluePirsSeals.png",
    px = 71,
    py = 95
}

SMODS.DrawStep {
    key = 'seal',
    order = 30,
    func = function(self, layer)
        local seal = G.P_SEALS[self.seal] or {}
        if self.ability.delay_seal then return end
        if type(seal.draw) == 'function' then
            seal:draw(self, layer)
        elseif self.seal then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' or self.seal == 'bpm_nitro' then
                G.shared_seals[self.seal]:draw_shader('voucher', nil,
                    self.ARGS.send_to_shader, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Seal {
    key          = "cloud",
    badge_colour = G.C.CHIPS,
    atlas        = "Blue_Seal",
    pos          = { x = 0, y = 0 },

    config       = { extra = {
        repeatTimes = 2 -- repeat two times
    } },

    loc_vars     = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.repeatTimes
            }
        }
    end,
    calculate    = function(self, card, context)
        if context.repetition and context.scoring_name == "Two Pair" then -- if the scoring hand is a two pair
            return {
                repetitions = self.config.extra.repeatTimes,              -- repeat #repeatTimes
                card = card                                               -- the card played
            }
        end
    end
}

SMODS.Seal {
    key          = "witch",
    badge_colour = G.C.PURPLE,
    atlas        = "Blue_Seal",
    pos          = { x = 1, y = 0 },
    config       = {
        extra = {
        }
    },
    calculate    = function(self, card, context)
        if context.end_of_round and context.cardarea == G.hand and context.other_card == card then
            local random_joker = nil
            local random_edition = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                    if #editionless_jokers > 0 then
                        local editions = {}
                        for _, edition in ipairs(G.P_CENTER_POOLS["Edition"]) do
                            if edition.in_shop then
                                editions[#editions + 1] = edition.key
                            end
                        end
                        random_joker = pseudorandom_element(editionless_jokers, "Witch Seal")
                        random_edition = pseudorandom_element(editions, "Witch Seal")
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if random_joker then
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    if random_joker and random_edition then
                        random_joker:set_edition(random_edition, true)
                    end
                    return true
                end
            }))
        end
    end
}

SMODS.Seal {
    key          = "nitro",
    badge_colour = G.C.DARK_EDITION,
    atlas        = "Blue_Seal",
    pos          = { x = 2, y = 0 },
    config       = {
        extra = {
        }
    },
    calculate    = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = math.floor(card:get_id() / 2)
            }
        end
    end
}
