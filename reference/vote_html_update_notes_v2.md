# vote.html — Authoritative Schema Update
**Source:** `Sandbox.json` (game translation file — ground truth for all key names, options, tooltips)  
**For:** Claude Code implementing changes to `vote.html`  
**Companion file:** `Sandbox.json` (save alongside this doc — contains every display name and tooltip)

The JSON key format is `Sandbox_KEYNAME` → the actual Lua SandboxVars key is `KEYNAME`.
e.g. `Sandbox_ZSpeed` → Lua key is `ZSpeed`, not `Speed`.

---

## Critical key name corrections (current schema is wrong)

These are breaking errors — the HTML is writing wrong key names to files.

| Current (wrong) key | Correct Lua key | Display name |
|---|---|---|
| `Speed` | `ZSpeed` | Speed |
| `Strength` | `ZStrength` | Strength |
| `Toughness` | `ZToughness` | Toughness |
| `Transmission` | `ZTransmission` | Transmission |
| `Mortality` | `ZInfectionMortality` | Infection Mortality |
| `Reanimate` | `ZReanimateTime` | Reanimate Time |
| `Cognition` | `ZCognition` | Cognition |
| `Memory` | `ZMemory` | Memory |
| `Sight` | `ZSight` | Sight |
| `Hearing` | `ZHearing` | Hearing |
| `ThumpNoChasing` | `ThumpNoChasing` | Environmental Attacks *(display name was wrong)* |
| `ThumpOnConstruction` | `ThumpOnConstruction` | Damage Construction *(display name was wrong)* |
| `ZombiesDragDown` | `ZombiesDragDown` | Drag Down *(display name was wrong)* |
| `ZombiesFenceLunge` | `ZombiesFenceLunge` | Zombie Lunge *(display name was wrong)* |
| `DisableFakeDead` | `DisableFakeDead` | Fake Dead Zombie Reanimation *(display name was wrong)* |
| `ActiveOnly` | `ActiveOnly` | Day/Night Zombie Speed Effect *(display name was wrong)* |
| `Alarm` | `HouseAlarmFrequency` | House Alarms Frequency |
| `LockedHouses` | `LockedHouseFrequency` | Locked Houses Frequency |
| `FoodRotSpeed` | `FoodSpoil` | Food Spoilage |
| `FridgeFactor` | `FridgeEffect` | Refrigeration Effectiveness |
| `Farming` | `FarmingSpeed` | Farming Speed *(the enum version — see below)* |
| `PlantAbundance` | `FarmingAmount` | Farming Abundance *(the enum version)* |
| `NatureAbundance` | `NatureAmount` | Nature's Abundance |
| `CarSpawnRate` | `CarSpawnRate` | Vehicle Spawn Rate *(display name was wrong)* |
| `CarAlarm` | `CarAlarmFrequency` | Vehicle Alarms Frequency |
| `TrafficJam` | `TrafficJam` | Car Wreck Congestion *(display name was wrong)* |
| `SirenShutoffHours` | `SirenShutoffHours` | Siren Shutoff Hours |
| `ConstructionBonusPoints` | `ConstructionBonusPoints` | Player-built Construction Strength *(display name was wrong)* |

---

## Option count corrections (enum ranges were wrong)

