# PZ Vote — Settings Schema Reference (B42)

**Sources:**
- `game_files/presets/Apocalypse.lua` — ground truth for key names, types, defaults, nested table structure
- `game_files/Sandbox.json` — display names and tooltips (`Sandbox_KEYNAME` → Lua key `KEYNAME`)
- Other preset files — values for Extinction, Outbreak, Rising, SixMonthsLater

**Output format:** The tool writes `SandboxVars.lua` (nested Lua tables) for the PZ server, and `.ini` for server.ini. See [Output format](#output-format) below.

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

Slider range: `0.0` to `3.0`, step `0.05`. The tool snaps display to named labels at the 6 values above.

---

## Output format

The tool writes two file types per player:

**`N_Name_SandboxVars.lua`** — nested Lua tables, for the PZ server:
```lua
SandboxVars = {
    Version = 6,
    -- flat keys ...
    Zombies = 4,
    FoodLootNew = 0.6,
    -- nested groups at end:
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
        Strength = 2,
        -- ...
    },
    ZombieConfig = {
        PopulationMultiplier = 0.65,
        -- ...
    },
    MultiplierConfig = {
        Global = 1.0,
        GlobalToggle = true,
        -- ...
    },
}
```

**`N_Name.ini`** — flat `key=value` for server.ini settings (PVP, sleep, safehouses, etc.)

**Key conflict:** `Strength` and `Farming` exist in both `ZombieLore` and `MultiplierConfig`. The schema uses a `luaTable` property on each setting to disambiguate. The parser uses `Table.Key` composite keys when reading files.

**Backward compat:** Old flat-format saves (`SandboxVars = { Speed=4 }`) still load — `SandboxVars` is treated as null table context during parsing.

---

## Complete key reference

Apocalypse.lua defaults. Keys marked `[skip]` are not exposed in the UI.

### Flat top-level keys

```lua
-- Time
DayLength = 4              -- enum 1-27 (1=15min … 27=Real-time)
StartYear = 1
StartMonth = 7             -- enum 1-12
StartDay = 9               -- int 1-28
StartTime = 2              -- enum 1-9
DayNightCycle = 1          -- enum 1-3: Normal/Endless Day/Endless Night
ClimateCycle = 1           -- enum 1-6: Normal/No Weather/Endless Rain/Storm/Snow/Blizzard
FogCycle = 1               -- enum 1-3: Normal/No Fog/Endless Fog

-- World shutoffs
WaterShut = 2              -- enum 1-9
ElecShut = 2               -- enum 1-9
AlarmDecay = 2
WaterShutModifier = 14     -- int, exact day override
ElecShutModifier = 14
AlarmDecayModifier = 14
MaximumFireFuelHours = 8
GeneratorTileRange = 20
GeneratorVerticalPowerRange = 3
ClayLakeChance = 0.05      -- float  [skip]
ClayRiverChance = 0.05     -- float  [skip]

-- Loot (ALL FLOATS 0.0–3.0)
FoodLootNew = 0.6
LiteratureLootNew = 0.6
SkillBookLoot = 0.6
RecipeResourceLoot = 0.6
MedicalLootNew = 0.6
SurvivalGearsLootNew = 0.6
CannedFoodLootNew = 0.6
WeaponLootNew = 0.6
RangedWeaponLootNew = 2.0  -- NOTE: boosted in Apocalypse (Kentucky guns)
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
RollsMultiplier = 1.0      -- [skip] dev setting
RemoveStoryLoot = false
RemoveZombieLoot = false
ZombiePopLootEffect = 0
InsaneLootFactor = 0.05    -- [skip] loot scale constants
ExtremeLootFactor = 0.2    -- [skip]
RareLootFactor = 0.6       -- [skip]
NormalLootFactor = 1.0     -- [skip]
CommonLootFactor = 2.0     -- [skip]
AbundantLootFactor = 3.0   -- [skip]
SeenHoursPreventLootRespawn = 0
HoursForLootRespawn = 0
MaxItemsForLootRespawn = 5
ConstructionPreventsLootRespawn = true
WorldItemRemovalList = "..."  -- string  [skip]
HoursForWorldItemRemoval = 24.0
ItemRemovalListBlacklistToggle = false
MaximumLooted = 25         -- int 0-100
DaysUntilMaximumLooted = 90
RuralLooted = 0.5          -- float
MaximumDiminishedLoot = 20
DaysUntilMaximumDiminishedLoot = 3650
MaximumLootedBuildingRooms = 50

-- Nature
Temperature = 3            -- enum 1-5
Rain = 3                   -- enum 1-5
ErosionSpeed = 3           -- enum 1-5
ErosionDays = 0            -- int (0=use ErosionSpeed)
Farming = 3                -- enum 1-5 (old key, still present)
FarmingSpeedNew = 1.0      -- float (B42)
FarmingAmountNew = 1.0     -- float (B42)
CompostTime = 2            -- enum 1-8
NatureAbundance = 3        -- enum 1-5
FishAbundance = 2          -- enum 1-5
PlantResilience = 3        -- enum 1-5
PlantAbundance = 3         -- enum (old key, still present)
KillInsideCrops = true
PlantGrowingSeasons = true
PlaceDirtAboveground = false  -- [skip]
MaximumRatIndex = 25
DaysUntilMaximumRatIndex = 90

-- Meta events / world state
TimeSinceApo = 1           -- enum 1-13 (months 0-12)
Helicopter = 2             -- enum 1-4
MetaEvent = 2              -- enum 1-3
SleepingEvent = 1          -- enum 1-2
GeneratorSpawning = 4      -- enum 1-7
GeneratorFuelConsumption = 0.1
SurvivorHouseChance = 3    -- enum 1-7
VehicleStoryChance = 3
ZoneStoryChance = 3
AnnotatedMapChance = 4     -- enum 1-6
HoursForCorpseRemoval = 216.0
DecayingCorpseHealthImpact = 3  -- enum 1-5
ZombieHealthImpact = false
BloodLevel = 3             -- enum 1-5
BloodSplatLifespanDays = 0
MaggotSpawn = 1            -- enum 1-3
MetaKnowledge = 3          -- enum 1-3

-- Character
StatsDecrease = 3          -- enum 1-5
EndRegen = 3               -- enum 1-5
StarterKit = false
Nutrition = true
FoodRotSpeed = 3           -- enum 1-5
FridgeFactor = 3           -- enum 1-6
CharacterFreePoints = 0    -- int -100 to 100
ConstructionBonusPoints = 3 -- enum 1-5
BoneFracture = true
InjurySeverity = 2         -- enum 1-3
MultiHitZombies = false
RearVulnerability = 3      -- enum 1-3
AttackBlockMovements = true
Alarm = 4                  -- enum 1-6 (house alarm frequency)
LockedHouses = 6           -- enum 1-6
NightDarkness = 3          -- enum 1-4
NightLength = 3            -- enum 1-5
AllClothesUnlocked = false
AllowExteriorGenerator = true
EnableTaintedWaterText = true
EnablePoisoning = 1        -- enum 1-3
LightBulbLifespan = 2.0    -- float (0=never break)
MaxFogIntensity = 1        -- enum 1-4
MaxRainFxIntensity = 1     -- enum 1-3
EnableSnowOnGround = true
FireSpread = true
DaysForRottenFoodRemoval = -1  -- int (-1=never)
ClothingDegradation = 3    -- enum 1-4
SeeNotLearntRecipe = true
LevelForMediaXPCutoff = 3
LevelForDismantleXPCutoff = 0
LiteratureCooldown = 45    -- int days
NegativeTraitsPenalty = 1  -- enum 1-4
MinutesPerPage = 2.0       -- float
EasyClimbing = false
MuscleStrainFactor = 0.7   -- float
DiscomfortFactor = 0.8     -- float
WoundInfectionFactor = 0.0 -- float
NoBlackClothes = true
FirearmUseDamageChance = true
FirearmNoiseMultiplier = 1.0
FirearmJamMultiplier = 1.0
FirearmMoodleMultiplier = 1.0
FirearmWeatherMultiplier = 1.0
FirearmHeadGearEffect = true

-- Vehicles
EnableVehicles = true
VehicleEasyUse = false
CarSpawnRate = 3           -- enum 1-5
ZombieAttractionMultiplier = 1.0
InitialGas = 2             -- enum 1-6
FuelStationGasInfinite = false
FuelStationGasMin = 0.0    -- float 0.0-1.0
FuelStationGasMax = 0.8    -- float 0.0-1.0
FuelStationGasEmptyChance = 20  -- int 0-100
ChanceHasGas = 1           -- enum 1-3
LockedCar = 4              -- enum 1-6
CarGasConsumption = 1.0    -- float
CarGeneralCondition = 3    -- enum 1-5
CarDamageOnImpact = 3      -- enum 1-5
DamageToPlayerFromHitByACar = 1  -- enum 1-5
TrafficJam = true
CarAlarm = 3               -- enum 1-6
PlayerDamageFromCrash = true
SirenShutoffHours = 0.0    -- float (0=never)
RecentlySurvivorVehicles = 2  -- enum 1-4
SirenEffectsZombies = true

-- Livestock (B42)
AnimalStatsModifier = 4    -- enum 1-6
AnimalMetaStatsModifier = 4
AnimalPregnancyTime = 4
AnimalAgeModifier = 4
AnimalMilkIncModifier = 4
AnimalWoolIncModifier = 4
AnimalEggHatch = 4
AnimalRanchChance = 5      -- enum 1-7
AnimalGrassRegrowTime = 240 -- int hours
AnimalMetaPredator = false
AnimalMatingSeason = true
AnimalSoundAttractZombies = true
AnimalTrackChance = 4
AnimalPathChance = 4

-- Zombie count (top-level)
Zombies = 4                -- enum 1-6: Insane/VeryHigh/High/Normal/Low/None
Distribution = 1           -- enum 1-2
ZombieVoronoiNoise = true
ZombieRespawn = 4          -- enum 1-4: High/Normal/Low/None
ZombieMigrate = true
```

### Nested: Basement
```lua
Basement = {
    SpawnFrequency = 4,    -- enum 1-7
}
```

### Nested: Map
```lua
Map = {
    AllowMiniMap = false,  -- NOTE: false in Apocalypse, true in Outbreak/Rising
    AllowWorldMap = true,
    MapAllKnown = false,
    MapNeedsLight = true,
}
```

### Nested: ZombieLore
```lua
ZombieLore = {
    Speed = 4,             -- enum 1-4: Sprinters/FastShamblers/Shamblers/Random
    SprinterPercentage = 0, -- int 0-100
    Strength = 2,          -- enum 1-4: Superhuman/Normal/Weak/Random
    Toughness = 4,         -- enum 1-4: Tough/Normal/Fragile/Random
    Transmission = 1,      -- enum 1-4
    Mortality = 5,         -- enum 1-7
    Reanimate = 3,         -- enum 1-6
    Cognition = 3,         -- enum 1-4
    DoorOpeningPercentage = 33, -- int 0-100
    CrawlUnderVehicle = 5, -- enum 1-7
    Memory = 2,            -- enum 1-6
    Sight = 5,             -- enum 1-5 (5=Random between Normal and Poor)
    Hearing = 5,
    SpottedLogic = true,
    ThumpNoChasing = false,
    ThumpOnConstruction = true,
    ActiveOnly = 1,        -- enum 1-3: Both/Night/Day
    TriggerHouseAlarm = true,
    ZombiesDragDown = true,
    ZombiesCrawlersDragDown = false,
    ZombiesFenceLunge = true,
    ZombiesArmorFactor = 2.0,   -- float
    ZombiesMaxDefense = 85,     -- int 0-100
    ChanceOfAttachedWeapon = 6, -- int 0-100
    ZombiesFallDamage = 1.0,    -- float
    DisableFakeDead = 1,        -- enum 1-3
    PlayerSpawnZombieRemoval = 1, -- enum 1-4
    FenceThumpersRequired = 25, -- 0/10/25/50/100
    FenceDamageMultiplier = 1.0,
}
```

### Nested: ZombieConfig
```lua
ZombieConfig = {
    PopulationMultiplier = 0.65,     -- Insane=2.5, VeryHigh=1.6, High=1.2, Normal=0.65, Low=0.15, None=0.0
    PopulationStartMultiplier = 1.0,
    PopulationPeakMultiplier = 1.5,
    PopulationPeakDay = 28,
    RespawnHours = 0.0,              -- float (0=disabled)
    RespawnUnseenHours = 0.0,
    RespawnMultiplier = 0.0,
    RedistributeHours = 12.0,
    FollowSoundDistance = 100,
    RallyGroupSize = 20,
    RallyGroupSizeVariance = 50,
    RallyTravelDistance = 20,
    RallyGroupSeparation = 15,
    RallyGroupRadius = 3,
    ZombiesCountBeforeDelete = 300,
}
```

### Nested: MultiplierConfig
```lua
MultiplierConfig = {
    Global = 1.0,          -- global XP multiplier
    GlobalToggle = true,   -- when true, all skills use Global
    -- 35 per-skill floats (all 1.0 in Apocalypse/Rising)
    -- Outbreak uses GlobalToggle=false with individual overrides (see below)
    Fitness=1.0, Strength=1.0, Sprinting=1.0, Lightfoot=1.0,
    Nimble=1.0, Sneak=1.0, Axe=1.0, Blunt=1.0, SmallBlunt=1.0,
    LongBlade=1.0, SmallBlade=1.0, Spear=1.0, Maintenance=1.0,
    Woodwork=1.0, Cooking=1.0, Farming=1.0, Doctor=1.0,
    Electricity=1.0, MetalWelding=1.0, Mechanics=1.0, Tailoring=1.0,
    Aiming=1.0, Reloading=1.0, Fishing=1.0, Trapping=1.0,
    PlantScavenging=1.0, FlintKnapping=1.0, Masonry=1.0,
    Pottery=1.0, Carving=1.0, Husbandry=1.0, Tracking=1.0,
    Blacksmith=1.0, Butchering=1.0, Glassmaking=1.0
}
```

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

---

## SixMonthsLater note

`SixMonthsLater.lua` is a B41 challenge preset (Version=5). Uses old flat loot keys (`FoodLoot`, etc.). Not used for B42 implementation.
