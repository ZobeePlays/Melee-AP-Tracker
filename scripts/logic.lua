-- Super Smash Bros. Melee PopTracker Logic
-- Base ability checks

function has(item)
    return Tracker:ProviderCountForCode(item) > 0
end

function hasCount(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    return count >= amount
end

-- =====================================
-- CHARACTER CHECKS
-- =====================================

-- Starting roster
function has_mario()
    return has("Mario")
end

function has_donkey_kong()
    return has("Donkey Kong")
end

function has_link()
    return has("Link")
end

function has_samus()
    return has("Samus")
end

function has_yoshi()
    return has("Yoshi")
end

function has_kirby()
    return has("Kirby")
end

function has_fox()
    return has("Fox")
end

function has_pikachu()
    return has("Pikachu")
end

function has_ness()
    return has("Ness")
end

function has_captain_falcon()
    return has("Captain Falcon")
end

-- Secret characters
function has_bowser()
    return has("Bowser")
end

function has_peach()
    return has("Peach")
end

function has_ice_climbers()
    return has("Ice Climbers")
end

function has_zelda()
    return has("Zelda")
end

function has_luigi()
    return has("Luigi")
end

function has_jigglypuff()
    return has("Jigglypuff")
end

function has_mewtwo()
    return has("Mewtwo")
end

function has_marth()
    return has("Marth")
end

function has_mr_game_and_watch()
    return has("Mr. Game & Watch")
end

function has_dr_mario()
    return has("Dr. Mario")
end

function has_ganondorf()
    return has("Ganondorf")
end

function has_falco()
    return has("Falco")
end

function has_young_link()
    return has("Young Link")
end

function has_pichu()
    return has("Pichu")
end

function has_roy()
    return has("Roy")
end

-- =====================================
-- GAME MODE ACCESS
-- =====================================

function has_adventure_mode()
    return has("Adventure Mode")
end

function has_classic_mode()
    return has("Classic Mode")
end

function has_all_star_mode()
    return has("All-Star Mode")
end

function has_target_test()
    return has("Target Test")
end

function has_home_run_contest()
    return has("Home-Run Contest")
end

function has_multi_man_melee()
    return has("Multi-Man Melee")
end

-- =====================================
-- EVENT MATCH PROGRESSION
-- =====================================

function progressive_event_pack()
    return has("Progressive Event Pack")
end

function progressive_event_pack_count(amount)
    return hasCount("Progressive Event Pack", amount)
end

function events_1_10_available()
    return true -- Always available
end

function events_11_20_available()
    return progressive_event_pack_count(1)
end

function events_21_30_available()
    return progressive_event_pack_count(2)
end

function events_31_40_available()
    return progressive_event_pack_count(3)
end

function events_41_51_available()
    return progressive_event_pack_count(4)
end

-- =====================================
-- CHARACTER GROUP CHECKS
-- =====================================

-- Base characters (14 total)
function has_all_base_characters()
    return has_mario() and has_donkey_kong() and has_bowser() and has_peach() and 
           has_captain_falcon() and has_yoshi() and has_fox() and has_ness() and 
           has_ice_climbers() and has_kirby() and has_samus() and has_link() and 
           has_pikachu() and has_zelda()
end

-- All secret characters
function has_all_secret_characters()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and 
           has_marth() and has_roy() and has_pichu() and has_ganondorf() and 
           has_dr_mario() and has_young_link() and has_falco()
end

-- Everyone except Game & Watch (needed for G&W unlock)
function has_everyone_except_gamewatch()
    return has_dr_mario() and has_mario() and has_luigi() and has_bowser() and 
           has_peach() and has_yoshi() and has_donkey_kong() and has_captain_falcon() and 
           has_ganondorf() and has_falco() and has_fox() and has_ness() and 
           has_ice_climbers() and has_kirby() and has_samus() and has_zelda() and 
           has_link() and has_young_link() and has_pichu() and has_pikachu() and 
           has_jigglypuff() and has_mewtwo() and has_marth() and has_roy()
end

-- Character count checks
function group_unique_characters_10()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon", 
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link", 
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch", 
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}
    
    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 10
end

function group_unique_characters_16()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon", 
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link", 
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch", 
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}
    
    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 16
end

function group_unique_characters_25()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon", 
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link", 
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch", 
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}
    
    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 25
end

-- =====================================
-- STAGE ACCESS
-- =====================================

function has_regular_stages()
    return has("Mushroom Kingdom II") and has("Poké Floats") and has("Big Blue") and 
           has("Flat Zone") and has("Fourside") and has("Brinstar Depths")
end

