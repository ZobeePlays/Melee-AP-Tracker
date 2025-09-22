-- Super Smash Bros. Melee Item Mapping for Archipelago
ITEM_MAPPING = {
    -- Characters (progression items)
    [0x01] = {"Jigglypuff", "toggle"},
    [0x02] = {"Dr. Mario", "toggle"},
    [0x03] = {"Pichu", "toggle"},
    [0x04] = {"Falco", "toggle"},
    [0x05] = {"Marth", "toggle"},
    [0x06] = {"Young Link", "toggle"},
    [0x07] = {"Ganondorf", "toggle"},
    [0x08] = {"Mewtwo", "toggle"},
    [0x09] = {"Luigi", "toggle"},
    [0x0A] = {"Roy", "toggle"},
    [0x0B] = {"Mr. Game & Watch", "toggle"},
    [0x0C] = {"Mario", "toggle"},
    [0x0D] = {"Bowser", "toggle"},
    [0x0E] = {"Peach", "toggle"},
    [0x0F] = {"Yoshi", "toggle"},
    [0x10] = {"Donkey Kong", "toggle"},
    [0x11] = {"Captain Falcon", "toggle"},
    [0x12] = {"Fox", "toggle"},
    [0x13] = {"Ness", "toggle"},
    [0x14] = {"Ice Climbers", "toggle"},
    [0x15] = {"Kirby", "toggle"},
    [0x16] = {"Samus", "toggle"},
    [0x17] = {"Zelda", "toggle"},
    [0x18] = {"Link", "toggle"},
    [0x19] = {"Pikachu", "toggle"},
    
    -- Stages
    [0x1A] = {"Brinstar Depths", "toggle"},
    [0x1B] = {"Fourside", "toggle"},
    [0x1C] = {"Big Blue", "toggle"},
    [0x1D] = {"Poké Floats", "toggle"},
    [0x1E] = {"Mushroom Kingdom II", "toggle"},
    [0x1F] = {"Dream Land (Past)", "toggle"},
    [0x20] = {"Kongo Jungle (Past)", "toggle"},
    [0x21] = {"Yoshi's Island (Past)", "toggle"},
    [0x22] = {"Battlefield", "toggle"},
    [0x23] = {"Final Destination", "toggle"},
    [0x24] = {"Flat Zone", "toggle"},
    
    -- 1P Modes
    [0x25] = {"Adventure Mode", "toggle"},
    [0x26] = {"Classic Mode", "toggle"},
    [0x27] = {"All-Star Mode", "toggle"},
    [0x28] = {"Target Test", "toggle"},
    [0x29] = {"Home-Run Contest", "toggle"},
    [0x2A] = {"Multi-Man Melee", "toggle"},
    [0x2B] = {"Progressive Event Pack", "progressive"},
    
    -- Character Trophies (examples - there are many more)
    [0x2C] = {"Mario (Trophy)", "toggle"},
    [0x2D] = {"Mario (Smash Trophy)", "toggle"},
    [0x2E] = {"Mario (Smash Alt Trophy)", "toggle"},
    
    -- Lottery Pool Upgrades
    [0x151] = {"Progressive Lottery Pool", "progressive"},
    [0x152] = {"Lottery Pool Upgrade (Adventure/Classic Clear)", "toggle"},
    [0x153] = {"Lottery Pool Upgrade (Secret Characters)", "toggle"},
    [0x154] = {"Lottery Pool Upgrade (200 Vs. Matches)", "toggle"},
    [0x155] = {"Lottery Pool Upgrade (250 Trophies)", "toggle"},
    
    -- Filler items
    [0x156] = {"Coin", "consumable"},
    [0x157] = {"10 Coins", "consumable"},
    [0x158] = {"20 Coins", "consumable"},
    
    -- Special items
    [0x159] = {"Pikmin Savefile", "toggle"},
    
    -- String-based lookups for character names
    ["Jigglypuff"] = {"Jigglypuff", "toggle"},
    ["Dr. Mario"] = {"Dr. Mario", "toggle"},
    ["Pichu"] = {"Pichu", "toggle"},
    ["Falco"] = {"Falco", "toggle"},
    ["Marth"] = {"Marth", "toggle"},
    ["Young Link"] = {"Young Link", "toggle"},
    ["Ganondorf"] = {"Ganondorf", "toggle"},
    ["Mewtwo"] = {"Mewtwo", "toggle"},
    ["Luigi"] = {"Luigi", "toggle"},
    ["Roy"] = {"Roy", "toggle"},
    ["Mr. Game & Watch"] = {"Mr. Game & Watch", "toggle"},
    ["Mario"] = {"Mario", "toggle"},
    ["Bowser"] = {"Bowser", "toggle"},
    ["Peach"] = {"Peach", "toggle"},
    ["Yoshi"] = {"Yoshi", "toggle"},
    ["Donkey Kong"] = {"Donkey Kong", "toggle"},
    ["Captain Falcon"] = {"Captain Falcon", "toggle"},
    ["Fox"] = {"Fox", "toggle"},
    ["Ness"] = {"Ness", "toggle"},
    ["Ice Climbers"] = {"Ice Climbers", "toggle"},
    ["Kirby"] = {"Kirby", "toggle"},
    ["Samus"] = {"Samus", "toggle"},
    ["Zelda"] = {"Zelda", "toggle"},
    ["Link"] = {"Link", "toggle"},
    ["Pikachu"] = {"Pikachu", "toggle"},
    
    -- Game modes
    ["Adventure Mode"] = {"Adventure Mode", "toggle"},
    ["Classic Mode"] = {"Classic Mode", "toggle"},
    ["All-Star Mode"] = {"All-Star Mode", "toggle"},
    ["Target Test"] = {"Target Test", "toggle"},
    ["Home-Run Contest"] = {"Home-Run Contest", "toggle"},
    ["Multi-Man Melee"] = {"Multi-Man Melee", "toggle"},
    ["Progressive Event Pack"] = {"Progressive Event Pack", "progressive"},
    
    -- Stages
    ["Brinstar Depths"] = {"Brinstar Depths", "toggle"},
    ["Fourside"] = {"Fourside", "toggle"},
    ["Big Blue"] = {"Big Blue", "toggle"},
    ["Poké Floats"] = {"Poké Floats", "toggle"},
    ["Mushroom Kingdom II"] = {"Mushroom Kingdom II", "toggle"},
    ["Dream Land (Past)"] = {"Dream Land (Past)", "toggle"},
    ["Kongo Jungle (Past)"] = {"Kongo Jungle (Past)", "toggle"},
    ["Yoshi's Island (Past)"] = {"Yoshi's Island (Past)", "toggle"},
    ["Battlefield"] = {"Battlefield", "toggle"},
    ["Final Destination"] = {"Final Destination", "toggle"},
    ["Flat Zone"] = {"Flat Zone", "toggle"},
    
    -- Special items
    ["Pikmin Savefile"] = {"Pikmin Savefile", "toggle"},
    ["Coin"] = {"Coin", "consumable"},
    ["10 Coins"] = {"10 Coins", "consumable"},
    ["20 Coins"] = {"20 Coins", "consumable"},
    
    -- Trophy items (examples)
    ["Birdo (Trophy)"] = {"Birdo (Trophy)", "toggle"},
    ["Kraid (Trophy)"] = {"Kraid (Trophy)", "toggle"},
    ["Falcon Flyer (Trophy)"] = {"Falcon Flyer (Trophy)", "toggle"},
    ["UFO (Trophy)"] = {"UFO (Trophy)", "toggle"},
    ["Sudowoodo (Trophy)"] = {"Sudowoodo (Trophy)", "toggle"}
}

