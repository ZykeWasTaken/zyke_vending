Config = Config or {}

Config.Settings = {
	props = {
		["default"] = {
			model = "prop_ld_flow_bottle",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["water_bottle"] = {
			model = "prop_ld_flow_bottle",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["sprunk"] = {
			model = "prop_ld_can_01b",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["ecola"] = {
			model = "prop_ecola_can",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["orango_tang"] = {
			model = "prop_orang_can_01",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["junk"] = {
			model = "sf_prop_sf_can_01a",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["phatchips_bigcheese"] = {
			model = "prop_ld_snack_01",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["phatchips_habernero"] = {
			model = "prop_choc_meto",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["coffee"] = {
			model = "ng_proc_coffee_01a",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
		["meteorite_bar"] = {
			model = "prop_choc_meto",
			offset = vector3(0.123, -0.039, 0.033),
			rotation = vector3(-103.202, -68.066, 2.815),
			bone = 18905,
		},
	},

	machines = {
		-- [====================] SODA MACHINES [====================]

		-- https://forge.plebmasters.de/objects/ch_chint10_vending_smallroom_01
		[`ch_chint10_vending_smallroom_01`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},

		-- https://forge.plebmasters.de/objects/sf_prop_sf_vend_drink_01a
		[`sf_prop_sf_vend_drink_01a`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},
		-- https://forge.plebmasters.de/objects/prop_vend_soda_02
		[`prop_vend_soda_02`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},

		-- https://forge.plebmasters.de/objects/prop_vend_soda_01
		[`prop_vend_soda_01`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},
		-- https://forge.plebmasters.de/objects/m23_2_prop_m32_vend_drink_01a
		[`m23_2_prop_m32_vend_drink_01a`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},
		-- https://forge.plebmasters.de/objects/v_68_broeknvend
		[`v_68_broeknvend`] = { -- Broken? Keep in if you want
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "sprunk", prop = "sprunk", price = 2},
				{name = "ecola", prop = "ecola", price = 2},
				{name = "orango_tang", prop = "orango_tang", price = 2},
				{name = "junk", prop = "junk", price = 2}
			}
		},

		-- [====================] SNACK MACHINES [====================]

		-- https://forge.plebmasters.de/objects/prop_vend_snak_01_tu
		[`prop_vend_snak_01_tu`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "phatchips_bigcheese", prop = "phatchips_bigcheese", price = 2},
				{name = "phatchips_habernero", prop = "phatchips_habernero", price = 2},
				{name = "meteorite_bar", prop = "meteorite_bar", price = 2},
			}
		},

		-- https://forge.plebmasters.de/objects/prop_vend_snak_01
		[`prop_vend_snak_01`] = {
			interactOffset = vector3(0.0, -0.97, 0.05),
			items = {
				{name = "phatchips_bigcheese", prop = "phatchips_bigcheese", price = 2},
				{name = "phatchips_habernero", prop = "phatchips_habernero", price = 2},
				{name = "meteorite_bar", prop = "meteorite_bar", price = 2},
			}
		},

		-- [====================] WATER MACHINES [====================]

		-- https://forge.plebmasters.de/objects/prop_vend_water_01
		[`prop_vend_water_01`] = {
			interactOffset = vector3(0.0, -0.8, 0.8),
			items = {
				{name = "water", prop = "water_bottle", price = 1},
				-- {name = "water_50cl", prop = "water_bottle", price = 1}, -- For those that use zyke_consumable
			}
		},

		-- [====================] COFFEE MACHINES [====================]

		-- https://forge.plebmasters.de/objects/prop_vend_coffe_01
		[`prop_vend_coffe_01`] = {
			interactOffset = vector3(0.0, -0.8, 0.8),
			items = {
				{name = "coffee", prop = "coffee", price = 2},
			}
		},
	}
}