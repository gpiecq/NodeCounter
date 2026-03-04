# NodeCounter

A World of Warcraft TBC Classic (2.5.5) addon for tracking gathering professions. Count your herb and ore harvests, set objectives, follow optimized farming routes, and level your professions with the built-in guide.

## Features

### Minimap Tracking
- Automatic tracking toggle between **Find Herbs** and **Find Minerals**
- Three modes: Herbs Only, Minerals Only, Auto-Switch
- Configurable auto-switch interval (5-60 seconds)
- Draggable minimap button with mode indicator

### Harvest Counting
- Tracks herbs and ores in your bags (by item type)
- Counts harvests per node type and zone (lifetime + session)
- Set custom objectives per item with progress bars
- Notification when an objective is reached

### Skill Monitoring
- Displays Herbalism and Mining skill bars with rank names
- Skill cap warnings when you need to train the next rank
- Multi-language support (EN, FR, DE, ES)

### Routes
Three sub-tabs (Herbs / Mining / Gas) with 150+ route maps:

**Zone Mode** (55 zone maps)
- Visual farming route maps overlaid on zone maps
- Browse all zones with prev/next navigation or dropdown
- Filter by Herbs, Mining, or Gas sub-tab
- **Classic zones** (1-300): 19 herbalism + 21 mining routes
- **TBC Outland zones** (300-375): 5 herbalism + 6 mining + 4 gas cloud routes

**Resource Mode** (100+ farming maps)
- Browse routes by specific resource (e.g. Dreamfoil, Thorium Ore, Windy Cloud)
- Multiple zone options per resource with sub-navigation
- 22 herb resources, 7 ore resources, and 4 gas cloud resources with dedicated maps

**Gas Clouds** (TBC Engineering 305+)
- Windy Cloud (Nagrand) — Mote of Air
- Swamp Gas (Zangarmarsh) — Mote of Water
- Felmist (Shadowmoon Valley) — Mote of Shadow
- Arcane Vortex (Netherstorm) — Mote of Mana
- Spawn data sourced from GatherMate2 and CavernOfTime databases

**Navigation**
- Player position dot tracking in real-time
- Auto-detect current zone
- Start/Stop navigation with coordinate display

### Leveling Guide
- Complete skill brackets from **1 to 375** (Classic + TBC)
- Herbalism: 11 brackets with recommended herbs and zones
- Mining: 9 brackets with recommended ores and zones
- Zones filtered by player faction (Horde/Alliance)
- Current bracket highlighted, past brackets marked as done
- Clickable `[Route]` links to jump directly to the Routes tab
- Training alerts when approaching skill cap

## Installation

1. Download or clone this repository
2. Copy the `NodeCounter` folder to:
   ```
   World of Warcraft/_anniversary_/Interface/AddOns/NodeCounter/
   ```
3. Restart WoW or `/reload`

## Usage

| Command | Action |
|---------|--------|
| `/nc` | Toggle main window |
| `/nc settings` | Open settings panel |
| `/nc herbs` | Track herbs only |
| `/nc minerals` | Track minerals only |
| `/nc auto` | Auto-switch tracking |
| `/nc reset session` | Reset session counters |
| `/nc reset all` | Reset all data (with confirmation) |

- **Left-click** minimap button: Toggle window
- **Right-click** minimap button: Cycle tracking mode
- **Drag** minimap button: Reposition on minimap edge

## File Structure

| File | Description |
|------|-------------|
| `NodeCounter.toc` | Addon manifest (Interface 20505) |
| `Core.lua` | Initialization, SavedVariables, event bus, slash commands |
| `Tracking.lua` | Minimap tracking toggle and auto-switch |
| `Counter.lua` | Harvest detection, bag scanning, skill monitoring |
| `GuideData.lua` | Leveling guide data (skill brackets 1-375) |
| `RoutesData.lua` | Route map definitions, zone aliases, localization tables |
| `FarmingData.lua` | Per-resource farming route data (herbs, ores, gas clouds) |
| `Routes.lua` | Navigation engine (player position tracking) |
| `UI.lua` | All UI: minimap button, main window, settings, guide |
| `textures/` | Zone route maps (TGA 512x256 32-bit) |
| `textures/farming/` | Per-resource farming route maps |

## Localization

The addon supports multiple languages through:
- **Spell detection**: Uses spell IDs (language-independent)
- **Tracking/skill names**: Multi-language lookup tables (EN/FR/DE/ES)
- **Zone detection**: Localized zone name aliases for route matching
- **Zone display**: Reverse locale tables (EN/FR/DE) for translated zone names in the UI
- **Resource display**: Localized herb and ore names (FR) in the Routes resource browser
- **Node/item names**: Stored as-is from the client

## Compatibility

- **Interface**: 20505 (TBC Classic 2.5.5)
- **ElvUI**: Detected and supported (uses `SetTemplate("Transparent")` for frames)
- **Container API**: Supports both legacy `GetContainerItemInfo` and `C_Container` API
- **Tracking API**: Supports both legacy `GetTrackingInfo` and `C_Minimap` API

## Credits & Sources

- Route maps sourced from [wow-professions.com](https://www.wow-professions.com/tbc/herbalism-leveling-guide-tbc-classic) (Classic and TBC leveling guides)
- Gas cloud spawn data from [GatherMate2](https://github.com/Nevcairiel/GatherMate2_Data) and [CavernOfTime TBC database](http://tbc.cavernoftime.com/)
- Leveling guide data compiled from:
  - [wow-professions.com](https://www.wow-professions.com/) - Herbalism and Mining 1-375 leveling guides
  - [taspas1po.fr](https://taspas1po.fr/) - TBC Herbalism and Mining guides (French)
- Built with assistance from [Claude Code](https://claude.ai/claude-code) by Anthropic

## License

This addon is provided as-is for personal use.