function group_unique_stages_11()
    local count = 0
    local stages = {"Brinstar Depths", "Fourside", "Big Blue", "Poké Floats", 
                   "Mushroom Kingdom II", "Dream Land (Past)", "Kongo Jungle (Past)", 
                   "Yoshi's Island (Past)", "Battlefield", "Final Destination", "Flat Zone"}
    
    for _, stage in ipairs(stages) do
        if has(stage) then
            count = count + 1
        end
    end
    return count >= 11
end

-- =====================================
-- SPECIAL CHARACTER ABILITIES
-- =====================================

-- Characters that can meteor smash
function has_meteor_character()
    local meteor_chars = {"Captain Falcon", "Donkey Kong", "Falco", "Fox", "Ganondorf",
                          "Ice Climbers", "Kirby", "Link", "Luigi", "Young Link",
                          "Mario", "Marth", "Mewtwo", "Mr. Game & Watch", "Ness",
                          "Peach", "Roy", "Samus", "Yoshi", "Zelda"}
    
    for _, char in ipairs(meteor_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Characters that can reflect projectiles
function has_reflect_character()
    local reflect_chars = {"Mario", "Dr. Mario", "Fox", "Falco", "Ness"}
    
    for _, char in ipairs(reflect_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Good home run contest characters (can get over 1,400 ft)
function has_good_hr_character()
    local good_hr_chars = {"Ganondorf", "Yoshi", "Jigglypuff", "Roy"}
    
    for _, char in ipairs(good_hr_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Decent home run contest characters (can get over 1,312 ft)
function has_decent_hr_character()
    return has("Dr. Mario") or has_good_hr_character()
end

-- Good combo characters
function has_good_combo_character()
    local good_combo_chars = {"Kirby", "Fox", "Pichu", "Pikachu", "Zelda"}
    
    for _, char in ipairs(good_combo_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Decent combo characters
function has_decent_combo_character()
    return has("Yoshi") or has("Falco") or has_good_combo_character()
end

-- =====================================
-- TROPHY REQUIREMENTS
-- =====================================

function has_birdo_trophy()
    return has("Birdo (Trophy)")
end

function has_kraid_trophy()
    return has("Kraid (Trophy)")
end

function has_falcon_flyer_trophy()
    return has("Falcon Flyer (Trophy)")
end

function has_ufo_trophy()
    return has("UFO (Trophy)")
end

function has_sudowoodo_trophy()
    return has("Sudowoodo (Trophy)")
end

-- =====================================
-- LOTTERY POOL ACCESS
-- =====================================

function has_base_lottery()
    return has("Progressive Lottery Pool")
end

function has_adventure_classic_lottery()
    return has("Lottery Pool Upgrade (Adventure/Classic Clear)")
end

function has_secret_character_lottery()
    return has("Lottery Pool Upgrade (Secret Characters)")
end

function has_vs_matches_lottery()
    return has("Lottery Pool Upgrade (200 Vs. Matches)")
end

function has_250_trophy_lottery()
    return has("Lottery Pool Upgrade (250 Trophies)")
end

-- =====================================
-- SPECIAL ITEMS
-- =====================================

function has_pikmin_savefile()
    return has("Pikmin Savefile")
end

-- =====================================
-- UNLOCK CONDITIONS
-- =====================================

-- Character unlock conditions based on the rules
function can_unlock_jigglypuff()
    return true -- Any 1P mode
end

function can_unlock_dr_mario()
    return has_mario()
end

function can_unlock_pichu()
    return true -- Event matches
end

function can_unlock_falco()
    return has_multi_man_melee()
end

function can_unlock_marth()
    return has_all_base_characters()
end

function can_unlock_young_link()
    return group_unique_characters_10()
end

function can_unlock_ganondorf()
    return has_link()
end

function can_unlock_mewtwo()
    return true -- VS matches or time
end

function can_unlock_luigi()
    return has_adventure_mode()
end

function can_unlock_roy()
    return has_marth()
end

function can_unlock_mr_game_and_watch()
    return has_everyone_except_gamewatch() and (has_adventure_mode() or has_all_star_mode() or has_classic_mode() or has_target_test())
end

-- =====================================
-- MODE-SPECIFIC REQUIREMENTS
-- =====================================

-- Training mode combo requirements
function can_do_125_combos()
    return has_good_combo_character() and has_bowser()
end

function can_do_10_hit_combo()
    return has_decent_combo_character() and has_bowser()
end

function can_do_20_hit_combo()
    return has_good_combo_character() and has_bowser()
end

-- Home Run Contest requirements
function can_do_combined_distance()
    return group_unique_characters_16()
end

function can_do_1312_feet()
    return has_decent_hr_character()
end

function can_do_1476_feet()
    return has_good_hr_character()
end

-- All-Star mode specific requirements
function can_access_all_star()
    return has_all_star_mode()
end

-- Classic mode specific requirements  
function can_do_gamewatch_classic()
    return has_mr_game_and_watch() and has_classic_mode()
end

-- =====================================
-- BONUS REQUIREMENTS
-- =====================================

-- Meteor-related bonuses
function can_get_meteor_bonus()
    return has_meteor_character()
end

-- Reflection bonuses
function can_get_bank_shot_ko()
    return has_reflect_character()
end

-- Luigi-specific bonuses
function can_get_poser_bonus()
    return has_luigi()
end

function can_get_metal_bros_ko()
    return has_luigi()
end

-- Multi-KO bonuses (Adventure/All-Star have more enemies)
function can_get_quadruple_ko()
    return has_adventure_mode() or has_all_star_mode()
end

function can_get_quintuple_ko()
    return has_adventure_mode() or has_all_star_mode()
end

-- All bonuses requirement (for Diskun trophy)
function can_get_all_bonuses()
    return has_adventure_mode() and has_all_star_mode() and has_classic_mode() and 
           has_luigi() and has_meteor_character() and has_reflect_character()
end

-- =====================================
-- TARGET TEST REQUIREMENTS
-- =====================================

-- Individual character target tests
function can_do_target_test(character)
    return has(character) and has_target_test()
end

-- Target test challenges requiring all characters
function can_do_all_targets()
    return group_unique_characters_25() and has_target_test()
end

-- =====================================
-- EVENT MATCH REQUIREMENTS
-- =====================================

-- Event matches with specific character requirements
function can_do_trouble_king()
    return has_mario()
end

function can_do_lord_of_jungle()
    return has_donkey_kong()
end

function can_do_spare_change()
    return has_ness()
end

function can_do_yoshis_egg()
    return has_yoshi()
end

function can_do_kirbys_air_raid()
    return has_kirby()
end

function can_do_bounty_hunters()
    return has_samus()
end

function can_do_links_adventure()
    return has_link()
end

function can_do_peachs_peril()
    return has_mario()
end

function can_do_gargantuans()
    return has_bowser()
end

function can_do_cold_armor()
    return has_samus()
end

function can_do_triforce_gathering()
    return has_link()
end

function can_do_target_acquired()
    return has_falco()
end

function can_do_lethal_marathon()
    return has_captain_falcon()
end

function can_do_seven_years()
    return has_young_link()
end

function can_do_time_for_checkup()
    return has_luigi()
end

function can_do_space_travelers()
    return has_ness()
end

function can_do_jigglypuff_live()
    return has_jigglypuff()
end

function can_do_en_garde()
    return has_marth()
end

function can_do_trouble_king_2()
    return has_luigi()
end

function can_do_birds_of_prey()
    return has_fox()
end

function can_do_gamewatch_forever()
    return has_mr_game_and_watch()
end

-- =====================================
-- TROPHY UNLOCK CONDITIONS
-- =====================================

-- Character trophy unlocks require having the character AND the mode
function can_get_adventure_trophy(character)
    return has(character) and has_adventure_mode()
end

function can_get_classic_trophy(character)
    return has(character) and has_classic_mode()
end

function can_get_allstar_trophy(character)
    return has(character) and has_all_star_mode()
end

-- Special trophy requirements
function has_required_special_trophies()
    return has_birdo_trophy() and has_kraid_trophy() and has_falcon_flyer_trophy() and 
           has_ufo_trophy() and has_sudowoodo_trophy()
end

-- =====================================
-- MILESTONE REQUIREMENTS
-- =====================================

-- Character unlock milestones
function has_first_secret_wave()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and has_marth()
end

function has_second_secret_wave()
    return has_roy() and has_pichu() and has_ganondorf() and has_dr_mario() and has_young_link() and has_falco()
end

-- Stage unlock milestone
function has_all_regular_stages()
    return has_regular_stages()
end

-- =====================================
-- GOAL CONDITIONS
-- =====================================

-- Goal: All Events Clear
function can_complete_all_events()
    local event_chars = {"Mario", "Donkey Kong", "Ness", "Yoshi", "Kirby", "Samus", 
                         "Link", "Bowser", "Falco", "Captain Falcon", "Young Link", 
                         "Luigi", "Jigglypuff", "Marth", "Fox", "Mr. Game & Watch"}
    
    for _, char in ipairs(event_chars) do
        if not has(char) then
            return false
        end
    end
    return true
end

-- Goal: All Targets Clear
function can_complete_all_targets()
    return group_unique_characters_25()
end

-- =====================================
-- UTILITY FUNCTIONS
-- =====================================

-- Check if player has access to lottery system
function has_lottery_access()
    return has_base_lottery()
end

-- Check if player can access special Pikmin content
function can_access_pikmin_content()
    return has_pikmin_savefile()
end

-- Check if player has enough characters for various challenges
function has_sufficient_roster_for_challenges()
    return group_unique_characters_16()
end