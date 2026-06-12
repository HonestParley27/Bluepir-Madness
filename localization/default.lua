return {
	["misc"] = {
		["v_text"] = {
			["ch_c_no_pairs"] = {
				"All hands containing a {C:attention}Pair{} are disallowed.",
			},
			["ch_c_only_two_pairs"] = {
				"Only {C:attention}Two Pair{} hands will score",
			},
		},
		["challenge_names"] = {
			["c_bpm_bluepairs_challenge"] = "Bluep(a)irs Challenge",
			["c_bpm_orange_pairless"] = "Orange Pairless",
		},
		["dictionary"] = {
			["k_bpm_angelic"] = "Angelic",
			["k_booster_group_p_bpm_bluster_pack"] = "Bluster Pack",
			["k_booster_group_p_bpm_mega_bluster_pack"] = "Mega Bluster Pack",
			["k_booster_group_p_bpm_jumbo_bluster_pack"] = "Jumbo Bluster Pack",
			["k_bpm_zodiac"] = "Zodiac",
			["b_bpm_zodiac_cards"] = "Zodiac Cards",
			["k_booster_group_p_bpm_zodiac_pack"] = "Zodiac Pack",
			["k_booster_group_p_bpm_mega_zodiac_pack"] = "Mega Zodiac Pack",
			["k_booster_group_p_bpm_jumbo_zodiac_pack"] = "Jumbo Zodiac Pack",
		},
		["labels"] = {
			["bpm_witch_seal"] = "Witch Seal",
			["bpm_cloud_seal"] = "Cloud Seal",
			["k_bpm_angelic"] = "Angelic",
		},
	},
	["descriptions"] = {
		["Back"] = {
			["b_bpm_Blue Pairs"] = {
				["name"] = "Blue Pairs",
				["text"] = {
					"Start with a {C:attention,T:j_bpm_blue_pairs}Blue Pairs{} Joker,",
					"And two {C:tarot,T:c_wheel_of_fortune} Wheel of Fortunes {}",
				},
			},
		},
		["Other"] = {
			["bpm_cloud_seal"] = {
				["name"] = "Cloud Seal",
				["label"] = "Cloud Seal",
				["text"] = {
					"If Played hand is a {C:attention}Two Pair{}",
					"Retrigger this card #1# times",
				},
			},
			["bpm_witch_seal"] = {
				["name"] = "Witch Seal",
				["label"] = "Witch Seal",
				["text"] = {
					"If held in hand by end of round,",
					"apply a {C:attention}random enhancement{} to a random {E:1}Joker{}.",
				},
			},
			["p_bpm_bluster_pack"] = {
				["group_name"] = "Blusters",
				["name"] = "Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
			["p_bpm_mega_bluster_pack"] = {
				["group_name"] = "Blusters",
				["name"] = "Mega Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
			["p_bpm_jumbo_bluster_pack"] = {
				["group_name"] = "Blusters",
				["name"] = "Jumbo Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
			["p_bpm_zodiac_pack"] = {
				["group_name"] = "Zodiacs",
				["name"] = "Zodiac Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} Zodiac Cards",
				},
			},
			["p_bpm_mega_zodiac_pack"] = {
				["group_name"] = "Zodiacs",
				["name"] = "Mega Zodiac Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} Zodiac Cards",
				},
			},
			["p_bpm_jumbo_zodiac_pack"] = {
				["group_name"] = "Zodiacs",
				["name"] = "Jumbo Zodiac Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} Zodiac Cards",
				},
			},
			["handsOfGod_ab1"] = {
				["name"] = "{C:dark_edition,E:1}Exponential{}",
				["text"] = {
					"{X:dark_edition,C:white}^e{} Mult",
					"Where {C:attention}e{} is the level of",
					"{C:attention}#1#{}",
				},
			}
		},
		["Joker"] = {
			["j_bpm_hands_of_god"] = {
				["name"] = "Hands Of God",
				["text"] = {
					"aaaa",
				},
			},
			["j_bpm_herb_cat"] = {
				["name"] = "Herbcat",
				["text"] = {
					"For every 2 and 7 still in deck",
					"Adds {C:chips}+#1#{} chips",
					"Currently {C:chips}+#2#{}",
				},
			},
			["j_bpm_snowball"] = {
				["name"] = "Snowball",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult{}.",
					"Gains {X:mult,C:white} X#2# {} Mult{} per consecutive poker hand played.",
					"Current hand: {C:attention}#3#{}",
				},
			},
			["j_bpm_vanium_curse"] = {
				["name"] = "Vanium's Curse",
				["text"] = {
					"If hand has a scoring {C:attention}6 and 7 {}",
					"{C:green,E:1}#3# in #4#{} to give {X:mult,C:white}x#2#{} Mult",
					"otherwise gives {X:mult,C:white}x#1#{} Mult",
				},
			},
			["j_bpm_blind_joker"] = {
				["name"] = "Blind Joker",
				["text"] = {
					"Changes Blind Requirement by {X:blind,C:white}x#1#{}",
					"Gains {X:blind,C:white}x#2#{} if played hand is {C:attention}#4#{}",
					"Loses {X:blind,C:white}x#3#{} if played hand is not {C:attention}#4#{}",
					"{C:inactive,S:0.8}(Poker Hand changes each round){}",
				},
			},
			["j_bpm_skip_a_lime"] = {
				["name"] = "Skip A Lime",
				["text"] = {
					"Gains {C:money}$#1#{} per blind skipped.",
					"{X:mult,C:white} +#2# {} Mult",
					"where Mult is equal to Sell Value of Joker",
				},
			},
			["j_bpm_wood_chipper"] = {
				["name"] = "Wood Chipper",
				["text"] = {
					"If {C:attention}First Hand{} of round",
					"has only {C:attention}1{} card, Gains {C:attention}one-fourth{} of",
					"its rank as {X:chips,C:white}xChips{} and destroy card.",
					"Currently {X:chips,C:white}x#1#{} Chips",
				},
			},
			["j_bpm_angels"] = {
				["name"] = "{C:blue}Angels{}",
				["text"] = {
					"Gains {X:mult,C:white}x#2#{} Mult",
					"Per member of {C:blue}Blue's{} Discord, and each follower {C:blue}Blue{} has on Twitch",
					"Currently {X:mult,C:white}x#1#{} Mult",
				},
			},
			["j_bpm_ad_astra"] = {
				["name"] = "Ad Astra",
				["text"] = {
					"{X:mult,C:white} x#1# {} Mult for each time ",
					"{C:attention}poker hand{} has been played this run.",
				},
			},
			["j_bpm_bluefrin"] = {
				["name"] = "Bluefrin",
				["text"] = {
					"If played hand is a {C:attention}Two Pair{},",
					"prevents Death {C:green,E:1}#1# more time(s).{}",
					"{C:red,E:2}Self destructs.{}",
				},
			},
			["j_bpm_double_vision"] = {
				["name"] = "Double Vision",
				["text"] = {
					"All {C:attention,E:2}Pairs{} are now {C:attention,E:2}Two Pairs{}",
				},
			},
			["j_bpm_blue_pairs"] = {
				["name"] = "Blue Pairs",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult when",
					"{C:attention,E:2}Two Pair{} is played",
					"Gains {X:mult,C:white} X#2# {} Mult",
					"when {C:attention,E:2}Two Pair{} is played.",
				},
			},
			["j_bpm_australian_joker"] = {
				["name"] = "Australian Joker",
				["text"] = {
					"Swaps {C:mult}Mult{} and {C:chips}Chips{}",
					"on hand played",
				},
			},
			["j_bpm_short_circut"] = {
				["name"] = "Short Circut",
				["text"] = {
					"Sets Gamespeed to x#1#",
					"adds {C:white,X:mult} x#1# {} Mult",
				},
			},
			["j_bpm_lucky_cloud"] = {
				["name"] = "Lucky Cloud",
				["text"] = {
					"{C:green,E:1}#1# in #2#{} chance to level up poker hand,",
					"when {C:attention,E:2}Two Pair{} is played.",
				},
			},
		},
		["Spectral"] = {
			["c_bpm_hydration"] = {
				["name"] = "Hydration",
				["text"] = {
					"Adds {C:blue}Cloud{} Seal to",
					"{C:attention}#1#{} selected card ",
				},
			},
			["c_bpm_spectrum"] = {
				["name"] = "Spectrum",
				["text"] = {
					"Adds {C:purple}Witch{} Seal to",
					"{C:attention}#1#{} selected card ",
				},
			},
		},
		["bpm_zodiac"] = {
			["c_bpm_aries"] = {
				name = "Aries",
				text = {
					"Gain {C:blue}+2{} hands.",
					"First hand per round",
					"must be a {C:attention}High Card{}"
				}
			},
			["c_bpm_taurus"] = {
				name = "Taurus",
				text = {
					"Earn {C:money}$10{} at end of round.",
					"{X:mult,C:white}X2{} blind size."
				}
			},
			["c_bpm_gemini"] = {
				name = "Gemini",
				text = {
					"{C:blue}+2{} {C:attention}consumable{} slots.",
					"{C:red}-1{} {E:2}Joker{} slots."
				}
			},
			["c_bpm_cancer"] = {
				name = "Cancer",
				text = {
					"Creates a {C:G.C.DARK_EDITION,E:1}negative{} copy of {C:attention}Mr. Bones{}.",
					"You can {C:red}no longer skip {C:red,E:2}blinds.{}"
				}
			},
			["c_bpm_leo"] = {
				name = "Leo",
				text = {
					"All scored {C:attention}face cards{} give {X:mult,C:white}X3{} Mult.",
					"All {C:attention}numbered cards{} are debuffed."
				}
			},
			["c_bpm_virgo"] = {
				name = "Virgo",
				text = {
					"{C:mult}+1{} Mult for every remaining card in {C:blue}deck{}.",
					"Every {C:attention}discarded card{} costs {C:money}$1{}."
				}
			},
			["c_bpm_libra"] = {
				name = "Libra",
				text = {
					"{C:chips}Chips{} and {C:mult}Mult{} get balanced at end of hand.",
					"{C:red}-1{} {C:blue}hand{} and {C:red}discard{}."
				}
			},
			["c_bpm_scorpius"] = {
				name = "Scorpius",
				text = {
					"{C:enhancement}Level up{} most played poker hand {C:blue}5 times{}.",
					"Only {C:attention}the enhanced card{} will score."
				}
			},
			["c_bpm_sagittarius"] = {
				name = "Sagittarius",
				text = {
					"All {C:green,E:1}probabilities{} are {G:edition,E:1}guaranteed{}.",
					"{C:red}-2{} hand size."
				}
			},
			["c_bpm_capricornus"] = {
				name = "Capricornus",
				text = {
					"Gain {X:mult,C:white}XMult{} equal to the",
					"sum of {C:attention}sell value{} of all {E:2}Jokers{}.",
					"{C:attention}Destroy{} all {E:2}Jokers{}."
				}
			},
			["c_bpm_aquarius"] = {
				name = "Aquarius",
				text = {
					"All {C:attention}hands{} will score as your {C:attention,E:1}most played{} poker hand.",
					"All cards and packs in {C:attention}Shop{} are 25% {C:red}more expensive{}."
				}
			},
			["c_bpm_pisces"] = {
				name = "Pisces",
				text = {
					"Sets {C:attention}Ante{} to 0.",
					"Loses {C:money}half your ${} at end of round."
				}
			},
		},
	},
}
