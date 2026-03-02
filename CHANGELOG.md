# Changelog

All notable changes to NodeCounter will be documented in this file.

## [1.1.1] - 2026-03-02

### Fixed
- Fix `SetBackdrop` nil error on Anniversary client: added missing `BackdropTemplate` inheritance to all skinned Button frames (tab buttons, route/guide sub-tabs, browse mode buttons, navigation arrows)

---

## [1.1.0] - 2026-03-01

### Added

#### Resource Farming Mode (Routes Tab)
- New **Resource browse mode** in Routes tab: browse farming routes by specific resource
- 22 herb resources with dedicated zone maps (Peacebloom/Silverleaf through Netherbloom)
- 7 ore resources with dedicated zone maps (Copper Ore through Adamantite Ore)
- Sub-navigation per resource with multiple zone options
- Resource dropdown selector with skill range display
- `FarmingData.lua` with all resource definitions and zone-specific texture paths
- `textures/farming/` directory with 100+ per-resource farming route maps

#### Zone & Resource Localization
- `NS.ZoneLocales` reverse lookup table (EN to localized zone names) for French (frFR) and German (deDE)
- `NS.LocalizeZone()` helper function for translated zone names in the UI
- `NS.ResourceLocales` table with French translations for all herb and ore names
- `NS.LocalizeResource()` helper function for translated resource names in the UI
- Zone names now display in the player's language across Routes tab (zone mode, resource mode, dropdowns) and Guide tab
- Resource names now display in French on frFR clients (e.g. "Feuillereve", "Minerai de thorium")
- Fallback to English for unsupported locales

#### Build & Release
- GitHub Actions workflow for automated builds on pull requests (`build-addon.yml`)
- GitHub Actions workflow for automated releases on merge to main (`release.yml`)
- `package.sh` script for local addon packaging with CurseForge/Wago/WoWInterface upload instructions

### Changed
- Interface version updated from 20504 to **20505**
- `RoutesData.lua` now includes localization tables and helper functions
- Routes tab UI supports dual browsing modes (zone mode + resource mode)

---

## [1.0.0] - 2026-03-01

### Added

#### Core Addon
- Addon initialization with SavedVariables persistence (`NodeCounterDB`)
- Internal event bus (`NS:RegisterCallback` / `NS:FireCallback`) for module communication
- Deep copy and merge defaults for safe SavedVariables migration
- Slash commands: `/nc`, `/nc settings`, `/nc herbs`, `/nc minerals`, `/nc auto`, `/nc reset session`, `/nc reset all`

#### Minimap Tracking
- Automatic minimap tracking toggle between Find Herbs and Find Minerals
- Three tracking modes: Herbs Only, Minerals Only, Auto-Switch
- Configurable auto-switch timer interval (5-60 seconds)
- Multi-language tracking name detection (EN, FR, DE, ES)

#### Harvest Counting
- Harvest detection via `UNIT_SPELLCAST_SENT` / `UNIT_SPELLCAST_SUCCEEDED` using spell IDs (language-independent)
- Bag scanning for herbs (classID 7, subclassID 9) and ores (classID 7, subclassID 7)
- Lifetime and session counters per node type and zone
- Custom harvest objectives with progress bars and completion notifications
- Support for both legacy and `C_Container` API

#### Skill Monitoring
- Real-time Herbalism and Mining skill bar display with localized rank names
- Skill cap warnings with sound alert when approaching max rank
- Multi-language skill name detection (EN, FR, DE, ES)

#### UI
- Draggable minimap button with mode indicator and tooltip
- Main window (420x470) with 4 tabs: Herbs, Ores, Routes, Guide
- Dark modern design with ElvUI compatibility (`SetTemplate("Transparent")`)
- Settings panel with tracking mode, timer interval, and skill cap warning toggle
- Objective dialog for setting per-item harvest targets
- ESC to close, draggable window

#### Routes Tab
- 51 farming route maps (TGA 512x256, 32-bit, top-left origin)
- Sub-tabs for Herbs and Minerals with zone navigation (prev/next)
- Player position dot tracking on route map in real-time
- Start/Stop navigation with coordinate display
- Auto-detect current zone on tab open
- Aspect ratio preserved (2:1) for map display

#### Routes - Classic Zones (40 maps)
Herbalism routes (19):
- Durotar, Mulgore, Tirisfal Glades, Dun Morogh, Elwynn Forest, Teldrassil, Darkshore
- The Barrens, Silverpine Forest, Loch Modan
- Hillsbrad Foothills, Wetlands, Stonetalon Mountains
- Stranglethorn Vale, Arathi Highlands
- Tanaris, Searing Gorge, The Hinterlands, Felwood

Mining routes (21):
- Durotar, Mulgore, Tirisfal Glades, Dun Morogh, Elwynn Forest, Darkshore
- The Barrens, Hillsbrad Foothills, Redridge Mountains, Ashenvale
- Arathi Highlands, Desolace, Thousand Needles
- Tanaris, The Hinterlands
- Un'Goro Crater, Blasted Lands, Felwood, Eastern Plaguelands, Winterspring, Burning Steppes

#### Routes - TBC Outland Zones (11 maps)
Herbalism routes (5):
- Hellfire Peninsula, Nagrand, Blade's Edge Mountains, Terokkar Forest, Netherstorm

Mining routes (6):
- Hellfire Peninsula, Zangarmarsh, Terokkar Forest, Nagrand, Netherstorm, Shadowmoon Valley

#### Guide Tab
- Complete leveling guide from skill 1 to 375 (Classic + TBC)
- Herbalism: 11 skill brackets with recommended herbs and zones
- Mining: 9 skill brackets with recommended ores and zones
- All brackets displayed in scrollable list
- Current bracket highlighted with accent color border
- Past brackets dimmed with "Done" indicator
- Future brackets shown in grey
- Zones filtered by player faction (`UnitFactionGroup("player")`)
- Clickable `[Route]` links on zones that have farming route maps
- Training alerts (Journeyman, Expert, Artisan, Master) when approaching skill cap
- Sub-tabs to switch between Herbalism and Mining guides
- Skill bar with current level and rank display

#### Localization
- Zone name aliases for route matching: French (FR), English (EN), German (DE)
- Skill rank names: EN, FR, DE, ES
- Tracking type names: EN, FR, DE, ES
- Gathering skill names: EN, FR, DE, ES

### Sources
- Route maps: [wow-professions.com](https://www.wow-professions.com/) (Herbalism and Mining leveling guides)
- Guide data: [wow-professions.com](https://www.wow-professions.com/) and [taspas1po.fr](https://taspas1po.fr/) (TBC Burning Crusade Classic guides)
