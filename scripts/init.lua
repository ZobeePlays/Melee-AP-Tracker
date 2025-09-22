-- Smash Melee 
-- This file ensures all components are correctly loaded and working

-- ===== Custom init function to ensure everything loads in the correct order =====
function customInitTracker()
    print("=============== Super Smash Bros Melee TRACKER INITIALIZATION =================")
    
    -- Load items and modifiers
    Tracker:AddItems("items/items.json")
    Tracker:AddItems("items/modifiers.json")
    
    -- Load maps
    Tracker:AddMaps("maps/maps.json")
    
    -- Load logic before locations to ensure logic functions are available
    print("Loading logic...")
    ScriptHost:LoadScript("scripts/logic.lua")
    
    -- Load location files in specific order
    print("Loading locations...")
	Tracker:AddLocations("locations/bonus_achievements.json")
	Tracker:AddLocations("locations/event_matches.json")
	Tracker:AddLocations("locations/single_player_modes.json")
	Tracker:AddLocations("locations/target_test.json")
	Tracker:AddLocations("locations/character_trophies.json")
	Tracker:AddLocations("locations/character_unlocks.json")
	Tracker:AddLocations("locations/trophy_collection.json")
	Tracker:AddLocations("locations/general_achievements.json")
    
    -- Load tracker layout
    print("Loading layouts...")
    Tracker:AddLayouts("layouts/items.json")
    Tracker:AddLayouts("layouts/tracker.json")
    
    -- Load autotracking in specific order
    print("Loading autotracking components...")
    ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
    ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua") 
    
    -- Force load our improved Archipelago script
    print("Loading Archipelago integration...")
    ScriptHost:LoadScript("scripts/autotracking/archipelago.lua")
	
    print("Super Smash Bros Melee v1.0.0 loaded successfully!")
    print("================ INITIALIZATION COMPLETE ================")
end

-- Run the custom initialization
customInitTracker()