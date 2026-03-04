----------------------------------------------------------------------
-- NodeCounter  –  UI.lua
-- Main window, minimap button, settings panel, objectives UI
-- ElvUI-compatible dark modern design
----------------------------------------------------------------------
local _, NS = ...

local UI = {}
NS.UI = UI

----------------------------------------------------------------------
-- Colour / style constants
----------------------------------------------------------------------
local COLOURS = {
    bg         = { 0.1,  0.1,  0.1,  0.92 },
    border     = { 0.3,  0.3,  0.3,  1    },
    accent     = { 0.0,  0.8,  1.0,  1    },
    herbGreen  = { 0.27, 1.0,  0.27, 1    },
    oreYellow  = { 1.0,  0.8,  0.27, 1    },
    gold       = { 1.0,  0.84, 0.0,  1    },
    barBg      = { 0.15, 0.15, 0.15, 1    },
    rowHover   = { 0.2,  0.2,  0.2,  0.6  },
    white      = { 1, 1, 1, 1 },
    dimWhite   = { 0.7, 0.7, 0.7, 1 },
    routeCyan  = { 0.0,  0.86, 1.0,  1    },
    gasPurple  = { 0.7,  0.4,  1.0,  1    },
}

----------------------------------------------------------------------
-- ElvUI helpers
----------------------------------------------------------------------
local function IsElvUI()
    return ElvUI and ElvUI[1] and true or false
end

local function SkinFrame(f)
    if IsElvUI() and f.SetTemplate then
        f:SetTemplate("Transparent")
    else
        f:SetBackdrop({
            bgFile   = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
        })
        f:SetBackdropColor(unpack(COLOURS.bg))
        f:SetBackdropBorderColor(unpack(COLOURS.border))
    end
end

local function GetFont()
    if IsElvUI() then
        local E = ElvUI[1]
        local LSM = E.Libs and E.Libs.LSM
        if LSM then
            local font = LSM:Fetch("font", E.db and E.db.general and E.db.general.font)
            if font then return font end
        end
    end
    return "Fonts\\FRIZQT__.TTF"
end

----------------------------------------------------------------------
-- Skill rank names by max skill value (localized)
----------------------------------------------------------------------
local SKILL_RANK_NAMES = {
    enUS = { [75] = "Apprentice", [150] = "Journeyman", [225] = "Expert", [300] = "Artisan", [375] = "Master" },
    enGB = { [75] = "Apprentice", [150] = "Journeyman", [225] = "Expert", [300] = "Artisan", [375] = "Master" },
    frFR = { [75] = "Apprenti",   [150] = "Compagnon",  [225] = "Expert", [300] = "Artisan", [375] = "Ma\195\174tre" },
    deDE = { [75] = "Lehrling",   [150] = "Geselle",    [225] = "Experte",[300] = "Fachmann",[375] = "Meister" },
    esES = { [75] = "Aprendiz",   [150] = "Oficial",    [225] = "Experto",[300] = "Artesano",[375] = "Maestro" },
    esMX = { [75] = "Aprendiz",   [150] = "Oficial",    [225] = "Experto",[300] = "Artesano",[375] = "Maestro" },
}

local function GetSkillRankName(maxSkill)
    local locale = GetLocale()
    local names = SKILL_RANK_NAMES[locale] or SKILL_RANK_NAMES["enUS"]
    return names[maxSkill] or ""
end

----------------------------------------------------------------------
-- Forward declarations
----------------------------------------------------------------------
local mainFrame, settingsFrame, minimapButton
local herbRows, oreRows = {}, {}
local activeTab = "herbs"

-- ====================================================================
--  MINIMAP BUTTON
-- ====================================================================
local function CreateMinimapButton()
    local btn = CreateFrame("Button", "NodeCounterMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:SetMovable(true)
    btn:SetClampedToScreen(true)

    -- Textures
    local overlay = btn:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")

    local icon = btn:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 0)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
    btn.icon = icon

    local highlight = btn:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetSize(24, 24)
    highlight:SetPoint("CENTER")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")

    -- Mode indicator dot
    local dot = btn:CreateTexture(nil, "OVERLAY")
    dot:SetSize(8, 8)
    dot:SetPoint("BOTTOMRIGHT", -2, 2)
    dot:SetTexture("Interface\\Buttons\\WHITE8x8")
    dot:SetVertexColor(unpack(COLOURS.accent))
    btn.dot = dot

    -- Position on minimap edge
    local function UpdatePosition()
        local angle = math.rad(NS.db and NS.db.settings.minimapPos or 220)
        local x = math.cos(angle) * 80
        local y = math.sin(angle) * 80
        btn:SetPoint("CENTER", Minimap, "CENTER", x, y)
    end

    -- Dragging
    local isDragging = false
    btn:RegisterForDrag("LeftButton")
    btn:SetScript("OnDragStart", function(self)
        isDragging = true
        self:SetScript("OnUpdate", function(self)
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale
            local angle = math.deg(math.atan2(cy - my, cx - mx))
            if NS.db then NS.db.settings.minimapPos = angle end
            local rad = math.rad(angle)
            self:ClearAllPoints()
            self:SetPoint("CENTER", Minimap, "CENTER", math.cos(rad) * 80, math.sin(rad) * 80)
        end)
    end)
    btn:SetScript("OnDragStop", function(self)
        isDragging = false
        self:SetScript("OnUpdate", nil)
    end)

    -- Clicks
    btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            NS:FireCallback("TOGGLE_WINDOW")
        elseif button == "RightButton" then
            NS.Tracking:CycleMode()
        end
    end)

    -- Localized "no gathering profession" message
    local NO_PROFESSION_MSG = {
        frFR = "Vous n'avez pas de m\195\169tier de r\195\169colte",
        deDE = "Ihr habt keinen Sammelberuf",
        esES = "No tienes una profesi\195\179n de recolecci\195\179n",
        esMX = "No tienes una profesi\195\179n de recolecci\195\179n",
    }
    local noGatherMsg = NO_PROFESSION_MSG[GetLocale()] or "You have no gathering profession"

    -- Tooltip
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("NodeCounter", 0.0, 0.8, 1.0)

        local hasHerbs, hasMinerals = NS.Tracking:HasTrackingTypes()
        if not hasHerbs and not hasMinerals then
            GameTooltip:AddLine(noGatherMsg, 0.7, 0.3, 0.3)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Left-click: Toggle window", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("Drag: Move button", 0.7, 0.7, 0.7)
            GameTooltip:Show()
            return
        end

        local mode = NS.db and NS.db.settings.trackingMode or "auto"
        local labels = { herbs = "Herbs Only", minerals = "Minerals Only", auto = "Auto-Switch" }
        GameTooltip:AddLine("Mode: " .. (labels[mode] or mode), 1, 1, 1)
        GameTooltip:AddLine(" ")
        local sh = NS.Counter:GetTotalBag("herbs")
        local so = NS.Counter:GetTotalBag("ores")
        GameTooltip:AddDoubleLine("Herbes (sacs):", tostring(sh), 0.27, 1.0, 0.27, 1, 1, 1)
        GameTooltip:AddDoubleLine("Minerais (sacs):", tostring(so), 1.0, 0.8, 0.27, 1, 1, 1)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Left-click: Toggle window", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("Right-click: Cycle mode", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("Drag: Move button", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Update icon based on mode
    function btn:UpdateIcon()
        local hasHerbs, hasMinerals = NS.Tracking:HasTrackingTypes()
        local hasAny = hasHerbs or hasMinerals

        if not hasAny then
            -- No gathering profession: greyed-out icon
            self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            self.icon:SetDesaturated(true)
            self.icon:SetVertexColor(0.5, 0.5, 0.5)
            self.dot:SetVertexColor(0.4, 0.4, 0.4, 1)
            return
        end

        -- Has at least one profession: normal icon
        self.icon:SetDesaturated(false)
        self.icon:SetVertexColor(1, 1, 1)

        local mode = NS.db and NS.db.settings.trackingMode or "auto"
        if mode == "herbs" then
            self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            self.dot:SetVertexColor(unpack(COLOURS.herbGreen))
        elseif mode == "minerals" then
            self.icon:SetTexture("Interface\\Icons\\INV_Pick_02")
            self.dot:SetVertexColor(unpack(COLOURS.oreYellow))
        else
            -- Auto mode: show whichever is currently active
            local st = NS.Tracking:GetAutoState()
            if st == "minerals" then
                self.icon:SetTexture("Interface\\Icons\\INV_Pick_02")
            else
                self.icon:SetTexture("Interface\\Icons\\INV_Misc_Flower_02")
            end
            self.dot:SetVertexColor(unpack(COLOURS.accent))
        end
    end

    UpdatePosition()
    minimapButton = btn
    return btn
end

-- ====================================================================
--  MAIN WINDOW
-- ====================================================================

----------------------------------------------------------------------
-- Create a styled tab button
----------------------------------------------------------------------
local function CreateTabButton(parent, label, anchorTo, offsetX)
    local tab = CreateFrame("Button", nil, parent, "BackdropTemplate")
    tab:SetSize(100, 26)
    if anchorTo then
        tab:SetPoint("LEFT", anchorTo, "RIGHT", 4, 0)
    else
        tab:SetPoint("BOTTOMLEFT", parent.headerBar, "BOTTOMLEFT", 8, -28)
    end

    SkinFrame(tab)

    tab.label = tab:CreateFontString(nil, "OVERLAY")
    tab.label:SetFont(GetFont(), 12, "OUTLINE")
    tab.label:SetPoint("CENTER")
    tab.label:SetText(label)

    tab:SetScript("OnEnter", function(self)
        if not self.selected then
            self:SetBackdropColor(0.25, 0.25, 0.25, 1)
        end
    end)
    tab:SetScript("OnLeave", function(self)
        if not self.selected then
            self:SetBackdropColor(unpack(COLOURS.bg))
        end
    end)

    function tab:SetSelected(sel)
        self.selected = sel
        if sel then
            self:SetBackdropBorderColor(unpack(COLOURS.accent))
            self.label:SetTextColor(unpack(COLOURS.accent))
        else
            self:SetBackdropBorderColor(unpack(COLOURS.border))
            self.label:SetTextColor(unpack(COLOURS.dimWhite))
            self:SetBackdropColor(unpack(COLOURS.bg))
        end
    end

    return tab
end

