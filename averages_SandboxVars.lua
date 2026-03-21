SandboxVars = {
    VERSION = 4,
    -- World Timeline
    DayLength = 3,
    StartMonth = 7,
    StartDay = 9,
    StartTime = 2,
    WaterShut = 3,
    ElecShut = 3,
    WaterShutModifier = -1,
    ElecShutModifier = -1,

    -- Zombie Population
    Zombies = 4,
    Distribution = 1,
    PopulationStartMultiplier = 1,
    PopulationPeakMultiplier = 1.5,
    PopulationPeakDay = 28,

    -- Zombie Character
    Speed = 2,
    Strength = 2,
    Toughness = 2,
    Transmission = 1,
    Mortality = 5,
    Reanimate = 3,
    Cognition = 3,
    Memory = 2,
    Sight = 2,
    Hearing = 2,
    ThumpNoChasing = false,
    ThumpOnConstruction = true,
    ActiveOnly = 1,
    ZombiesDragDown = true,
    ZombiesFenceLunge = true,
    DisableFakeDead = 1,

    -- Zombie Respawn
    RespawnHours = 72,
    RespawnUnseenHours = 16,
    RespawnMultiplier = 0.1,

    -- Loot by Category
    FoodLoot = 4,
    CannedFoodLoot = 4,
    LiteratureLoot = 4,
    SurvivalGearsLoot = 4,
    MedicalLoot = 4,
    WeaponLoot = 4,
    RangedWeaponLoot = 4,
    AmmoLoot = 4,
    MechanicsLoot = 4,
    OtherLoot = 4,

    -- Loot Respawn & Cleanup
    LootRespawn = 1,
    SeenHoursPreventLootRespawn = 0,
    HoursForWorldItemRemoval = 24,

    -- Character & Survival
    XpMultiplier = 1.3,
    StatsDecrease = 3,
    EndRegen = 3,
    InjurySeverity = 2,
    BoneFracture = true,
    CharacterFreePoints = 0,
    MultiHitZombies = false,
    RearVulnerability = 3,
    AttackBlockMovements = true,

    -- Environment
    Temperature = 3,
    Rain = 3,
    NightDarkness = 2,
    NightLength = 3,
    ErosionSpeed = 3,
    FireSpread = true,
    TimeSinceApo = 1,

    -- Farming & Nature
    Farming = 3,
    NatureAbundance = 3,
    PlantResilience = 3,
    PlantAbundance = 3,
    FoodRotSpeed = 3,
    FridgeFactor = 3,
    CompostTime = 2,

    -- Meta Events
    Helicopter = 2,
    MetaEvent = 2,
    GeneratorSpawning = 3,
    SurvivorHouseChance = 3,
    VehicleStoryChance = 3,
    ZoneStoryChance = 3,
    AnnotatedMapChance = 4,
    Alarm = 4,
    LockedHouses = 4,

    -- Vehicles
    CarSpawnRate = 3,
    ChanceHasGas = 1,
    InitialGas = 2,
    FuelStationGas = 5,
    CarGasConsumption = 1,
    CarGeneralCondition = 2,
    LockedCar = 3,
    TrafficJam = true,
    EnableVehicles = true,
    VehicleEasyUse = false,
    ZombieAttractionMultiplier = 1,
    CarAlarm = 2,
    SirenShutoffHours = 0,

    -- Corpses & Blood
    HoursForCorpseRemoval = 216,
    DecayingCorpseHealthImpact = 3,
    BloodLevel = 3,
    ClothingDegradation = 3,

    -- Misc & Display
    StarterKit = false,
    AllowMiniMap = false,
    AllowWorldMap = true,
    MapAllKnown = false,
    Nutrition = true,
    EnablePoisoning = true,
    GeneratorFuelConsumption = 1,
    LightBulbLifespan = 1,
    AllowExteriorGenerator = true,
    ConstructionBonusPoints = 3,

    -- [B42] Animals & Livestock
    AnimalAgingSpeed = 3, -- B42 (verify key name)
    MilkIncreaseSpeed = 3, -- B42 (verify key name)
    AnimalSpawnMultiplier = 1.2, -- B42 (verify key name)
    WildAnimalSpawnMultiplier = 1.2, -- B42 (verify key name)

    -- [B42] Crafting & Resources
    CraftingYieldMultiplier = 1, -- B42 (verify key name)
    OreSpawnMultiplier = 1, -- B42 (verify key name)
    BlacksmithingEnabled = true, -- B42 (verify key name)
    PotteryEnabled = true, -- B42 (verify key name)

    -- [B42] Basements & Darkness
    BasementSpawnFrequency = 2, -- B42 (verify key name)
    UndergroundDarkness = 2, -- B42 (verify key name)

}