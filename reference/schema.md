# PZ Vote — Settings Schema Reference (B42)

**Sources:**
- `game_files/presets/Apocalypse.lua` — key names, types, defaults, nested table structure
- `game_files/Sandbox.json` — display names, enum options, tooltips
- Other preset files — values for Extinction, Outbreak, Rising

---

## Loot keys are float multipliers, not enums

Every `*LootNew` key is a **float multiplier** (0.0–3.0), not an integer enum index.

| Label | Value |
|---|---|
| Insane | 0.05 |
| Extremely Rare | 0.2 |
| Rare | 0.6 |
| Normal | 1.0 |
| Common | 2.0 |
| Abundant | 3.0 |

The tool snaps display to named labels at these 6 values.

---

## Lua table nesting

`buildSchema()` checks `luaTableHint` on the allowlist group, falling back to `luaTableOf` from `Apocalypse.lua`. Only these five tables get nested output; everything else is written at root level.

| Lua table | Allowlist group(s) | Example keys |
|---|---|---|
| `ZombieLore` | `Zombie Lore` (`zlore`) | `Speed`, `Strength`, `Toughness`, `Transmission`, `Mortality`, `Reanimate`, `Cognition`, `Memory`, `Sight`, `Hearing`, `ThumpNoChasing`, `ThumpOnConstruction`, `ActiveOnly`, `ZombiesDragDown`, `ZombiesFenceLunge`, `DisableFakeDead` |
| `ZombieConfig` | `Zombie Population` (`zpop`), `Zombie Respawn` (`zrespawn`) | `PopulationMultiplier`, `PopulationStartMultiplier`, `PopulationPeakMultiplier`, `PopulationPeakDay`, `RespawnHours`, `RespawnUnseenHours`, `RespawnMultiplier`, `RedistributeHours`, `FollowSoundDistance`, `RallyGroup*` |
| `MultiplierConfig` | `Character & Survival` (`char`) | `Global` (XP multiplier), per-skill floats |
| `Map` | `Misc & Display` (`misc`) | `AllowMiniMap`, `AllowWorldMap`, `MapAllKnown`, `MapNeedsLight` |
| `Basement` | `Basements & Darkness` (`b42world`) | `SpawnFrequency` |

---

## Preset comparison (key differentiators)

| Key | Apocalypse | Extinction | Outbreak | Rising |
|---|---|---|---|---|
| **Zombies** | 4 Normal | 3 High | 4 Normal | 5 Low |
| **ZombieRespawn** | 4 None | 2 Normal | 4 None | 3 Low |
| **ZombieLore.Speed** | 4 Random | 4 Random | 4 Random | 3 Shamblers |
| **ZombieLore.Strength** | 2 Normal | 1 Superhuman | 2 Normal | 3 Weak |
| **ZombieLore.Toughness** | 4 Random | 1 Tough | 4 Random | 3 Fragile |
| **ZombieConfig.PopMult** | 0.65 | 1.2 | 0.65 | 0.15 |
| **ZombieConfig.PeakMult** | 1.5 | 2.0 | 1.5 | 1.0 |
| **ZombieConfig.RespawnHrs** | 0.0 | 72.0 | 0.0 | 72.0 |
| **NightDarkness** | 3 Normal | 1 Pitch Black | 3 Normal | 3 Normal |
| **InjurySeverity** | 2 Normal | 3 High | 1 Low | 1 Low |
| **BoneFracture** | true | true | true | **false** |
| **FarmingSpeedNew** | 1.0 | 1.0 | **1.5** | 1.0 |
| **WeaponLootNew** | 0.6 | 0.4 | **2.0** | 0.4 |
| **MaterialLootNew** | 0.6 | 0.6 | 0.6 | **3.0** |
| **ToolLootNew** | 0.6 | 0.4 | **2.0** | **2.0** |
| **MultiHitZombies** | false | false | **true** | **true** |
| **Map.AllowMiniMap** | false | false | **true** | **true** |
| **StarterKit** | false | false | false | **true** |
| **GlobalToggle** | true | true | **false** | true |
| **AnimalMatingSeason** | true | true | **false** | true |

### Outbreak's MultiplierConfig (only preset using per-skill overrides)
```lua
GlobalToggle = false,
Doctor = 1.5,
MetalWelding = 1.4, Mechanics = 1.4, Tailoring = 1.4,
Fitness = 1.2, Strength = 1.2, Sprinting = 1.2, Lightfoot = 1.2,
Maintenance = 1.2, Woodwork = 1.2, Cooking = 1.2, Farming = 1.2,
Electricity = 1.2, Fishing = 1.2, Trapping = 1.2, PlantScavenging = 1.2,
-- combat/stealth skills stay at 1.0
```