----------------------------------------------------------------------
-- Create a node row inside the scroll content
----------------------------------------------------------------------
local function CreateNodeRow(parent, index)
    local row = CreateFrame("Button", nil, parent)
    row:SetSize(parent:GetWidth() - 4, 28)
    row:SetPoint("TOPLEFT", 2, -(index - 1) * 30)

    -- Hover highlight
    local hl = row:CreateTexture(nil, "BACKGROUND")
    hl:SetAllPoints()
    hl:SetTexture("Interface\\Buttons\\WHITE8x8")
    hl:SetVertexColor(unpack(COLOURS.rowHover))
    hl:Hide()
    row.hl = hl

    -- Node name
    row.nameText = row:CreateFontString(nil, "OVERLAY")
    row.nameText:SetFont(GetFont(), 11, "")
    row.nameText:SetPoint("LEFT", 6, 0)
    row.nameText:SetWidth(150)
    row.nameText:SetJustifyH("LEFT")
    row.nameText:SetTextColor(1, 1, 1)

    -- Count
    row.countText = row:CreateFontString(nil, "OVERLAY")
    row.countText:SetFont(GetFont(), 11, "")
    row.countText:SetPoint("LEFT", row.nameText, "RIGHT", 8, 0)
    row.countText:SetWidth(60)
    row.countText:SetJustifyH("CENTER")

    -- Progress bar background
    row.barBg = row:CreateTexture(nil, "ARTWORK")
    row.barBg:SetSize(110, 14)
    row.barBg:SetPoint("LEFT", row.countText, "RIGHT", 8, 0)
    row.barBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    row.barBg:SetVertexColor(unpack(COLOURS.barBg))

    -- Progress bar fill
    row.barFill = row:CreateTexture(nil, "ARTWORK", nil, 1)
    row.barFill:SetSize(1, 14)
    row.barFill:SetPoint("LEFT", row.barBg, "LEFT", 0, 0)
    row.barFill:SetTexture("Interface\\Buttons\\WHITE8x8")
    row.barFill:SetVertexColor(unpack(COLOURS.herbGreen))

    -- Progress text
    row.progressText = row:CreateFontString(nil, "OVERLAY")
    row.progressText:SetFont(GetFont(), 9, "OUTLINE")
    row.progressText:SetPoint("CENTER", row.barBg, "CENTER")
    row.progressText:SetTextColor(1, 1, 1)

    -- Tooltip
    row:SetScript("OnEnter", function(self)
        self.hl:Show()
        if self.nodeData then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(self.nodeName or "", 1, 1, 1)
            GameTooltip:AddDoubleLine("Dans les sacs:", tostring(self.nodeData.count or 0), 0.7, 0.7, 0.7, 1, 1, 1)
            local obj = NS.db and NS.db.objectives[self.nodeName]
            if obj and obj > 0 then
                GameTooltip:AddDoubleLine("Objectif:", tostring(obj), 0.7, 0.7, 0.7, 1, 0.84, 0)
            end
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Clic: définir objectif", 0.5, 0.5, 0.5)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(self)
        self.hl:Hide()
        GameTooltip:Hide()
    end)

    -- Click: set/edit objective
    row:RegisterForClicks("LeftButtonUp")
    row:SetScript("OnClick", function(self)
        if not self.nodeName then return end
        UI:ShowObjectiveDialog(self.nodeName, self.nodeCategory)
    end)

    return row
end

