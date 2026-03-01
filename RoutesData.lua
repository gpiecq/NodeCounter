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
    },
    ["Blade's Edge Mountains"] = {
        faction = "both", skillRange = "315-325",
        herbs  = { texture = TEX .. "blades-edge-herbo" },
    },
    ["Netherstorm"] = {
        faction = "both", skillRange = "350-375",
        herbs  = { texture = TEX .. "netherstorm-herbo" },
        mining = { texture = TEX .. "netherstorm-minage" },
    },
    ["Shadowmoon Valley"] = {
        faction = "both", skillRange = "350-375",
        mining = { texture = TEX .. "shadowmoon-minage" },
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
}

----------------------------------------------------------------------
-- Build sorted list of all zone keys for browsing
----------------------------------------------------------------------
NS.RouteZoneList = {}
for key in pairs(NS.RoutesData) do
    NS.RouteZoneList[#NS.RouteZoneList + 1] = key
end
table.sort(NS.RouteZoneList)
