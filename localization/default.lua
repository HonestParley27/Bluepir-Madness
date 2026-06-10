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
			["k_booster_group_p_bpm_mega_bluster_pack"] = "Mega Blueter Pack",
			["k_bpm_angelic"] = "Angelic",
			["k_booster_group_p_bpm_bluster_pack"] = "Bluster Pack",
			["k_booster_group_p_bpm_jumbo_bluster_pack"] = "Jumbo Bluster Pack",
		},
		["labels"] = {
			["bpm_cloud_seal"] = "Cloud Seal",
			["k_bpm_angelic"] = "Angelic",
			["bpm_witch_seal"] = "Witch Seal",
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
		["Blind"] = {
			["bl_wheel"] = {
				["text"] = {
					"#1# in #2# cards get",
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
				["group_name"] = "",
				["name"] = "Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
			["handsOfGod_ab1"] = {
				["name"] = "{C:dark_edition,E:1}Exponential{}",
				["text"] = {
					"{X:dark_edition,C:white}^e{} Mult",
					"Where {C:attention}e{} is the level of",
					"{C:attention}#1#{}",
				},
			},
			["p_bpm_mega_bluster_pack"] = {
				["group_name"] = "",
				["name"] = "Mega Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
			["p_bpm_jumbo_bluster_pack"] = {
				["group_name"] = "",
				["name"] = "Jumbo Bluster Pack",
				["text"] = {
					"Choose {C:blue}#1#{} out of {C:blue}#2#{} BluePir's Madness Jokers",
				},
			},
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
					"{X:mult,C:white} X#1# {} Mult when ",
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
	},
}
