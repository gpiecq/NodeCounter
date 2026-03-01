----------------------------------------------------------------------
-- NodeCounter  –  Core.lua
-- Addon initialisation, SavedVariables defaults, event bus, slash cmds
----------------------------------------------------------------------
local ADDON_NAME, NS = ...
NS.version = "1.0.0"

----------------------------------------------------------------------
-- Default saved-variables template
----------------------------------------------------------------------
local DEFAULTS = {
    herbs = {},
    ores  = {},
    objectives = {},
    settings = {
        trackingMode   = "auto",   -- "herbs", "minerals", "auto"
        timerInterval  = 10,       -- seconds for auto-switch
        minimapPos     = 220,      -- angle on minimap edge
        skillCapWarning = true,
        routes = {
            lastType = "herbs",    -- last selected route sub-tab
            browseMode = "zone",   -- "zone" or "resource"
        },
        guide = {
            lastType = "herbs",    -- last selected guide sub-tab
        },
    },
    session = { herbs = {}, ores = {} },
}

----------------------------------------------------------------------
-- Deep-copy helper (for defaults)
----------------------------------------------------------------------
local function DeepCopy(src)
    if type(src) ~= "table" then return src end
    local copy = {}
    for k, v in pairs(src) do copy[k] = DeepCopy(v) end
    return copy
end

----------------------------------------------------------------------
-- Merge defaults into saved table (non-destructive)
----------------------------------------------------------------------
local function MergeDefaults(sv, def)
    for k, v in pairs(def) do
        if type(v) == "table" then
            if type(sv[k]) ~= "table" then sv[k] = {} end
            MergeDefaults(sv[k], v)
        elseif sv[k] == nil then
            sv[k] = v
        end
    end
end

----------------------------------------------------------------------
-- Simple internal event bus
----------------------------------------------------------------------
NS.callbacks = {}

function NS:RegisterCallback(event, fn)
    if not self.callbacks[event] then self.callbacks[event] = {} end
    self.callbacks[event][#self.callbacks[event] + 1] = fn
end

function NS:FireCallback(event, ...)
    local cbs = self.callbacks[event]
    if not cbs then return end
    for i = 1, #cbs do cbs[i](...) end
end

----------------------------------------------------------------------
-- Addon init frame
----------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")

frame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        -- Initialise / migrate saved variables
        if not NodeCounterDB then
            NodeCounterDB = DeepCopy(DEFAULTS)
        else
            MergeDefaults(NodeCounterDB, DEFAULTS)
        end

        -- Always reset session counters on login
        NodeCounterDB.session = { herbs = {}, ores = {} }

        NS.db = NodeCounterDB

        -- Notify modules
        NS:FireCallback("ADDON_LOADED")

        frame:UnregisterEvent("ADDON_LOADED")

    elseif event == "PLAYER_LOGOUT" then
        -- Session counters are ephemeral; clear before save
        if NS.db then
            NS.db.session = { herbs = {}, ores = {} }
        end
    end
end)

----------------------------------------------------------------------
-- Slash commands  /nc  /nodecounter
----------------------------------------------------------------------
SLASH_NODECOUNTER1 = "/nc"
SLASH_NODECOUNTER2 = "/nodecounter"

SlashCmdList["NODECOUNTER"] = function(msg)
    msg = strtrim(msg):lower()

    if msg == "show" or msg == "" then
        NS:FireCallback("TOGGLE_WINDOW")

    elseif msg == "hide" then
        NS:FireCallback("HIDE_WINDOW")

    elseif msg == "settings" or msg == "config" then
        NS:FireCallback("SHOW_SETTINGS")

    elseif msg == "reset session" then
        if NS.db then
            NS.db.session = { herbs = {}, ores = {} }
            NS:FireCallback("DATA_UPDATED")
            print("|cff00ccffNodeCounter:|r Session counters reset.")
        end

    elseif msg == "reset all" then
        StaticPopup_Show("NODECOUNTER_RESET_ALL")

    elseif msg == "herbs" then
        if NS.db then NS.db.settings.trackingMode = "herbs" end
        NS:FireCallback("TRACKING_MODE_CHANGED", "herbs")
        print("|cff00ccffNodeCounter:|r Tracking mode set to |cff44ff44Herbs Only|r.")

    elseif msg == "minerals" then
        if NS.db then NS.db.settings.trackingMode = "minerals" end
        NS:FireCallback("TRACKING_MODE_CHANGED", "minerals")
        print("|cff00ccffNodeCounter:|r Tracking mode set to |cffffcc44Minerals Only|r.")

    elseif msg == "auto" then
        if NS.db then NS.db.settings.trackingMode = "auto" end
        NS:FireCallback("TRACKING_MODE_CHANGED", "auto")
        print("|cff00ccffNodeCounter:|r Tracking mode set to |cffff8844Auto-Switch|r.")

    else
        print("|cff00ccffNodeCounter|r v" .. NS.version .. " commands:")
        print("  /nc             - toggle main window")
        print("  /nc settings    - open settings panel")
        print("  /nc herbs       - track herbs only")
        print("  /nc minerals    - track minerals only")
        print("  /nc auto        - auto-switch tracking")
        print("  /nc reset session - reset session counters")
        print("  /nc reset all   - reset ALL data (confirm)")
    end
end

----------------------------------------------------------------------
-- Static popup for "reset all" confirmation
----------------------------------------------------------------------
StaticPopupDialogs["NODECOUNTER_RESET_ALL"] = {
    text = "Are you sure you want to reset ALL NodeCounter data?\nThis cannot be undone.",
    button1 = "Yes, Reset",
    button2 = "Cancel",
    OnAccept = function()
        local pos = NS.db and NS.db.settings.minimapPos or 220
        NodeCounterDB = DeepCopy(DEFAULTS)
        NodeCounterDB.settings.minimapPos = pos
        NS.db = NodeCounterDB
        NS:FireCallback("DATA_UPDATED")
        print("|cff00ccffNodeCounter:|r All data has been reset.")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}
