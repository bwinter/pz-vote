# In-game verification checklist

Settings that need eyes on the actual PZ menu. Do in one pass.

## Livestock tab (tab 9)

- [ ] **Stats Reduction Speed** (`AnimalStatsModifier`) — open dropdown, note all option labels in order. Currently showing "Ultra Fast → Very Slow" (borrowed from AnimalSpeed scale, wording likely wrong).
- [ ] **Animal Spawn Chance** (`AnimalRanchChance`) — confirm dropdown matches: Never / Extremely Rare / Rare / Sometimes / Often / Very Often / Always.
- [ ] **Meta Stats Reduction Speed** (`AnimalMetaStatsModifier`) — note whether it's a dropdown or number. Key exists in Sandbox.json but is not in the allowlist yet. If it's a meaningful player-facing setting, add it to the `b42animals` group.

## Time tab (tab 1)

- [ ] **Start Day** (`StartDay`) — dropdown or number input (1–31)? Sandbox.json has no enum options, currently renders as number.