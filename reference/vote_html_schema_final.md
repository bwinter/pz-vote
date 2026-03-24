# vote.html — Definitive Implementation Brief
**Sources (in priority order):**
1. `Apocalypse_Clone.cfg` — authoritative schema: key names, types, ranges, enum options, tooltips, dot-notation grouping
2. `Apocalypse.lua` / `Extinction.lua` / `Outbreak.lua` / `Rising.lua` — preset values
3. `Sandbox.json` — display names and tooltips (redundant with .cfg comments but useful as lookup)

**Everything in `vote_html_update_notes.md` and `vote_html_update_notes_v2.md` is superseded by this doc.**

---

## Most critical discovery: output format is .cfg, not Lua

The vote tool must **read and write `.cfg` files**, not Lua. This is the format PZ uses for custom sandbox presets.

**Format:** flat `key=value` with dot-notation for groups. No nested tables.
```
Zombies=4
ZombieLore.Speed=4
ZombieConfig.PopulationMultiplier=0.65
Basement.SpawnFrequency=4
Map.AllowMiniMap=false
MultiplierConfig.Global=1.0
```

**Schema is embedded in the file as `#` comment blocks** — every key has its tooltip, enum options, and `Min:/Max:/Default:` on the lines immediately above it. Parse `Apocalypse_Clone.cfg` at runtime to build the entire UI. Do not hardcode settings.

**The `.lua` preset files use a different (nested Lua table) format** — they are only used as the source of preset values when a player clicks a preset dropdown. They are not read or written during normal load/save.

**File naming convention** (unchanged from current tool):
```
0_Diesel.cfg          1_GunFox.cfg          2_SnowCrash.cfg
averages.cfg
```

---

## How to parse Apocalypse_Clone.cfg into a schema

Each setting block looks like:
```
# Tooltip text here. Min: 0.00 Max: 4.00 Default: 0.60
KeyName=value
```
or for enums:
```
# Tooltip text. Default = Label
    -- 1 = Option One
    -- 2 = Option Two
KeyName=2
```
or for booleans:
```
# Tooltip text.
KeyName=true
```

**Parsing algorithm:**
1. Read lines sequentially, accumulating `#` comment lines into a buffer
2. When a non-comment, non-blank line is found (`key=value`), emit a schema entry:
   - `key`: everything before `=`
   - `value`: everything after `=` (the Apocalypse default)
   - `type`: detect from value — `true`/`false` → bool; contains `.` or matches float pattern → float; else → int
   - `min`/`max`: extract from `Min: X Max: Y` in comment if present
   - `default`: extract from `Default: X` in comment if present (for numeric); or `Default = Label` (for enum)
   - `options`: collect all `-- N = Label` lines from comment buffer
   - `tooltip`: first `#` line(s) before any `--` options
   - `group`: prefix before `.` in key name (e.g. `ZombieLore`, `ZombieConfig`, `MultiplierConfig`, `Basement`, `Map`); absent = top-level
3. Clear comment buffer, move to next key

**Special cases:**
- `Version=6` — skip, do not expose
- Keys with `[!] It is recommended that you DO NOT change this` in tooltip — flag as `hidden:true`, omit from UI
- `WorldItemRemovalList` — string type, omit from sliders (show as read-only or skip)
- `LootItemRemovalList` — same

---

## Critical structural discoveries from the preset files

### 1. Loot is float multipliers, not enums

Every `*LootNew` key is a **float multiplier**, not an integer enum index.  
The loot factor scale from the presets:

| Label | Float value |
|---|---|
| Insane | 0.05 |
| Extremely Rare | 0.2 |
| Rare | 0.6 |
| Normal | 1.0 |
| Common | 2.0 |
| Abundant | 3.0 |

Slider range: `0.0` to `3.0`, step `0.05` (or snap to the 6 named values above).  
**The vote tool's loot sliders need to be floats, not enum pickers.**

Example from Apocalypse:
```
FoodLootNew = 0.6       -- Rare
RangedWeaponLootNew = 2.0  -- Common (boosted for 1993 Kentucky authenticity)
KeyLootNew = 0.4        -- between Insane and Extremely Rare
```

