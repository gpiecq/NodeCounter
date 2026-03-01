# NodeCounter

A World of Warcraft TBC Classic (2.5.4) addon for tracking gathering professions. Count your herb and ore harvests, set objectives, follow optimized farming routes, and level your professions with the built-in guide.

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

### Routes (51 zone maps)
- Visual farming route maps overlaid on zone maps
- Player position dot tracking in real-time
- Browse all zones with prev/next navigation
- Auto-detect current zone
- Start/Stop navigation with coordinate display
- **Classic zones** (1-300): 19 herbalism + 21 mining routes
- **TBC Outland zones** (300-375): 5 herbalism + 6 mining routes

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
| `NodeCounter.toc` | Addon manifest (Interface 20504) |
| `Core.lua` | Initialization, SavedVariables, event bus, slash commands |
| `Tracking.lua` | Minimap tracking toggle and auto-switch |
| `Counter.lua` | Harvest detection, bag scanning, skill monitoring |
| `GuideData.lua` | Leveling guide data (skill brackets 1-375) |
| `RoutesData.lua` | Route map definitions and zone aliases |
| `Routes.lua` | Navigation engine (player position tracking) |
| `UI.lua` | All UI: minimap button, main window, settings, guide |
| `textures/` | Route map images (TGA 512x256 32-bit) |

## Localization

The addon supports multiple languages through:
- **Spell detection**: Uses spell IDs (language-independent)
- **Tracking/skill names**: Multi-language lookup tables (EN/FR/DE/ES)
- **Zone detection**: Localized zone name aliases for route matching
- **Node/item names**: Stored as-is from the client

## Compatibility

- **Interface**: 20504 (TBC Classic 2.5.4)
- **ElvUI**: Detected and supported (uses `SetTemplate("Transparent")` for frames)
- **Container API**: Supports both legacy `GetContainerItemInfo` and `C_Container` API

## Credits & Sources

- Route maps sourced from [wow-professions.com](https://www.wow-professions.com/tbc/herbalism-leveling-guide-tbc-classic) (Classic and TBC leveling guides)
- Leveling guide data compiled from:
  - [wow-professions.com](https://www.wow-professions.com/) - Herbalism and Mining 1-375 leveling guides
  - [taspas1po.fr](https://taspas1po.fr/) - TBC Herbalism and Mining guides (French)
- Built with assistance from [Claude Code](https://claude.ai/claude-code) by Anthropic

## License

This addon is provided as-is for personal use.
