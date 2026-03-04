----------------------------------------------------------------------
-- NodeCounter  –  RoutesData.lua
-- Route data for each zone: texture paths, faction, skill range
-- All maps from wow-professions.com (Classic + TBC)
----------------------------------------------------------------------
local _, NS = ...

local TEX = "Interface\\AddOns\\NodeCounter\\textures\\"

NS.RoutesData = {
    -----------------------------------------------------------------
    -- HORDE starting zones  (Skill 1-70)
    -----------------------------------------------------------------
    ["Durotar"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "durotar-herbo" },
        mining = { texture = TEX .. "durotar-minage" },
    },
    ["Mulgore"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "mulgore-herbo" },
        mining = { texture = TEX .. "mulgore-minage" },
    },
    ["Tirisfal Glades"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "tirisfal-herbo" },
        mining = { texture = TEX .. "tirisfal-minage" },
    },

    -----------------------------------------------------------------
    -- ALLIANCE starting zones  (Skill 1-70)
    -----------------------------------------------------------------
    ["Dun Morogh"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "dun-morogh-herbo" },
        mining = { texture = TEX .. "dun-morogh-minage" },
    },
    ["Elwynn Forest"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "elwynn-herbo" },
        mining = { texture = TEX .. "elwynn-minage" },
    },
    ["Teldrassil"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "teldrassil-herbo" },
    },
    ["Darkshore"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "darkshore-herbo" },
        mining = { texture = TEX .. "darkshore-minage" },
    },

    -----------------------------------------------------------------
    -- Skill 70-115
    -----------------------------------------------------------------
    ["The Barrens"] = {
        faction = "horde", skillRange = "70-125",
        herbs  = { texture = TEX .. "barrens-herbo" },
        mining = { texture = TEX .. "barrens-minage" },
    },
    ["Silverpine Forest"] = {
        faction = "horde", skillRange = "70-115",
        herbs  = { texture = TEX .. "silverpine-herbo" },
    },
    ["Loch Modan"] = {
        faction = "alliance", skillRange = "70-115",
        herbs  = { texture = TEX .. "loch-modan-herbo" },
    },

    -----------------------------------------------------------------
    -- Skill 115-175
    -----------------------------------------------------------------
    ["Hillsbrad Foothills"] = {
        faction = "both", skillRange = "115-170",
        herbs  = { texture = TEX .. "hillsbrad-herbo" },
        mining = { texture = TEX .. "hillsbrad-minage" },
    },
    ["Wetlands"] = {
        faction = "alliance", skillRange = "115-170",
        herbs  = { texture = TEX .. "wetlands-herbo" },
    },
    ["Stonetalon Mountains"] = {
        faction = "both", skillRange = "115-170",
        herbs  = { texture = TEX .. "stonetalon-herbo" },
    },
    ["Redridge Mountains"] = {
        faction = "alliance", skillRange = "65-125",
        mining = { texture = TEX .. "redridge-minage" },
    },
    ["Ashenvale"] = {
        faction = "both", skillRange = "65-125",
        mining = { texture = TEX .. "ashenvale-minage" },
    },

    -----------------------------------------------------------------
    -- Skill 125-205
    -----------------------------------------------------------------
    ["Stranglethorn Vale"] = {
        faction = "both", skillRange = "170-205",
        herbs  = { texture = TEX .. "stv-herbo" },
    },
    ["Arathi Highlands"] = {
        faction = "both", skillRange = "125-205",
        herbs  = { texture = TEX .. "arathi-herbo" },
        mining = { texture = TEX .. "arathi-minage" },
    },
    ["Desolace"] = {
        faction = "both", skillRange = "125-175",
        mining = { texture = TEX .. "desolace-minage" },
    },
    ["Thousand Needles"] = {
        faction = "both", skillRange = "125-175",
        mining = { texture = TEX .. "thousand-needles-minage" },
    },

    -----------------------------------------------------------------
    -- Skill 205-270
    -----------------------------------------------------------------
    ["Tanaris"] = {
        faction = "both", skillRange = "205-245",
        herbs  = { texture = TEX .. "tanaris-herbo" },
        mining = { texture = TEX .. "tanaris-minage" },
    },
    ["Searing Gorge"] = {
        faction = "both", skillRange = "205-230",
        herbs  = { texture = TEX .. "searing-gorge-herbo" },
    },
    ["The Hinterlands"] = {
        faction = "both", skillRange = "230-270",
        herbs  = { texture = TEX .. "hinterlands-herbo" },
        mining = { texture = TEX .. "hinterlands-minage" },
    },

    -----------------------------------------------------------------
    -- Skill 245-300
    -----------------------------------------------------------------
    ["Felwood"] = {
        faction = "both", skillRange = "270-300",
        herbs  = { texture = TEX .. "felwood-herbo" },
        mining = { texture = TEX .. "felwood-minage" },
    },
    ["Un'Goro Crater"] = {
        faction = "both", skillRange = "245-300",
        herbs  = { texture = TEX .. "ungoro-herbo" },
        mining = { texture = TEX .. "ungoro-minage" },
    },
    ["Blasted Lands"] = {
        faction = "both", skillRange = "245-275",
        mining = { texture = TEX .. "blasted-lands-minage" },
    },
    ["Eastern Plaguelands"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "eastern-plaguelands-minage" },
    },
    ["Winterspring"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "winterspring-minage" },
    },
    ["Burning Steppes"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "burning-steppes-minage" },
    },

    -----------------------------------------------------------------
    -- TBC Outland  (Skill 300-375)
    -----------------------------------------------------------------
    ["Hellfire Peninsula"] = {
        faction = "both", skillRange = "300-325",
        herbs  = { texture = TEX .. "hellfire-herbo" },
        mining = { texture = TEX .. "hellfire-minage" },
    },
    ["Zangarmarsh"] = {
        faction = "both", skillRange = "325-350",
        mining = { texture = TEX .. "zangarmarsh-minage" },
        gases  = { texture = TEX .. "zangarmarsh-gases" },
    },
    ["Terokkar Forest"] = {
        faction = "both", skillRange = "325-350",
        herbs  = { texture = TEX .. "terokkar-herbo" },
        mining = { texture = TEX .. "terokkar-minage" },
    },
    ["Nagrand"] = {
        faction = "both", skillRange = "315-375",
        herbs  = { texture = TEX .. "nagrand-herbo" },
        mining = { texture = TEX .. "nagrand-minage" },
        gases  = { texture = TEX .. "nagrand-gases" },
    },
    ["Blade's Edge Mountains"] = {
        faction = "both", skillRange = "315-325",
        herbs  = { texture = TEX .. "blades-edge-herbo" },
    },
    ["Netherstorm"] = {
        faction = "both", skillRange = "350-375",
        herbs  = { texture = TEX .. "netherstorm-herbo" },
        mining = { texture = TEX .. "netherstorm-minage" },
        gases  = { texture = TEX .. "netherstorm-gases" },
    },
    ["Shadowmoon Valley"] = {
        faction = "both", skillRange = "350-375",
        mining = { texture = TEX .. "shadowmoon-minage" },
        gases  = { texture = TEX .. "shadowmoon-gases" },
    },
}