### 2. The output file has five nested Lua tables

The `SandboxVars.lua` output file is **not flat**. Five groups are nested tables:

```lua
SandboxVars = {
    -- flat keys ...
    Basement = {
        SpawnFrequency = 4,
    },
    Map = {
        AllowMiniMap = false,
        AllowWorldMap = true,
        MapAllKnown = false,
        MapNeedsLight = true,
    },
    ZombieLore = {
        Speed = 4,
        SprinterPercentage = 0,
        Strength = 2,
        -- ... all zombie lore keys
    },
    ZombieConfig = {
        PopulationMultiplier = 0.65,
        PopulationStartMultiplier = 1.0,
        -- ... all population/respawn/rally keys
    },
    MultiplierConfig = {
        Global = 1.0,
        GlobalToggle = true,
        Fitness = 1.0,
        -- ... all per-skill XP keys
    },
}
```

**The current tool writes everything flat. This is wrong.** The file writer must emit these five groups as nested tables.

### 3. SandboxVars.lua (the game's own file) just loads Apocalypse

```lua
SandboxVars = require "Sandbox/Apocalypse"
getSandboxOptions():initSandboxVars()
```

There is no separate "defaults" file. Apocalypse.lua IS the defaults.

### 4. The .cfg file lives in the save folder, not the install folder

Look in: `%UserProfile%\Zomboid\Saves\Sandbox\[savename]\[savename].cfg`  
Not needed for this implementation — the preset Lua files give everything required.

### 5. SixMonthsLater.lua is a B41 challenge preset (Version=5, not 6)

Uses old flat loot keys (`FoodLoot`, etc.) — commented out in the file.  
B42 presets are all Version=6. Ignore SixMonthsLater for B42 implementation.

---

## Complete key reference (from Apocalypse.lua as defaults)

Use `Apocalypse.lua` as the schema source. Every key and its Apocalypse default value is listed below, grouped by nesting level.

### Flat top-level keys

