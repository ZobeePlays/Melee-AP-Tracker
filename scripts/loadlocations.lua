-- Load all location files for Super Smash Bros Melee

print("Loading Super Smash Bros Melee locations...")

-- Load single location file per category
Tracker:AddLocations("locations/bonus_achievements.json")
Tracker:AddLocations("locations/event_matches.json")
Tracker:AddLocations("locations/single_player_modes.json")
Tracker:AddLocations("locations/target_test.json")
Tracker:AddLocations("locations/character_trophies.json")
Tracker:AddLocations("locations/character_unlocks.json")
Tracker:AddLocations("locations/trophy_collection.json")
Tracker:AddLocations("locations/general_achievements.json")

print("All location files loaded for Super Smash Bros Melee")