-- Helper function to get tracker code from item description
function get_tracker_code_for_item(item_description)
    if ITEM_MAPPING[item_description] then
        if type(ITEM_MAPPING[item_description]) == "string" then
            return ITEM_MAPPING[item_description]
        elseif type(ITEM_MAPPING[item_description]) == "table" then
            return ITEM_MAPPING[item_description][1]
        end
    end
    
    -- Try numeric lookup
    local item_id = tonumber(item_description)
    if item_id and ITEM_MAPPING[item_id] then
        if type(ITEM_MAPPING[item_id]) == "table" then
            return ITEM_MAPPING[item_id][1]
        end
    end
    
    return nil
end

-- Helper function to get item type from tracker code
function get_item_type(tracker_code)
    for _, mapping in pairs(ITEM_MAPPING) do
        if type(mapping) == "table" and mapping[1] == tracker_code then
            return mapping[2]
        end
    end
    return "toggle" -- Default to toggle
end

-- Function to update trophy counters when trophies are received
function updateTrophyCounters(item_name)
    if not item_name then return end
    
    -- Check if it's a trophy item
    if item_name:find("Trophy") then
        local total_counter = Tracker:FindObjectForCode("total_trophies")
        if total_counter then
            total_counter.AcquiredCount = total_counter.AcquiredCount + 1
            print("Total trophies: " .. total_counter.AcquiredCount)
        end
        
        -- Check if it's a character trophy
        if item_name:find("Smash Trophy") or item_name:find("Smash Alt Trophy") or 
           (item_name:find("Trophy") and not item_name:find("(")) then
            local char_counter = Tracker:FindObjectForCode("character_trophies")
            if char_counter then
                char_counter.AcquiredCount = char_counter.AcquiredCount + 1
                print("Character trophies: " .. char_counter.AcquiredCount)
            end
        end
    end
end