----------------------------------------------------------------------
-- Zone name aliases (localized zone name -> RoutesData key)
----------------------------------------------------------------------
NS.RouteZoneAliases = {
    -- FR Classic
    ["Durotar"]                     = "Durotar",
    ["Mulgore"]                     = "Mulgore",
    ["Clairières de Tirisfal"]     = "Tirisfal Glades",
    ["Dun Morogh"]                  = "Dun Morogh",
    ["Forêt d'Elwynn"]             = "Elwynn Forest",
    ["Teldrassil"]                  = "Teldrassil",
    ["Sombrivage"]                  = "Darkshore",
    ["Les Tarides"]                 = "The Barrens",
    ["Forêt des Pins Argentés"]   = "Silverpine Forest",
    ["Loch Modan"]                  = "Loch Modan",
    ["Contreforts de Hillsbrad"]    = "Hillsbrad Foothills",
    ["Les Paluns"]                  = "Wetlands",
    ["Serres-Rocheuses"]            = "Stonetalon Mountains",
    ["Les Carmines"]                = "Redridge Mountains",
    ["Ashenvale"]                   = "Ashenvale",
    ["Vallée de Strangleronce"]    = "Stranglethorn Vale",
    ["Hautes-terres d'Arathi"]     = "Arathi Highlands",
    ["Désolace"]                   = "Desolace",
    ["Mille Pointes"]               = "Thousand Needles",
    ["Tanaris"]                     = "Tanaris",
    ["Steppes ardentes"]            = "Searing Gorge",
    ["Les Hinterlands"]             = "The Hinterlands",
    ["Gangrebois"]                  = "Felwood",
    ["Cratère d'Un'Goro"]          = "Un'Goro Crater",
    ["Terres Foudroyées"]          = "Blasted Lands",
    ["Maleterres de l'est"]        = "Eastern Plaguelands",
    ["Berceau-de-l'Hiver"]         = "Winterspring",
    ["Steppes Ardentes"]            = "Burning Steppes",
    -- FR TBC Outland
    ["Péninsule des Flammes infernales"] = "Hellfire Peninsula",
    ["Marécage de Zangar"]         = "Zangarmarsh",
    ["Forêt de Terokkar"]          = "Terokkar Forest",
    ["Nagrand"]                     = "Nagrand",
    ["Les Tranchantes"]             = "Blade's Edge Mountains",
    ["Raz-de-Néant"]               = "Netherstorm",
    ["Vallée d'Ombrelune"]         = "Shadowmoon Valley",
    -- EN (direct match)
    ["Tirisfal Glades"]             = "Tirisfal Glades",
    ["Elwynn Forest"]               = "Elwynn Forest",
    ["Darkshore"]                   = "Darkshore",
    ["The Barrens"]                 = "The Barrens",
    ["Silverpine Forest"]           = "Silverpine Forest",
    ["Hillsbrad Foothills"]         = "Hillsbrad Foothills",
    ["Wetlands"]                    = "Wetlands",
    ["Stonetalon Mountains"]        = "Stonetalon Mountains",
    ["Redridge Mountains"]          = "Redridge Mountains",
    ["Stranglethorn Vale"]          = "Stranglethorn Vale",
    ["Arathi Highlands"]            = "Arathi Highlands",
    ["Thousand Needles"]            = "Thousand Needles",
    ["Searing Gorge"]               = "Searing Gorge",
    ["The Hinterlands"]             = "The Hinterlands",
    ["Felwood"]                     = "Felwood",
    ["Un'Goro Crater"]              = "Un'Goro Crater",
    ["Blasted Lands"]               = "Blasted Lands",
    ["Eastern Plaguelands"]         = "Eastern Plaguelands",
    ["Winterspring"]                = "Winterspring",
    ["Burning Steppes"]             = "Burning Steppes",
    ["Hellfire Peninsula"]          = "Hellfire Peninsula",
    ["Zangarmarsh"]                 = "Zangarmarsh",
    ["Terokkar Forest"]             = "Terokkar Forest",
    ["Blade's Edge Mountains"]      = "Blade's Edge Mountains",
    ["Netherstorm"]                 = "Netherstorm",
    ["Shadowmoon Valley"]           = "Shadowmoon Valley",
    -- DE Classic
    ["Lichtung von Tirisfal"]       = "Tirisfal Glades",
    ["Wald von Elwynn"]             = "Elwynn Forest",
    ["Dunkelküste"]                = "Darkshore",
    ["Das Brachland"]               = "The Barrens",
    ["Silberwald"]                  = "Silverpine Forest",
    ["Vorgebirge des Hügellands"] = "Hillsbrad Foothills",
    ["Sumpfland"]                   = "Wetlands",
    ["Steinkrallengebirge"]         = "Stonetalon Mountains",
    ["Rotkammgebirge"]              = "Redridge Mountains",
    ["Eschental"]                   = "Ashenvale",
    ["Schlingendorntal"]            = "Stranglethorn Vale",
    ["Arathihochland"]              = "Arathi Highlands",
    ["Tausend Nadeln"]              = "Thousand Needles",
    ["Sengende Schlucht"]           = "Searing Gorge",
    ["Das Hinterland"]              = "The Hinterlands",
    ["Teufelswald"]                 = "Felwood",
    ["Krater von Un'Goro"]         = "Un'Goro Crater",
    ["Verwüstete Lande"]           = "Blasted Lands",
    ["Östliche Pestländer"]       = "Eastern Plaguelands",
    ["Winterquell"]                 = "Winterspring",
    ["Brennende Steppe"]            = "Burning Steppes",
    -- DE TBC Outland
    ["Höllenfeuerhalbinsel"]       = "Hellfire Peninsula",
    ["Zangarmarschen"]              = "Zangarmarsh",
    ["Wälder von Terokkar"]        = "Terokkar Forest",
    ["Schergrat"]                   = "Blade's Edge Mountains",
    ["Nethersturm"]                 = "Netherstorm",
    ["Schattenmondtal"]             = "Shadowmoon Valley",

    -- Extra zones used by FarmingData (not in RoutesData zone list)
    -- EN
    ["Feralas"]                     = "Feralas",
    ["Badlands"]                    = "Badlands",
    ["Dustwallow Marsh"]            = "Dustwallow Marsh",
    ["Swamp of Sorrows"]            = "Swamp of Sorrows",
    ["Duskwood"]                    = "Duskwood",
    ["Silithus"]                    = "Silithus",
    ["Azshara"]                     = "Azshara",
    ["Western Plaguelands"]         = "Western Plaguelands",
    -- FR
    ["Féralas"]                    = "Feralas",
    ["Terres ingrates"]             = "Badlands",
    ["Marécage d'Âprefange"]      = "Dustwallow Marsh",
    ["Marais des Chagrins"]         = "Swamp of Sorrows",
    ["Bois de la Pénombre"]        = "Duskwood",
    ["Silithus"]                    = "Silithus",
    ["Azshara"]                     = "Azshara",
    ["Maleterres de l'ouest"]      = "Western Plaguelands",
    -- DE
    ["Feralas"]                     = "Feralas",
    ["Ödland"]                     = "Badlands",
    ["Düstermarschen"]             = "Dustwallow Marsh",
    ["Sümpfe des Elends"]          = "Swamp of Sorrows",
    ["Dämmerwald"]                 = "Duskwood",
    ["Westliche Pestländer"]       = "Western Plaguelands",
}

