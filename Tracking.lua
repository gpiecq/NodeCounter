----------------------------------------------------------------------
-- NodeCounter  –  Tracking.lua
-- Minimap tracking toggle (Herbs / Minerals) with auto-switch timer
-- Supports both legacy API (TBC) and C_Minimap API (Anniversary)
----------------------------------------------------------------------
local _, NS = ...

local Tracking = {}
NS.Tracking = Tracking

local herbIndex, mineralIndex
local ticker

----------------------------------------------------------------------
-- API compatibility layer (Anniversary uses C_Minimap namespace)
----------------------------------------------------------------------
local GetNumTracking = C_Minimap and C_Minimap.GetNumTrackingTypes
                       or GetNumTrackingTypes
local SetTrackingFn  = C_Minimap and C_Minimap.SetTracking
                       or SetTracking
local useCMinimap    = C_Minimap and C_Minimap.GetTrackingInfo and true or false

-- Wrapper: always returns name, texture, active
local function GetTrackingInfoCompat(index)
    if useCMinimap then
        local info = C_Minimap.GetTrackingInfo(index)
        if info then
            return info.name, info.texture, info.active
        end
        return nil
    else
        return GetTrackingInfo(index)
    end
end

----------------------------------------------------------------------
-- Tracking name lookup (multi-language: EN, FR, DE, ES)
----------------------------------------------------------------------
local HERB_TRACKING_NAMES = {
    ["find herbs"]             = true,  -- EN
    ["découverte d'herbes"]    = true,  -- FR
    ["kräutersuche"]           = true,  -- DE
    ["buscar hierbas"]         = true,  -- ES
}

local MINERAL_TRACKING_NAMES = {
    ["find minerals"]            = true,  -- EN
    ["découverte de gisements"]  = true,  -- FR
    ["mineraliensuche"]          = true,  -- DE
    ["buscar minerales"]         = true,  -- ES
}

----------------------------------------------------------------------
-- Discover tracking indices (must be called after ADDON_LOADED)
----------------------------------------------------------------------
function Tracking:ScanTrackingTypes()
    herbIndex, mineralIndex = nil, nil
    if not GetNumTracking then return end
    for i = 1, GetNumTracking() do
        local name = GetTrackingInfoCompat(i)
        if name then
            local lower = name:lower()
            if HERB_TRACKING_NAMES[lower] then
                herbIndex = i
            elseif MINERAL_TRACKING_NAMES[lower] then
                mineralIndex = i
            end
        end
    end
end

----------------------------------------------------------------------
-- Enable a specific tracking type (enabling one disables the other)
-- Anniversary Edition allows multiple tracking types at once,
-- so we must explicitly disable the other to enforce mutual exclusivity.
----------------------------------------------------------------------
function Tracking:EnableHerbTracking()
    self:ScanTrackingTypes()
    if SetTrackingFn then
        if mineralIndex then pcall(SetTrackingFn, mineralIndex, false) end
        if herbIndex    then pcall(SetTrackingFn, herbIndex,    true)  end
    end
end

function Tracking:EnableMineralTracking()
    self:ScanTrackingTypes()
    if SetTrackingFn then
        if herbIndex    then pcall(SetTrackingFn, herbIndex,    false) end
        if mineralIndex then pcall(SetTrackingFn, mineralIndex, true)  end
    end
end

----------------------------------------------------------------------
-- Current active tracking query
----------------------------------------------------------------------
function Tracking:GetActiveTracking()
    local herbOn, minOn = false, false
    if herbIndex then
        local _, _, active = GetTrackingInfoCompat(herbIndex)
        herbOn = active
    end
    if mineralIndex then
        local _, _, active = GetTrackingInfoCompat(mineralIndex)
        minOn = active
    end
    if herbOn and minOn then return "both" end
    if herbOn then return "herbs" end
    if minOn then return "minerals" end
    return "none"
end

----------------------------------------------------------------------
-- Auto-switch state
----------------------------------------------------------------------
local autoState = "herbs"

