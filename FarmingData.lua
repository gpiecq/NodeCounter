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
    -----------------------------------------------------------------
    -- TBC GAS CLOUDS
    -----------------------------------------------------------------
    {
        name = "Windy Cloud",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Nagrand", texture = TEX .. "windy-cloud-nagrand" },
        },
    },
    {
        name = "Swamp Gas",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Zangarmarsh", texture = TEX .. "swamp-gas-zangarmarsh" },
        },
    },
    {
        name = "Felmist",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Shadowmoon Valley", texture = TEX .. "felmist-shadowmoon" },
        },
    },
    {
        name = "Arcane Vortex",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Netherstorm", texture = TEX .. "arcane-vortex-netherstorm" },
        },
    },
}

----------------------------------------------------------------------
-- Build filtered index lists for navigation
----------------------------------------------------------------------
NS.FarmingHerbList = {}
NS.FarmingMiningList = {}
NS.FarmingGasList = {}

for i, entry in ipairs(NS.FarmingData) do
    if entry.type == "herbs" then
        NS.FarmingHerbList[#NS.FarmingHerbList + 1] = i
    elseif entry.type == "mining" then
        NS.FarmingMiningList[#NS.FarmingMiningList + 1] = i
    elseif entry.type == "gases" then
        NS.FarmingGasList[#NS.FarmingGasList + 1] = i
    end
end

----------------------------------------------------------------------
-- Build inverse lookup: zone → resources available in that zone
----------------------------------------------------------------------
NS.ZoneResources = {}  -- [zoneKey][type] = { { name, skillRange, sortKey }, ... }

-- Helper: add a resource entry to ZoneResources, deduplicating by name
local function AddZoneResource(zKey, rType, name, skillRange)
    if not NS.ZoneResources[zKey] then NS.ZoneResources[zKey] = {} end
    if not NS.ZoneResources[zKey][rType] then NS.ZoneResources[zKey][rType] = {} end
    local list = NS.ZoneResources[zKey][rType]
    for _, existing in ipairs(list) do
        if existing.name == name then return end
    end
    list[#list + 1] = {
        name = name,
        skillRange = skillRange,
        sortKey = tonumber(skillRange:match("^(%d+)")) or 0,
    }
end

-- 1) Populate from FarmingData (resources with dedicated farming route maps)
for _, entry in ipairs(NS.FarmingData) do
    for _, zoneInfo in ipairs(entry.zones) do
        AddZoneResource(zoneInfo.zone, entry.type, entry.name, entry.skillRange)
    end
end

-- 2) Supplementary data: resources that exist in each zone but have no
--    dedicated farming route map in FarmingData.
local Extra = {
    -----------------------------------------------------------------
    -- Starting zones (Skill 1-70)
    -----------------------------------------------------------------
    ["Durotar"] = {
        herbs  = { { "Earthroot", "15-70" } },
    },
    ["Mulgore"] = {
        herbs  = { { "Earthroot", "15-70" } },
        mining = { { "Copper Ore", "1-65" } },
    },
    ["Tirisfal Glades"] = {
        herbs  = { { "Earthroot", "15-70" } },
        mining = { { "Copper Ore", "1-65" } },
    },
    ["Dun Morogh"] = {
        herbs  = { { "Earthroot", "15-70" } },
        mining = { { "Copper Ore", "1-65" } },
    },
    ["Elwynn Forest"] = {
        herbs  = { { "Earthroot", "15-70" } },
        mining = { { "Copper Ore", "1-65" } },
    },
    ["Teldrassil"] = {
        herbs  = { { "Earthroot", "15-70" } },
    },
    ["Darkshore"] = {
        herbs  = { { "Earthroot", "15-70" }, { "Stranglekelp", "85-135" } },
        mining = { { "Tin Ore", "65-125" } },
    },
    -----------------------------------------------------------------
    -- Skill 50-125
    -----------------------------------------------------------------
    ["The Barrens"] = {
        herbs  = {
            { "Earthroot", "15-70" },
            { "Briarthorn / Mageroyal", "50-100" },
            { "Stranglekelp", "85-135" },
            { "Bruiseweed", "100-150" },
        },
        mining = {
            { "Copper Ore", "1-65" },
            { "Tin Ore", "65-125" },
            { "Silver Ore", "75-150" },
        },
    },
    ["Silverpine Forest"] = {
        herbs  = {
            { "Earthroot", "15-70" },
            { "Briarthorn / Mageroyal", "50-100" },
            { "Stranglekelp", "85-135" },
        },
        mining = {
            { "Copper Ore", "1-65" },
            { "Tin Ore", "65-125" },
        },
    },
    ["Loch Modan"] = {
        herbs  = {
            { "Earthroot", "15-70" },
            { "Briarthorn / Mageroyal", "50-100" },
        },
        mining = {
            { "Copper Ore", "1-65" },
            { "Tin Ore", "65-125" },
            { "Silver Ore", "75-150" },
        },
    },
    -----------------------------------------------------------------
    -- Skill 100-175
    -----------------------------------------------------------------
    ["Hillsbrad Foothills"] = {
        herbs  = {
            { "Stranglekelp", "85-135" },
            { "Bruiseweed", "100-150" },
            { "Wild Steelbloom", "115-170" },
            { "Kingsblood", "125-175" },
            { "Liferoot", "150-205" },
        },
        mining = {
            { "Silver Ore", "75-150" },
            { "Iron Ore", "125-175" },
        },
    },
    ["Wetlands"] = {
        herbs  = {
            { "Briarthorn / Mageroyal", "50-100" },
            { "Wild Steelbloom", "115-170" },
            { "Kingsblood", "125-175" },
            { "Liferoot", "150-205" },
        },
        mining = {
            { "Tin Ore", "65-125" },
            { "Iron Ore", "125-175" },
        },
    },
    ["Stonetalon Mountains"] = {
        herbs  = {
            { "Briarthorn / Mageroyal", "50-100" },
            { "Bruiseweed", "100-150" },
            { "Wild Steelbloom", "115-170" },
            { "Kingsblood", "125-175" },
        },
        mining = {
            { "Tin Ore", "65-125" },
            { "Silver Ore", "75-150" },
            { "Iron Ore", "125-175" },
        },
    },
    ["Redridge Mountains"] = {
        mining = {
            { "Copper Ore", "1-65" },
            { "Tin Ore", "65-125" },
            { "Silver Ore", "75-150" },
        },
    },
    ["Ashenvale"] = {
        herbs  = {
            { "Briarthorn / Mageroyal", "50-100" },
            { "Stranglekelp", "85-135" },
            { "Kingsblood", "125-175" },
        },
        mining = {
            { "Tin Ore", "65-125" },
            { "Silver Ore", "75-150" },
            { "Iron Ore", "125-175" },
        },
    },
    -----------------------------------------------------------------
    -- Skill 125-230
    -----------------------------------------------------------------
    ["Stranglethorn Vale"] = {
        herbs  = {
            { "Goldthorn", "150-220" },
            { "Khadgar's Whisker", "160-220" },
        },
        mining = {
            { "Iron Ore", "125-175" },
            { "Gold Ore", "155-205" },
            { "Mithril Ore", "175-250" },
        },
    },
    ["Arathi Highlands"] = {
        herbs  = {
            { "Wild Steelbloom", "115-170" },
            { "Kingsblood", "125-175" },
            { "Liferoot", "150-205" },
            { "Fadeleaf", "150-205" },
        },
        mining = {
            { "Iron Ore", "125-175" },
            { "Gold Ore", "155-205" },
            { "Mithril Ore", "175-250" },
        },
    },
    ["Desolace"] = {
        herbs  = {
            { "Kingsblood", "125-175" },
            { "Liferoot", "150-205" },
            { "Gromsblood", "250-280" },
        },
        mining = {
            { "Iron Ore", "125-175" },
            { "Gold Ore", "155-205" },
            { "Mithril Ore", "175-250" },
        },
    },
    ["Thousand Needles"] = {
        herbs  = {
            { "Purple Lotus", "210-250" },
        },
        mining = {
            { "Iron Ore", "125-175" },
            { "Gold Ore", "155-205" },
            { "Mithril Ore", "175-250" },
        },
    },
    -----------------------------------------------------------------
    -- Skill 205-300
    -----------------------------------------------------------------
    ["Tanaris"] = {
        herbs  = {
            { "Purple Lotus", "210-250" },
            { "Sungrass", "230-270" },
        },
        mining = {
            { "Mithril Ore", "175-250" },
            { "Truesilver Ore", "205-250" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["Searing Gorge"] = {
        herbs  = {
            { "Sungrass", "230-270" },
        },
        mining = {
            { "Mithril Ore", "175-250" },
            { "Truesilver Ore", "205-250" },
            { "Dark Iron Ore", "230+" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["The Hinterlands"] = {
        herbs  = {
            { "Khadgar's Whisker", "160-220" },
            { "Purple Lotus", "210-250" },
            { "Sungrass", "230-270" },
            { "Blindweed", "235-275" },
            { "Ghost Mushroom", "245-275" },
        },
        mining = {
            { "Mithril Ore", "175-250" },
            { "Truesilver Ore", "205-250" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["Felwood"] = {
        herbs  = {
            { "Sungrass", "230-270" },
            { "Dreamfoil", "270-300" },
            { "Mountain Silversage", "280-300" },
            { "Plaguebloom", "285-300" },
        },
        mining = {
            { "Truesilver Ore", "205-250" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["Un'Goro Crater"] = {
        herbs  = {
            { "Sungrass", "230-270" },
            { "Blindweed", "235-275" },
            { "Golden Sansam", "260-300" },
            { "Dreamfoil", "270-300" },
            { "Mountain Silversage", "280-300" },
        },
        mining = {
            { "Mithril Ore", "175-250" },
            { "Truesilver Ore", "205-250" },
        },
    },
    ["Blasted Lands"] = {
        herbs  = {
            { "Gromsblood", "250-280" },
        },
        mining = {
            { "Mithril Ore", "175-250" },
            { "Truesilver Ore", "205-250" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["Eastern Plaguelands"] = {
        herbs  = {
            { "Golden Sansam", "260-300" },
            { "Dreamfoil", "270-300" },
            { "Mountain Silversage", "280-300" },
            { "Plaguebloom", "285-300" },
        },
        mining = {
            { "Truesilver Ore", "205-250" },
            { "Thorium Ore", "245-300" },
        },
    },
    ["Burning Steppes"] = {
        herbs  = {
            { "Sungrass", "230-270" },
            { "Dreamfoil", "270-300" },
            { "Mountain Silversage", "280-300" },
        },
        mining = {
            { "Dark Iron Ore", "230+" },
            { "Thorium Ore", "245-300" },
        },
    },
    -----------------------------------------------------------------
    -- TBC Outland (Skill 300-375)
    -----------------------------------------------------------------
    ["Hellfire Peninsula"] = {
        herbs  = {
            { "Felweed", "300-325" },
            { "Dreaming Glory", "315-350" },
        },
        mining = {
            { "Adamantite Ore", "325-375" },
        },
    },
    ["Zangarmarsh"] = {
        herbs  = {
            { "Felweed", "300-325" },
            { "Dreaming Glory", "315-350" },
        },
        mining = {
            { "Adamantite Ore", "325-375" },
        },
    },
    ["Terokkar Forest"] = {
        herbs  = {
            { "Felweed", "300-325" },
            { "Dreaming Glory", "315-350" },
        },
        mining = {
            { "Adamantite Ore", "325-375" },
        },
    },
    ["Nagrand"] = {
        mining = {
            { "Fel Iron Ore", "300-325" },
            { "Khorium Ore", "375" },
        },
    },
    ["Blade's Edge Mountains"] = {
        herbs  = {
            { "Mana Thistle", "375" },
        },
        mining = {
            { "Fel Iron Ore", "300-325" },
            { "Adamantite Ore", "325-375" },
            { "Khorium Ore", "375" },
        },
    },
    ["Netherstorm"] = {
        herbs  = {
            { "Dreaming Glory", "315-350" },
            { "Nightmare Vine", "365-375" },
            { "Mana Thistle", "375" },
        },
        mining = {
            { "Fel Iron Ore", "300-325" },
            { "Khorium Ore", "375" },
        },
    },
    ["Shadowmoon Valley"] = {
        herbs  = {
            { "Felweed", "300-325" },
            { "Dreaming Glory", "315-350" },
            { "Mana Thistle", "375" },
        },
        mining = {
            { "Fel Iron Ore", "300-325" },
            { "Khorium Ore", "375" },
        },
    },
}

-- Merge supplementary data into ZoneResources
for zKey, types in pairs(Extra) do
    for rType, entries in pairs(types) do
        for _, e in ipairs(entries) do
            AddZoneResource(zKey, rType, e[1], e[2])
        end
    end
end

-- Sort each zone's resource list by minimum skill level
for _, types in pairs(NS.ZoneResources) do
    for _, list in pairs(types) do
        table.sort(list, function(a, b) return a.sortKey < b.sortKey end)
    end
end