```lua
-- Time
DayLength = 4              -- enum 1-27 (1=15min ... 27=Real-time)
StartYear = 1
StartMonth = 7             -- enum 1-12
StartDay = 9               -- int 1-28
StartTime = 2              -- enum 1-9
DayNightCycle = 1          -- enum 1-3: Normal/Endless Day/Endless Night
ClimateCycle = 1           -- enum 1-6: Normal/No Weather/Endless Rain/Storm/Snow/Blizzard
FogCycle = 1               -- enum 1-3: Normal/No Fog/Endless Fog

-- World
WaterShut = 2              -- enum 1-9
ElecShut = 2               -- enum 1-9
AlarmDecay = 2             -- enum (same as shutoff options)
WaterShutModifier = 14     -- int, exact day override
ElecShutModifier = 14
AlarmDecayModifier = 14
MaximumFireFuelHours = 8   -- int hours
GeneratorTileRange = 20
GeneratorVerticalPowerRange = 3
ClayLakeChance = 0.05      -- float
ClayRiverChance = 0.05

-- Loot (ALL FLOATS 0.0-3.0)
FoodLootNew = 0.6
LiteratureLootNew = 0.6
SkillBookLoot = 0.6
RecipeResourceLoot = 0.6
MedicalLootNew = 0.6
SurvivalGearsLootNew = 0.6
CannedFoodLootNew = 0.6
WeaponLootNew = 0.6
RangedWeaponLootNew = 2.0   -- NOTE: boosted in Apocalypse (Kentucky guns)
AmmoLootNew = 0.6
MechanicsLootNew = 0.6
OtherLootNew = 0.6
ClothingLootNew = 0.6
ContainerLootNew = 0.6
KeyLootNew = 0.4
MediaLootNew = 0.6
MementoLootNew = 0.6
CookwareLootNew = 0.6
MaterialLootNew = 0.6
FarmingLootNew = 0.6
ToolLootNew = 0.6
RollsMultiplier = 1.0       -- DO NOT EXPOSE (dev setting)
RemoveStoryLoot = false
RemoveZombieLoot = false
ZombiePopLootEffect = 0     -- float
InsaneLootFactor = 0.05     -- DO NOT EXPOSE (loot scale constants)
ExtremeLootFactor = 0.2
RareLootFactor = 0.6
NormalLootFactor = 1.0
CommonLootFactor = 2.0
AbundantLootFactor = 3.0
SeenHoursPreventLootRespawn = 0
HoursForLootRespawn = 0
MaxItemsForLootRespawn = 5
ConstructionPreventsLootRespawn = true
WorldItemRemovalList = "Base.Hat, Base.Glasses, Base.Maggots, ..."  -- string, do not expose
HoursForWorldItemRemoval = 24.0
ItemRemovalListBlacklistToggle = false
MaximumLooted = 25          -- int 0-100 (percent)
DaysUntilMaximumLooted = 90
RuralLooted = 0.5           -- float multiplier
MaximumDiminishedLoot = 20  -- int 0-100
DaysUntilMaximumDiminishedLoot = 3650
MaximumLootedBuildingRooms = 50

-- Nature
Temperature = 3             -- enum 1-5
Rain = 3                    -- enum 1-5
ErosionSpeed = 3            -- enum 1-5
ErosionDays = 0             -- int 0-36500 (0=use ErosionSpeed)
Farming = 3                 -- enum 1-5 (old farming speed)
FarmingSpeedNew = 1.0       -- float (B42 float version — use this)
FarmingAmountNew = 1.0      -- float (B42 float version — use this)
CompostTime = 2             -- enum 1-8
NatureAbundance = 3         -- enum 1-5
FishAbundance = 2           -- enum 1-5 (NOTE: key is FishAbundance not FishAmount)
PlantResilience = 3         -- enum 1-5
PlantAbundance = 3          -- enum (Farming's Abundance — the OLD key)
KillInsideCrops = true
PlantGrowingSeasons = true
PlaceDirtAboveground = false  -- DO NOT EXPOSE
MaximumRatIndex = 25
DaysUntilMaximumRatIndex = 90

-- Meta events / world state
TimeSinceApo = 1            -- enum 1-13 (months: 0-12)
Helicopter = 2              -- enum 1-4
MetaEvent = 2               -- enum 1-3
SleepingEvent = 1           -- enum 1-2(?)
GeneratorSpawning = 4       -- enum 1-7 (rarity scale)
GeneratorFuelConsumption = 0.1
SurvivorHouseChance = 3     -- enum 1-7
VehicleStoryChance = 3      -- enum 1-7(?)
ZoneStoryChance = 3
AnnotatedMapChance = 4      -- enum 1-6
HoursForCorpseRemoval = 216.0
DecayingCorpseHealthImpact = 3  -- enum 1-5
ZombieHealthImpact = false
BloodLevel = 3              -- enum 1-5
BloodSplatLifespanDays = 0
MaggotSpawn = 1             -- enum 1-3
MetaKnowledge = 3           -- enum 1-3

-- Character
StatsDecrease = 3           -- enum 1-5
EndRegen = 3                -- enum 1-5
StarterKit = false
Nutrition = true
FoodRotSpeed = 3            -- enum 1-5 (Food Spoilage)
FridgeFactor = 3            -- enum 1-6
CharacterFreePoints = 0     -- int -100 to 100
ConstructionBonusPoints = 3 -- enum 1-5
BoneFracture = true
InjurySeverity = 2          -- enum 1-3
MultiHitZombies = false
RearVulnerability = 3       -- enum 1-3
AttackBlockMovements = true
Alarm = 4                   -- enum 1-6 (HouseAlarmFrequency)
LockedHouses = 6            -- enum 1-6 (LockedHouseFrequency)
NightDarkness = 3           -- enum 1-4
NightLength = 3             -- enum 1-5
AllClothesUnlocked = false
AllowExteriorGenerator = true
EnableTaintedWaterText = true
EnablePoisoning = 1         -- enum 1-3
LightBulbLifespan = 2.0     -- float (0=never break)
MaxFogIntensity = 1         -- enum 1-4
MaxRainFxIntensity = 1      -- enum 1-3
EnableSnowOnGround = true
FireSpread = true
DaysForRottenFoodRemoval = -1  -- int (-1=never)
ClothingDegradation = 3     -- enum 1-4
SeeNotLearntRecipe = true
LevelForMediaXPCutoff = 3   -- int
LevelForDismantleXPCutoff = 0
LiteratureCooldown = 45     -- int days
NegativeTraitsPenalty = 1   -- enum 1-4
MinutesPerPage = 2.0        -- float
EasyClimbing = false
MuscleStrainFactor = 0.7    -- float
DiscomfortFactor = 0.8      -- float
WoundInfectionFactor = 0.0  -- float
NoBlackClothes = true
FirearmUseDamageChance = true
FirearmNoiseMultiplier = 1.0  -- float
FirearmJamMultiplier = 1.0
FirearmMoodleMultiplier = 1.0
FirearmWeatherMultiplier = 1.0
FirearmHeadGearEffect = true

-- Vehicles
EnableVehicles = true
VehicleEasyUse = false
CarSpawnRate = 3            -- enum 1-5
ZombieAttractionMultiplier = 1.0
InitialGas = 2              -- enum 1-6
FuelStationGasInfinite = false
FuelStationGasMin = 0.0     -- float 0.0-1.0
FuelStationGasMax = 0.8     -- float 0.0-1.0
FuelStationGasEmptyChance = 20  -- int 0-100 (percent)
ChanceHasGas = 1            -- enum 1-3
LockedCar = 4               -- enum 1-6
CarGasConsumption = 1.0     -- float
CarGeneralCondition = 3     -- enum 1-5
CarDamageOnImpact = 3       -- enum 1-5
DamageToPlayerFromHitByACar = 1  -- enum 1-5
TrafficJam = true
CarAlarm = 3                -- enum 1-6
PlayerDamageFromCrash = true
SirenShutoffHours = 0.0     -- float (0=never)
RecentlySurvivorVehicles = 2  -- enum 1-4
SirenEffectsZombies = true

-- Livestock (B42)
AnimalStatsModifier = 4     -- enum 1-6 (AnimalSpeed options)
AnimalMetaStatsModifier = 4
AnimalPregnancyTime = 4
AnimalAgeModifier = 4
AnimalMilkIncModifier = 4
AnimalWoolIncModifier = 4
AnimalEggHatch = 4
AnimalRanchChance = 5       -- enum 1-7
AnimalGrassRegrowTime = 240 -- int hours
AnimalMetaPredator = false
AnimalMatingSeason = true
AnimalSoundAttractZombies = true
AnimalTrackChance = 4       -- enum 1-? (Sometimes=4)
AnimalPathChance = 4

-- Zombie count (top-level, maps to ZombieConfig.PopulationMultiplier)
Zombies = 4                 -- enum 1-6 (Insane/VeryHigh/High/Normal/Low/None)
Distribution = 1            -- enum 1-2
ZombieVoronoiNoise = true
ZombieRespawn = 4           -- enum 1-4: High/Normal/Low/None
ZombieMigrate = true
```