----------------------------------------------------------------------
-- Build the main window
----------------------------------------------------------------------
local function CreateMainFrame()
    local f = CreateFrame("Frame", "NodeCounterMainFrame", UIParent, "BackdropTemplate")
    f:SetSize(520, 560)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    SkinFrame(f)

    -- Make draggable
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)

    -- ESC to close
    tinsert(UISpecialFrames, "NodeCounterMainFrame")

    -------------------------------------------------------------------
    -- Header bar
    -------------------------------------------------------------------
    local header = CreateFrame("Frame", nil, f, "BackdropTemplate")
    header:SetSize(f:GetWidth(), 30)
    header:SetPoint("TOP")
    SkinFrame(header)
    f.headerBar = header

    local title = header:CreateFontString(nil, "OVERLAY")
    title:SetFont(GetFont(), 13, "OUTLINE")
    title:SetPoint("LEFT", 10, 0)
    title:SetText("NodeCounter")
    title:SetTextColor(unpack(COLOURS.accent))

    -- Session stats in header
    f.headerStats = header:CreateFontString(nil, "OVERLAY")
    f.headerStats:SetFont(GetFont(), 10, "")
    f.headerStats:SetPoint("CENTER", header, "CENTER", 20, 0)
    f.headerStats:SetTextColor(unpack(COLOURS.dimWhite))

    -- Close button
    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(18, 18)
    closeBtn:SetPoint("RIGHT", -6, 0)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD")
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- Settings button
    local settingsBtn = CreateFrame("Button", nil, header)
    settingsBtn:SetSize(18, 18)
    settingsBtn:SetPoint("RIGHT", closeBtn, "LEFT", -4, 0)
    settingsBtn:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton")
    settingsBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD")
    settingsBtn:SetScript("OnClick", function()
        NS:FireCallback("SHOW_SETTINGS")
    end)
    settingsBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine("Settings")
        GameTooltip:Show()
    end)
    settingsBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -------------------------------------------------------------------
    -- Skill bars (Herbalism / Mining progression)
    -------------------------------------------------------------------
    local skillArea = CreateFrame("Frame", nil, f)
    skillArea:SetHeight(60)
    skillArea:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 8, -4)
    skillArea:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", -8, -4)
    f.skillArea = skillArea

    -- "Métiers" header
    local skillHeader = skillArea:CreateFontString(nil, "OVERLAY")
    skillHeader:SetFont(GetFont(), 10, "OUTLINE")
    skillHeader:SetPoint("TOPLEFT", skillArea, "TOPLEFT", 0, 0)
    skillHeader:SetTextColor(unpack(COLOURS.dimWhite))
    skillHeader:SetText("Métiers")
    skillArea.header = skillHeader

    local SKILL_BAR_TOP = -16  -- offset below header

    -- Helper: create one skill bar
    local function CreateSkillBar(parent, yOffset, color)
        local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        bar:SetHeight(18)
        bar:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)
        bar:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, yOffset)
        bar:SetBackdrop({
            bgFile   = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
        })
        bar:SetBackdropColor(0.12, 0.12, 0.12, 1)
        bar:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)

        bar.fill = bar:CreateTexture(nil, "ARTWORK")
        bar.fill:SetHeight(16)
        bar.fill:SetPoint("LEFT", bar, "LEFT", 1, 0)
        bar.fill:SetTexture("Interface\\Buttons\\WHITE8x8")
        bar.fill:SetVertexColor(unpack(color))

        bar.text = bar:CreateFontString(nil, "OVERLAY")
        bar.text:SetFont(GetFont(), 10, "OUTLINE")
        bar.text:SetPoint("CENTER")
        bar.text:SetTextColor(1, 1, 1)

        bar:Hide()
        return bar
    end

    f.herbSkillBar   = CreateSkillBar(skillArea, SKILL_BAR_TOP,       COLOURS.herbGreen)
    f.miningSkillBar = CreateSkillBar(skillArea, SKILL_BAR_TOP - 22,  COLOURS.oreYellow)

    function f:UpdateSkillBars()
        local data = NS.skillData or {}

        -- Herb skill
        if data.herb then
            local d = data.herb
            local pct = (d.max > 0) and (d.rank / d.max) or 0
            local barW = math.max(1, pct * (self.herbSkillBar:GetWidth() - 2))
            self.herbSkillBar.fill:SetWidth(barW)
            local rankName = GetSkillRankName(d.max)
            local label = d.name
            if rankName ~= "" then label = label .. "  |cffffcc00" .. rankName .. "|r" end
            self.herbSkillBar.text:SetText(label .. "  " .. d.rank .. "/" .. d.max)
            if d.rank >= d.max then
                self.herbSkillBar.fill:SetVertexColor(1.0, 0.3, 0.3, 1)
            else
                self.herbSkillBar.fill:SetVertexColor(unpack(COLOURS.herbGreen))
            end
            self.herbSkillBar:Show()
        else
            self.herbSkillBar:Hide()
        end

        -- Mining skill
        if data.mining then
            local d = data.mining
            local pct = (d.max > 0) and (d.rank / d.max) or 0
            local barW = math.max(1, pct * (self.miningSkillBar:GetWidth() - 2))
            self.miningSkillBar.fill:SetWidth(barW)
            local rankName = GetSkillRankName(d.max)
            local label = d.name
            if rankName ~= "" then label = label .. "  |cffffcc00" .. rankName .. "|r" end
            self.miningSkillBar.text:SetText(label .. "  " .. d.rank .. "/" .. d.max)
            if d.rank >= d.max then
                self.miningSkillBar.fill:SetVertexColor(1.0, 0.3, 0.3, 1)
            else
                self.miningSkillBar.fill:SetVertexColor(unpack(COLOURS.oreYellow))
            end
            self.miningSkillBar:Show()

            -- Adjust position: if no herb bar, move mining bar up
            self.miningSkillBar:ClearAllPoints()
            if data.herb then
                self.miningSkillBar:SetPoint("TOPLEFT", skillArea, "TOPLEFT", 0, SKILL_BAR_TOP - 22)
                self.miningSkillBar:SetPoint("TOPRIGHT", skillArea, "TOPRIGHT", 0, SKILL_BAR_TOP - 22)
            else
                self.miningSkillBar:SetPoint("TOPLEFT", skillArea, "TOPLEFT", 0, SKILL_BAR_TOP)
                self.miningSkillBar:SetPoint("TOPRIGHT", skillArea, "TOPRIGHT", 0, SKILL_BAR_TOP)
            end
        else
            self.miningSkillBar:Hide()
        end

        -- Adjust skill area height (header + bars)
        local count = (data.herb and 1 or 0) + (data.mining and 1 or 0)
        if count == 0 then
            skillArea:SetHeight(1)
            skillHeader:Hide()
        elseif count == 1 then
            skillArea:SetHeight(38)
            skillHeader:Show()
        else
            skillArea:SetHeight(60)
            skillHeader:Show()
        end
    end

    -------------------------------------------------------------------
    -- Tabs
    -------------------------------------------------------------------
    local herbTab = CreateTabButton(f, "Herbs")
    herbTab:ClearAllPoints()
    herbTab:SetPoint("TOPLEFT", skillArea, "BOTTOMLEFT", 0, -4)
    herbTab:SetWidth(90)
    local oreTab   = CreateTabButton(f, "Ores", herbTab)
    oreTab:SetWidth(90)
    local routeTab = CreateTabButton(f, "Routes", oreTab)
    routeTab:SetWidth(90)
    local guideTab = CreateTabButton(f, "Guide", routeTab)
    guideTab:SetWidth(90)
    f.herbTab  = herbTab
    f.oreTab   = oreTab
    f.routeTab = routeTab
    f.guideTab = guideTab

    -------------------------------------------------------------------
    -- Scroll frames (one per tab)
    -------------------------------------------------------------------
    local function CreateScrollArea(parent)
        local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        container:SetPoint("TOPLEFT", herbTab, "BOTTOMLEFT", 0, -4)
        container:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -8, 10)
        SkinFrame(container)

        local scroll = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 4, -4)
        scroll:SetPoint("BOTTOMRIGHT", -26, 4)

        local content = CreateFrame("Frame", nil, scroll)
        content:SetSize(scroll:GetWidth(), 1)  -- height set dynamically
        scroll:SetScrollChild(content)

        return container, scroll, content
    end

    local herbContainer, herbScroll, herbContent = CreateScrollArea(f)
    local oreContainer,  oreScroll,  oreContent  = CreateScrollArea(f)

    f.herbContainer = herbContainer
    f.herbContent   = herbContent
    f.oreContainer  = oreContainer
    f.oreContent    = oreContent

    -------------------------------------------------------------------
    -- Routes container
    -------------------------------------------------------------------
    local routeContainer = CreateFrame("Frame", nil, f, "BackdropTemplate")
    routeContainer:SetPoint("TOPLEFT", herbTab, "BOTTOMLEFT", 0, -4)
    routeContainer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8, 10)
    SkinFrame(routeContainer)
    routeContainer:Hide()
    f.routeContainer = routeContainer

    -- Route state
    local activeRouteSubTab = "herbs"
    local currentRouteZone  = nil  -- currently displayed zone key
    local currentRouteIdx   = 1    -- index in NS.RouteZoneList

    -- Resource browse mode state
    local routeBrowseMode       = "zone"   -- "zone" or "resource"
    local currentResourceIdx    = 1        -- index in FarmingHerbList/FarmingMiningList
    local currentResourceZoneIdx = 1       -- index in the zones of the current resource

    -- Sub-tab buttons (Herbes / Minage)
    local routeHerbBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    routeHerbBtn:SetSize(100, 24)
    routeHerbBtn:SetPoint("TOPLEFT", routeContainer, "TOPLEFT", 6, -6)
    SkinFrame(routeHerbBtn)
    routeHerbBtn.label = routeHerbBtn:CreateFontString(nil, "OVERLAY")
    routeHerbBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    routeHerbBtn.label:SetPoint("CENTER")
    routeHerbBtn.label:SetText("Herbes")

    local routeMineBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    routeMineBtn:SetSize(100, 24)
    routeMineBtn:SetPoint("LEFT", routeHerbBtn, "RIGHT", 4, 0)
    SkinFrame(routeMineBtn)
    routeMineBtn.label = routeMineBtn:CreateFontString(nil, "OVERLAY")
    routeMineBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    routeMineBtn.label:SetPoint("CENTER")
    routeMineBtn.label:SetText("Minage")

    local routeGasBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    routeGasBtn:SetSize(100, 24)
    routeGasBtn:SetPoint("LEFT", routeMineBtn, "RIGHT", 4, 0)
    SkinFrame(routeGasBtn)
    routeGasBtn.label = routeGasBtn:CreateFontString(nil, "OVERLAY")
    routeGasBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    routeGasBtn.label:SetPoint("CENTER")
    routeGasBtn.label:SetText("Gaz")

    -- Sub-tab selection visuals
    local function UpdateRouteSubTabs()
        -- Reset all to default
        routeHerbBtn:SetBackdropBorderColor(unpack(COLOURS.border))
        routeHerbBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
        routeMineBtn:SetBackdropBorderColor(unpack(COLOURS.border))
        routeMineBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
        routeGasBtn:SetBackdropBorderColor(unpack(COLOURS.border))
        routeGasBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
        -- Highlight active
        if activeRouteSubTab == "herbs" then
            routeHerbBtn:SetBackdropBorderColor(unpack(COLOURS.herbGreen))
            routeHerbBtn.label:SetTextColor(unpack(COLOURS.herbGreen))
        elseif activeRouteSubTab == "mining" then
            routeMineBtn:SetBackdropBorderColor(unpack(COLOURS.oreYellow))
            routeMineBtn.label:SetTextColor(unpack(COLOURS.oreYellow))
        elseif activeRouteSubTab == "gases" then
            routeGasBtn:SetBackdropBorderColor(unpack(COLOURS.gasPurple))
            routeGasBtn.label:SetTextColor(unpack(COLOURS.gasPurple))
        end
    end

    -- Browse mode toggle buttons (Par zone / Par ressource)
    local browseZoneBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    browseZoneBtn:SetSize(110, 22)
    browseZoneBtn:SetPoint("TOPLEFT", routeHerbBtn, "BOTTOMLEFT", 0, -8)
    SkinFrame(browseZoneBtn)
    browseZoneBtn.label = browseZoneBtn:CreateFontString(nil, "OVERLAY")
    browseZoneBtn.label:SetFont(GetFont(), 9, "OUTLINE")
    browseZoneBtn.label:SetPoint("CENTER")
    browseZoneBtn.label:SetText("Par zone")

    local browseResBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    browseResBtn:SetSize(110, 22)
    browseResBtn:SetPoint("LEFT", browseZoneBtn, "RIGHT", 4, 0)
    SkinFrame(browseResBtn)
    browseResBtn.label = browseResBtn:CreateFontString(nil, "OVERLAY")
    browseResBtn.label:SetFont(GetFont(), 9, "OUTLINE")
    browseResBtn.label:SetPoint("CENTER")
    browseResBtn.label:SetText("Par ressource")

    local function UpdateBrowseModeButtons()
        if routeBrowseMode == "zone" then
            browseZoneBtn:SetBackdropBorderColor(unpack(COLOURS.accent))
            browseZoneBtn.label:SetTextColor(unpack(COLOURS.accent))
            browseResBtn:SetBackdropBorderColor(unpack(COLOURS.border))
            browseResBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
        else
            browseZoneBtn:SetBackdropBorderColor(unpack(COLOURS.border))
            browseZoneBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
            browseResBtn:SetBackdropBorderColor(unpack(COLOURS.accent))
            browseResBtn.label:SetTextColor(unpack(COLOURS.accent))
        end
    end

    -- Resource zone sub-navigation (shown in resource mode)
    local resZonePrevBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    resZonePrevBtn:SetSize(16, 16)
    SkinFrame(resZonePrevBtn)
    resZonePrevBtn.label = resZonePrevBtn:CreateFontString(nil, "OVERLAY")
    resZonePrevBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    resZonePrevBtn.label:SetPoint("CENTER")
    resZonePrevBtn.label:SetText("<")
    resZonePrevBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
    resZonePrevBtn:Hide()

    local resZoneNextBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    resZoneNextBtn:SetSize(16, 16)
    SkinFrame(resZoneNextBtn)
    resZoneNextBtn.label = resZoneNextBtn:CreateFontString(nil, "OVERLAY")
    resZoneNextBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    resZoneNextBtn.label:SetPoint("CENTER")
    resZoneNextBtn.label:SetText(">")
    resZoneNextBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
    resZoneNextBtn:Hide()

    local resZoneNameText = routeContainer:CreateFontString(nil, "OVERLAY")
    resZoneNameText:SetFont(GetFont(), 9, "")
    resZoneNameText:SetJustifyH("CENTER")
    resZoneNameText:SetTextColor(unpack(COLOURS.dimWhite))
    resZoneNameText:Hide()

    -- Zone navigation: zone name + prev/next arrows
    local zonePrevBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    zonePrevBtn:SetSize(20, 20)
    zonePrevBtn:SetPoint("TOPLEFT", browseZoneBtn, "BOTTOMLEFT", 0, -8)
    SkinFrame(zonePrevBtn)
    zonePrevBtn.label = zonePrevBtn:CreateFontString(nil, "OVERLAY")
    zonePrevBtn.label:SetFont(GetFont(), 12, "OUTLINE")
    zonePrevBtn.label:SetPoint("CENTER")
    zonePrevBtn.label:SetText("<")
    zonePrevBtn.label:SetTextColor(unpack(COLOURS.dimWhite))

    local zoneNextBtn = CreateFrame("Button", nil, routeContainer, "BackdropTemplate")
    zoneNextBtn:SetSize(20, 20)
    zoneNextBtn:SetPoint("TOP", browseZoneBtn, "BOTTOM", 0, -8)
    zoneNextBtn:SetPoint("RIGHT", routeContainer, "RIGHT", -6, 0)
    SkinFrame(zoneNextBtn)
    zoneNextBtn.label = zoneNextBtn:CreateFontString(nil, "OVERLAY")
    zoneNextBtn.label:SetFont(GetFont(), 12, "OUTLINE")
    zoneNextBtn.label:SetPoint("CENTER")
    zoneNextBtn.label:SetText(">")
    zoneNextBtn.label:SetTextColor(unpack(COLOURS.dimWhite))

    local zoneNameText = routeContainer:CreateFontString(nil, "OVERLAY")
    zoneNameText:SetFont(GetFont(), 11, "OUTLINE")
    zoneNameText:SetPoint("LEFT", zonePrevBtn, "RIGHT", 4, 0)
    zoneNameText:SetPoint("RIGHT", zoneNextBtn, "LEFT", -4, 0)
    zoneNameText:SetJustifyH("CENTER")
    zoneNameText:SetTextColor(unpack(COLOURS.accent))

    -- Skill range label
    local skillRangeText = routeContainer:CreateFontString(nil, "OVERLAY")
    skillRangeText:SetFont(GetFont(), 9, "")
    skillRangeText:SetPoint("TOP", zoneNameText, "BOTTOM", 0, -1)
    skillRangeText:SetTextColor(unpack(COLOURS.dimWhite))

    -- Map frame (fills container width, fixed 2:1 aspect ratio)
    local MAP_RATIO = 0.5  -- height = width * 0.5
    local mapFrame = CreateFrame("Frame", nil, routeContainer, "BackdropTemplate")
    mapFrame:SetPoint("TOP", skillRangeText, "BOTTOM", 0, -4)
    mapFrame:SetPoint("LEFT", routeContainer, "LEFT", 6, 0)
    mapFrame:SetPoint("RIGHT", routeContainer, "RIGHT", -6, 0)
    -- Height set dynamically via OnSizeChanged to maintain ratio
    mapFrame:SetScript("OnSizeChanged", function(self, w)
        self:SetHeight(w * MAP_RATIO)
    end)
    mapFrame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
    })
    mapFrame:SetBackdropColor(0.05, 0.05, 0.05, 1)
    mapFrame:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)
    f.routeMapFrame = mapFrame

    local mapTex = mapFrame:CreateTexture(nil, "ARTWORK")
    mapTex:SetAllPoints()

    -- Player dot
    local playerDot = mapFrame:CreateTexture(nil, "OVERLAY")
    playerDot:SetSize(8, 8)
    playerDot:SetTexture("Interface\\Buttons\\WHITE8x8")
    playerDot:SetVertexColor(0.0, 0.86, 1.0, 1)
    playerDot:Hide()

    -- Start point marker
    local startDot = mapFrame:CreateTexture(nil, "OVERLAY")
    startDot:SetSize(10, 10)
    startDot:SetTexture("Interface\\Buttons\\WHITE8x8")
    startDot:SetVertexColor(1.0, 0.84, 0.0, 1)
    startDot:Hide()

    -- "No route" text
    local noRouteText = mapFrame:CreateFontString(nil, "OVERLAY")
    noRouteText:SetFont(GetFont(), 12, "OUTLINE")
    noRouteText:SetPoint("CENTER", mapFrame, "CENTER")
    noRouteText:SetTextColor(0.5, 0.5, 0.5)
    noRouteText:SetText("Pas de route disponible")
    noRouteText:Hide()

    -- "Hors zone" text
    local oozText = mapFrame:CreateFontString(nil, "OVERLAY")
    oozText:SetFont(GetFont(), 14, "OUTLINE")
    oozText:SetPoint("CENTER", mapFrame, "CENTER")
    oozText:SetTextColor(1, 0.3, 0.3)
    oozText:SetText("Hors zone")
    oozText:Hide()

    -- Info line (coordinates)
    local infoText = routeContainer:CreateFontString(nil, "OVERLAY")
    infoText:SetFont(GetFont(), 10, "")
    infoText:SetPoint("BOTTOM", routeContainer, "BOTTOM", 0, 14)
    infoText:SetTextColor(unpack(COLOURS.dimWhite))
    infoText:SetText("")

    -- Start / Stop buttons (anchored to bottom of container)
    local startBtn = CreateFrame("Button", nil, routeContainer, "UIPanelButtonTemplate")
    startBtn:SetSize(100, 24)
    startBtn:SetPoint("BOTTOMLEFT", routeContainer, "BOTTOMLEFT", 20, 8)
    startBtn:SetText("Demarrer")

    local stopBtn = CreateFrame("Button", nil, routeContainer, "UIPanelButtonTemplate")
    stopBtn:SetSize(100, 24)
    stopBtn:SetPoint("BOTTOMRIGHT", routeContainer, "BOTTOMRIGHT", -20, 8)
    stopBtn:SetText("Arreter")
    stopBtn:Disable()
    f.routeStartBtn = startBtn
    f.routeStopBtn  = stopBtn

    -------------------------------------------------------------------
    -- Custom dropdown frame (reusable for zone/resource selection)
    -------------------------------------------------------------------
    local dropdownFrame = CreateFrame("Frame", nil, routeContainer, "BackdropTemplate")
    dropdownFrame:SetFrameStrata("TOOLTIP")
    dropdownFrame:SetSize(260, 40)
    SkinFrame(dropdownFrame)
    dropdownFrame:Hide()

    -- Click-outside overlay to close dropdown
    local dropdownOverlay = CreateFrame("Frame", nil, UIParent)
    dropdownOverlay:SetAllPoints(UIParent)
    dropdownOverlay:SetFrameStrata("TOOLTIP")
    dropdownOverlay:SetFrameLevel(dropdownFrame:GetFrameLevel() - 1)
    dropdownOverlay:EnableMouse(true)
    dropdownOverlay:SetScript("OnMouseDown", function()
        dropdownFrame:Hide()
    end)
    dropdownOverlay:Hide()

    -- Ensure overlay hides when dropdown hides
    dropdownFrame:SetScript("OnHide", function()
        dropdownOverlay:Hide()
    end)

    -- Scroll frame inside dropdown
    local dropScroll = CreateFrame("ScrollFrame", nil, dropdownFrame, "UIPanelScrollFrameTemplate")
    dropScroll:SetPoint("TOPLEFT", 4, -4)
    dropScroll:SetPoint("BOTTOMRIGHT", -22, 4)

    local dropContent = CreateFrame("Frame", nil, dropScroll)
    dropContent:SetSize(230, 1)
    dropScroll:SetScrollChild(dropContent)

    -- Pool of item buttons
    local dropdownItems = {}
    local DROPDOWN_ITEM_H = 20
    local DROPDOWN_MAX_VISIBLE = 10

    local function GetOrCreateDropdownItem(idx)
        if dropdownItems[idx] then return dropdownItems[idx] end

        local item = CreateFrame("Button", nil, dropContent)
        item:SetHeight(DROPDOWN_ITEM_H)
        item:SetPoint("TOPLEFT", dropContent, "TOPLEFT", 0, -(idx - 1) * DROPDOWN_ITEM_H)
        item:SetPoint("RIGHT", dropContent, "RIGHT", 0, 0)

        -- Hover highlight
        local hl = item:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints()
        hl:SetTexture("Interface\\Buttons\\WHITE8x8")
        hl:SetVertexColor(unpack(COLOURS.rowHover))
        hl:Hide()
        item.hl = hl

        -- Main label (left)
        item.label = item:CreateFontString(nil, "OVERLAY")
        item.label:SetFont(GetFont(), 10, "")
        item.label:SetPoint("LEFT", 6, 0)
        item.label:SetJustifyH("LEFT")
        item.label:SetTextColor(1, 1, 1)

        -- Sub label (right)
        item.subLabel = item:CreateFontString(nil, "OVERLAY")
        item.subLabel:SetFont(GetFont(), 9, "")
        item.subLabel:SetPoint("RIGHT", -6, 0)
        item.subLabel:SetJustifyH("RIGHT")
        item.subLabel:SetTextColor(unpack(COLOURS.dimWhite))

        item:SetScript("OnEnter", function(self)
            self.hl:Show()
        end)
        item:SetScript("OnLeave", function(self)
            self.hl:Hide()
        end)

        dropdownItems[idx] = item
        return item
    end

    local function HideDropdown()
        dropdownFrame:Hide()
        dropdownOverlay:Hide()
    end

    local function ShowDropdown(anchorFrame, items, selectedIdx, onSelect)
        -- items = { { label="...", subLabel="...", idx=N }, ... }
        if not items or #items == 0 then return end

        HideDropdown()

        local count = #items
        local visibleCount = math.min(count, DROPDOWN_MAX_VISIBLE)
        local totalH = visibleCount * DROPDOWN_ITEM_H + 8

        dropdownFrame:SetHeight(totalH)
        dropContent:SetHeight(count * DROPDOWN_ITEM_H)

        -- Populate items
        for i, data in ipairs(items) do
            local item = GetOrCreateDropdownItem(i)
            item:ClearAllPoints()
            item:SetPoint("TOPLEFT", dropContent, "TOPLEFT", 0, -(i - 1) * DROPDOWN_ITEM_H)
            item:SetPoint("RIGHT", dropContent, "RIGHT", 0, 0)
            item.label:SetText(data.label or "")
            item.subLabel:SetText(data.subLabel or "")

            -- Highlight selected
            if i == selectedIdx then
                item.label:SetTextColor(unpack(COLOURS.accent))
                item.subLabel:SetTextColor(unpack(COLOURS.accent))
            else
                item.label:SetTextColor(1, 1, 1)
                item.subLabel:SetTextColor(unpack(COLOURS.dimWhite))
            end

            item:SetScript("OnClick", function()
                HideDropdown()
                if onSelect then onSelect(data.idx or i) end
            end)
            item:Show()
        end

        -- Hide excess items
        for i = count + 1, #dropdownItems do
            dropdownItems[i]:Hide()
        end

        -- Anchor below the text
        dropdownFrame:ClearAllPoints()
        dropdownFrame:SetPoint("TOP", anchorFrame, "BOTTOM", 0, -2)

        -- Adjust width to match routeContainer
        local containerW = routeContainer:GetWidth() - 12
        dropdownFrame:SetWidth(containerW)
        dropContent:SetWidth(containerW - 26)

        dropScroll:SetVerticalScroll(0)
        dropdownOverlay:Show()
        dropdownFrame:Show()
    end

    -- Close dropdown on Escape (hook into main frame ESC)
    dropdownFrame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            HideDropdown()
            self:SetPropagateKeyboardInput(false)
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)
    dropdownFrame:EnableKeyboard(true)

    -- Clickable overlay for zoneNameText (main navigation label)
    local zoneNameBtn = CreateFrame("Button", nil, routeContainer)
    zoneNameBtn:SetPoint("LEFT", zonePrevBtn, "RIGHT", 4, 0)
    zoneNameBtn:SetPoint("RIGHT", zoneNextBtn, "LEFT", -4, 0)
    zoneNameBtn:SetHeight(20)
    zoneNameBtn:SetFrameLevel(routeContainer:GetFrameLevel() + 5)

    -- Dropdown arrow indicator for zone name
    local zoneDropArrow = routeContainer:CreateFontString(nil, "OVERLAY")
    zoneDropArrow:SetFont(GetFont(), 8, "OUTLINE")
    zoneDropArrow:SetText("v")
    zoneDropArrow:SetTextColor(unpack(COLOURS.dimWhite))

    zoneNameBtn:SetScript("OnEnter", function()
        zoneNameText:SetTextColor(unpack(COLOURS.routeCyan))
        zoneDropArrow:SetTextColor(unpack(COLOURS.routeCyan))
    end)
    zoneNameBtn:SetScript("OnLeave", function()
        zoneNameText:SetTextColor(unpack(COLOURS.accent))
        zoneDropArrow:SetTextColor(unpack(COLOURS.dimWhite))
    end)

    -- Clickable overlay for resZoneNameText (resource mode zone sub-nav)
    local resZoneNameBtn = CreateFrame("Button", nil, routeContainer)
    resZoneNameBtn:SetHeight(16)
    resZoneNameBtn:SetFrameLevel(routeContainer:GetFrameLevel() + 5)
    resZoneNameBtn:Hide()

    -- Dropdown arrow indicator for resource zone name
    local resZoneDropArrow = routeContainer:CreateFontString(nil, "OVERLAY")
    resZoneDropArrow:SetFont(GetFont(), 7, "OUTLINE")
    resZoneDropArrow:SetText("v")
    resZoneDropArrow:SetTextColor(unpack(COLOURS.dimWhite))
    resZoneDropArrow:Hide()

    resZoneNameBtn:SetScript("OnEnter", function()
        resZoneNameText:SetTextColor(unpack(COLOURS.routeCyan))
        resZoneDropArrow:SetTextColor(unpack(COLOURS.routeCyan))
    end)
    resZoneNameBtn:SetScript("OnLeave", function()
        resZoneNameText:SetTextColor(unpack(COLOURS.dimWhite))
        resZoneDropArrow:SetTextColor(unpack(COLOURS.dimWhite))
    end)

    -------------------------------------------------------------------
    -- Zone navigation helpers (zone mode)
    -------------------------------------------------------------------
    local function GetFilteredZoneList()
        local list = {}
        for _, key in ipairs(NS.RouteZoneList) do
            if NS.Routes:ZoneHasRoute(key, activeRouteSubTab) then
                list[#list + 1] = key
            end
        end
        return list
    end

    local function FindZoneIndex(list, zoneKey)
        for i, k in ipairs(list) do
            if k == zoneKey then return i end
        end
        return 1
    end

    -------------------------------------------------------------------
    -- Resource browse helpers
    -------------------------------------------------------------------
    local function GetCurrentFarmingList()
        if activeRouteSubTab == "herbs" then
            return NS.FarmingHerbList or {}
        elseif activeRouteSubTab == "gases" then
            return NS.FarmingGasList or {}
        else
            return NS.FarmingMiningList or {}
        end
    end

    local function GetCurrentFarmingEntry()
        local list = GetCurrentFarmingList()
        if #list == 0 then return nil end
        if currentResourceIdx < 1 then currentResourceIdx = 1 end
        if currentResourceIdx > #list then currentResourceIdx = #list end
        local dataIdx = list[currentResourceIdx]
        return NS.FarmingData and NS.FarmingData[dataIdx] or nil
    end

    -------------------------------------------------------------------
    -- Unified display update
    -------------------------------------------------------------------
    local function UpdateRouteDisplay()
        HideDropdown()

        if routeBrowseMode == "resource" then
            -- Resource mode: show resource name in main nav, zone in sub-nav
            resZonePrevBtn:Show()
            resZoneNextBtn:Show()
            resZoneNameText:Show()
            resZoneNameBtn:Show()
            resZoneDropArrow:Show()

            local entry = GetCurrentFarmingEntry()
            if not entry then
                mapTex:SetTexture(nil)
                noRouteText:Show()
                zoneNameText:SetText("--")
                skillRangeText:SetText("")
                resZoneNameText:SetText("")
                resZoneNameBtn:Hide()
                resZoneDropArrow:Hide()
                zoneDropArrow:ClearAllPoints()
                zoneDropArrow:SetPoint("LEFT", zoneNameText, "RIGHT", 2, 0)
                zoneDropArrow:Show()
                return
            end

            noRouteText:Hide()
            zoneNameText:SetText(NS.LocalizeResource(entry.name))
            skillRangeText:SetText("Skill " .. entry.skillRange)

            -- Position dropdown arrow for zone name
            zoneDropArrow:ClearAllPoints()
            zoneDropArrow:SetPoint("LEFT", zoneNameText, "RIGHT", 2, 0)
            zoneDropArrow:Show()

            -- Anchor sub-nav elements next to skillRangeText
            resZonePrevBtn:ClearAllPoints()
            resZonePrevBtn:SetPoint("LEFT", skillRangeText, "RIGHT", 10, 0)
            resZoneNextBtn:ClearAllPoints()
            resZoneNameText:ClearAllPoints()

            local zones = entry.zones
            if not zones or #zones == 0 then
                mapTex:SetTexture(nil)
                noRouteText:Show()
                resZoneNameText:SetText("")
                resZoneNameBtn:Hide()
                resZoneDropArrow:Hide()
                return
            end

            if currentResourceZoneIdx < 1 then currentResourceZoneIdx = 1 end
            if currentResourceZoneIdx > #zones then currentResourceZoneIdx = #zones end

            local zoneEntry = zones[currentResourceZoneIdx]
            resZoneNameText:SetText(NS.LocalizeZone(zoneEntry.zone) .. " (" .. currentResourceZoneIdx .. "/" .. #zones .. ")")
            resZoneNameText:SetPoint("LEFT", resZonePrevBtn, "RIGHT", 4, 0)
            resZoneNextBtn:SetPoint("LEFT", resZoneNameText, "RIGHT", 4, 0)

            -- Position resZone dropdown button and arrow
            resZoneNameBtn:ClearAllPoints()
            resZoneNameBtn:SetPoint("LEFT", resZonePrevBtn, "RIGHT", 4, 0)
            resZoneNameBtn:SetPoint("RIGHT", resZoneNextBtn, "LEFT", -4, 0)
            resZoneDropArrow:ClearAllPoints()
            resZoneDropArrow:SetPoint("LEFT", resZoneNameText, "RIGHT", 2, 0)

            if zoneEntry.texture then
                mapTex:SetTexture(zoneEntry.texture)
                noRouteText:Hide()
            else
                mapTex:SetTexture(nil)
                noRouteText:Show()
            end
        else
            -- Zone mode: hide resource sub-nav
            resZonePrevBtn:Hide()
            resZoneNextBtn:Hide()
            resZoneNameText:Hide()
            resZoneNameBtn:Hide()
            resZoneDropArrow:Hide()

            if not currentRouteZone then
                mapTex:SetTexture(nil)
                noRouteText:Show()
                zoneNameText:SetText("--")
                skillRangeText:SetText("")
                zoneDropArrow:ClearAllPoints()
                zoneDropArrow:SetPoint("LEFT", zoneNameText, "RIGHT", 2, 0)
                zoneDropArrow:Show()
                return
            end

            noRouteText:Hide()
            zoneNameText:SetText(NS.LocalizeZone(currentRouteZone))

            -- Position dropdown arrow for zone name
            zoneDropArrow:ClearAllPoints()
            zoneDropArrow:SetPoint("LEFT", zoneNameText, "RIGHT", 2, 0)
            zoneDropArrow:Show()

            local zd = NS.RoutesData[currentRouteZone]
            if zd and zd.skillRange then
                local factionStr = ""
                if zd.faction == "horde" then factionStr = " |cffff4444(Horde)|r"
                elseif zd.faction == "alliance" then factionStr = " |cff4444ff(Alliance)|r"
                end
                skillRangeText:SetText("Skill " .. zd.skillRange .. factionStr)
            else
                skillRangeText:SetText("")
            end

            local tex = NS.Routes:GetTexture(currentRouteZone, activeRouteSubTab)
            if tex then
                mapTex:SetTexture(tex)
                noRouteText:Hide()
            else
                mapTex:SetTexture(nil)
                noRouteText:Show()
            end
        end
    end

    local function SetRouteZone(zoneKey)
        currentRouteZone = zoneKey
        UpdateRouteDisplay()
    end

    local function NavigateZone(delta)
        if routeBrowseMode == "resource" then
            -- In resource mode, prev/next navigates resources
            local list = GetCurrentFarmingList()
            if #list == 0 then return end
            currentResourceIdx = currentResourceIdx + delta
            if currentResourceIdx < 1 then currentResourceIdx = #list end
            if currentResourceIdx > #list then currentResourceIdx = 1 end
            currentResourceZoneIdx = 1
            UpdateRouteDisplay()
        else
            local list = GetFilteredZoneList()
            if #list == 0 then return end
            local idx = FindZoneIndex(list, currentRouteZone)
            idx = idx + delta
            if idx < 1 then idx = #list end
            if idx > #list then idx = 1 end
            SetRouteZone(list[idx])
        end
    end

    local function NavigateResourceZone(delta)
        local entry = GetCurrentFarmingEntry()
        if not entry or not entry.zones or #entry.zones == 0 then return end
        currentResourceZoneIdx = currentResourceZoneIdx + delta
        if currentResourceZoneIdx < 1 then currentResourceZoneIdx = #entry.zones end
        if currentResourceZoneIdx > #entry.zones then currentResourceZoneIdx = 1 end
        UpdateRouteDisplay()
    end

    -------------------------------------------------------------------
    -- Dropdown click handlers for zone/resource names
    -------------------------------------------------------------------
    zoneNameBtn:SetScript("OnClick", function()
        if routeBrowseMode == "resource" then
            -- Show list of all resources for the active sub-tab
            local list = GetCurrentFarmingList()
            if #list == 0 then return end
            local items = {}
            for i, dataIdx in ipairs(list) do
                local entry = NS.FarmingData and NS.FarmingData[dataIdx]
                if entry then
                    items[#items + 1] = {
                        label = NS.LocalizeResource(entry.name),
                        subLabel = entry.skillRange or "",
                        idx = i,
                    }
                end
            end
            ShowDropdown(zoneNameBtn, items, currentResourceIdx, function(idx)
                currentResourceIdx = idx
                currentResourceZoneIdx = 1
                UpdateRouteDisplay()
            end)
        else
            -- Zone mode: show all filtered zones
            local list = GetFilteredZoneList()
            if #list == 0 then return end
            local curIdx = FindZoneIndex(list, currentRouteZone)
            local items = {}
            for i, key in ipairs(list) do
                local subLabel = ""
                local zd = NS.RoutesData and NS.RoutesData[key]
                if zd and zd.skillRange then
                    subLabel = zd.skillRange
                end
                items[#items + 1] = {
                    label = NS.LocalizeZone(key),
                    subLabel = subLabel,
                    idx = i,
                }
            end
            ShowDropdown(zoneNameBtn, items, curIdx, function(idx)
                SetRouteZone(list[idx])
            end)
        end
    end)

    resZoneNameBtn:SetScript("OnClick", function()
        local entry = GetCurrentFarmingEntry()
        if not entry or not entry.zones or #entry.zones == 0 then return end
        local items = {}
        for i, zoneEntry in ipairs(entry.zones) do
            items[#items + 1] = {
                label = NS.LocalizeZone(zoneEntry.zone),
                subLabel = "(" .. i .. "/" .. #entry.zones .. ")",
                idx = i,
            }
        end
        ShowDropdown(resZoneNameBtn, items, currentResourceZoneIdx, function(idx)
            currentResourceZoneIdx = idx
            UpdateRouteDisplay()
        end)
    end)

    local function AutoDetectZone()
        if routeBrowseMode == "resource" then
            currentResourceIdx = 1
            currentResourceZoneIdx = 1
            UpdateRouteDisplay()
        else
            local zoneKey = NS.Routes:GetCurrentZoneKey()
            if zoneKey and NS.Routes:ZoneHasRoute(zoneKey, activeRouteSubTab) then
                SetRouteZone(zoneKey)
            else
                local list = GetFilteredZoneList()
                if #list > 0 then
                    SetRouteZone(list[1])
                else
                    SetRouteZone(nil)
                end
            end
        end
    end

    -------------------------------------------------------------------
    -- Browse mode switching
    -------------------------------------------------------------------
    local function SwitchBrowseMode(mode)
        routeBrowseMode = mode
        if NS.db then NS.db.settings.routes.browseMode = mode end
        UpdateBrowseModeButtons()

        -- Stop navigation when switching modes
        if NS.Routes:IsNavigating() then
            NS.Routes:StopRoute()
        end

        if mode == "resource" then
            currentResourceIdx = 1
            currentResourceZoneIdx = 1
        end

        UpdateRouteDisplay()
    end

    browseZoneBtn:SetScript("OnClick", function() SwitchBrowseMode("zone") end)
    browseResBtn:SetScript("OnClick", function() SwitchBrowseMode("resource") end)
    browseZoneBtn:SetScript("OnEnter", function(self)
        if routeBrowseMode ~= "zone" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    browseZoneBtn:SetScript("OnLeave", function(self)
        if routeBrowseMode ~= "zone" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)
    browseResBtn:SetScript("OnEnter", function(self)
        if routeBrowseMode ~= "resource" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    browseResBtn:SetScript("OnLeave", function(self)
        if routeBrowseMode ~= "resource" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)

    -------------------------------------------------------------------
    -- Sub-tab switching
    -------------------------------------------------------------------
    local function SwitchRouteSubTab(subTab)
        activeRouteSubTab = subTab
        if NS.db then NS.db.settings.routes.lastType = subTab end
        UpdateRouteSubTabs()

        -- If navigating on the other type, stop
        if NS.Routes:IsNavigating() then
            local _, navType = NS.Routes:GetActiveInfo()
            if navType ~= subTab then
                NS.Routes:StopRoute()
            end
        end

        if routeBrowseMode == "resource" then
            currentResourceIdx = 1
            currentResourceZoneIdx = 1
            UpdateRouteDisplay()
        else
            AutoDetectZone()
        end
    end

    routeHerbBtn:SetScript("OnClick", function() SwitchRouteSubTab("herbs") end)
    routeMineBtn:SetScript("OnClick", function() SwitchRouteSubTab("mining") end)
    routeGasBtn:SetScript("OnClick", function() SwitchRouteSubTab("gases") end)
    routeHerbBtn:SetScript("OnEnter", function(self)
        if activeRouteSubTab ~= "herbs" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    routeHerbBtn:SetScript("OnLeave", function(self)
        if activeRouteSubTab ~= "herbs" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)
    routeMineBtn:SetScript("OnEnter", function(self)
        if activeRouteSubTab ~= "mining" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    routeMineBtn:SetScript("OnLeave", function(self)
        if activeRouteSubTab ~= "mining" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)
    routeGasBtn:SetScript("OnEnter", function(self)
        if activeRouteSubTab ~= "gases" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    routeGasBtn:SetScript("OnLeave", function(self)
        if activeRouteSubTab ~= "gases" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)

    zonePrevBtn:SetScript("OnClick", function() NavigateZone(-1) end)
    zoneNextBtn:SetScript("OnClick", function() NavigateZone(1) end)
    resZonePrevBtn:SetScript("OnClick", function() NavigateResourceZone(-1) end)
    resZoneNextBtn:SetScript("OnClick", function() NavigateResourceZone(1) end)

    -------------------------------------------------------------------
    -- Start / Stop handlers
    -------------------------------------------------------------------
    startBtn:SetScript("OnClick", function()
        if routeBrowseMode == "resource" then
            local entry = GetCurrentFarmingEntry()
            if entry and entry.zones and entry.zones[currentResourceZoneIdx] then
                local zoneEntry = entry.zones[currentResourceZoneIdx]
                NS.Routes:StartRoute(zoneEntry.zone, activeRouteSubTab, true)
            end
        else
            if currentRouteZone then
                NS.Routes:StartRoute(currentRouteZone, activeRouteSubTab)
            end
        end
    end)

    stopBtn:SetScript("OnClick", function()
        NS.Routes:StopRoute()
    end)

    -------------------------------------------------------------------
    -- Route update callback
    -------------------------------------------------------------------
    local function OnRouteUpdate(px, py)
        if not mainFrame or not mainFrame:IsShown() or activeTab ~= "routes" then
            return
        end

        if not px or not py then
            playerDot:Hide()
            oozText:Show()
            infoText:SetText("")
            return
        end

        oozText:Hide()

        -- Position player dot on map
        local mw = mapFrame:GetWidth()
        local mh = mapFrame:GetHeight()
        playerDot:ClearAllPoints()
        playerDot:SetPoint("CENTER", mapFrame, "TOPLEFT", px * mw, -(py * mh))
        playerDot:Show()

        -- Start point marker
        local spos = NS.Routes:GetStartPos()
        if spos and not startDot.placed then
            startDot:ClearAllPoints()
            startDot:SetPoint("CENTER", mapFrame, "TOPLEFT", spos.x * mw, -(spos.y * mh))
            startDot:Show()
            startDot.placed = true
        end

        infoText:SetText(string.format("%.1f, %.1f", px * 100, py * 100))
    end

    local function OnRouteStarted()
        startBtn:Disable()
        stopBtn:Enable()
    end

    local function OnRouteStopped()
        startBtn:Enable()
        stopBtn:Disable()
        playerDot:Hide()
        startDot:Hide()
        startDot.placed = false
        oozText:Hide()
        infoText:SetText("")
    end

    f.OnRouteUpdate  = OnRouteUpdate
    f.OnRouteStarted = OnRouteStarted
    f.OnRouteStopped = OnRouteStopped

    -------------------------------------------------------------------
    -- Forward-declare SwitchTab (used by guide route-link click handlers)
    -------------------------------------------------------------------
    local SwitchTab

    -------------------------------------------------------------------
    -- Guide container
    -------------------------------------------------------------------
    local guideContainer = CreateFrame("Frame", nil, f, "BackdropTemplate")
    guideContainer:SetPoint("TOPLEFT", herbTab, "BOTTOMLEFT", 0, -4)
    guideContainer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8, 10)
    SkinFrame(guideContainer)
    guideContainer:Hide()
    f.guideContainer = guideContainer

    -- Guide state
    local activeGuideSubTab = "herbs"

    -- Sub-tab buttons (Herbes / Minage)
    local guideHerbBtn = CreateFrame("Button", nil, guideContainer, "BackdropTemplate")
    guideHerbBtn:SetSize(100, 24)
    guideHerbBtn:SetPoint("TOPLEFT", guideContainer, "TOPLEFT", 6, -6)
    SkinFrame(guideHerbBtn)
    guideHerbBtn.label = guideHerbBtn:CreateFontString(nil, "OVERLAY")
    guideHerbBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    guideHerbBtn.label:SetPoint("CENTER")
    guideHerbBtn.label:SetText("Herbes")

    local guideMineBtn = CreateFrame("Button", nil, guideContainer, "BackdropTemplate")
    guideMineBtn:SetSize(100, 24)
    guideMineBtn:SetPoint("LEFT", guideHerbBtn, "RIGHT", 4, 0)
    SkinFrame(guideMineBtn)
    guideMineBtn.label = guideMineBtn:CreateFontString(nil, "OVERLAY")
    guideMineBtn.label:SetFont(GetFont(), 10, "OUTLINE")
    guideMineBtn.label:SetPoint("CENTER")
    guideMineBtn.label:SetText("Minage")

    local function UpdateGuideSubTabs()
        if activeGuideSubTab == "herbs" then
            guideHerbBtn:SetBackdropBorderColor(unpack(COLOURS.herbGreen))
            guideHerbBtn.label:SetTextColor(unpack(COLOURS.herbGreen))
            guideMineBtn:SetBackdropBorderColor(unpack(COLOURS.border))
            guideMineBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
        else
            guideHerbBtn:SetBackdropBorderColor(unpack(COLOURS.border))
            guideHerbBtn.label:SetTextColor(unpack(COLOURS.dimWhite))
            guideMineBtn:SetBackdropBorderColor(unpack(COLOURS.oreYellow))
            guideMineBtn.label:SetTextColor(unpack(COLOURS.oreYellow))
        end
    end

    -- Guide scroll area
    local guideScrollContainer = CreateFrame("Frame", nil, guideContainer, "BackdropTemplate")
    guideScrollContainer:SetPoint("TOPLEFT", guideHerbBtn, "BOTTOMLEFT", 0, -4)
    guideScrollContainer:SetPoint("BOTTOMRIGHT", guideContainer, "BOTTOMRIGHT", -4, 4)
    SkinFrame(guideScrollContainer)

    local guideScroll = CreateFrame("ScrollFrame", nil, guideScrollContainer, "UIPanelScrollFrameTemplate")
    guideScroll:SetPoint("TOPLEFT", 4, -4)
    guideScroll:SetPoint("BOTTOMRIGHT", -26, 4)

    local guideContent = CreateFrame("Frame", nil, guideScroll)
    guideContent:SetSize(guideScroll:GetWidth(), 1)
    guideScroll:SetScrollChild(guideContent)

    -------------------------------------------------------------------
    -- Guide: find current bracket for a skill level
    -------------------------------------------------------------------
    local function GetCurrentBracket(guideType, skillLevel)
        local data = NS.GuideData and NS.GuideData[guideType]
        if not data then return nil, nil end

        for i, bracket in ipairs(data) do
            if skillLevel >= bracket.skillRange[1] and skillLevel < bracket.skillRange[2] then
                return bracket, i
            end
        end
        -- If at or beyond last bracket max, return last bracket
        local last = data[#data]
        if last and skillLevel >= last.skillRange[1] then
            return last, #data
        end
        return data[1], 1
    end

    -------------------------------------------------------------------
    -- Guide: get player faction (lowercase)
    -------------------------------------------------------------------
    local function GetPlayerFaction()
        local faction = UnitFactionGroup("player")
        if faction then return faction:lower() end
        return "horde"
    end

    -------------------------------------------------------------------
    -- Guide: check if a zone has a route in RoutesData
    -------------------------------------------------------------------
    local function ZoneHasRouteForGuide(zoneKey, guideType)
        if not NS.RoutesData then return false end
        local routeType = guideType == "herbs" and "herbs" or "mining"
        local zd = NS.RoutesData[zoneKey]
        if not zd then return false end
        return zd[routeType] and zd[routeType].texture and true or false
    end

    -------------------------------------------------------------------
    -- Guide: get skill data for the active guide type
    -------------------------------------------------------------------
    local function GetGuideSkillInfo(guideType)
        local data = NS.skillData or {}
        if guideType == "herbs" then
            return data.herb
        else
            return data.mining
        end
    end

    -------------------------------------------------------------------
    -- Guide: check if training is needed
    -------------------------------------------------------------------
    local function GetTrainingAlert(skillLevel, skillMax)
        if not NS.GuideTraining then return nil end
        for _, t in ipairs(NS.GuideTraining) do
            if skillMax == t.cap and skillLevel >= (t.skill - 5) then
                return t
            end
        end
        return nil
    end

    -------------------------------------------------------------------
    -- Guide: refresh content
    -------------------------------------------------------------------
    -- Stored UI elements for guide content (reused on refresh)
    local guideElements = {}

    local function ClearGuideContent()
        for _, el in ipairs(guideElements) do
            if el.Hide then el:Hide() end
            if el.ClearAllPoints then el:ClearAllPoints() end
            if el.SetParent then el:SetParent(nil) end
        end
        guideElements = {}
        -- Also hide all children of guideContent
        local children = { guideContent:GetChildren() }
        for _, child in ipairs(children) do
            child:Hide()
            child:ClearAllPoints()
            child:SetParent(nil)
        end
        -- Clear font strings (regions)
        local regions = { guideContent:GetRegions() }
        for _, region in ipairs(regions) do
            region:Hide()
        end
    end

    local function AddGuideFontString(parent, yOffset, text, fontSize, color, xOffset)
        local fs = parent:CreateFontString(nil, "OVERLAY")
        fs:SetFont(GetFont(), fontSize, "")
        fs:SetPoint("TOPLEFT", parent, "TOPLEFT", xOffset or 8, yOffset)
        fs:SetPoint("RIGHT", parent, "RIGHT", -8, 0)
        fs:SetJustifyH("LEFT")
        fs:SetTextColor(unpack(color))
        fs:SetText(text)
        fs:Show()
        guideElements[#guideElements + 1] = fs
        return fs
    end

    local function AddGuideSkillBar(parent, yOffset, skillRank, skillMax, color)
        local barW = parent:GetWidth() - 20
        local barFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        barFrame:SetSize(barW, 14)
        barFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, yOffset)
        barFrame:SetBackdrop({
            bgFile   = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = 1,
        })
        barFrame:SetBackdropColor(0.12, 0.12, 0.12, 1)
        barFrame:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)
        barFrame:Show()
        guideElements[#guideElements + 1] = barFrame

        local pct = (skillMax > 0) and (skillRank / skillMax) or 0
        local fillW = math.max(1, pct * (barW - 2))
        local fill = barFrame:CreateTexture(nil, "ARTWORK")
        fill:SetSize(fillW, 12)
        fill:SetPoint("LEFT", barFrame, "LEFT", 1, 0)
        fill:SetTexture("Interface\\Buttons\\WHITE8x8")
        if skillRank >= skillMax then
            fill:SetVertexColor(1.0, 0.3, 0.3, 1)
        else
            fill:SetVertexColor(unpack(color))
        end

        local barText = barFrame:CreateFontString(nil, "OVERLAY")
        barText:SetFont(GetFont(), 9, "OUTLINE")
        barText:SetPoint("CENTER", barFrame)
        barText:SetTextColor(1, 1, 1)
        barText:SetText(skillRank .. " / " .. skillMax)

        return barFrame
    end

    local function AddGuideSeparator(parent, yOffset)
        local sep = parent:CreateTexture(nil, "ARTWORK")
        sep:SetHeight(1)
        sep:SetPoint("TOPLEFT", parent, "TOPLEFT", 8, yOffset)
        sep:SetPoint("RIGHT", parent, "RIGHT", -8, 0)
        sep:SetTexture("Interface\\Buttons\\WHITE8x8")
        sep:SetVertexColor(0.3, 0.3, 0.3, 0.6)
        sep:Show()
        guideElements[#guideElements + 1] = sep
        return sep
    end

    local function RefreshGuide()
        ClearGuideContent()

        local guideType = activeGuideSubTab
        local dataKey = guideType == "herbs" and "herbs" or "mining"
        local skillInfo = GetGuideSkillInfo(guideType)
        local faction = GetPlayerFaction()
        local accentColor = guideType == "herbs" and COLOURS.herbGreen or COLOURS.oreYellow

        local y = -4

        -- Skill display
        if skillInfo then
            local skillName = skillInfo.name or (guideType == "herbs" and "Herbalism" or "Mining")
            local rankName = GetSkillRankName(skillInfo.max)
            local label = skillName
            if rankName ~= "" then label = label .. "  |cffffcc00" .. rankName .. "|r" end
            AddGuideFontString(guideContent, y, label .. "  :  " .. skillInfo.rank .. " / " .. skillInfo.max, 12, COLOURS.white)
            y = y - 18

            -- Skill bar
            AddGuideSkillBar(guideContent, y, skillInfo.rank, skillInfo.max, accentColor)
            y = y - 22
        else
            local noSkillMsg = guideType == "herbs" and "Herboristerie non detectee" or "Minage non detecte"
            AddGuideFontString(guideContent, y, noSkillMsg, 11, {0.6, 0.4, 0.4, 1})
            y = y - 18
        end

        y = y - 6

        -- Get all brackets
        local allBrackets = NS.GuideData and NS.GuideData[dataKey]
        if not allBrackets or #allBrackets == 0 then
            AddGuideFontString(guideContent, y, "Aucune donnee de guide disponible", 11, COLOURS.dimWhite)
            guideContent:SetHeight(math.abs(y) + 20)
            return
        end

        -- Find current bracket index
        local skillLevel = skillInfo and skillInfo.rank or 1
        local _, currentIdx = GetCurrentBracket(dataKey, skillLevel)

        -- Loop through ALL brackets
        for bIdx, bracket in ipairs(allBrackets) do
            local isCurrent = (bIdx == currentIdx)
            local isPast = skillLevel >= bracket.skillRange[2]

            -- Box frame for this bracket
            local boxFrame = CreateFrame("Frame", nil, guideContent, "BackdropTemplate")
            boxFrame:SetPoint("TOPLEFT", guideContent, "TOPLEFT", 6, y)
            boxFrame:SetPoint("RIGHT", guideContent, "RIGHT", -6, 0)
            boxFrame:SetBackdrop({
                bgFile   = "Interface\\Buttons\\WHITE8x8",
                edgeFile = "Interface\\Buttons\\WHITE8x8",
                edgeSize = 1,
            })
            guideElements[#guideElements + 1] = boxFrame

            -- Style: current = accent border, past = dim, future = grey border
            if isCurrent then
                boxFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.9)
                boxFrame:SetBackdropBorderColor(unpack(accentColor))
            elseif isPast then
                boxFrame:SetBackdropColor(0.06, 0.06, 0.06, 0.7)
                boxFrame:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.6)
            else
                boxFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.8)
                boxFrame:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.8)
            end
            boxFrame:Show()

            local boxY = -6

            -- Bracket title
            local titleFs = boxFrame:CreateFontString(nil, "OVERLAY")
            titleFs:SetFont(GetFont(), 12, "OUTLINE")
            titleFs:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 10, boxY)
            if isCurrent then
                titleFs:SetTextColor(unpack(accentColor))
                titleFs:SetText(">> Skill " .. bracket.label .. " <<")
            elseif isPast then
                titleFs:SetTextColor(0.4, 0.4, 0.4, 1)
                titleFs:SetText("Skill " .. bracket.label .. "  |cff44ff44Done|r")
            else
                titleFs:SetTextColor(0.7, 0.7, 0.7, 1)
                titleFs:SetText("Skill " .. bracket.label)
            end
            boxY = boxY - 18

            -- Separator
            local sep1 = boxFrame:CreateTexture(nil, "ARTWORK")
            sep1:SetHeight(1)
            sep1:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 8, boxY)
            sep1:SetPoint("RIGHT", boxFrame, "RIGHT", -8, 0)
            sep1:SetTexture("Interface\\Buttons\\WHITE8x8")
            sep1:SetVertexColor(0.3, 0.3, 0.3, 0.4)
            boxY = boxY - 6

            -- Text colour depends on state
            local textColor = isCurrent and COLOURS.white or (isPast and {0.45, 0.45, 0.45, 1} or COLOURS.dimWhite)
            local zoneTextColor = isCurrent and {0.9, 0.9, 0.9, 1} or (isPast and {0.4, 0.4, 0.4, 1} or {0.6, 0.6, 0.6, 1})

            -- Resources
            local resLabel = boxFrame:CreateFontString(nil, "OVERLAY")
            resLabel:SetFont(GetFont(), 10, "")
            resLabel:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 10, boxY)
            resLabel:SetPoint("RIGHT", boxFrame, "RIGHT", -10, 0)
            resLabel:SetJustifyH("LEFT")
            resLabel:SetWordWrap(true)
            resLabel:SetTextColor(unpack(textColor))
            resLabel:SetText("Ressources : " .. table.concat(bracket.resources, ", "))
            local resHeight = resLabel:GetStringHeight()
            if resHeight < 12 then resHeight = 12 end
            boxY = boxY - resHeight - 6

            -- Zones
            local zonesHeader = boxFrame:CreateFontString(nil, "OVERLAY")
            zonesHeader:SetFont(GetFont(), 10, "")
            zonesHeader:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 10, boxY)
            zonesHeader:SetTextColor(unpack(textColor))
            zonesHeader:SetText("Zones :")
            boxY = boxY - 14

            -- Filter zones by faction
            local filteredZones = {}
            for _, z in ipairs(bracket.zones) do
                if z.faction == "both" or z.faction == faction then
                    filteredZones[#filteredZones + 1] = z
                end
            end

            for _, z in ipairs(filteredZones) do
                local zoneText = "  \194\183 " .. NS.LocalizeZone(z.zone)
                local hasRoute = isCurrent and ZoneHasRouteForGuide(z.zone, guideType)

                local zoneFs = boxFrame:CreateFontString(nil, "OVERLAY")
                zoneFs:SetFont(GetFont(), 10, "")
                zoneFs:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 14, boxY)
                zoneFs:SetTextColor(unpack(zoneTextColor))

                if hasRoute then
                    zoneFs:SetText(zoneText .. "  |cff00ddff[Route]|r")
                else
                    zoneFs:SetText(zoneText)
                end

                -- Make route link clickable (only for current bracket)
                if hasRoute then
                    local clickBtn = CreateFrame("Button", nil, boxFrame)
                    clickBtn:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 14, boxY)
                    clickBtn:SetSize(boxFrame:GetWidth() - 28, 14)
                    clickBtn:SetScript("OnClick", function()
                        local routeType = guideType == "herbs" and "herbs" or "mining"
                        activeRouteSubTab = routeType
                        if NS.db then NS.db.settings.routes.lastType = routeType end
                        SwitchTab("routes", z.zone)
                    end)
                    clickBtn:SetScript("OnEnter", function(self)
                        zoneFs:SetTextColor(unpack(COLOURS.routeCyan))
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                        GameTooltip:AddLine("Voir la route pour " .. NS.LocalizeZone(z.zone), 0, 0.86, 1)
                        GameTooltip:Show()
                    end)
                    clickBtn:SetScript("OnLeave", function()
                        zoneFs:SetTextColor(unpack(zoneTextColor))
                        GameTooltip:Hide()
                    end)
                    guideElements[#guideElements + 1] = clickBtn
                end

                boxY = boxY - 14
            end

            if #filteredZones == 0 then
                local noZone = boxFrame:CreateFontString(nil, "OVERLAY")
                noZone:SetFont(GetFont(), 10, "")
                noZone:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 14, boxY)
                noZone:SetTextColor(0.5, 0.5, 0.5)
                noZone:SetText("  Aucune zone pour votre faction")
                boxY = boxY - 14
            end

            -- Training alert & tip (only for current bracket)
            if isCurrent then
                if skillInfo then
                    local training = GetTrainingAlert(skillInfo.rank, skillInfo.max)
                    if training then
                        boxY = boxY - 2
                        local alertFs = boxFrame:CreateFontString(nil, "OVERLAY")
                        alertFs:SetFont(GetFont(), 10, "OUTLINE")
                        alertFs:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 10, boxY)
                        alertFs:SetPoint("RIGHT", boxFrame, "RIGHT", -10, 0)
                        alertFs:SetJustifyH("LEFT")
                        alertFs:SetTextColor(1.0, 0.6, 0.0, 1)
                        alertFs:SetText(">> Former " .. training.rank .. " a " .. training.skill .. " !")
                        boxY = boxY - 14
                    end
                end

                if bracket.tip then
                    boxY = boxY - 2
                    local tipFs = boxFrame:CreateFontString(nil, "OVERLAY")
                    tipFs:SetFont(GetFont(), 10, "")
                    tipFs:SetPoint("TOPLEFT", boxFrame, "TOPLEFT", 10, boxY)
                    tipFs:SetPoint("RIGHT", boxFrame, "RIGHT", -10, 0)
                    tipFs:SetJustifyH("LEFT")
                    tipFs:SetTextColor(1.0, 0.6, 0.0, 1)
                    tipFs:SetText(bracket.tip)
                    boxY = boxY - 14
                end
            end

            boxY = boxY - 4
            boxFrame:SetHeight(math.abs(boxY))

            y = y + boxY - 6
        end

        guideContent:SetHeight(math.abs(y) + 10)
    end

    f.RefreshGuide = RefreshGuide

    -------------------------------------------------------------------
    -- Guide sub-tab switching
    -------------------------------------------------------------------
    local function SwitchGuideSubTab(subTab)
        activeGuideSubTab = subTab
        if NS.db then NS.db.settings.guide.lastType = subTab end
        UpdateGuideSubTabs()
        RefreshGuide()
    end

    guideHerbBtn:SetScript("OnClick", function() SwitchGuideSubTab("herbs") end)
    guideMineBtn:SetScript("OnClick", function() SwitchGuideSubTab("mining") end)
    guideHerbBtn:SetScript("OnEnter", function(self)
        if activeGuideSubTab ~= "herbs" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    guideHerbBtn:SetScript("OnLeave", function(self)
        if activeGuideSubTab ~= "herbs" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)
    guideMineBtn:SetScript("OnEnter", function(self)
        if activeGuideSubTab ~= "mining" then self:SetBackdropColor(0.25, 0.25, 0.25, 1) end
    end)
    guideMineBtn:SetScript("OnLeave", function(self)
        if activeGuideSubTab ~= "mining" then self:SetBackdropColor(unpack(COLOURS.bg)) end
    end)

    -------------------------------------------------------------------
    -- Tab switching (4 tabs: herbs, ores, routes, guide)
    -------------------------------------------------------------------
    SwitchTab = function(tab, targetRouteZone)
        activeTab = tab
        herbTab:SetSelected(tab == "herbs")
        oreTab:SetSelected(tab == "ores")
        routeTab:SetSelected(tab == "routes")
        guideTab:SetSelected(tab == "guide")

        herbContainer:SetShown(tab == "herbs")
        oreContainer:SetShown(tab == "ores")
        routeContainer:SetShown(tab == "routes")
        guideContainer:SetShown(tab == "guide")

        if tab == "routes" then
            -- Restore last sub-tab
            if NS.db and NS.db.settings.routes then
                local last = NS.db.settings.routes.lastType
                if last == "mining" then
                    activeRouteSubTab = "mining"
                elseif last == "gases" then
                    activeRouteSubTab = "gases"
                else
                    activeRouteSubTab = "herbs"
                end
                -- Restore browse mode
                local bm = NS.db.settings.routes.browseMode
                if bm == "resource" then
                    routeBrowseMode = "resource"
                else
                    routeBrowseMode = "zone"
                end
            end
            UpdateRouteSubTabs()
            UpdateBrowseModeButtons()
            if targetRouteZone then
                routeBrowseMode = "zone"
                UpdateBrowseModeButtons()
                SetRouteZone(targetRouteZone)
            else
                AutoDetectZone()
            end
        elseif tab == "guide" then
            -- Restore last sub-tab
            if NS.db and NS.db.settings.guide then
                local last = NS.db.settings.guide.lastType
                if last == "mining" then
                    activeGuideSubTab = "mining"
                else
                    activeGuideSubTab = "herbs"
                end
            end
            UpdateGuideSubTabs()
            RefreshGuide()
        end
    end

    herbTab:SetScript("OnClick", function() SwitchTab("herbs") end)
    oreTab:SetScript("OnClick", function() SwitchTab("ores") end)
    routeTab:SetScript("OnClick", function() SwitchTab("routes") end)
    guideTab:SetScript("OnClick", function() SwitchTab("guide") end)
    SwitchTab("herbs")

    -------------------------------------------------------------------
    -- Update header stats
    -------------------------------------------------------------------
    function f:UpdateHeader()
        local sh = NS.Counter:GetTotalBag("herbs")
        local so = NS.Counter:GetTotalBag("ores")
        self.headerStats:SetText(
            "|cff44ff44Herbes: " .. sh .. "|r  |  |cffffcc44Minerais: " .. so .. "|r"
        )
    end

    mainFrame = f
    return f
end

----------------------------------------------------------------------
-- Populate / refresh rows
----------------------------------------------------------------------
local function RefreshList(content, category, rowCache)
    local store = NS.bagItems and NS.bagItems[category]
    if not store then return end

    -- Sort item names alphabetically
    local sorted = {}
    for name in pairs(store) do sorted[#sorted + 1] = name end
    table.sort(sorted)

    -- Ensure enough rows
    local rowWidth = content:GetParent():GetWidth() - 4
    for i = #rowCache + 1, #sorted do
        rowCache[i] = CreateNodeRow(content, i)
        rowCache[i]:SetWidth(rowWidth)
    end

    -- Hide excess rows
    for i = #sorted + 1, #rowCache do
        rowCache[i]:Hide()
    end

    -- Populate rows
    for i, name in ipairs(sorted) do
        local row  = rowCache[i]
        local data = store[name]
        row.nodeName     = name
        row.nodeData     = data
        row.nodeCategory = category

        row.nameText:SetText(name)

        -- Count text (bag quantity)
        local count = data.count or 0
        row.countText:SetText(tostring(count))
        if category == "herbs" then
            row.countText:SetTextColor(unpack(COLOURS.herbGreen))
        else
            row.countText:SetTextColor(unpack(COLOURS.oreYellow))
        end

        -- Objective / progress bar
        local obj = NS.db and NS.db.objectives[name]
        if obj and obj > 0 then
            local pct = math.min(count / obj, 1.0)
            local barWidth = math.max(1, pct * 110)
            row.barFill:SetWidth(barWidth)
            row.barFill:Show()
            row.barBg:Show()
            row.progressText:SetText(count .. "/" .. obj)
            row.progressText:SetTextColor(1, 1, 1)
            row.progressText:Show()

            if pct >= 1.0 then
                row.barFill:SetVertexColor(unpack(COLOURS.gold))
            elseif category == "herbs" then
                row.barFill:SetVertexColor(unpack(COLOURS.herbGreen))
            else
                row.barFill:SetVertexColor(unpack(COLOURS.oreYellow))
            end
        else
            row.barFill:Hide()
            row.barBg:Show()
            row.progressText:SetText("no objective")
            row.progressText:SetTextColor(0.4, 0.4, 0.4)
            row.progressText:Show()
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 2, -(i - 1) * 30)
        row:Show()
    end

    -- Adjust content height
    content:SetHeight(math.max(1, #sorted * 30))
end

function UI:RefreshMainWindow()
    if not mainFrame or not mainFrame:IsShown() then return end
    RefreshList(mainFrame.herbContent, "herbs", herbRows)
    RefreshList(mainFrame.oreContent,  "ores",  oreRows)
    mainFrame:UpdateHeader()
    mainFrame:UpdateSkillBars()
    if activeTab == "guide" and mainFrame.RefreshGuide then
        mainFrame.RefreshGuide()
    end
end

----------------------------------------------------------------------
-- Objective dialog
----------------------------------------------------------------------
function UI:ShowObjectiveDialog(nodeName, category)
    if not nodeName then return end

    -- Simple static popup with editbox
    local popupName = "NODECOUNTER_SET_OBJECTIVE"
    if not StaticPopupDialogs[popupName] then
        StaticPopupDialogs[popupName] = {
            text = "Set harvest objective for:\n%s\n\nEnter target amount (0 to remove):",
            button1 = "Set",
            button2 = "Cancel",
            hasEditBox = true,
            editBoxWidth = 100,
            OnShow = function(self)
                local eb = self.editBox or self.EditBox
                local cur = NS.db and NS.db.objectives[self.data] or 0
                eb:SetText(tostring(cur))
                eb:HighlightText()
                eb:SetFocus()
            end,
            OnAccept = function(self)
                local eb = self.editBox or self.EditBox
                local val = tonumber(eb:GetText()) or 0
                if val <= 0 then
                    NS.db.objectives[self.data] = nil
                else
                    NS.db.objectives[self.data] = val
                end
                NS:FireCallback("DATA_UPDATED")
            end,
            EditBoxOnEnterPressed = function(self)
                local parent = self:GetParent()
                local val = tonumber(self:GetText()) or 0
                if val <= 0 then
                    NS.db.objectives[parent.data] = nil
                else
                    NS.db.objectives[parent.data] = val
                end
                NS:FireCallback("DATA_UPDATED")
                parent:Hide()
            end,
            EditBoxOnEscapePressed = function(self)
                self:GetParent():Hide()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
    end

    StaticPopup_Show(popupName, nodeName, nil, nodeName)
end

-- ====================================================================
--  SETTINGS PANEL
-- ====================================================================
local function CreateSettingsFrame()
    local f = CreateFrame("Frame", "NodeCounterSettingsFrame", UIParent, "BackdropTemplate")
    f:SetSize(320, 300)
    f:SetPoint("CENTER", 230, 0)
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    SkinFrame(f)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "NodeCounterSettingsFrame")
    f:Hide()

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY")
    title:SetFont(GetFont(), 13, "OUTLINE")
    title:SetPoint("TOP", 0, -10)
    title:SetText("NodeCounter Settings")
    title:SetTextColor(unpack(COLOURS.accent))

    -- Close
    local closeBtn = CreateFrame("Button", nil, f)
    closeBtn:SetSize(18, 18)
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight", "ADD")
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    local yOff = -35

    -------------------------------------------------------------------
    -- Tracking Mode selector
    -------------------------------------------------------------------
    local modeLabel = f:CreateFontString(nil, "OVERLAY")
    modeLabel:SetFont(GetFont(), 11, "")
    modeLabel:SetPoint("TOPLEFT", 16, yOff)
    modeLabel:SetText("Tracking Mode:")
    modeLabel:SetTextColor(unpack(COLOURS.white))

    yOff = yOff - 22
    local modes = {
        { key = "herbs",    label = "Herbs Only" },
        { key = "minerals", label = "Minerals Only" },
        { key = "auto",     label = "Auto-Switch" },
    }

    local modeButtons = {}
    for i, m in ipairs(modes) do
        local btn = CreateFrame("CheckButton", nil, f, "UIRadioButtonTemplate")
        btn:SetPoint("TOPLEFT", 20, yOff)
        btn.text = btn:CreateFontString(nil, "OVERLAY")
        btn.text:SetFont(GetFont(), 10, "")
        btn.text:SetPoint("LEFT", btn, "RIGHT", 4, 0)
        btn.text:SetText(m.label)
        btn.text:SetTextColor(unpack(COLOURS.dimWhite))
        btn.key = m.key
        modeButtons[i] = btn
        yOff = yOff - 20
    end

    local function UpdateModeButtons()
        local cur = NS.db and NS.db.settings.trackingMode or "auto"
        for _, btn in ipairs(modeButtons) do
            btn:SetChecked(btn.key == cur)
        end
    end

    for _, btn in ipairs(modeButtons) do
        btn:SetScript("OnClick", function(self)
            if NS.db then NS.db.settings.trackingMode = self.key end
            UpdateModeButtons()
            NS:FireCallback("TRACKING_MODE_CHANGED", self.key)
        end)
    end

    yOff = yOff - 10

    -------------------------------------------------------------------
    -- Timer interval slider
    -------------------------------------------------------------------
    local timerLabel = f:CreateFontString(nil, "OVERLAY")
    timerLabel:SetFont(GetFont(), 11, "")
    timerLabel:SetPoint("TOPLEFT", 16, yOff)
    timerLabel:SetText("Auto-switch interval:")
    timerLabel:SetTextColor(unpack(COLOURS.white))

    yOff = yOff - 26

    local slider = CreateFrame("Slider", "NodeCounterTimerSlider", f, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", 20, yOff)
    slider:SetWidth(260)
    slider:SetMinMaxValues(5, 60)
    slider:SetValueStep(1)
    slider:SetObeyStepOnDrag(true)
    slider.Low:SetText("5s")
    slider.High:SetText("60s")

    local sliderVal = f:CreateFontString(nil, "OVERLAY")
    sliderVal:SetFont(GetFont(), 10, "")
    sliderVal:SetPoint("TOP", slider, "BOTTOM", 0, -2)
    sliderVal:SetTextColor(unpack(COLOURS.accent))

    slider:SetScript("OnValueChanged", function(self, val)
        val = math.floor(val + 0.5)
        sliderVal:SetText(val .. "s")
        if NS.db then
            NS.Tracking:UpdateInterval(val)
        end
    end)

    yOff = yOff - 40

    -------------------------------------------------------------------
    -- Skill cap warning toggle
    -------------------------------------------------------------------
    local warnCheck = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    warnCheck:SetPoint("TOPLEFT", 16, yOff)
    warnCheck.text = warnCheck:CreateFontString(nil, "OVERLAY")
    warnCheck.text:SetFont(GetFont(), 10, "")
    warnCheck.text:SetPoint("LEFT", warnCheck, "RIGHT", 4, 0)
    warnCheck.text:SetText("Enable skill cap warnings")
    warnCheck.text:SetTextColor(unpack(COLOURS.dimWhite))
    warnCheck:SetScript("OnClick", function(self)
        if NS.db then NS.db.settings.skillCapWarning = self:GetChecked() end
    end)

    yOff = yOff - 36

    -------------------------------------------------------------------
    -- Reset session button
    -------------------------------------------------------------------
    local resetSessionBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    resetSessionBtn:SetSize(140, 22)
    resetSessionBtn:SetPoint("TOPLEFT", 16, yOff)
    resetSessionBtn:SetText("Reset Session")
    resetSessionBtn:SetScript("OnClick", function()
        if NS.db then
            NS.db.session = { herbs = {}, ores = {} }
            NS:FireCallback("DATA_UPDATED")
            print("|cff00ccffNodeCounter:|r Session counters reset.")
        end
    end)

    -- Reset all button
    local resetAllBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    resetAllBtn:SetSize(140, 22)
    resetAllBtn:SetPoint("LEFT", resetSessionBtn, "RIGHT", 8, 0)
    resetAllBtn:SetText("Reset All Data")
    resetAllBtn:SetScript("OnClick", function()
        StaticPopup_Show("NODECOUNTER_RESET_ALL")
    end)

    -------------------------------------------------------------------
    -- OnShow: sync UI to current settings
    -------------------------------------------------------------------
    f:SetScript("OnShow", function()
        UpdateModeButtons()
        local interval = (NS.db and NS.db.settings.timerInterval) or 10
        slider:SetValue(interval)
        sliderVal:SetText(interval .. "s")
        local warn = NS.db and NS.db.settings.skillCapWarning
        warnCheck:SetChecked(warn ~= false)
    end)

    settingsFrame = f
    return f
end

-- ====================================================================
--  CALLBACK WIRING
-- ====================================================================
NS:RegisterCallback("ADDON_LOADED", function()
    CreateMinimapButton()
    CreateMainFrame()
    CreateSettingsFrame()
    mainFrame:Hide()
end)

NS:RegisterCallback("TOGGLE_WINDOW", function()
    if not mainFrame then return end
    if mainFrame:IsShown() then
        mainFrame:Hide()
    else
        mainFrame:Show()
        UI:RefreshMainWindow()
    end
end)

NS:RegisterCallback("HIDE_WINDOW", function()
    if mainFrame then mainFrame:Hide() end
end)

NS:RegisterCallback("SHOW_SETTINGS", function()
    if not settingsFrame then CreateSettingsFrame() end
    if settingsFrame:IsShown() then
        settingsFrame:Hide()
    else
        settingsFrame:Show()
    end
end)

NS:RegisterCallback("DATA_UPDATED", function()
    UI:RefreshMainWindow()
end)

NS:RegisterCallback("SKILLS_UPDATED", function()
    if mainFrame and mainFrame.UpdateSkillBars then
        mainFrame:UpdateSkillBars()
    end
    if mainFrame and mainFrame:IsShown() and activeTab == "guide" and mainFrame.RefreshGuide then
        mainFrame.RefreshGuide()
    end
end)

NS:RegisterCallback("TRACKING_MODE_CHANGED", function()
    if minimapButton then minimapButton:UpdateIcon() end
end)

NS:RegisterCallback("TRACKING_SWITCHED", function()
    if minimapButton then minimapButton:UpdateIcon() end
end)

NS:RegisterCallback("TRACKING_APPLIED", function()
    if minimapButton then minimapButton:UpdateIcon() end
end)

-- Route navigation callbacks
NS:RegisterCallback("ROUTE_UPDATE", function(...)
    if mainFrame and mainFrame.OnRouteUpdate then
        mainFrame.OnRouteUpdate(...)
    end
end)

NS:RegisterCallback("ROUTE_STARTED", function(...)
    if mainFrame and mainFrame.OnRouteStarted then
        mainFrame.OnRouteStarted(...)
    end
end)

NS:RegisterCallback("ROUTE_STOPPED", function(...)
    if mainFrame and mainFrame.OnRouteStopped then
        mainFrame.OnRouteStopped(...)
    end
end)