function Tracking:ApplyMode(mode)
    mode = mode or (NS.db and NS.db.settings.trackingMode) or "auto"

    -- Stop existing ticker
    if ticker then ticker:Cancel(); ticker = nil end

    if mode == "herbs" then
        self:EnableHerbTracking()

    elseif mode == "minerals" then
        self:EnableMineralTracking()

    elseif mode == "auto" then
        self:ScanTrackingTypes()

        if herbIndex and mineralIndex then
            -- Both professions: start auto-switch ticker
            autoState = "herbs"
            self:EnableHerbTracking()

            local interval = (NS.db and NS.db.settings.timerInterval) or 10
            ticker = C_Timer.NewTicker(interval, function()
                if autoState == "herbs" then
                    autoState = "minerals"
                    Tracking:EnableMineralTracking()
                else
                    autoState = "herbs"
                    Tracking:EnableHerbTracking()
                end
                NS:FireCallback("TRACKING_SWITCHED", autoState)
            end)
        elseif herbIndex then
            -- Only herbs available, just enable it
            autoState = "herbs"
            self:EnableHerbTracking()
        elseif mineralIndex then
            -- Only minerals available, just enable it
            autoState = "minerals"
            self:EnableMineralTracking()
        end
        -- If neither tracking type is available, do nothing
    end

    NS:FireCallback("TRACKING_APPLIED", mode, autoState)
end

----------------------------------------------------------------------
-- Cycle mode: herbs -> minerals -> auto -> herbs
----------------------------------------------------------------------
function Tracking:CycleMode()
    if not NS.db then return end
    local cur = NS.db.settings.trackingMode
    local next
    if cur == "herbs" then
        next = "minerals"
    elseif cur == "minerals" then
        next = "auto"
    else
        next = "herbs"
    end
    NS.db.settings.trackingMode = next
    -- ApplyMode is called by the TRACKING_MODE_CHANGED callback; no direct call needed
    NS:FireCallback("TRACKING_MODE_CHANGED", next)

    local labels = { herbs = "Herbs Only", minerals = "Minerals Only", auto = "Auto-Switch" }
    print("|cff00ccffNodeCounter:|r Tracking mode: |cffffcc00" .. labels[next] .. "|r")
end

----------------------------------------------------------------------
-- Restart ticker when interval changes
----------------------------------------------------------------------
function Tracking:UpdateInterval(newInterval)
    if NS.db then NS.db.settings.timerInterval = newInterval end
    if NS.db and NS.db.settings.trackingMode == "auto" then
        self:ApplyMode("auto")
    end
end

----------------------------------------------------------------------
-- Get auto-switch state for UI indicator
----------------------------------------------------------------------
function Tracking:GetAutoState()
    return autoState
end

----------------------------------------------------------------------
-- Check which tracking types are available on this character
-- Returns hasHerbs, hasMinerals
----------------------------------------------------------------------
function Tracking:HasTrackingTypes()
    self:ScanTrackingTypes()
    return herbIndex ~= nil, mineralIndex ~= nil
end

----------------------------------------------------------------------
-- Init on addon loaded
----------------------------------------------------------------------
local initFrame = CreateFrame("Frame")
local pausedByCombat = false

initFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
initFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

initFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(1, function()
            Tracking:ScanTrackingTypes()
            Tracking:ApplyMode()
        end)
    elseif event == "PLAYER_REGEN_DISABLED" then
        if ticker then
            ticker:Cancel()
            ticker = nil
            pausedByCombat = true
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if pausedByCombat then
            pausedByCombat = false
            C_Timer.After(1, function()
                if not InCombatLockdown() then
                    Tracking:ApplyMode()
                end
            end)
        end
    end
end)

NS:RegisterCallback("ADDON_LOADED", function()
    Tracking:ScanTrackingTypes()
    C_Timer.After(1, function()
        Tracking:ScanTrackingTypes()
        Tracking:ApplyMode()
    end)
    initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
end)

NS:RegisterCallback("TRACKING_MODE_CHANGED", function(mode)
    Tracking:ApplyMode(mode)
end)