| Key | Old option count | Correct options |
|---|---|---|
| `ZSpeed` | 3 | 4: Sprinters / Fast Shamblers / Shamblers / **Random** |
| `ZStrength` | 3 | 4: Superhuman / Normal / Weak / **Random** |
| `ZToughness` | 3 | 4: Tough / Normal / Fragile / **Random** |
| `ZTransmission` | 3 | 4: Blood and Saliva / Saliva Only / Everyone's Infected / **None** |
| `ZInfectionMortality` | 6 | 7: add **Never** as option 7 |
| `ZReanimateTime` | 5 | 6: add **1-2 Weeks** as option 6 |
| `ZCognition` | 3 | 4: Navigate and Use Doors / Navigate / Basic Navigation / **Random** |
| `ZMemory` | 4 | 6: add **Random** and **Random between Normal and None** |
| `ZSight` | 3 | 5: add **Random** and **Random between Normal and Poor** |
| `ZHearing` | 3 | 5: add **Random** and **Random between Normal and Poor** |
| `InjurySeverity` | 2 | 3: Low / Normal / **High** |
| `FoodSpoil` | 4 | 5: add **Very Slow** |
| `FridgeEffect` | 4 | 6: add **Very High** and **No decay** |
| `FarmingSpeed` | 4 | 5: add **Very Slow** |
| `FarmingAmount` | 4 | 5: add **Very Abundant** |
| `FishAmount` (new) | — | 5: Very Poor / Poor / Normal / Abundant / Very Abundant |
| `NatureAmount` | 4 | 5: add **Very Abundant** |
| `WorldTemperature` | 4 | 5: add **Very Hot** |
| `RainAmount` | 4 | 5: add **Very Rainy** |
| `ErosionSpeed` | 4 | 5: add **Very Slow (500 Days)** |
| `PlantResilience` | 4 | 5: add **Very Low** |
| `HouseAlarmFrequency` | 5 | 6: add **Very Often** |
| `LockedHouseFrequency` | 5 | 6: add **Very Often** |
| `NightDarkness` | 3 | 4: Pitch Black / Dark / Normal / **Bright** |
| `NightLength` | 4 | 5: add **Always Day** |
| `Helicopter` | 3 | 4: add **Often** |
| `MetaEvent` | 2 | 3: add **Often** |
| `SurvivorHouseChance` | 5 | 7: add **Very Often** and **Always Tries** |
| `AnnotatedMapChance` | 5 | 6: add **Very Often** |
| `CarSpawnRate` | 4 | 5: add **High** |
| `InitialGas` | 5 | 6: add **Full** |
| `FuelStationGas` | 8 | 9: add **Infinite** |
| `CarGeneralCondition` | 4 | 5: add **Very High** |
| `DecayingCorpseHealthImpact` | 3 | 5: add **High** and **Insane** |
| `BloodLevel` | 4 | 5: add **Ultra Gore** |
| `WaterShut` / `ElecShut` | 7 | 9: add **6-12 Months** and **Disabled** |
| `ConstructionBonusPoints` | 4 | 5: add **Very High** |
| `StatDecrease` | 4 | 5: add **Very Slow** |
| `EnduranceRegen` | 4 | 5: add **Very Slow** |
| `ActiveOnly` | 2 | 3: Both / Night / **Day** |
| `ZombieCount` | 5 | 6: add **None** as option 6 |
| `AnimalRanchChance` | 5 | 7: add **Very Often** and **Always** |
| `BasementSpawnFrequency` | 5 | 7: add **Very Often** and **Always** |
| `EnablePoisoning` | bool | 3-option enum: True / False / **Only bleach poisoning is disabled** |
| `DisableFakeDead` | 2 | 3: World Zombies / World and Combat Zombies / **Never** |
| `MaggotSpawn` | 2 | 3: In and Around Bodies / In Bodies Only / **Never** |
| `LootRespawn` | 4 | 5: add **Every 2 Months** |
| `GeneratorSpawning` | 4 | 7: (rarity scale, not 1-4 — see below) |
| `DayNightCycle` | 3 | 3: Normal / Endless Day / Endless Night |
| `ClimateCycle` | 3 | 6: Normal / No Weather / Endless Rain / Endless Storm / Endless Snow / Endless Blizzard |
| `FogCycle` | 3 | 3: Normal / No Fog / Endless Fog |
| `FenceThumpersRequired` | numeric | 5-option enum: Disabled / 10 / 25 / 50 / 100 |

---

## Population multiplier actual values

