# Project Zomboid Setting Descriptions

### server.ini — PVP & Safety
**PVP** — Flipping this on lets survivors hurt each other, turning the world into a PvP battlefield; turning it off keeps everyone safe from player attacks. Source: https://wabbanode.com/help/project-zomboid/how-to-configure-pvp-on-your-project-zomboid-server, https://supercraft.host/wiki/project-zomboid/configuration_guide/
**SafetySystem** — When enabled each player can toggle their own PvP state via a skull icon, so they only deal or take friendly fire when they deliberately go into PvP mode. Source: https://wabbanode.com/help/project-zomboid/how-to-configure-the-safety-system-on-your-project-zomboid-server, https://supercraft.host/wiki/project-zomboid/configuration_guide/

### server.ini — Sleep
**SleepAllowed** — Lets players climb into beds and rest; if it is off the sleep button simply does nothing. Source: https://supercraft.host/wiki/project-zomboid/server_sleeping/
**SleepNeeded** — When true, characters earn fatigue penalties if they skip sleep, so they really *need* to sleep; when false they can skip sleep without punishment and still doze occasionally. Source: https://supercraft.host/wiki/project-zomboid/server_sleeping/

### server.ini — Safehouses
**PlayerSafehouse** — Allows players to claim a safehouse as their private base and enjoy its protections. Source: https://supercraft.host/wiki/project-zomboid/configuration_guide/, https://help.sparkedhost.com/en/article/how-to-change-server-options-project-zomboid-1b8fp6b/
**SafehouseDaySurvivedToClaim** — Sets how many in-game days someone must survive before claiming their first safehouse, so the early hours stay fair. Source: https://help.sparkedhost.com/en/article/how-to-change-server-options-project-zomboid-1b8fp6b/

### server.ini — Server
**MaxPlayers** — Caps the number of simultaneous logins so the server throttles on your hardware or community size. Source: https://supercraft.host/wiki/project-zomboid/configuration_guide/
**PauseEmpty** — Stops the world clock and zombies when no one is online, preventing plants, decay, and storms from moving forward alone. Source: https://supercraft.host/wiki/project-zomboid/configuration_guide/
**HoursForLootRespawn** — After this many in-game hours every eligible container refills loot; set to 0 to keep containers empty forever. Source: https://supercraft.host/wiki/project-zomboid/configuration_guide/, https://help.sparkedhost.com/en/article/how-to-change-server-options-project-zomboid-1b8fp6b/

