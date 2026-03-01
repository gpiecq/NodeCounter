----------------------------------------------------------------------
-- NodeCounter  –  GuideData.lua
-- Structured leveling guide data for Herbalism & Mining (1-375)
-- Classic (1-300) + TBC Outland (300-375)
-- Sources: wow-professions.com, taspas1po.fr
----------------------------------------------------------------------
local _, NS = ...

NS.GuideData = {
    herbs = {
        ---------------------------------------------------------
        -- Classic  (1-300)
        ---------------------------------------------------------
        {
            skillRange = {1, 70},
            label = "1 - 70",
            resources = { "Peacebloom", "Silverleaf", "Earthroot" },
            zones = {
                { zone = "Durotar",          faction = "horde" },
                { zone = "Mulgore",          faction = "horde" },
                { zone = "Tirisfal Glades",  faction = "horde" },
                { zone = "Elwynn Forest",    faction = "alliance" },
                { zone = "Dun Morogh",       faction = "alliance" },
                { zone = "Teldrassil",       faction = "alliance" },
            },
            tip = "Former Compagnon a 50 !",
        },
        {
            skillRange = {70, 115},
            label = "70 - 115",
            resources = { "Mageroyal", "Briarthorn", "Stranglekelp" },
            zones = {
                { zone = "The Barrens",       faction = "horde" },
                { zone = "Silverpine Forest", faction = "horde" },
                { zone = "Darkshore",         faction = "alliance" },
                { zone = "Loch Modan",        faction = "alliance" },
            },
        },
        {
            skillRange = {115, 170},
            label = "115 - 170",
            resources = { "Bruiseweed", "Wild Steelbloom", "Kingsblood", "Liferoot" },
            zones = {
                { zone = "Hillsbrad Foothills", faction = "both" },
                { zone = "Wetlands",            faction = "alliance" },
                { zone = "Stonetalon Mountains",faction = "both" },
            },
            tip = "Former Expert a 125 !",
        },
        {
            skillRange = {170, 205},
            label = "170 - 205",
            resources = { "Kingsblood", "Liferoot", "Fadeleaf", "Goldthorn", "Khadgar's Whisker" },
            zones = {
                { zone = "Stranglethorn Vale", faction = "both" },
                { zone = "Arathi Highlands",   faction = "both" },
            },
            tip = "Former Artisan a 200 !",
        },
        {
            skillRange = {205, 230},
            label = "205 - 230",
            resources = { "Purple Lotus", "Firebloom" },
            zones = {
                { zone = "Tanaris",        faction = "both" },
                { zone = "Searing Gorge",  faction = "both" },
            },
        },
        {
            skillRange = {230, 270},
            label = "230 - 270",
            resources = { "Sungrass", "Purple Lotus", "Ghost Mushroom", "Golden Sansam" },
            zones = {
                { zone = "The Hinterlands", faction = "both" },
            },
        },
        {
            skillRange = {270, 300},
            label = "270 - 300",
            resources = { "Sungrass", "Gromsblood", "Golden Sansam", "Dreamfoil", "Mountain Silversage", "Plaguebloom" },
            zones = {
                { zone = "Felwood", faction = "both" },
            },
            tip = "Former Maitre (TBC) a 275 !",
        },
        ---------------------------------------------------------
        -- TBC Outland  (300-375)
        ---------------------------------------------------------
        {
            skillRange = {300, 315},
            label = "300 - 315",
            resources = { "Felweed", "Dreaming Glory" },
            zones = {
                { zone = "Hellfire Peninsula", faction = "both" },
            },
            tip = "Formateur Horde : Ruak Stronghorn (Thrallmar) / Alliance : Rorelien (Honor Hold)",
        },
        {
            skillRange = {315, 325},
            label = "315 - 325",
            resources = { "Felweed", "Dreaming Glory" },
            zones = {
                { zone = "Nagrand",                faction = "both" },
                { zone = "Blade's Edge Mountains", faction = "both" },
            },
        },
        {
            skillRange = {325, 350},
            label = "325 - 350",
            resources = { "Felweed", "Dreaming Glory", "Terocone" },
            zones = {
                { zone = "Terokkar Forest", faction = "both" },
            },
        },
        {
            skillRange = {350, 375},
            label = "350 - 375",
            resources = { "Netherbloom", "Nightmare Vine", "Mana Thistle" },
            zones = {
                { zone = "Netherstorm", faction = "both" },
            },
        },
    },

    mining = {
        ---------------------------------------------------------
        -- Classic  (1-300)
        ---------------------------------------------------------
        {
            skillRange = {1, 65},
            label = "1 - 65",
            resources = { "Copper Ore" },
            zones = {
                { zone = "Durotar",          faction = "horde" },
                { zone = "Mulgore",          faction = "horde" },
                { zone = "Tirisfal Glades",  faction = "horde" },
                { zone = "Elwynn Forest",    faction = "alliance" },
                { zone = "Dun Morogh",       faction = "alliance" },
                { zone = "Darkshore",        faction = "alliance" },
            },
            tip = "Former Compagnon a 50 !",
        },
        {
            skillRange = {65, 125},
            label = "65 - 125",
            resources = { "Tin Ore", "Silver Ore" },
            zones = {
                { zone = "The Barrens",         faction = "horde" },
                { zone = "Hillsbrad Foothills", faction = "both" },
                { zone = "Redridge Mountains",  faction = "alliance" },
                { zone = "Ashenvale",           faction = "both" },
            },
            tip = "Former Expert a 125 !",
        },
        {
            skillRange = {125, 175},
            label = "125 - 175",
            resources = { "Iron Ore", "Gold Ore" },
            zones = {
                { zone = "Arathi Highlands",  faction = "both" },
                { zone = "Desolace",          faction = "both" },
                { zone = "Thousand Needles",  faction = "both" },
            },
        },
        {
            skillRange = {175, 245},
            label = "175 - 245",
            resources = { "Mithril Ore", "Truesilver Ore" },
            zones = {
                { zone = "The Hinterlands", faction = "both" },
                { zone = "Tanaris",         faction = "both" },
            },
            tip = "Former Artisan a 200 !",
        },
        {
            skillRange = {245, 275},
            label = "245 - 275",
            resources = { "Mithril Ore", "Truesilver Ore", "Thorium Ore" },
            zones = {
                { zone = "Un'Goro Crater",  faction = "both" },
                { zone = "Blasted Lands",   faction = "both" },
                { zone = "Felwood",         faction = "both" },
            },
            tip = "Former Maitre (TBC) a 275 !",
        },
        {
            skillRange = {275, 300},
            label = "275 - 300",
            resources = { "Thorium Ore", "Rich Thorium Vein" },
            zones = {
                { zone = "Un'Goro Crater",      faction = "both" },
                { zone = "Eastern Plaguelands",  faction = "both" },
                { zone = "Winterspring",         faction = "both" },
                { zone = "Burning Steppes",      faction = "both" },
            },
        },
        ---------------------------------------------------------
        -- TBC Outland  (300-375)
        ---------------------------------------------------------
        {
            skillRange = {300, 325},
            label = "300 - 325",
            resources = { "Fel Iron Ore" },
            zones = {
                { zone = "Hellfire Peninsula", faction = "both" },
            },
            tip = "Formateur Horde : Krugosh (Thrallmar) / Alliance : Hurnak Grimmord (Honor Hold)",
        },
        {
            skillRange = {325, 350},
            label = "325 - 350",
            resources = { "Adamantite Ore" },
            zones = {
                { zone = "Zangarmarsh",     faction = "both" },
                { zone = "Terokkar Forest", faction = "both" },
            },
        },
        {
            skillRange = {350, 375},
            label = "350 - 375",
            resources = { "Rich Adamantite Ore", "Khorium Ore" },
            zones = {
                { zone = "Nagrand",             faction = "both" },
                { zone = "Netherstorm",         faction = "both" },
                { zone = "Shadowmoon Valley",   faction = "both" },
            },
        },
    },
}

----------------------------------------------------------------------
-- Training thresholds
-- skill = level at which you should train, cap = current max
----------------------------------------------------------------------
NS.GuideTraining = {
    { skill = 50,  rank = "Compagnon",  cap = 75  },
    { skill = 125, rank = "Expert",     cap = 150 },
    { skill = 200, rank = "Artisan",    cap = 225 },
    { skill = 275, rank = "Maitre",     cap = 300 },
}