### Nested: Basement

```lua
Basement = {
    SpawnFrequency = 4,     -- enum 1-7 (Never to Always)
}
```

### Nested: Map

```lua
Map = {
    AllowMiniMap = false,   -- NOTE: false in Apocalypse, true in Outbreak/Rising
    AllowWorldMap = true,
    MapAllKnown = false,
    MapNeedsLight = true,
}
```

### Nested: ZombieLore

```lua
ZombieLore = {
    Speed = 4,              -- enum 1-4: Sprinters/FastShamblers/Shamblers/Random
    SprinterPercentage = 0, -- int 0-100 (% when Speed=Random)
    Strength = 2,           -- enum 1-4: Superhuman/Normal/Weak/Random
    Toughness = 4,          -- enum 1-4: Tough/Normal/Fragile/Random
    Transmission = 1,       -- enum 1-4
    Mortality = 5,          -- enum 1-7
    Reanimate = 3,          -- enum 1-6
    Cognition = 3,          -- enum 1-4
    DoorOpeningPercentage = 33,  -- int 0-100
    CrawlUnderVehicle = 5,  -- enum 1-7
    Memory = 2,             -- enum 1-6
    Sight = 5,              -- NOTE: 5 = "Random between Normal and Poor"
    Hearing = 5,            -- NOTE: 5 = "Random between Normal and Poor"
    SpottedLogic = true,
    ThumpNoChasing = false,
    ThumpOnConstruction = true,
    ActiveOnly = 1,         -- enum 1-3: Both/Night/Day
    TriggerHouseAlarm = true,
    ZombiesDragDown = true,
    ZombiesCrawlersDragDown = false,
    ZombiesFenceLunge = true,
    ZombiesArmorFactor = 2.0,    -- float
    ZombiesMaxDefense = 85,      -- int 0-100
    ChanceOfAttachedWeapon = 6,  -- int 0-100
    ZombiesFallDamage = 1.0,     -- float
    DisableFakeDead = 1,         -- enum 1-3
    PlayerSpawnZombieRemoval = 1, -- enum 1-4
    FenceThumpersRequired = 25,  -- enum: 0(disabled)/10/25/50/100
    FenceDamageMultiplier = 1.0, -- float
}
```

