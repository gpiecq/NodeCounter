----------------------------------------------------------------------
-- NodeCounter  -  FarmingData.lua
-- Farming routes per resource: herbs & ores with zone-specific maps
-- All maps from wow-professions.com farming guides
----------------------------------------------------------------------
local _, NS = ...

local TEX = "Interface\\AddOns\\NodeCounter\\textures\\farming\\"

NS.FarmingData = {
    -----------------------------------------------------------------
    -- CLASSIC HERBS
    -----------------------------------------------------------------
    {
        name = "Peacebloom / Silverleaf",
        type = "herbs",
        skillRange = "1-70",
        zones = {
            { zone = "Tirisfal Glades", texture = TEX .. "peacebloom-silverleaf-tirisfal-glades" },
            { zone = "Elwynn Forest",   texture = TEX .. "peacebloom-silverleaf-elwynn-forest" },
            { zone = "Durotar",         texture = TEX .. "peacebloom-silverleaf-durotar" },
            { zone = "Dun Morogh",      texture = TEX .. "peacebloom-silverleaf-dun-morogh" },
            { zone = "Teldrassil",      texture = TEX .. "peacebloom-silverleaf-teldrassil" },
            { zone = "Mulgore",         texture = TEX .. "peacebloom-silverleaf-mulgore" },
        },
    },
    {
        name = "Briarthorn / Mageroyal",
        type = "herbs",
        skillRange = "50-100",
        zones = {
            { zone = "Hillsbrad Foothills", texture = TEX .. "briarthorn-mageroyal-hillsbrad" },
            { zone = "Darkshore",           texture = TEX .. "briarthorn-mageroyal-darkshore" },
        },
    },
    {
        name = "Stranglekelp",
        type = "herbs",
        skillRange = "85-135",
        zones = {
            { zone = "Wetlands", texture = TEX .. "stranglekelp-wetlands" },
        },
    },
    {
        name = "Bruiseweed",
        type = "herbs",
        skillRange = "100-150",
        zones = {
            { zone = "Stranglethorn Vale", texture = TEX .. "bruiseweed-stv" },
            { zone = "Ashenvale",          texture = TEX .. "bruiseweed-ashenvale" },
            { zone = "Wetlands",           texture = TEX .. "bruiseweed-wetlands" },
        },
    },
    {
        name = "Wild Steelbloom",
        type = "herbs",
        skillRange = "115-170",
        zones = {
            { zone = "Stranglethorn Vale", texture = TEX .. "wild-steelbloom-stv" },
            { zone = "Ashenvale",          texture = TEX .. "wild-steelbloom-ashenvale" },
        },
    },
    {
        name = "Grave Moss",
        type = "herbs",
        skillRange = "120-170",
        zones = {
            { zone = "Hillsbrad Foothills", texture = TEX .. "grave-moss-hillsbrad" },
            { zone = "Arathi Highlands",    texture = TEX .. "grave-moss-arathi" },
            { zone = "Wetlands",            texture = TEX .. "grave-moss-wetlands" },
            { zone = "Duskwood",            texture = TEX .. "grave-moss-duskwood" },
        },
    },
    {
        name = "Kingsblood",
        type = "herbs",
        skillRange = "125-175",
        zones = {
            { zone = "Stranglethorn Vale",  texture = TEX .. "kingsblood-stv" },
            { zone = "Western Plaguelands", texture = TEX .. "kingsblood-wpl" },
        },
    },
    {
        name = "Liferoot",
        type = "herbs",
        skillRange = "150-205",
        zones = {
            { zone = "Western Plaguelands", texture = TEX .. "liferoot-wpl" },
            { zone = "Eastern Plaguelands", texture = TEX .. "liferoot-epl" },
            { zone = "Stranglethorn Vale",  texture = TEX .. "liferoot-northern-stranglethorn" },
        },
    },
    {
        name = "Fadeleaf",
        type = "herbs",
        skillRange = "150-205",
        zones = {
            { zone = "Feralas",            texture = TEX .. "fadeleaf-feralas" },
            { zone = "Stranglethorn Vale", texture = TEX .. "fadeleaf-stv" },
        },
    },
    {
        name = "Goldthorn",
        type = "herbs",
        skillRange = "150-220",
        zones = {
            { zone = "The Hinterlands",    texture = TEX .. "goldthorn-hinterlands" },
            { zone = "Arathi Highlands",   texture = TEX .. "goldthorn-arathi" },
            { zone = "Dustwallow Marsh",   texture = TEX .. "goldthorn-dustwallow" },
        },
    },
    {
        name = "Khadgar's Whisker",
        type = "herbs",
        skillRange = "160-220",
        zones = {
            { zone = "Eastern Plaguelands",  texture = TEX .. "khadgars-whisker-eastern-plaguelands" },
            { zone = "Western Plaguelands",  texture = TEX .. "khadgars-whisker-western-plaguelands" },
        },
    },
    {
        name = "Firebloom",
        type = "herbs",
        skillRange = "205-255",
        zones = {
            { zone = "Burning Steppes", texture = TEX .. "firebloom-burning-steppes" },
            { zone = "Searing Gorge",   texture = TEX .. "firebloom-searing-gorge" },
            { zone = "Tanaris",         texture = TEX .. "firebloom-tanaris" },
        },
    },
    {
        name = "Sungrass",
        type = "herbs",
        skillRange = "230-270",
        zones = {
            { zone = "Thousand Needles",    texture = TEX .. "sungrass-thousand-needles" },
            { zone = "Eastern Plaguelands", texture = TEX .. "sungrass-eastern-plaguelands" },
        },
    },
    {
        name = "Purple Lotus",
        type = "herbs",
        skillRange = "210-250",
        zones = {
            { zone = "Felwood", texture = TEX .. "purple-lotus-felwood" },
        },
    },
    {
        name = "Blindweed",
        type = "herbs",
        skillRange = "235-275",
        zones = {
            { zone = "Feralas",             texture = TEX .. "blindweed-feralas" },
            { zone = "Western Plaguelands", texture = TEX .. "blindweed-western-plaguelands" },
        },
    },
    {
        name = "Ghost Mushroom",
        type = "herbs",
        skillRange = "245-275",
        zones = {
            { zone = "Un'Goro Crater", texture = TEX .. "ghost-mushroom-ungoro" },
            { zone = "Zangarmarsh",    texture = TEX .. "ghost-mushroom-zangarmarsh" },
        },
    },
    {
        name = "Gromsblood",
        type = "herbs",
        skillRange = "250-280",
        zones = {
            { zone = "Felwood", texture = TEX .. "gromsblood-felwood" },
        },
    },
    {
        name = "Golden Sansam",
        type = "herbs",
        skillRange = "260-300",
        zones = {
            { zone = "Swamp of Sorrows", texture = TEX .. "golden-sansam-swamp" },
            { zone = "Felwood",          texture = TEX .. "golden-sansam-felwood" },
        },
    },
    {
        name = "Dreamfoil",
        type = "herbs",
        skillRange = "270-300",
        zones = {
            { zone = "Blasted Lands", texture = TEX .. "dreamfoil-blasted-lands" },
            { zone = "Silithus",      texture = TEX .. "dreamfoil-silithus" },
        },
    },
    {
        name = "Mountain Silversage",
        type = "herbs",
        skillRange = "280-300",
        zones = {
            { zone = "Winterspring", texture = TEX .. "mountain-silversage-winterspring" },
            { zone = "Winterspring", texture = TEX .. "mountain-silversage-winterspring2" },
        },
    },
    {
        name = "Icecap",
        type = "herbs",
        skillRange = "290-300",
        zones = {
            { zone = "Winterspring", texture = TEX .. "icecap-winterspring" },
        },
    },
    {
        name = "Sorrowmoss",
        type = "herbs",
        skillRange = "285-300",
        zones = {
            { zone = "Swamp of Sorrows", texture = TEX .. "sorrowmoss-swamp-of-sorrows" },
        },
    },
    -----------------------------------------------------------------
    -- TBC HERBS
    -----------------------------------------------------------------
    {
        name = "Felweed",
        type = "herbs",
        skillRange = "300-325",
        zones = {
            { zone = "Blade's Edge Mountains", texture = TEX .. "felweed-blades-edge" },
            { zone = "Nagrand",                texture = TEX .. "felweed-nagrand" },
        },
    },
    {
        name = "Dreaming Glory",
        type = "herbs",
        skillRange = "315-350",
        zones = {
            { zone = "Blade's Edge Mountains", texture = TEX .. "dreaming-glory-blades-edge" },
            { zone = "Nagrand",                texture = TEX .. "dreaming-glory-nagrand" },
        },
    },
    {
        name = "Terocone",
        type = "herbs",
        skillRange = "325-350",
        zones = {
            { zone = "Terokkar Forest", texture = TEX .. "terocone-terokkar" },
            { zone = "Terokkar Forest", texture = TEX .. "terocone-terokkar2" },
        },
    },
    {
        name = "Ragveil",
        type = "herbs",
        skillRange = "325-350",
        zones = {
            { zone = "Zangarmarsh", texture = TEX .. "ragveil-zangarmarsh" },
            { zone = "Zangarmarsh", texture = TEX .. "ragveil-zangarmarsh2" },
            { zone = "Zangarmarsh", texture = TEX .. "ragveil-zangarmarsh3" },
        },
    },
    {
        name = "Nightmare Vine",
        type = "herbs",
        skillRange = "365-375",
        zones = {
            { zone = "Shadowmoon Valley", texture = TEX .. "nightmare-vine-shadowmoon" },
            { zone = "Blade's Edge Mountains", texture = TEX .. "nightmare-vine-blades-edge" },
        },
    },
    {
        name = "Netherbloom",
        type = "herbs",
        skillRange = "350-375",
        zones = {
            { zone = "Netherstorm", texture = TEX .. "netherbloom-netherstorm" },
            { zone = "Netherstorm", texture = TEX .. "netherbloom-netherstorm2" },
        },
    },
    -----------------------------------------------------------------
    -- CLASSIC ORES
    -----------------------------------------------------------------
    {
        name = "Copper Ore",
        type = "mining",
        skillRange = "1-65",
        zones = {
            { zone = "Durotar",   texture = TEX .. "copper-ore-durotar" },
            { zone = "Darkshore", texture = TEX .. "copper-ore-darkshore" },
        },
    },
    {
        name = "Tin Ore",
        type = "mining",
        skillRange = "50-125",
        zones = {
            { zone = "Hillsbrad Foothills",  texture = TEX .. "tin-ore-hillsbrad" },
            { zone = "Stranglethorn Vale",   texture = TEX .. "tin-ore-stranglethorn" },
        },
    },
    {
        name = "Iron Ore",
        type = "mining",
        skillRange = "100-175",
        zones = {
            { zone = "Feralas",             texture = TEX .. "iron-ore-feralas" },
            { zone = "Western Plaguelands", texture = TEX .. "iron-ore-wpl" },
        },
    },
    {
        name = "Mithril Ore",
        type = "mining",
        skillRange = "150-250",
        zones = {
            { zone = "Burning Steppes", texture = TEX .. "mithril-ore-burning-steppes" },
            { zone = "Badlands",        texture = TEX .. "mithril-ore-badlands" },
            { zone = "Felwood",         texture = TEX .. "mithril-ore-felwood" },
        },
    },
    {
        name = "Thorium Ore",
        type = "mining",
        skillRange = "200-300",
        zones = {
            { zone = "Winterspring",    texture = TEX .. "thorium-ore-winterspring" },
            { zone = "Un'Goro Crater",  texture = TEX .. "thorium-ore-ungoro" },
            { zone = "Silithus",        texture = TEX .. "thorium-ore-silithus" },
        },
    },
    -----------------------------------------------------------------
    -- TBC ORES
    -----------------------------------------------------------------
    {
        name = "Fel Iron Ore",
        type = "mining",
        skillRange = "300-325",
        zones = {
            { zone = "Hellfire Peninsula", texture = TEX .. "fel-iron-ore-hellfire" },
            { zone = "Hellfire Peninsula", texture = TEX .. "fel-iron-ore-hellfire-2" },
            { zone = "Terokkar Forest",    texture = TEX .. "fel-iron-ore-terokkar" },
            { zone = "Zangarmarsh",        texture = TEX .. "fel-iron-ore-zangarmarsh" },
        },
    },
    {
        name = "Adamantite Ore",
        type = "mining",
        skillRange = "325-375",
        zones = {
            { zone = "Nagrand",            texture = TEX .. "adamantite-ore-nagrand" },
            { zone = "Netherstorm",        texture = TEX .. "adamantite-ore-netherstorm" },
            { zone = "Shadowmoon Valley",  texture = TEX .. "adamantite-ore-shadowmoon" },
        },
    },
}

----------------------------------------------------------------------
-- Build filtered index lists for navigation
----------------------------------------------------------------------
NS.FarmingHerbList = {}
NS.FarmingMiningList = {}

for i, entry in ipairs(NS.FarmingData) do
    if entry.type == "herbs" then
        NS.FarmingHerbList[#NS.FarmingHerbList + 1] = i
    elseif entry.type == "mining" then
        NS.FarmingMiningList[#NS.FarmingMiningList + 1] = i
    end
end