From the JSON help text — use these as the enum-to-float mappings:

**PopulationMultiplier** (set by ZombieCount preset):
- Insane = 2.5, Very High = 1.6, High = 1.2, Normal = 0.65, Low = 0.15, None = 0.0

**PopulationStartMultiplier** and **PopulationPeakMultiplier**:
- Insane = 3.0, Very High = 2.0, High = 1.5, Normal = 1.0, Low = 0.5, None = 0.0

The presets in the vote tool should use the float values, not the enum indices.

---

## B42 loot rarity restructure (significant)

B42 adds `New` versions of all loot keys. The old keys (`FoodLoot`, `CannedFoodLoot`, etc.) may still exist for B41 compatibility but the B42 UI uses the `New` variants. **Replace all old loot keys with the New versions:**

| Old key | New B42 key | Display name | Tooltip |
|---|---|---|---|
| `FoodLoot` | `FoodLootNew` | Perishable Food | Any food that can rot or spoil |
| `CannedFoodLoot` | `CannedFoodLootNew` | Non-Perishable Food | Canned and dried food, beverages |
| `LiteratureLoot` | split into 3 below | — | — |
| — | `SkillBookLoot` | Skill Books | Books that provide skill XP multipliers |
| — | `RecipeResourceLoot` | Recipe Resources | Items that teach recipes |
| — | `LiteratureLootNew` | Other Literature | All other readable items incl. fliers, newspapers |
| `SurvivalGearsLoot` | `SurvivalGearsLootNew` | Survival Essentials | Fishing Rods, Tents, camping gear |
| `MedicalLoot` | `MedicalLootNew` | Medical | Medicine, bandages, first aid tools |
| `WeaponLoot` | `WeaponLootNew` | Melee Weapons | Weapons that are not tools |
| `RangedWeaponLoot` | `RangedWeaponLootNew` | Ranged Weapons | Also includes weapon attachments |
| `AmmoLoot` | `AmmoLootNew` | Ammo | Loose ammo, boxes and magazines |
| `MechanicsLoot` | `MechanicsLootNew` | Mechanics | Vehicle parts and tools |
| `OtherLoot` | `OtherLootNew` | Other | Everything else + foraging in Town/Road zones |
| (missing) | `ClothingLootNew` | Clothing | All wearable items that are not containers |
| (missing) | `ContainerLootNew` | Bags | Backpacks and equippable containers |
| (missing) | `KeyLootNew` | Keys | Building/car keys, key rings, locks |
| (missing) | `MediaLootNew` | Media | VHS tapes and CDs |
| (missing) | `MementoLootNew` | Mementos | Spiffo items, plushies, collectibles, photos |
| (missing) | `CookwareLootNew` | Cooking | Cooking items including knife-weapons |
| (missing) | `MaterialLootNew` | Material | Crafting/building ingredients (not tools) |
| (missing) | `FarmingLootNew` | Farming | Seeds, Trowels, Shovels |
| (missing) | `ToolLootNew` | Tools | Tools not in other categories |

All use the same 7-option rarity scale: None / Insanely Rare / Extremely Rare / Rare / Normal / Common / Abundant

---

## New settings to add

### Zombie tab additions