### Nested: ZombieConfig

```lua
ZombieConfig = {
    PopulationMultiplier = 0.65,    -- float (set by Zombies enum: Insane=2.5, VeryHigh=1.6, High=1.2, Normal=0.65, Low=0.15, None=0.0)
    PopulationStartMultiplier = 1.0, -- float
    PopulationPeakMultiplier = 1.5, -- float
    PopulationPeakDay = 28,         -- int
    RespawnHours = 0.0,             -- float (0=disabled)
    RespawnUnseenHours = 0.0,       -- float
    RespawnMultiplier = 0.0,        -- float
    RedistributeHours = 12.0,       -- float (0=disabled)
    FollowSoundDistance = 100,      -- int tiles
    RallyGroupSize = 20,            -- int
    RallyGroupSizeVariance = 50,    -- int percent
    RallyTravelDistance = 20,       -- int tiles
    RallyGroupSeparation = 15,      -- int tiles
    RallyGroupRadius = 3,           -- int tiles
    ZombiesCountBeforeDelete = 300, -- int
}
```

### Nested: MultiplierConfig

```lua
MultiplierConfig = {
    Global = 1.0,           -- float (the global XP multiplier)
    GlobalToggle = true,    -- bool (when true, all skills use Global)
    -- 35 per-skill floats, all 1.0 in Apocalypse/Rising
    -- Outbreak uses GlobalToggle=false with individual overrides
    Fitness = 1.0, Strength = 1.0, Sprinting = 1.0, Lightfoot = 1.0,
    Nimble = 1.0, Sneak = 1.0, Axe = 1.0, Blunt = 1.0,
    SmallBlunt = 1.0, LongBlade = 1.0, SmallBlade = 1.0, Spear = 1.0,
    Maintenance = 1.0, Woodwork = 1.0, Cooking = 1.0, Farming = 1.0,
    Doctor = 1.0, Electricity = 1.0, MetalWelding = 1.0, Mechanics = 1.0,
    Tailoring = 1.0, Aiming = 1.0, Reloading = 1.0, Fishing = 1.0,
    Trapping = 1.0, PlantScavenging = 1.0, FlintKnapping = 1.0,
    Masonry = 1.0, Pottery = 1.0, Carving = 1.0, Husbandry = 1.0,
    Tracking = 1.0, Blacksmith = 1.0, Butchering = 1.0, Glassmaking = 1.0
}
```

---

## Outbreak's interesting MultiplierConfig

Outbreak is the only preset that uses `GlobalToggle = false` and sets individual skills differently:
```lua
GlobalToggle = false,
Doctor = 1.5,       -- First Aid boosted most
MetalWelding = 1.4, Mechanics = 1.4, Tailoring = 1.4,
Fitness = 1.2, Strength = 1.2, Sprinting = 1.2, Lightfoot = 1.2,
Maintenance = 1.2, Woodwork = 1.2, Cooking = 1.2, Farming = 1.2,
Electricity = 1.2, Fishing = 1.2, Trapping = 1.2, PlantScavenging = 1.2,
FlintKnapping = 1.2, Masonry = 1.2, Pottery = 1.2, Carving = 1.2,
Husbandry = 1.2, Tracking = 1.2, Blacksmith = 1.2, Butchering = 1.2,
Glassmaking = 1.2,
-- Combat/stealth skills stay at 1.0
```