### SandboxVars.lua — World Timeline
**DayLength** — Picks how long a full day-night cycle lasts in real time (from 15 minutes up to almost a full day). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**StartMonth** — Chooses the in-world month that the map begins in, letting you open straight into summer, winter, or anywhere else. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**StartDay** — Sets how many days into the apocalypse the server starts, so you can begin on day 1 or jump ahead. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**StartTime** — Controls the exact hour survivors wake up on the first day (morning, afternoon, evening, or even midnight). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**WaterShut** — Picks a loose timeframe (days, months, years) for when the public water stops working, adding pressure on players to store clean water. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ElecShut** — Likewise picks when electricity stops, forcing generators, batteries, and quiet bases. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**WaterShutModifier** — Forces water to fail on a specific day if you want a predictable cutoff instead of a random range. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ElecShutModifier** — Same for electricity, so you can pin an exact day for lights and appliances to blink out. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Zombie Population
**Zombies** — Changes the population multiplier from “Insane” down to “Low,” letting you dial in how many undead are roaming. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Distribution** — Picks whether zombies cluster in cities (urban) or spread evenly across the map (uniform). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**PopulationStartMultiplier** — Shrinks or swells how many zombies are on day one before the usual ramp-up. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**PopulationPeakMultiplier** — Sets how many zombies you get on the “peak” day, so the late game can go from tolerable to overwhelming. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**PopulationPeakDay** — Chooses which day the zombie population hits that peak number. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Zombie Character
**Speed** — Picks whether zombies shuffle slowly, run fast, or take the middle ground. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Strength** — Controls how much damage zombies deal when they hit you. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Toughness** — Adjusts how hard zombies are to kill, so you can make each hit feel like a slog or a breeze. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Transmission** — Sets how the virus spreads: blood and saliva, saliva only, or everyone simply being infected. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Mortality** — Controls how fast infection turns you into a zombie, from instant to a couple of weeks. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Reanimate** — Dictates how quickly dead bodies get back up as zombies. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Cognition** — Lets zombies navigate or even open doors, or keeps them stuck wandering aimlessly. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Memory** — Determines how long zombies remember a sound or sighting before ignoring it. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Sight** — Adjusts how far zombies can see you, from eagle-eyed to poor vision. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Hearing** — Adjusts how well they hear noises like gunshots or engines. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ThumpNoChasing** — When on, idle zombies will smash doors or walls even if they aren’t chasing anyone. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ThumpOnConstruction** — Lets zombies attack player-built walls and barricades, so your bases can be slowly torn down. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ActiveOnly** — Controls whether zombies stay active day and night or only get aggressive in the daytime. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ZombiesDragDown** — When true, extra zombies can grab you and drag you down into the horde. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ZombiesFenceLunge** — Allows zombies to lunge over fences if you get too close. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**DisableFakeDead** — Determines whether some zombies pretend to be dead, so you can’t be sure every limp body stays still. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Zombie Respawn
**RespawnHours** — Sets how many hours must pass before zombies can respawn in a cell; zero turns respawns off. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**RespawnUnseenHours** — Requires a chunk to go unseen this many hours before zombies appear there again. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**RespawnMultiplier** — Controls what fraction of the original population respawns when a cycle runs. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Loot by Category
**FoodLoot** — 1 means no food spawns, 6 means food is common; lower numbers make food rarer. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CannedFoodLoot** — Same idea for canned goods, from none to common. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**LiteratureLoot** — Controls how often books or notes show up. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**SurvivalGearsLoot** — Adjusts the rarity of tools and survival gear like seeds, nails, and fishing rods. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**MedicalLoot** — Tunes how rare med supplies are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**WeaponLoot** — Controls how often weapons spawn. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**RangedWeaponLoot** — Specifically for guns and ranged gear. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**AmmoLoot** — Adjusts how frequently ammunition appears. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**MechanicsLoot** — Sets how rare mechanical items like car parts are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**OtherLoot** — Covers everything else, including foraging drops for town/road zones. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Loot Respawn & Cleanup
**LootRespawn** — Determines how often containers refill (none, daily, weekly, or monthly). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/, https://setreadygame.com/games/guides/does-loot-respawn-in-project-zomboid/
**SeenHoursPreventLootRespawn** — If you visit an area, loot there won’t respawn until this many hours pass, so campers can keep places empty. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/, https://pzfans.com/how-to-set-loot-respawn-in-project-zomboid/
**HoursForWorldItemRemoval** — Drops just sit on the ground for this many hours before disappearing when the map chunk reloads; zero keeps them forever. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Character & Survival
**XpMultiplier** — Multiplies the experience earned from actions so leveling is faster or slower. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**StatsDecrease** — Controls how quickly hunger, thirst and fatigue drain from your character. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**EndRegen** — Determines how quickly endurance refills when you stop sprinting. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**InjurySeverity** — Makes wounds heal faster or slower and changes their impact on your stats. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**BoneFracture** — Enables or disables bone-breaking injuries (true lets limbs snap). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CharacterFreePoints** — Adds extra trait points during character creation. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**MultiHitZombies** — Lets one melee swing hit several zombies when enabled. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**RearVulnerability** — Adjusts the chance of getting bitten when a zombie hits you from behind. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**AttackBlockMovements** — When true, attacking slows your movement; false keeps you as nimble as usual. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Environment
**Temperature** — Picks the worldwide temperature theme (very cold to hot). Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Rain** — Controls how often rain falls. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**NightDarkness** — Sets how bright or pitch-black the night feels. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**NightLength** — Chooses how long dusk-to-dawn lasts, from always night to short nights. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ErosionSpeed** — Governs how fast weeds take over buildings by rating growth speed. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**FireSpread** — Enables or disables fires spreading to nearby tiles. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**TimeSinceApo** — Picks how many months have passed since the apocalypse, influencing erosion and spoilage. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Farming & Nature
**Farming** — Controls plant growth speed from very fast to slow. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**NatureAbundance** — Sets how much wild food and forage you can find. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**PlantResilience** — Changes how easily plants dry out or fall sick. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**PlantAbundance** — Controls how much produce you get when harvesting. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**FoodRotSpeed** — Determines how fast food spoils, inside or outside fridges. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**FridgeFactor** — Multiplies how effective refrigeration is. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CompostTime** — Sets how long composting takes. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Meta Events
**Helicopter** — Adjusts how often helicopter event sounds happen. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**MetaEvent** — Controls how often random event noises like gunshots occur. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**GeneratorSpawning** — Tunes how frequently generators spawn around the map. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**SurvivorHouseChance** — Sets how rare randomized survivor homes are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**VehicleStoryChance** — Decides how often special story vehicles show up. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ZoneStoryChance** — Controls the frequency of story-driven zone scenes. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**AnnotatedMapChance** — Sets how often you find maps with survivor notes. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**Alarm** — Tunes how common buildings with active alarms are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**LockedHouses** — Sets the chance for houses to spawn locked. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Vehicles
**CarSpawnRate** — Controls how many cars appear on the map. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ChanceHasGas** — Sets how likely a spawned car has fuel in the tank. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**InitialGas** — Sets the starting fuel level of cars you find. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**FuelStationGas** — Controls how much fuel is stocked at gas stations. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CarGasConsumption** — Multiplies how fast cars burn gas. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CarGeneralCondition** — Picks how beat-up newly discovered cars are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**LockedCar** — Chooses how often cars spawn locked. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**TrafficJam** — Enables or disables junked-up traffic on roads. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**EnableVehicles** — Turns vehicles on or off globally. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**VehicleEasyUse** — When true, cars don’t need keys or locks, making driving simpler. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**ZombieAttractionMultiplier** — Multiplies how much engine noise draws zombies. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**CarAlarm** — Sets how common cars with alarms are. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**SirenShutoffHours** — After this many hours a wailing siren goes quiet; zero means sirens stay on forever. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/

### SandboxVars.lua — Corpses & Blood
**HoursForCorpseRemoval** — Determines how long zombie bodies stick around before vanishing. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**DecayingCorpseHealthImpact** — Sets how much nearby rotten corpses hurt your health and morale. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
**BloodLevel** — Controls how much blood and gore spray is visible. Source: https://supercraft.host/wiki/project-zomboid/all_sandbox_settings/