| Lua key | Display | Type | Default | Notes |
|---|---|---|---|---|
| `ZombieMigrate` | Zombie Migration | bool | true | Zombies migrate to empty cells |
| `ZSprinterPercentage` | Random Sprinter Amount | enum | None | % sprinters when Speed=Random |
| `ZDoorOpeningPercentage` | Random Door Opening Amount | enum | Normal | Door-opening % at Basic cognition |
| `SpottedLogic` | New Stealth System | bool | true | B42 advanced stealth |
| `SlowInCold` | Slow During Cold Weather | bool | false | All zombies slow in winter |
| `ZombiesCrawlersDragDown` | Crawlers Drag Down | bool | false | Crawlers contribute to drag-down |
| `ZombiesArmorFactor` | Zombie Armor Factor | float | 2.0 | Clothing protection multiplier |
| `ZombiesMaxDefense` | Maximum Zombie Armor Defense | int | 85 | Cap on zombie armor % |
| `ChanceOfAttachedWeapon` | Chance Of Attached Weapon | int | 6 | % chance zombie has weapon |
| `ZombiesFallDamage` | Zombie Fall Damage Multiplier | float | 1.0 | Fall damage to zombies |
| `ZSpawnRemoval` | Player Spawn Area | enum | option1 | Clear zone around player spawn |
| `ZombieRespawn` | Zombie Respawn | enum | None | Simplified respawn: High/Normal/Low/None |
| `ZombieRespawnPercent` | Zombies Respawn Amount | enum | — | % respawned per interval (10–100%) |
| `RedistributeHours` | Redistribute Hours | float | 12.0 | Hours before zombies redistribute |
| `FollowSoundDistance` | Follow Sound Distance | int | 100 | Tiles zombie follows last sound |
| `RallyGroupSize` | Rally Group Size | int | 20 | Avg idle group size |
| `RallyGroupSizeVariance` | Rally Group Size Variance | int | 50 | % size variance |
| `RallyTravelDistance` | Rally Travel Distance | int | 20 | Tiles to travel to form group |
| `RallyGroupSeparation` | Rally Group Separation | int | 15 | Min distance between groups |
| `RallyGroupRadius` | Rally Group Radius | int | 3 | Group cohesion radius |
| `ZombiesCountBeforeDelete` | Zombie count before deletion | int | 300 | Max zombies in area before oldest deleted |

### Loot tab additions

| Lua key | Display | Type | Default | Notes |
|---|---|---|---|---|
| `MaxItemsForLootRespawn` | Max Items For Loot Respawn | int | 5 | Container must have ≤ this to respawn |
| `ConstructionPreventsLootRespawn` | Construction Prevents Loot Respawn | bool | true | No respawn in built-in areas |
| `MaximumLooted` | Maximum Looted Building Chance | enum | Low | % buildings pre-looted |
| `DaysUntilMaximumLooted` | Days Until Max Looted Building Chance | int | 90 | Days to reach max pre-looted % |
| `RuralLooted` | Rural Building Looted Chance Multiplier | enum | Normal | Rural multiplier |
| `MaximumDiminishedLoot` | Maximum Diminished Loot Percentage | enum | Low | Max loot depletion over time |
| `DaysUntilMaximumDiminishedLoot` | Days Until Maximum Diminished Loot | int | 3650 | Days to reach max depletion |
| `MaximumLootedBuildingRooms` | Maximum Looted Building Rooms | int | 50 | Rooms threshold — larger = not pre-looted |
| `RollsMultiplier` | Rolls Multiplier [!] | float | 1.0 | **Do not change** — dev setting |
| `ZombiePopLootEffect` | Zombie Population Loot Effect | float | 0 | Loot increases near high zombie pop |
| `RemoveStoryLoot` | Remove Unwanted Story Loot | bool | false | |
| `RemoveZombieLoot` | Remove Unwanted Zombie Loot | bool | false | |
| `LootItemRemovalList` | Loot Item Removal List | text | — | CSV of item types |

### World tab additions