---

## Preset comparison table (key differentiators only)

| Key | Apocalypse | Extinction | Outbreak | Rising |
|---|---|---|---|---|
| **Zombies** | 4 (Normal) | 3 (High) | 4 (Normal) | 5 (Low) |
| **ZombieRespawn** | 4 (None) | 2 (Normal) | 4 (None) | 3 (Low) |
| **ZombieLore.Speed** | 4 (Random) | 4 (Random) | 4 (Random) | 3 (Shamblers) |
| **ZombieLore.Strength** | 2 (Normal) | 1 (Superhuman) | 2 (Normal) | 3 (Weak) |
| **ZombieLore.Toughness** | 4 (Random) | 1 (Tough) | 4 (Random) | 3 (Fragile) |
| **ZombieConfig.PopMult** | 0.65 | 1.2 | 0.65 | 0.15 |
| **ZombieConfig.PeakMult** | 1.5 | 2.0 | 1.5 | 1.0 |
| **ZombieConfig.RespawnHrs** | 0.0 | 72.0 | 0.0 | 72.0 |
| **WaterShut** | 2 (0-30d) | 2 (0-30d) | 3 (0-2mo) | 3 (0-2mo) |
| **ElecShut** | 2 (0-30d) | 2 (0-30d) | 3 (0-2mo) | 3 (0-2mo) |
| **NightDarkness** | 3 (Normal) | 1 (Pitch Black) | 3 (Normal) | 3 (Normal) |
| **InjurySeverity** | 2 (Normal) | 3 (High) | 1 (Low) | 1 (Low) |
| **BoneFracture** | true | true | true | **false** |
| **FarmingSpeedNew** | 1.0 | 1.0 | **1.5** | 1.0 |
| **FarmingAmountNew** | 1.0 | 1.0 | **1.5** | 1.0 |
| **WeaponLootNew** | 0.6 | 0.4 | **2.0** | 0.4 |
| **MaterialLootNew** | 0.6 | 0.6 | 0.6 | **3.0** |
| **FarmingLootNew** | 0.6 | 0.6 | 0.6 | **2.0** |
| **ToolLootNew** | 0.6 | 0.4 | **2.0** | **2.0** |
| **MultiHitZombies** | false | false | **true** | **true** |
| **Map.AllowMiniMap** | false | false | **true** | **true** |
| **StarterKit** | false | false | false | **true** |
| **GlobalToggle** | true | true | **false** | true |
| **AnimalMatingSeason** | true | true | **false** | true |

---

## How to use Sandbox.json with the preset files

`Sandbox.json` supplies: display name, tooltip, enum option labels  
Preset `.lua` files supply: actual key names, types, defaults, preset values  

**Mapping pattern**: `Sandbox_KEYNAME` in JSON → `KEYNAME` in Lua.  
For nested keys: `Sandbox_ZSpeed` in JSON → `ZombieLore.Speed` in Lua.

The vote tool should load `Sandbox.json` at runtime from the same folder to get tooltip text, rather than hardcoding strings.

---

## File writer specification

Write `.cfg` format — flat `key=value`, one per line, no comments in output. Preserve key ordering from `Apocalypse_Clone.cfg`.

```
Version=6
Zombies=4
Distribution=1
...
ZombieLore.Speed=4
ZombieLore.Strength=2
...
ZombieConfig.PopulationMultiplier=0.65
...
MultiplierConfig.Global=1.0
MultiplierConfig.GlobalToggle=true
...
```

Booleans: `true` / `false`. Floats: 1-2 decimal places. Enums/ints: whole numbers.

For `averages.cfg`: average each value independently. Booleans → majority vote (≥2 of 3 true → true). Enums/ints → `Math.round(avg)`. Floats → 2 decimal places.

## Where save .cfg files live

Custom sandbox presets save to: `%UserProfile%\Zomboid\Sandbox Presets\[name].cfg`  
The vote tool saves to whatever folder the user opens — no game-path dependency.