----------------------------------------------------------------------
-- Reverse locale table: EN key -> localized name per locale
----------------------------------------------------------------------
NS.ZoneLocales = {
    ["frFR"] = {
        -- Classic
        ["Tirisfal Glades"]         = "Clairières de Tirisfal",
        ["Elwynn Forest"]           = "Forêt d'Elwynn",
        ["Darkshore"]               = "Sombrivage",
        ["The Barrens"]             = "Les Tarides",
        ["Silverpine Forest"]       = "Forêt des Pins Argentés",
        ["Hillsbrad Foothills"]     = "Contreforts de Hillsbrad",
        ["Wetlands"]                = "Les Paluns",
        ["Stonetalon Mountains"]    = "Serres-Rocheuses",
        ["Redridge Mountains"]      = "Les Carmines",
        ["Stranglethorn Vale"]      = "Vallée de Strangleronce",
        ["Arathi Highlands"]        = "Hautes-terres d'Arathi",
        ["Desolace"]                = "Désolace",
        ["Thousand Needles"]        = "Mille Pointes",
        ["Searing Gorge"]           = "Steppes ardentes",
        ["The Hinterlands"]         = "Les Hinterlands",
        ["Felwood"]                 = "Gangrebois",
        ["Un'Goro Crater"]          = "Cratère d'Un'Goro",
        ["Blasted Lands"]           = "Terres Foudroyées",
        ["Eastern Plaguelands"]     = "Maleterres de l'est",
        ["Winterspring"]            = "Berceau-de-l'Hiver",
        ["Burning Steppes"]         = "Steppes Ardentes",
        -- TBC Outland
        ["Hellfire Peninsula"]      = "Péninsule des Flammes infernales",
        ["Zangarmarsh"]             = "Marécage de Zangar",
        ["Terokkar Forest"]         = "Forêt de Terokkar",
        ["Blade's Edge Mountains"]  = "Les Tranchantes",
        ["Netherstorm"]             = "Raz-de-Néant",
        ["Shadowmoon Valley"]       = "Vallée d'Ombrelune",
        -- Extra zones (FarmingData)
        ["Feralas"]                 = "Féralas",
        ["Badlands"]                = "Terres ingrates",
        ["Dustwallow Marsh"]        = "Marécage d'Âprefange",
        ["Swamp of Sorrows"]        = "Marais des Chagrins",
        ["Duskwood"]                = "Bois de la Pénombre",
        ["Western Plaguelands"]     = "Maleterres de l'ouest",
    },
    ["deDE"] = {
        -- Classic
        ["Tirisfal Glades"]         = "Lichtung von Tirisfal",
        ["Elwynn Forest"]           = "Wald von Elwynn",
        ["Darkshore"]               = "Dunkelküste",
        ["The Barrens"]             = "Das Brachland",
        ["Silverpine Forest"]       = "Silberwald",
        ["Hillsbrad Foothills"]     = "Vorgebirge des Hügellands",
        ["Wetlands"]                = "Sumpfland",
        ["Stonetalon Mountains"]    = "Steinkrallengebirge",
        ["Redridge Mountains"]      = "Rotkammgebirge",
        ["Ashenvale"]               = "Eschental",
        ["Stranglethorn Vale"]      = "Schlingendorntal",
        ["Arathi Highlands"]        = "Arathihochland",
        ["Thousand Needles"]        = "Tausend Nadeln",
        ["Searing Gorge"]           = "Sengende Schlucht",
        ["The Hinterlands"]         = "Das Hinterland",
        ["Felwood"]                 = "Teufelswald",
        ["Un'Goro Crater"]          = "Krater von Un'Goro",
        ["Blasted Lands"]           = "Verwüstete Lande",
        ["Eastern Plaguelands"]     = "Östliche Pestländer",
        ["Winterspring"]            = "Winterquell",
        ["Burning Steppes"]         = "Brennende Steppe",
        -- TBC Outland
        ["Hellfire Peninsula"]      = "Höllenfeuerhalbinsel",
        ["Zangarmarsh"]             = "Zangarmarschen",
        ["Terokkar Forest"]         = "Wälder von Terokkar",
        ["Blade's Edge Mountains"]  = "Schergrat",
        ["Netherstorm"]             = "Nethersturm",
        ["Shadowmoon Valley"]       = "Schattenmondtal",
        -- Extra zones (FarmingData)
        ["Feralas"]                 = "Feralas",
        ["Badlands"]                = "Ödland",
        ["Dustwallow Marsh"]        = "Düstermarschen",
        ["Swamp of Sorrows"]        = "Sümpfe des Elends",
        ["Duskwood"]                = "Dämmerwald",
        ["Western Plaguelands"]     = "Westliche Pestländer",
    },
}