| Lua key | Display | Type | Default | Notes |
|---|---|---|---|---|
| `AlarmDecay` | Alarm Battery Decay | enum (shared shutoff options) | "0-30 Days" | Alarms stop after power-out |
| `FuelStationGasInfinite` | Infinite Gas Pumps | bool | false | |
| `FuelStationGasMin` | Initial Minimum Gas Pump Amount | enum | Empty | Range floor |
| `FuelStationGasMax` | Initial Maximum Gas Pump Amount | enum | High | Range ceiling |
| `FuelStationGasEmptyChance` | Initial Gas Pump Empty Chance | int | 20 | % chance pump spawns empty |
| `MaximumFireFuelHours` | Maximum Fire Fuel Hours | int | 8 | Max hours of campfire fuel |
| `GeneratorTileRange` | Generator tile range | int | 20 | |
| `GeneratorVerticalPowerRange` | Generator vertical range | int | 3 | Floors above+below generator |
| `DayNightCycle` | Day / Night Cycle | enum | Normal | Normal/Endless Day/Endless Night |
| `ClimateCycle` | Climate Cycle | enum | Normal | 6 options incl. Endless Snow/Blizzard |
| `FogCycle` | Fog Cycle | enum | Normal | Normal/No Fog/Endless Fog |
| `FenceThumpersRequired` | Zombies To Damage Fences | enum | 25 | Options: Disabled/10/25/50/100 |
| `FenceDamageMultiplier` | Fence Damage Multiplier | float | 1.0 | |
| `MapNeedsLight` | Light Needed To Read Map | bool | true | |
| `UniqueHomeVHS` | Unique Home VHS Tapes | bool | true | One per VHS type normally |

### Nature tab additions/corrections

| Lua key | Display | Type | Default | Notes |
|---|---|---|---|---|
| `FishAmount` | Fishing Abundance | enum | Poor | **Separate from NatureAmount** — 5 options |
| `FarmingSpeedNew` | Farming Speed | float | 1.0 | B42 float version (use instead of FarmingSpeed enum) |
| `FarmingAmountNew` | Farming Abundance | float | 1.0 | B42 float version (use instead of FarmingAmount enum) |
| `StartErosion` | Starting Erosion | enum | 0% | 22 options 0–100% — starting world erosion state |
| `KillInsideCrops` | Kill Crops Grown Inside | bool | true | Crops die without sunlight |
| `PlantGrowingSeasons` | Plant Growing Seasons | bool | true | Seasonal crop growth |
| `PlaceDirtAboveground` | Farms not on Ground Level [!] | bool | false | **Dev setting — do not expose** |
| `MaximumRatIndex` | Maximum Vermin Index | int | 25 | Rat/vermin intensity cap |
| `DaysUntilMaximumRatIndex` | Days Until Maximum Vermin Index | int | 90 | Days to reach max vermin |
| `ClayLakeChance` | Clay chance - Lake | float | 0.05 | |
| `ClayRiverChance` | Clay chance - River | float | 0.05 | |

### Meta tab additions/corrections

