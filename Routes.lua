----------------------------------------------------------------------
-- NodeCounter  –  Routes.lua
-- Navigation engine: player position tracking on route maps
----------------------------------------------------------------------
local _, NS = ...

local Routes = {}
NS.Routes = Routes

----------------------------------------------------------------------
-- State
----------------------------------------------------------------------
local activeZoneKey  = nil   -- e.g. "Durotar"
local activeType     = nil   -- "herbs" or "mining"
local startPos       = nil   -- {x, y} player position when navigation started
local isNavigating   = false
local lastUpdate     = 0
local UPDATE_THROTTLE = 0.1  -- seconds

----------------------------------------------------------------------
-- Update frame
----------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:Hide()

----------------------------------------------------------------------
-- Map ID resolution
----------------------------------------------------------------------
local function GetCurrentMapID()
    if C_Map and C_Map.GetBestMapForUnit then
        return C_Map.GetBestMapForUnit("player")
    end
    return nil
end

----------------------------------------------------------------------
-- Player map position (normalised 0-1)
----------------------------------------------------------------------
function Routes:GetPlayerMapPos()
    local mapID = GetCurrentMapID()
    if not mapID then return nil, nil end

    if C_Map and C_Map.GetPlayerMapPosition then
        local pos = C_Map.GetPlayerMapPosition(mapID, "player")
        if pos then
            return pos:GetXY()
        end
    end
    return nil, nil
end

----------------------------------------------------------------------
-- Get current zone key (try to match RoutesData)
----------------------------------------------------------------------
function Routes:GetCurrentZoneKey()
    local zone = GetRealZoneText()
    if not zone then return nil end

    -- Direct match
    if NS.RoutesData[zone] then return zone end

    -- Alias lookup
    if NS.RouteZoneAliases and NS.RouteZoneAliases[zone] then
        return NS.RouteZoneAliases[zone]
    end

    return nil
end

----------------------------------------------------------------------
-- Check if a zone has a route for the given type
----------------------------------------------------------------------
function Routes:ZoneHasRoute(zoneKey, routeType)
    local zd = NS.RoutesData[zoneKey]
    if not zd then return false end
    return zd[routeType] and true or false
end

----------------------------------------------------------------------
-- Get texture path for a zone + type
----------------------------------------------------------------------
function Routes:GetTexture(zoneKey, routeType)
    local zd = NS.RoutesData[zoneKey]
    if not zd or not zd[routeType] then return nil end
    return zd[routeType].texture
end

----------------------------------------------------------------------
-- Start tracking on a route
----------------------------------------------------------------------
function Routes:StartRoute(zoneKey, routeType, skipValidation)
    if not skipValidation and not self:ZoneHasRoute(zoneKey, routeType) then return false end

    activeZoneKey = zoneKey
    activeType    = routeType
    isNavigating  = true

    local px, py = self:GetPlayerMapPos()
    if px and py then
        startPos = { x = px, y = py }
    else
        startPos = nil
    end

    frame:Show()
    NS:FireCallback("ROUTE_STARTED", zoneKey, routeType)
    return true
end

----------------------------------------------------------------------
-- Stop tracking
----------------------------------------------------------------------
function Routes:StopRoute()
    isNavigating  = false
    activeZoneKey = nil
    activeType    = nil
    startPos      = nil
    frame:Hide()
    NS:FireCallback("ROUTE_STOPPED")
end

----------------------------------------------------------------------
-- Getters
----------------------------------------------------------------------
function Routes:IsNavigating()
    return isNavigating
end

function Routes:GetActiveInfo()
    return activeZoneKey, activeType
end

function Routes:GetStartPos()
    return startPos
end

----------------------------------------------------------------------
-- OnUpdate: send player position
----------------------------------------------------------------------
frame:SetScript("OnUpdate", function(self, elapsed)
    lastUpdate = lastUpdate + elapsed
    if lastUpdate < UPDATE_THROTTLE then return end
    lastUpdate = 0

    if not isNavigating then return end

    local px, py = Routes:GetPlayerMapPos()
    NS:FireCallback("ROUTE_UPDATE", px, py)
end)