function NS.LocalizeZone(key)
    local locale = GetLocale()
    local t = NS.ZoneLocales[locale]
    if t and t[key] then return t[key] end
    return key  -- fallback: EN name as-is
end

----------------------------------------------------------------------
-- Resource name localization: EN key -> localized name per locale
----------------------------------------------------------------------
NS.ResourceLocales = {
    ["frFR"] = {
        -- Classic Herbs
        ["Peacebloom / Silverleaf"]  = "Pacifique / Feuillargent",
        ["Briarthorn / Mageroyal"]   = "Eglantine / Mage royal",
        ["Stranglekelp"]             = "Etouffante",
        ["Bruiseweed"]               = "Doulourante",
        ["Wild Steelbloom"]          = "Aciérite sauvage",
        ["Grave Moss"]               = "Tombeline",
        ["Kingsblood"]               = "Sang-royal",
        ["Liferoot"]                 = "Vietérule",
        ["Fadeleaf"]                 = "Pâlerette",
        ["Goldthorn"]                = "Dorépine",
        ["Khadgar's Whisker"]        = "Moustache de Khadgar",
        ["Firebloom"]                = "Fleur de feu",
        ["Sungrass"]                 = "Soleillette",
        ["Purple Lotus"]             = "Lotus pourpre",
        ["Blindweed"]                = "Aveuglette",
        ["Ghost Mushroom"]           = "Champignon fantôme",
        ["Gromsblood"]               = "Gromsang",
        ["Golden Sansam"]            = "Sansam doré",
        ["Dreamfoil"]                = "Feuillerêve",
        ["Mountain Silversage"]      = "Sauge-argent des montagnes",
        ["Icecap"]                   = "Calot de glace",
        ["Sorrowmoss"]               = "Chagrinelle",
        -- TBC Herbs
        ["Felweed"]                  = "Gangrelette",
        ["Dreaming Glory"]           = "Glaurier",
        ["Terocone"]                 = "Terocône",
        ["Ragveil"]                  = "Voile-misère",
        ["Nightmare Vine"]           = "Cauchemardelle",
        ["Netherbloom"]              = "Néantine",
        -- Classic Ores
        ["Copper Ore"]               = "Minerai de cuivre",
        ["Tin Ore"]                  = "Minerai d'étain",
        ["Iron Ore"]                 = "Minerai de fer",
        ["Mithril Ore"]              = "Minerai de mithril",
        ["Thorium Ore"]              = "Minerai de thorium",
        -- TBC Ores
        ["Fel Iron Ore"]             = "Minerai de gangrefer",
        ["Adamantite Ore"]           = "Minerai d'adamantite",
        -- TBC Gas Clouds
        ["Windy Cloud"]              = "Nuage venteux",
        ["Swamp Gas"]                = "Gaz des marais",
        ["Felmist"]                  = "Brume gangrénée",
        ["Arcane Vortex"]            = "Vortex arcanique",
    },
}

function NS.LocalizeResource(key)
    local locale = GetLocale()
    local t = NS.ResourceLocales[locale]
    if t and t[key] then return t[key] end
    return key  -- fallback: EN name as-is
end

----------------------------------------------------------------------
-- Build sorted list of all zone keys for browsing
----------------------------------------------------------------------
NS.RouteZoneList = {}
for key in pairs(NS.RoutesData) do
    NS.RouteZoneList[#NS.RouteZoneList + 1] = key
end
table.sort(NS.RouteZoneList)