| Lua key | Display | Type | Notes |
|---|---|---|---|
| `ZombieHealthImpact` | Zombie Health Impact | bool | Living zombies affect player health/mood |
| `BloodSplatLifespanDays` | Blood Splat Lifespan Days | int | 0 = permanent |
| `MetaKnowledge` | Media List Meta Knowledge | enum | Fully revealed / Shown as ??? / Completely hidden |
| `DayNightCycle` | Day/Night Cycle | enum | (move to World tab — it's in World in the game UI) |

### Character tab additions

| Lua key | Display | Type | Default | Notes |
|---|---|---|---|---|
| `MuscleStrainFactor` | Muscle Strain Factor | float | 0.7 | Weapon swing / carry fatigue multiplier |
| `DiscomfortFactor` | Discomfort Factor | float | 0.8 | Pain from worn items multiplier |
| `WoundInfectionFactor` | Wound Infection Damage Factor | float | 0.0 | Extra damage from infected wounds (0=off) |
| `NoBlackClothes` | No Black Clothes | bool | true | Prevents near-black random clothing |
| `FirearmUseDamageChance` | Firearms Use Damage Chance | bool | true | Hit-chance vs damage-chance aiming mode |
| `FirearmNoiseMultiplier` | Firearm Noise Multiplier | float | 1.0 | Gunshot zombie-attraction range |
| `FirearmMoodleMultiplier` | Firearm Moodle Multiplier | float | 1.0 | Moodle effect on hit chance (0=disable) |
| `FirearmJamMultiplier` | Firearm Jam Multiplier | float | 1.0 | Jam chance multiplier (0=no jams) |
| `FirearmWeatherMultiplier` | Firearm Weather Multiplier | float | 1.0 | Weather hit-chance effect (0=disable) |
| `FirearmHeadGearEffect` | Firearm Headgear Effect | bool | true | Headgear like welding masks affects aim |
| `SpottedLogic` | New Stealth System | bool | true | *Also in Zombie tab — same key* |
| `AttackBlockMovements` | Melee Movement Disruption | bool | true | Melee attacking slows you down |
| `LevelForDismantleXPCutoff` | Maximum Dismantling XP Level | int | 0 | 0 = always gives XP |
| `LevelForMediaXPCutoff` | Maximum Media XP Level | int | 3 | TV/radio XP cap level |
| `EasyClimbing` | Easy Climbing | bool | false | Disables sheet rope / wall climb failures |
| `SeeNotLearntRecipe` | See Not Known Recipes | bool | true | Unknown recipes visible but greyed |
| `LiteratureCooldown` | Literature Cooldown Days | int | 45 | Days before re-reading gives XP |
| `NegativeTraitsPenalty` | Negative Traits Penalty | enum | None | 4 options for diminishing returns |
| `MinutesPerPage` | Minutes Per Skill Book Page | float | 2.0 | In-game minutes per page |
| `XpMultiplierAffectsPassive` | XP Multiplier Affects Passive Skills | bool | false | Whether global multi affects Fitness/Strength |
| `GlobalToggle` | Use Global Multiplier | bool | true | When true, all skills use GlobalMultiplier |

**Per-skill XP multipliers** — all float, default 1.0, only active when `GlobalToggle=false`:  
Lua keys (from Sandbox_ prefix): `Fitness`, `Strength`, `Sprinting`, `Lightfoot`, `Nimble`, `Sneak`, `Axe`, `Blunt`, `SmallBlunt`, `LongBlade`, `SmallBlade`, `Spear`, `Maintenance`, `Woodwork`, `Cooking`, `Farming` *(Agriculture)*, `Doctor`, `Electricity`, `MetalWelding`, `Mechanics`, `Tailoring`, `Aiming`, `Reloading`, `Fishing`, `Tracking`, `Trapping`, `PlantScavenging` *(Foraging)*, `FlintKnapping`, `Masonry`, `Pottery`, `Carving`, `Husbandry` *(Animal Care)*, `Blacksmith`, `Butchering`, `Glassmaking`

### Vehicles tab additions

| Lua key | Display | Type | Notes |
|---|---|---|---|
| `SirenEffectsZombies` | Vehicle Sirens Attract Zombies | bool | Siren sound draws zombies |
| `RecentlySurvivorVehicles` | Recent Survivor Vehicles | enum | None/Low/Normal/High — well-maintained post-infection car |
| `DamageToPlayerFromHitByACar` | Player Damage From Vehicle Impact | enum | None — being hit by a car |

### Livestock tab (entire new tab — all B42)

Internal section key: `Animal`

| Lua key | Display | Type | Options/range | Notes |
|---|---|---|---|---|
| `AnimalStatsModifier` | Stats Reduction Speed | enum (AnimalSpeed) | Ultra Fast / Very Fast / Fast / Normal / Slow / Very Slow | How quickly animal stats (hunger etc.) drop |
| `AnimalMetaStatsModifier` | Meta Stats Reduction Speed | enum (AnimalSpeed) | same 6 options | Stats drop when animal is off-screen |
| `AnimalPregnancyTime` | Pregnancy Time | enum (AnimalSpeed) | same 6 options | |
| `AnimalEggHatch` | Egg Hatch Time | enum (AnimalSpeed) | same 6 options | |
| `AnimalAgeModifier` | Aging Modifier Speed | enum | Very Fast / Fast / Normal *(only 3 confirmed)* | How fast animals reach adulthood |
| `AnimalMilkIncModifier` | Milk Increase Speed | enum (AnimalSpeed?) | — | Milk yield growth rate |
| `AnimalWoolIncModifier` | Wool Increase Speed | enum (AnimalSpeed?) | — | Wool regrowth rate |
| `AnimalRanchChance` | Animal Spawn Chance | enum | Never / Extremely Rare / Rare / Sometimes / Often / Very Often / Always | Animals at farm spawn |
| `AnimalGrassRegrowTime` | Grass Regrowth time | int | default 240 | Hours for grass to regrow after grazing/cutting |
| `AnimalMetaPredator` | Meta Predator | bool | false | Off-screen fox may attack open chicken hutch at night |
| `AnimalMatingSeason` | Breeding Season | bool | true | Animals respect breeding seasons |
| `AnimalSoundAttractZombies` | Animals Attract Zombies | bool | true | Animal calls attract nearby zombies |
| `AnimalTrackChance` | Animal Tracks Chance | enum | Sometimes | Chance animals leave trackable traces |
| `AnimalPathChance` | Animal Paths Chance | enum | Sometimes | Chance animals establish travel paths |

---

## Implementation notes for Claude Code

### Priority order

**Do first (correctness — wrong keys being written to files):**
1. Fix all zombie lore key names (`ZSpeed`, `ZStrength`, etc.)
2. Fix `HouseAlarmFrequency` and `LockedHouseFrequency`
3. Fix `FoodSpoil` and `FridgeEffect`
4. Fix all option counts (especially `ZSpeed` Random option, `WaterShut`/`ElecShut` Disabled, `InjurySeverity` High)
5. Replace old loot keys with `New` variants and add missing loot categories

**Do second (significant missing content):**
6. Add full Livestock tab
7. Add `FishAmount` (fishing separate from nature's abundance)
8. Add `FarmingSpeedNew` / `FarmingAmountNew` float versions
9. Add `ZombieMigrate`, `SpottedLogic`, `SlowInCold` to zombie tab
10. Add firearm multipliers to Character tab
11. Add loot depletion settings (`MaximumLooted`, `DaysUntilMaximumLooted`, etc.)

**Do third (nice-to-have):**
12. Add `DayNightCycle`, `ClimateCycle`, `FogCycle` to World tab
13. Add livestock-adjacent nature settings (vermin, clay)
14. Add `ZombieHealthImpact`, `BloodSplatLifespanDays` to Meta

**Skip (too granular / dev settings / rarely changed):**
- Per-skill XP multipliers (35 sliders — use only GlobalMultiplier + XpMultiplierAffectsPassive + GlobalToggle)
- `RollsMultiplier` — game explicitly warns do not change
- `PlaceDirtAboveground` — game explicitly warns do not change
- `SpawnHouseStories` — game explicitly warns do not change
- Rally group fine-tuning (RallyGroupRadius, RallyGroupSeparation, etc.) — advanced, rarely touched
- Clay chance settings — too granular
- `SadisticAIDirector` — no tooltip, unclear purpose

### Key thing about ZombieRespawn

There are now **two** respawn controls:
- `ZombieRespawn` — simplified enum: High / Normal / Low / None (the new B42 primary control)
- `RespawnHours` / `RespawnUnseenHours` / `RespawnMultiplier` — the old advanced float controls

These may overlap. Consider showing `ZombieRespawn` as the primary slider and putting the float controls in an "Advanced" group.

### Sandbox.json usage

The companion `Sandbox.json` file has every tooltip and every option label. Claude Code should read it directly to get exact tooltip text for any setting rather than guessing.

To find a setting: search for `Sandbox_KEYNAME_tooltip` for the tooltip, `Sandbox_KEYNAME_optionN` for enum options.
