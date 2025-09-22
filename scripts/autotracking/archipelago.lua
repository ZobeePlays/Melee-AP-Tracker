-- Super Smash Bros. Melee  Auto-tracking Script for Archipelago

-- Configuration
CUR_INDEX = -1
SLOT_DATA = nil
DEBUG_ENABLED = true

-- Helper function for debug messages
function debugPrint(message)
    if DEBUG_ENABLED then
        print("[SSBM DEBUG] " .. message)
    end
end

-- Character item IDs to character codes mapping (from your item data)
-- Adding both hex and decimal versions to handle different item ID formats
local CHARACTER_ITEM_MAPPING = {
    -- Secret characters (hex format)
    [0x01] = "jigglypuff",     -- Jigglypuff
    [0x02] = "dr_mario",       -- Dr. Mario
    [0x03] = "pichu",          -- Pichu
    [0x04] = "falco",          -- Falco
    [0x05] = "marth",          -- Marth
    [0x06] = "young_link",     -- Young Link
    [0x07] = "ganondorf",      -- Ganondorf
    [0x08] = "mewtwo",         -- Mewtwo
    [0x09] = "luigi",          -- Luigi
    [0x0A] = "roy",            -- Roy
    [0x0B] = "game_watch",     -- Mr. Game & Watch
    
    -- Starting characters (locked in randomizer until found) (hex format)
    [0x0C] = "mario",          -- Mario
    [0x0D] = "bowser",         -- Bowser
    [0x0E] = "peach",          -- Peach
    [0x0F] = "yoshi",          -- Yoshi
    [0x10] = "donkey_kong",    -- Donkey Kong
    [0x11] = "falcon",         -- Captain Falcon
    [0x12] = "fox",            -- Fox
    [0x13] = "ness",           -- Ness
    [0x14] = "ice_climbers",   -- Ice Climbers
    [0x15] = "kirby",          -- Kirby
    [0x16] = "samus",          -- Samus
    [0x17] = "zelda",          -- Zelda
    [0x18] = "link",           -- Link
    [0x19] = "pikachu",        -- Pikachu
    
    -- Decimal equivalents (in case multi-world sends decimal IDs)
    [1] = "jigglypuff",        -- 0x01
    [2] = "dr_mario",          -- 0x02
    [3] = "pichu",             -- 0x03
    [4] = "falco",             -- 0x04
    [5] = "marth",             -- 0x05
    [6] = "young_link",        -- 0x06
    [7] = "ganondorf",         -- 0x07
    [8] = "mewtwo",            -- 0x08
    [9] = "luigi",             -- 0x09
    [10] = "roy",              -- 0x0A
    [11] = "game_watch",       -- 0x0B
    [12] = "mario",            -- 0x0C
    [13] = "bowser",           -- 0x0D
    [14] = "peach",            -- 0x0E
    [15] = "yoshi",            -- 0x0F
    [16] = "donkey_kong",      -- 0x10
    [17] = "falcon",           -- 0x11
    [18] = "fox",              -- 0x12
    [19] = "ness",             -- 0x13
    [20] = "ice_climbers",     -- 0x14
    [21] = "kirby",            -- 0x15
    [22] = "samus",            -- 0x16
    [23] = "zelda",            -- 0x17
    [24] = "link",             -- 0x18
    [25] = "pikachu"           -- 0x19
}

-- String-based character mapping for item names
local CHARACTER_NAME_MAPPING = {
    ["Jigglypuff"] = "jigglypuff",
    ["Dr. Mario"] = "dr_mario", 
    ["Pichu"] = "pichu",
    ["Falco"] = "falco",
    ["Marth"] = "marth",
    ["Young Link"] = "young_link",
    ["Ganondorf"] = "ganondorf", 
    ["Mewtwo"] = "mewtwo",
    ["Luigi"] = "luigi",
    ["Roy"] = "roy",
    ["Mr. Game & Watch"] = "game_watch",
    ["Mario"] = "mario",
    ["Bowser"] = "bowser",
    ["Peach"] = "peach",
    ["Yoshi"] = "yoshi",
    ["Donkey Kong"] = "donkey_kong",
    ["Captain Falcon"] = "falcon",
    ["Fox"] = "fox",
    ["Ness"] = "ness",
    ["Ice Climbers"] = "ice_climbers",
    ["Kirby"] = "kirby",
    ["Samus"] = "samus",
    ["Zelda"] = "zelda",
    ["Link"] = "link",
    ["Pikachu"] = "pikachu"
}

-- Complete location mapping from your archipelago.lua
LOCATION_TO_TRACKER_MAP = {
    -- =====================================
    -- EVENT MATCHES
    -- =====================================
    [0xF9] = "@Event Matches/Event Match 1-10/Bomb-fest",
    [0x104] = "@Event Matches/Event Match 11-20/Trophy Tussle 1",
    [0x110] = "@Event Matches/Event Match 21-30/Trophy Tussle 2",
    [0x123] = "@Event Matches/Event Match 41-51/Game & Watch Forever!",
    [0x125] = "@Event Matches/Event Match 41-51/Trophy Tussle 3",
    [0x129] = "@Event Matches/Event Match 41-51/The Showdown",
    
    -- Additional Event Matches (when event_checks enabled)
    [0xF7] = "@Event Matches/Event Match 1-10/Trouble King",
    [0xF8] = "@Event Matches/Event Match 1-10/Lord of the Jungle",
    [0xFA] = "@Event Matches/Event Match 1-10/Dino-wrangling",
    [0xFB] = "@Event Matches/Event Match 1-10/Spare Change",
    [0xFC] = "@Event Matches/Event Match 1-10/Kirbys on Parade",
    [0xFD] = "@Event Matches/Event Match 1-10/Pokémon Battle",
    [0xFE] = "@Event Matches/Event Match 1-10/Hot Date on Brinstar",
    [0xFF] = "@Event Matches/Event Match 1-10/Hide'n' Sheik",
    [0x100] = "@Event Matches/Event Match 1-10/All-Star Match 1",
    [0x101] = "@Event Matches/Event Match 11-20/King of the Mountain",
    [0x102] = "@Event Matches/Event Match 11-20/Seconds, Anyone?",
    [0x103] = "@Event Matches/Event Match 11-20/Yoshi's Egg",
    [0x105] = "@Event Matches/Event Match 11-20/Girl Power",
    [0x106] = "@Event Matches/Event Match 11-20/Kirby's Air-raid",
    [0x107] = "@Event Matches/Event Match 11-20/Bounty Hunters",
    [0x108] = "@Event Matches/Event Match 11-20/Link's Adventure",
    [0x109] = "@Event Matches/Event Match 11-20/Peach's Peril",
    [0x10A] = "@Event Matches/Event Match 11-20/All-Star Match 2",
    [0x10B] = "@Event Matches/Event Match 21-30/Ice Breaker",
    [0x10C] = "@Event Matches/Event Match 21-30/Super Mario 128",
    [0x10D] = "@Event Matches/Event Match 21-30/Slippy's Invention",
    [0x10E] = "@Event Matches/Event Match 21-30/The Yoshi Herd",
    [0x10F] = "@Event Matches/Event Match 21-30/Gargantuans",
    [0x111] = "@Event Matches/Event Match 21-30/Cold Armor",
    [0x112] = "@Event Matches/Event Match 21-30/Puffballs Unite!",
    [0x113] = "@Event Matches/Event Match 21-30/Triforce Gathering",
    [0x114] = "@Event Matches/Event Match 21-30/All-Star Match 3",
    [0x115] = "@Event Matches/Event Match 31-40/Mario Bros. Madness",
    [0x116] = "@Event Matches/Event Match 31-40/Target Acquired",
    [0x117] = "@Event Matches/Event Match 31-40/Lethal Marathon",
    [0x118] = "@Event Matches/Event Match 31-40/Seven Years",
    [0x119] = "@Event Matches/Event Match 31-40/Time for a Checkup",
    [0x11A] = "@Event Matches/Event Match 31-40/Space Travelers",
    [0x11B] = "@Event Matches/Event Match 31-40/Legendary Pokémon",
    [0x11C] = "@Event Matches/Event Match 31-40/Super Mario Bros. 2",
    [0x11D] = "@Event Matches/Event Match 31-40/Jigglypuff Live!",
    [0x11E] = "@Event Matches/Event Match 31-40/All-Star Match 4",
    [0x11F] = "@Event Matches/Event Match 41-51/En Garde!",
    [0x120] = "@Event Matches/Event Match 41-51/Trouble King 2",
    [0x121] = "@Event Matches/Event Match 41-51/Birds of Prey",
    [0x122] = "@Event Matches/Event Match 41-51/Mewtwo Strikes!",
    [0x124] = "@Event Matches/Event Match 41-51/Fire Emblem Pride",
    [0x126] = "@Event Matches/Event Match 41-51/Pikachu and Pichu",
    [0x127] = "@Event Matches/Event Match 41-51/All-Star Match Deluxe",
    [0x128] = "@Event Matches/Event Match 41-51/Final Destination Match",

    -- =====================================
    -- CHARACTER TROPHIES
    -- =====================================
    -- Adventure Mode Trophies
    [0x12A] = "@Character Trophies/Adventure Mode Trophies/Mario - Adventure Trophy",
    [0x12B] = "@Character Trophies/Classic Mode Trophies/Mario - Classic Trophy",
    [0x12C] = "@Character Trophies/All-Star Mode Trophies/Mario - All-Star Trophy",
    [0x12D] = "@Character Trophies/Adventure Mode Trophies/Donkey Kong - Adventure Trophy",
    [0x12E] = "@Character Trophies/Classic Mode Trophies/Donkey Kong - Classic Trophy",
    [0x12F] = "@Character Trophies/All-Star Mode Trophies/Donkey Kong - All-Star Trophy",
    [0x130] = "@Character Trophies/Adventure Mode Trophies/Link - Adventure Trophy",
    [0x131] = "@Character Trophies/Classic Mode Trophies/Link - Classic Trophy",
    [0x132] = "@Character Trophies/All-Star Mode Trophies/Link - All-Star Trophy",
    [0x133] = "@Character Trophies/Adventure Mode Trophies/Samus - Adventure Trophy",
    [0x134] = "@Character Trophies/Classic Mode Trophies/Samus - Classic Trophy",
    [0x135] = "@Character Trophies/All-Star Mode Trophies/Samus - All-Star Trophy",
    [0x136] = "@Character Trophies/Adventure Mode Trophies/Yoshi - Adventure Trophy",
    [0x137] = "@Character Trophies/Classic Mode Trophies/Yoshi - Classic Trophy",
    [0x138] = "@Character Trophies/All-Star Mode Trophies/Yoshi - All-Star Trophy",
    [0x139] = "@Character Trophies/Adventure Mode Trophies/Kirby - Adventure Trophy",
    [0x13A] = "@Character Trophies/Classic Mode Trophies/Kirby - Classic Trophy",
    [0x13B] = "@Character Trophies/All-Star Mode Trophies/Kirby - All-Star Trophy",
    [0x13C] = "@Character Trophies/Adventure Mode Trophies/Fox - Adventure Trophy",
    [0x13D] = "@Character Trophies/Classic Mode Trophies/Fox - Classic Trophy",
    [0x13E] = "@Character Trophies/All-Star Mode Trophies/Fox - All-Star Trophy",
    [0x13F] = "@Character Trophies/Adventure Mode Trophies/Pikachu - Adventure Trophy",
    [0x140] = "@Character Trophies/Classic Mode Trophies/Pikachu - Classic Trophy",
    [0x141] = "@Character Trophies/All-Star Mode Trophies/Pikachu - All-Star Trophy",
    [0x142] = "@Character Trophies/Adventure Mode Trophies/Ness - Adventure Trophy",
    [0x143] = "@Character Trophies/Classic Mode Trophies/Ness - Classic Trophy",
    [0x144] = "@Character Trophies/All-Star Mode Trophies/Ness - All-Star Trophy",
    [0x145] = "@Character Trophies/Adventure Mode Trophies/Captain Falcon - Adventure Trophy",
    [0x146] = "@Character Trophies/Classic Mode Trophies/Captain Falcon - Classic Trophy",
    [0x147] = "@Character Trophies/All-Star Mode Trophies/Captain Falcon - All-Star Trophy",
    [0x148] = "@Character Trophies/Adventure Mode Trophies/Bowser - Adventure Trophy",
    [0x149] = "@Character Trophies/Classic Mode Trophies/Bowser - Classic Trophy",
    [0x14A] = "@Character Trophies/All-Star Mode Trophies/Bowser - All-Star Trophy",
    [0x14B] = "@Character Trophies/Adventure Mode Trophies/Peach - Adventure Trophy",
    [0x14C] = "@Character Trophies/Classic Mode Trophies/Peach - Classic Trophy",
    [0x14D] = "@Character Trophies/All-Star Mode Trophies/Peach - All-Star Trophy",
    [0x14E] = "@Character Trophies/Adventure Mode Trophies/Ice Climbers - Adventure Trophy",
    [0x14F] = "@Character Trophies/Classic Mode Trophies/Ice Climbers - Classic Trophy",
    [0x150] = "@Character Trophies/All-Star Mode Trophies/Ice Climbers - All-Star Trophy",
    [0x151] = "@Character Trophies/Adventure Mode Trophies/Zelda - Adventure Trophy",
    [0x152] = "@Character Trophies/Classic Mode Trophies/Zelda - Classic Trophy",
    [0x153] = "@Character Trophies/All-Star Mode Trophies/Zelda - All-Star Trophy",
    [0x154] = "@Character Trophies/Adventure Mode Trophies/Sheik - Adventure Trophy",
    [0x155] = "@Character Trophies/Classic Mode Trophies/Sheik - Classic Trophy",
    [0x156] = "@Character Trophies/All-Star Mode Trophies/Sheik - All-Star Trophy",
    [0x157] = "@Character Trophies/Adventure Mode Trophies/Luigi - Adventure Trophy",
    [0x158] = "@Character Trophies/Classic Mode Trophies/Luigi - Classic Trophy",
    [0x159] = "@Character Trophies/All-Star Mode Trophies/Luigi - All-Star Trophy",
    [0x15A] = "@Character Trophies/Adventure Mode Trophies/Jigglypuff - Adventure Trophy",
    [0x15B] = "@Character Trophies/Classic Mode Trophies/Jigglypuff - Classic Trophy",
    [0x15C] = "@Character Trophies/All-Star Mode Trophies/Jigglypuff - All-Star Trophy",
    [0x15D] = "@Character Trophies/Adventure Mode Trophies/Mewtwo - Adventure Trophy",
    [0x15E] = "@Character Trophies/Classic Mode Trophies/Mewtwo - Classic Trophy",
    [0x15F] = "@Character Trophies/All-Star Mode Trophies/Mewtwo - All-Star Trophy",
    [0x160] = "@Character Trophies/Adventure Mode Trophies/Marth - Adventure Trophy",
    [0x161] = "@Character Trophies/Classic Mode Trophies/Marth - Classic Trophy",
    [0x162] = "@Character Trophies/All-Star Mode Trophies/Marth - All-Star Trophy",
    [0x163] = "@Character Trophies/Adventure Mode Trophies/Mr. Game & Watch - Adventure Trophy",
    [0x164] = "@Character Trophies/Classic Mode Trophies/Mr. Game & Watch - Classic Trophy",
    [0x165] = "@Character Trophies/All-Star Mode Trophies/Mr. Game & Watch - All-Star Trophy",
    [0x166] = "@Character Trophies/Adventure Mode Trophies/Dr. Mario - Adventure Trophy",
    [0x167] = "@Character Trophies/Classic Mode Trophies/Dr. Mario - Classic Trophy",
    [0x168] = "@Character Trophies/All-Star Mode Trophies/Dr. Mario - All-Star Trophy",
    [0x169] = "@Character Trophies/Adventure Mode Trophies/Ganondorf - Adventure Trophy",
    [0x16A] = "@Character Trophies/Classic Mode Trophies/Ganondorf - Classic Trophy",
    [0x16B] = "@Character Trophies/All-Star Mode Trophies/Ganondorf - All-Star Trophy",
    [0x16C] = "@Character Trophies/Adventure Mode Trophies/Falco - Adventure Trophy",
    [0x16D] = "@Character Trophies/Classic Mode Trophies/Falco - Classic Trophy",
    [0x16E] = "@Character Trophies/All-Star Mode Trophies/Falco - All-Star Trophy",
    [0x16F] = "@Character Trophies/Adventure Mode Trophies/Young Link - Adventure Trophy",
    [0x170] = "@Character Trophies/Classic Mode Trophies/Young Link - Classic Trophy",
    [0x171] = "@Character Trophies/All-Star Mode Trophies/Young Link - All-Star Trophy",
    [0x172] = "@Character Trophies/Adventure Mode Trophies/Pichu - Adventure Trophy",
    [0x173] = "@Character Trophies/Classic Mode Trophies/Pichu - Classic Trophy",
    [0x174] = "@Character Trophies/All-Star Mode Trophies/Pichu - All-Star Trophy",
    [0x175] = "@Character Trophies/Adventure Mode Trophies/Roy - Adventure Trophy",
    [0x176] = "@Character Trophies/Classic Mode Trophies/Roy - Classic Trophy",
    [0x177] = "@Character Trophies/All-Star Mode Trophies/Roy - All-Star Trophy",

    -- =====================================
    -- SINGLE PLAYER MODE CHALLENGES
    -- =====================================
    [0x178] = "@Single Player Modes/Adventure Mode/Sub 18:20 Clear",
    [0x179] = "@Single Player Modes/Adventure Mode/Hard-Continueless Clear",
    [0x17A] = "@Single Player Modes/Adventure Mode/Escape Brinstar",
    [0x17C] = "@Single Player Modes/Adventure Mode/Giga Bowser Continueless",
    [0x17D] = "@Single Player Modes/All-Star Mode/Clear",
    [0x17E] = "@Single Player Modes/All-Star Mode/Continueless Clear",
    [0x17F] = "@Single Player Modes/All-Star Mode/Hard Clear",
    [0x181] = "@Single Player Modes/Classic Mode/5 Minute Clear",
    [0x182] = "@Single Player Modes/Classic Mode/Hard-Continueless Clear",
    [0x272] = "@Single Player Modes/Classic Mode/Game & Watch Clear",

    -- Multi-Man Melee
    [0x1A0] = "@Single Player Modes/Multi Man Melee/15 Minute Melee Clear",
    [0x1A1] = "@Single Player Modes/Multi Man Melee/100 Man Melee Sub 4 Minutes",
    [0x1A2] = "@Single Player Modes/Multi Man Melee/Cruel Melee 5 KO's",
    [0x1A3] = "@Single Player Modes/Multi Man Melee/Endless Melee 100 KO's",

    -- Training Mode
    [0x1AA] = "@Single Player Modes/Training Mode/Training Mode - 125 Combined Combos",
    [0x1AB] = "@Single Player Modes/Training Mode/Training Mode - 10-Hit Combo",
    [0x1AC] = "@Single Player Modes/Training Mode/Training Mode - 20-Hit Combo",

    -- Home-Run Contest
    [0x1AD] = "@Single Player Modes/Home-Run Contest/Home-Run Contest - 16,404 Ft. Combined",
    [0x1AE] = "@Single Player Modes/Home-Run Contest/Home-Run Contest - 984 Ft.",
    [0x1AF] = "@Single Player Modes/Home-Run Contest/Home-Run Contest - 1,312 Ft.",
    [0x1B0] = "@Single Player Modes/Home-Run Contest/Home-Run Contest - 1,476 Ft.",

    -- =====================================
    -- TARGET TEST
    -- =====================================
    [0x184] = "@Target Test/Starting Characters/Mario",
    [0x185] = "@Target Test/Secret Characters/Dr. Mario",
    [0x186] = "@Target Test/Secret Characters/Luigi",
    [0x187] = "@Target Test/Secret Characters/Bowser",
    [0x188] = "@Target Test/Secret Characters/Peach",
    [0x189] = "@Target Test/Starting Characters/Yoshi",
    [0x18A] = "@Target Test/Starting Characters/Donkey Kong",
    [0x18B] = "@Target Test/Starting Characters/Captain Falcon",
    [0x18C] = "@Target Test/Secret Characters/Ganondorf",
    [0x18D] = "@Target Test/Secret Characters/Falco",
    [0x18E] = "@Target Test/Starting Characters/Fox",
    [0x18F] = "@Target Test/Starting Characters/Ness",
    [0x190] = "@Target Test/Secret Characters/Ice Climbers",
    [0x191] = "@Target Test/Starting Characters/Kirby",
    [0x192] = "@Target Test/Starting Characters/Samus",
    [0x193] = "@Target Test/Secret Characters/Zelda",
    [0x194] = "@Target Test/Starting Characters/Link",
    [0x195] = "@Target Test/Secret Characters/Young Link",
    [0x196] = "@Target Test/Secret Characters/Pichu",
    [0x197] = "@Target Test/Starting Characters/Pikachu",
    [0x198] = "@Target Test/Secret Characters/Jigglypuff",
    [0x199] = "@Target Test/Secret Characters/Mewtwo",
    [0x19A] = "@Target Test/Secret Characters/Mr. Game & Watch",
    [0x19B] = "@Target Test/Secret Characters/Marth",
    [0x19C] = "@Target Test/Secret Characters/Roy",

    -- Target Test Challenges
    [0x19D] = "@Target Test/Target Test Challenges/All Characters, Sub 12:30 Total Time",
    [0x19E] = "@Target Test/Target Test Challenges/All Characters",
    [0x19F] = "@Target Test/Target Test Challenges/All Characters, Sub 25 Minutes Total Time",

    -- =====================================
    -- CHARACTER UNLOCKS
    -- =====================================
    [0x1B9] = "@Character Unlocks/Secret Character Unlock Matches/Jigglypuff Unlock Match",
    [0x1BA] = "@Character Unlocks/Secret Character Unlock Matches/Dr. Mario Unlock Match",
    [0x1BB] = "@Character Unlocks/Secret Character Unlock Matches/Pichu Unlock Match",
    [0x1BC] = "@Character Unlocks/Secret Character Unlock Matches/Falco Unlock Match",
    [0x1BD] = "@Character Unlocks/Secret Character Unlock Matches/Marth Unlock Match",
    [0x1BE] = "@Character Unlocks/Secret Character Unlock Matches/Young Link Unlock Match",
    [0x1BF] = "@Character Unlocks/Secret Character Unlock Matches/Ganondorf Unlock Match",
    [0x1C0] = "@Character Unlocks/Secret Character Unlock Matches/Mewtwo Unlock Match",
    [0x1C1] = "@Character Unlocks/Secret Character Unlock Matches/Luigi Unlock Match",
    [0x1C2] = "@Character Unlocks/Secret Character Unlock Matches/Roy Unlock Match",
    [0x1C3] = "@Character Unlocks/Secret Character Unlock Matches/Game & Watch Unlock Match",
	

    -- =====================================
    -- TROPHY COLLECTION
    -- =====================================
    -- Base Trophy Pool (Lottery Base)
    [0x1CC] = "@Trophy Collection/Lottery Base/Andross (64)",
    [0x1CD] = "@Trophy Collection/Lottery Base/Baby Bowser",
    [0x1CE] = "@Trophy Collection/Lottery Base/Ball Kirby",
    [0x1CF] = "@Trophy Collection/Lottery Base/Balloon Fighter",
    [0x1D0] = "@Trophy Collection/Lottery Base/Barrel",
    [0x1D1] = "@Trophy Collection/Lottery Base/Barrel Cannon",
    [0x1D2] = "@Trophy Collection/Lottery Base/Bellossom",
    [0x1D3] = "@Trophy Collection/Lottery Base/Birdo",
    [0x1D4] = "@Trophy Collection/Lottery Base/Blastoise",
    [0x1D5] = "@Trophy Collection/Lottery Base/Bob-omb",
    [0x1D6] = "@Trophy Collection/Lottery Base/Bucket",
    [0x1D7] = "@Trophy Collection/Lottery Base/Bulbasaur",
    [0x1D8] = "@Trophy Collection/Lottery Base/Capsule",
    [0x1D9] = "@Trophy Collection/Lottery Base/Chikorita",
    [0x1DA] = "@Trophy Collection/Lottery Base/Clefairy",
    [0x1DB] = "@Trophy Collection/Lottery Base/Coin",
    [0x1DC] = "@Trophy Collection/Lottery Base/Crate",
    [0x1DD] = "@Trophy Collection/Lottery Base/Crobat",
    [0x1DE] = "@Trophy Collection/Lottery Base/Cyndaquil",
    [0x1DF] = "@Trophy Collection/Lottery Base/Daisy",
    [0x1E0] = "@Trophy Collection/Lottery Base/Donbe & Hikari",
    [0x1E1] = "@Trophy Collection/Lottery Base/Dr. Stewart",
    [0x1E2] = "@Trophy Collection/Lottery Base/Dr. Wright",
    [0x1E3] = "@Trophy Collection/Lottery Base/Ducks",
    [0x1E4] = "@Trophy Collection/Lottery Base/Egg",
    [0x1E5] = "@Trophy Collection/Lottery Base/Excitebike",
    [0x1E6] = "@Trophy Collection/Lottery Base/Fan",
    [0x1E7] = "@Trophy Collection/Lottery Base/Fire Flower",
    [0x1E8] = "@Trophy Collection/Lottery Base/Flipper",
    [0x1E9] = "@Trophy Collection/Lottery Base/Goldeen",
    [0x1EA] = "@Trophy Collection/Lottery Base/Heracross",
    [0x1EB] = "@Trophy Collection/Lottery Base/Heririn",
    [0x1EC] = "@Trophy Collection/Lottery Base/Home-Run Bat",
    [0x1ED] = "@Trophy Collection/Lottery Base/Igglybuff",
    [0x1EE] = "@Trophy Collection/Lottery Base/Jody Summer",
    [0x1EF] = "@Trophy Collection/Lottery Base/Kirby Hat 1",
    [0x1F0] = "@Trophy Collection/Lottery Base/Kirby Hat 2",
    [0x1F1] = "@Trophy Collection/Lottery Base/Kirby Hat 3",
    [0x1F2] = "@Trophy Collection/Lottery Base/Klap Trap",
    [0x1F3] = "@Trophy Collection/Lottery Base/Koopa Troopa",
    [0x1F4] = "@Trophy Collection/Lottery Base/Lakitu",
    [0x1F5] = "@Trophy Collection/Lottery Base/Metal Mario",
    [0x1F6] = "@Trophy Collection/Lottery Base/Metroid",
    [0x1F7] = "@Trophy Collection/Lottery Base/Monster",
    [0x1F8] = "@Trophy Collection/Lottery Base/Mr. Saturn",
    [0x1F9] = "@Trophy Collection/Lottery Base/Party Ball",
    [0x1FA] = "@Trophy Collection/Lottery Base/Poliwhirl",
    [0x1FB] = "@Trophy Collection/Lottery Base/Porygon2",
    [0x1FC] = "@Trophy Collection/Lottery Base/Racing Kart",
    [0x1FD] = "@Trophy Collection/Lottery Base/Raphael Raven",
    [0x1FE] = "@Trophy Collection/Lottery Base/Ray Gun",
    [0x1FF] = "@Trophy Collection/Lottery Base/Rick",
    [0x200] = "@Trophy Collection/Lottery Base/Ridley",
    [0x201] = "@Trophy Collection/Lottery Base/Ryota Hayami",
    [0x202] = "@Trophy Collection/Lottery Base/Scizor",
    [0x203] = "@Trophy Collection/Lottery Base/Slippy Toad",
    [0x204] = "@Trophy Collection/Lottery Base/Snorlax",
    [0x205] = "@Trophy Collection/Lottery Base/Squirtle",
    [0x206] = "@Trophy Collection/Lottery Base/Starman",
    [0x207] = "@Trophy Collection/Lottery Base/Starman (EarthBound)",
    [0x208] = "@Trophy Collection/Lottery Base/Star Rod",
    [0x209] = "@Trophy Collection/Lottery Base/Steelix",
    [0x20A] = "@Trophy Collection/Lottery Base/Super Mushroom",
    [0x20B] = "@Trophy Collection/Lottery Base/Super Scope",
    [0x20C] = "@Trophy Collection/Lottery Base/Thwomp",
    [0x20D] = "@Trophy Collection/Lottery Base/Toad",
    [0x20E] = "@Trophy Collection/Lottery Base/Topi",
    [0x20F] = "@Trophy Collection/Lottery Base/Totodile",
    [0x210] = "@Trophy Collection/Lottery Base/Waddle Dee",
    [0x211] = "@Trophy Collection/Lottery Base/Weezing",
    [0x212] = "@Trophy Collection/Lottery Base/Wobbuffet",
    [0x213] = "@Trophy Collection/Lottery Base/ZERO-ONE",

    -- Single Player Trophy Unlocks
    [0x214] = "@Trophy Collection/Any Main 1-P (No All-Star)/Ayumi Tachibana",
    [0x215] = "@Trophy Collection/Any Main 1-P (No All-Star)/Banzai Bill",
    [0x216] = "@Trophy Collection/Any Main 1-P (No All-Star)/Beam Sword",
    [0x217] = "@Trophy Collection/Any Main 1-P (No All-Star)/Charizard",
    [0x218] = "@Trophy Collection/Any Main 1-P (No All-Star)/Cleffa",
    [0x219] = "@Trophy Collection/Any Main 1-P (No All-Star)/Electrode",
    [0x21A] = "@Trophy Collection/Any Main 1-P (No All-Star)/Fire Kirby",
    [0x21B] = "@Trophy Collection/Any Main 1-P (No All-Star)/Four Giants",
    [0x21C] = "@Trophy Collection/Any Main 1-P (No All-Star)/Freezie",
    [0x21D] = "@Trophy Collection/Any Main 1-P (No All-Star)/Goron",
    [0x21E] = "@Trophy Collection/Any Main 1-P (No All-Star)/Green Shell",
    [0x21F] = "@Trophy Collection/Any Main 1-P (No All-Star)/Koopa Paratroopa",
    [0x220] = "@Trophy Collection/Any Main 1-P (No All-Star)/Like Like",
    [0x221] = "@Trophy Collection/Any Main 1-P (No All-Star)/Love Giant",
    [0x222] = "@Trophy Collection/Any Main 1-P (No All-Star)/Marill",
    [0x223] = "@Trophy Collection/Any Main 1-P (No All-Star)/Master Sword",
    [0x224] = "@Trophy Collection/Any Main 1-P (No All-Star)/Octorok",
    [0x225] = "@Trophy Collection/Any Main 1-P (No All-Star)/Parasol",
    [0x226] = "@Trophy Collection/Any Main 1-P (No All-Star)/Paula",
    [0x227] = "@Trophy Collection/Any Main 1-P (No All-Star)/Pit",
    [0x228] = "@Trophy Collection/Any Main 1-P (No All-Star)/Plum",
    [0x229] = "@Trophy Collection/Any Main 1-P (No All-Star)/ReDead",
    [0x22A] = "@Trophy Collection/Any Main 1-P (No All-Star)/Screw Attack",
    [0x22B] = "@Trophy Collection/Any Main 1-P (No All-Star)/Staryu",
    [0x22C] = "@Trophy Collection/Any Main 1-P (No All-Star)/Vegetable",
    [0x22D] = "@Trophy Collection/Any Main 1-P (No All-Star)/Viruses",
    [0x22E] = "@Trophy Collection/Any Main 1-P (No All-Star)/Warp Star",

    -- Additional Lottery Base Trophies
    [0x22F] = "@Trophy Collection/Lottery Base/Bubbles",
    [0x230] = "@Trophy Collection/Lottery Base/Chansey",
    [0x231] = "@Trophy Collection/Lottery Base/Dixie Kong",
    [0x232] = "@Trophy Collection/Lottery Base/Eevee",
    [0x233] = "@Trophy Collection/Lottery Base/Eggplant Man",
    [0x234] = "@Trophy Collection/Lottery Base/Fighter Kirby",
    [0x235] = "@Trophy Collection/Lottery Base/Jeff",
    [0x236] = "@Trophy Collection/Lottery Base/Maruo Maruhige",
    [0x237] = "@Trophy Collection/Lottery Base/Misty",
    [0x238] = "@Trophy Collection/Lottery Base/Professor Oak",
    [0x239] = "@Trophy Collection/Lottery Base/Ray Mk II",
    [0x23A] = "@Trophy Collection/Lottery Base/Red Shell",

    -- Lottery Adventure-Classic Clear Trophies
    [0x23B] = "@Trophy Collection/Lottery Adventure-Classic Clear/Arwing",
    [0x23C] = "@Trophy Collection/Lottery Adventure-Classic Clear/Baby Mario",
    [0x23D] = "@Trophy Collection/Lottery Adventure-Classic Clear/Bayonette",
    [0x23E] = "@Trophy Collection/Lottery Adventure-Classic Clear/Chozo Statue",
    [0x23F] = "@Trophy Collection/Lottery Adventure-Classic Clear/Ditto",
    [0x240] = "@Trophy Collection/Lottery Adventure-Classic Clear/Fountain of Dreams",
    [0x241] = "@Trophy Collection/Lottery Adventure-Classic Clear/Gooey",
    [0x242] = "@Trophy Collection/Lottery Adventure-Classic Clear/Great Fox",
    [0x243] = "@Trophy Collection/Lottery Adventure-Classic Clear/Hammer",
    [0x244] = "@Trophy Collection/Lottery Adventure-Classic Clear/King Dedede",
    [0x245] = "@Trophy Collection/Lottery Adventure-Classic Clear/Moon",
    [0x246] = "@Trophy Collection/Lottery Adventure-Classic Clear/Pak E. Derm",
    [0x247] = "@Trophy Collection/Lottery Adventure-Classic Clear/Pidgit",
    [0x248] = "@Trophy Collection/Lottery Adventure-Classic Clear/Pikmin",
    [0x249] = "@Trophy Collection/Lottery Adventure-Classic Clear/Poké Ball",
    [0x24A] = "@Trophy Collection/Lottery Adventure-Classic Clear/Pokémon Stadium",
    [0x24B] = "@Trophy Collection/Lottery Adventure-Classic Clear/Princess Peach's Castle",
    [0x24C] = "@Trophy Collection/Lottery Adventure-Classic Clear/Shy Guys",
    [0x24D] = "@Trophy Collection/Lottery Adventure-Classic Clear/Suicune",
    [0x24E] = "@Trophy Collection/Lottery Adventure-Classic Clear/Tingle",
    [0x24F] = "@Trophy Collection/Lottery Adventure-Classic Clear/Turtle",
    [0x250] = "@Trophy Collection/Lottery Adventure-Classic Clear/Venusaur",
    [0x251] = "@Trophy Collection/Lottery Adventure-Classic Clear/Whispy Woods",

    -- Lottery Secret Characters Trophies
    [0x252] = "@Trophy Collection/Lottery Secret Characters/Alpha",
    [0x253] = "@Trophy Collection/Lottery Secret Characters/Articuno",
    [0x254] = "@Trophy Collection/Lottery Secret Characters/Boo",
    [0x255] = "@Trophy Collection/Lottery Secret Characters/Hate Giant",
    [0x256] = "@Trophy Collection/Lottery Secret Characters/Ho-Oh",
    [0x257] = "@Trophy Collection/Lottery Secret Characters/King K. Rool",
    [0x258] = "@Trophy Collection/Lottery Secret Characters/Moltres",
    [0x259] = "@Trophy Collection/Lottery Secret Characters/Ocarina of Time",
    [0x25A] = "@Trophy Collection/Lottery Secret Characters/Raikou",
    [0x25B] = "@Trophy Collection/Lottery Secret Characters/Zapdos",

    -- Lottery 250 Trophies
    [0x25C] = "@Trophy Collection/Lottery 250 Trophies/GCN",
    [0x25D] = "@Trophy Collection/Lottery 250 Trophies/Koopa Clown Car",
    [0x25E] = "@Trophy Collection/Lottery 250 Trophies/Raccoon Mario",
    [0x25F] = "@Trophy Collection/Lottery 250 Trophies/Waluigi",

    -- Lottery 200 Vs. Matches Trophies
    [0x262] = "@Trophy Collection/Lottery 200 Vs. Matches/Andross",
    [0x263] = "@Trophy Collection/Lottery 200 Vs. Matches/Annie",
    [0x264] = "@Trophy Collection/Lottery 200 Vs. Matches/Cloaking Device",
    [0x265] = "@Trophy Collection/Lottery 200 Vs. Matches/Kensuke Kimachi",
    [0x266] = "@Trophy Collection/Lottery 200 Vs. Matches/Lugia",
    [0x267] = "@Trophy Collection/Lottery 200 Vs. Matches/Megavitamins",
    [0x268] = "@Trophy Collection/Lottery 200 Vs. Matches/Meta-Knight",
    [0x269] = "@Trophy Collection/Lottery 200 Vs. Matches/Peppy Hare",
    [0x26A] = "@Trophy Collection/Lottery 200 Vs. Matches/Poison Mushroom",
    [0x26B] = "@Trophy Collection/Lottery 200 Vs. Matches/Polar Bear",
    [0x26C] = "@Trophy Collection/Lottery 200 Vs. Matches/Poo",
    [0x26D] = "@Trophy Collection/Lottery 200 Vs. Matches/Samurai Goroh",
    [0x26E] = "@Trophy Collection/Lottery 200 Vs. Matches/Stanley",
    [0x26F] = "@Trophy Collection/Lottery 200 Vs. Matches/Togepi",
    [0x270] = "@Trophy Collection/Lottery 200 Vs. Matches/Totakeke",
    [0x271] = "@Trophy Collection/Lottery 200 Vs. Matches/Vacuum Luigi",
    
    -- =====================================
    -- BONUS ACHIEVEMENTS
    -- =====================================
    -- Combat Bonuses
    [0x01] = "@Bonus Achievements/Combat Bonuses/Dedicated Specialist",
    [0x02] = "@Bonus Achievements/Combat Bonuses/One-Two Punch",
    [0x03] = "@Bonus Achievements/Combat Bonuses/First Strike",
    [0x04] = "@Bonus Achievements/Combat Bonuses/150% Damage",
    [0x05] = "@Bonus Achievements/Combat Bonuses/200% Damage",
    [0x06] = "@Bonus Achievements/Combat Bonuses/250% Damage",
    [0x07] = "@Bonus Achievements/Combat Bonuses/300% Damage",
    [0x08] = "@Bonus Achievements/Combat Bonuses/350% Damage",
    [0x0C] = "@Bonus Achievements/Combat Bonuses/Berserker",
    [0x0D] = "@Bonus Achievements/Combat Bonuses/Smash King",
    [0x0E] = "@Bonus Achievements/Combat Bonuses/Smash Maniac",
    [0x0F] = "@Bonus Achievements/Combat Bonuses/Smash-less",
    [0x10] = "@Bonus Achievements/Combat Bonuses/Specialist",
    [0x12] = "@Bonus Achievements/Combat Bonuses/Full Power",
    [0x38] = "@Bonus Achievements/Combat Bonuses/Heavy Damage",
    [0x39] = "@Bonus Achievements/Combat Bonuses/Sniper",
    [0x3A] = "@Bonus Achievements/Combat Bonuses/Brawler",
    [0x3B] = "@Bonus Achievements/Combat Bonuses/Precise Aim",
    [0x33] = "@Bonus Achievements/Combat Bonuses/Pummeler",
    [0x34] = "@Bonus Achievements/Combat Bonuses/Fists of Fury",
    [0x36] = "@Bonus Achievements/Combat Bonuses/Opportunist",
    [0x37] = "@Bonus Achievements/Combat Bonuses/Spectator",
    [0xBF] = "@Bonus Achievements/Combat Bonuses/KO Artist",
    [0xC0] = "@Bonus Achievements/Combat Bonuses/KO Master",
    [0xC1] = "@Bonus Achievements/Combat Bonuses/Offensive Artist",
    [0xC2] = "@Bonus Achievements/Combat Bonuses/Offensive Master",
    [0x3F] = "@Bonus Achievements/Combat Bonuses/Cuddly Bear",
    [0x40] = "@Bonus Achievements/Combat Bonuses/Punching Bag",
    [0x41] = "@Bonus Achievements/Combat Bonuses/Stale Moves",
    [0x42] = "@Bonus Achievements/Combat Bonuses/Blind Eye",
    [0x43] = "@Bonus Achievements/Combat Bonuses/Crowd Favorite",
    [0x44] = "@Bonus Achievements/Combat Bonuses/Master of Suspense",
    [0x45] = "@Bonus Achievements/Combat Bonuses/Lost in Space",
    [0x46] = "@Bonus Achievements/Combat Bonuses/Lost Luggage",
    [0x6E] = "@Bonus Achievements/Combat Bonuses/Bully",
    [0x6F] = "@Bonus Achievements/Combat Bonuses/Coward",
    [0x70] = "@Bonus Achievements/Combat Bonuses/In the Fray",
    [0x71] = "@Bonus Achievements/Combat Bonuses/Friendly Foe",
    [0x72] = "@Bonus Achievements/Combat Bonuses/Center Stage",
    [0x76] = "@Bonus Achievements/Combat Bonuses/Pacifist",
    [0x77] = "@Bonus Achievements/Combat Bonuses/Moment of Silence",
    [0x78] = "@Bonus Achievements/Combat Bonuses/Impervious",
    [0x79] = "@Bonus Achievements/Combat Bonuses/Immortal",
    [0x7A] = "@Bonus Achievements/Combat Bonuses/Switzerland",
    [0x7B] = "@Bonus Achievements/Combat Bonuses/Predator",
    [0x7C] = "@Bonus Achievements/Combat Bonuses/Solar Being",
    [0x7D] = "@Bonus Achievements/Combat Bonuses/Stalker",

    -- Movement and Positioning Bonuses
    [0x15] = "@Bonus Achievements/Movement and Positioning Bonuses/Exceptional Aim",
    [0x16] = "@Bonus Achievements/Movement and Positioning Bonuses/Perfect Aim",
    [0x17] = "@Bonus Achievements/Movement and Positioning Bonuses/All Ground",
    [0x18] = "@Bonus Achievements/Movement and Positioning Bonuses/All Aerial",
    [0x19] = "@Bonus Achievements/Movement and Positioning Bonuses/Bird of Prey",
    [0x1A] = "@Bonus Achievements/Movement and Positioning Bonuses/Combo King",
    [0x1B] = "@Bonus Achievements/Movement and Positioning Bonuses/Juggler",
    [0x1C] = "@Bonus Achievements/Movement and Positioning Bonuses/Backstabber",
    [0x1D] = "@Bonus Achievements/Movement and Positioning Bonuses/Sweeper",
    [0x1E] = "@Bonus Achievements/Movement and Positioning Bonuses/Clean Sweep",
    [0x1F] = "@Bonus Achievements/Movement and Positioning Bonuses/Meteor Smash",
    [0x20] = "@Bonus Achievements/Movement and Positioning Bonuses/Meteor Clear",
    [0x21] = "@Bonus Achievements/Movement and Positioning Bonuses/Aerialist",
    [0x22] = "@Bonus Achievements/Movement and Positioning Bonuses/Acrobat",
    [0x23] = "@Bonus Achievements/Movement and Positioning Bonuses/Cement Shoes",
    [0x24] = "@Bonus Achievements/Movement and Positioning Bonuses/Head Banger",
    [0x25] = "@Bonus Achievements/Movement and Positioning Bonuses/Elbow Room",
    [0x30] = "@Bonus Achievements/Movement and Positioning Bonuses/Eagle",
    [0x31] = "@Bonus Achievements/Movement and Positioning Bonuses/Compass Tosser",
    [0x32] = "@Bonus Achievements/Movement and Positioning Bonuses/Throw Down",
    [0x2B] = "@Bonus Achievements/Movement and Positioning Bonuses/Stiff Knees",
    [0x2C] = "@Bonus Achievements/Movement and Positioning Bonuses/Run, Don't Walk",
    [0x2D] = "@Bonus Achievements/Movement and Positioning Bonuses/Ambler",
    [0x2E] = "@Bonus Achievements/Movement and Positioning Bonuses/No Hurry",
    [0x2F] = "@Bonus Achievements/Movement and Positioning Bonuses/Marathon Man",
    [0x48] = "@Bonus Achievements/Movement and Positioning Bonuses/Rock Steady",
    [0x49] = "@Bonus Achievements/Movement and Positioning Bonuses/Pratfaller",
    [0x4A] = "@Bonus Achievements/Movement and Positioning Bonuses/Face Planter",
    [0x4B] = "@Bonus Achievements/Movement and Positioning Bonuses/Twinkle Toes",
    [0x4C] = "@Bonus Achievements/Movement and Positioning Bonuses/Floor Diver",
    [0x4D] = "@Bonus Achievements/Movement and Positioning Bonuses/No R 4 U",
    [0x4F] = "@Bonus Achievements/Movement and Positioning Bonuses/Floored",
    [0x50] = "@Bonus Achievements/Movement and Positioning Bonuses/Life on the Edge",
    [0x51] = "@Bonus Achievements/Movement and Positioning Bonuses/Poser",
    [0x53] = "@Bonus Achievements/Movement and Positioning Bonuses/Poser Power",
    [0x55] = "@Bonus Achievements/Movement and Positioning Bonuses/Instant Poser",
    [0x57] = "@Bonus Achievements/Movement and Positioning Bonuses/Button Holder",
    [0x58] = "@Bonus Achievements/Movement and Positioning Bonuses/Shield Stupidity",
    [0x59] = "@Bonus Achievements/Movement and Positioning Bonuses/Shield Saver",
    [0x5A] = "@Bonus Achievements/Movement and Positioning Bonuses/Skid Master",
    [0x5B] = "@Bonus Achievements/Movement and Positioning Bonuses/Rock Climber",
    [0x5C] = "@Bonus Achievements/Movement and Positioning Bonuses/Edge Hog",
    [0x5D] = "@Bonus Achievements/Movement and Positioning Bonuses/Cliffhanger",
    [0x28] = "@Bonus Achievements/Movement and Positioning Bonuses/Shattered Shield",
    [0x29] = "@Bonus Achievements/Movement and Positioning Bonuses/Statue",
    [0x2A] = "@Bonus Achievements/Movement and Positioning Bonuses/Never Look Back",

    -- KO Type Bonuses
    [0x5E] = "@Bonus Achievements/KO Type Bonuses/Sacrificial KO",
    [0x5F] = "@Bonus Achievements/KO Type Bonuses/Avenger KO",
    [0x60] = "@Bonus Achievements/KO Type Bonuses/Double KO",
    [0x61] = "@Bonus Achievements/KO Type Bonuses/Triple KO",
    [0x64] = "@Bonus Achievements/KO Type Bonuses/Dead-Weight KO",
    [0x65] = "@Bonus Achievements/KO Type Bonuses/Kiss-the-Floor KO",
    [0x66] = "@Bonus Achievements/KO Type Bonuses/Poser KO",
    [0x67] = "@Bonus Achievements/KO Type Bonuses/Cheap KO",
    [0x68] = "@Bonus Achievements/KO Type Bonuses/Bank-Shot KO",
    [0x73] = "@Bonus Achievements/KO Type Bonuses/Star KO",
    [0x74] = "@Bonus Achievements/KO Type Bonuses/Wimpy KO",
    [0x69] = "@Bonus Achievements/KO Type Bonuses/Timely KO",
    [0x6A] = "@Bonus Achievements/KO Type Bonuses/Special KO",
    [0x6B] = "@Bonus Achievements/KO Type Bonuses/Hangman's KO",
    [0x6C] = "@Bonus Achievements/KO Type Bonuses/KO 64",
    [0x6D] = "@Bonus Achievements/KO Type Bonuses/Bubble-Blast KO",
    [0x75] = "@Bonus Achievements/KO Type Bonuses/Bull's-eye KO",
    [0x7E] = "@Bonus Achievements/KO Type Bonuses/Carrier KO",
    [0x95] = "@Bonus Achievements/KO Type Bonuses/Assisted KO",
    [0xDE] = "@Bonus Achievements/KO Type Bonuses/Rocket KO",
    [0x9D] = "@Bonus Achievements/KO Type Bonuses/Tiny KO",
    [0x9E] = "@Bonus Achievements/KO Type Bonuses/Invisible KO",
    [0xAB] = "@Bonus Achievements/KO Type Bonuses/Giant KO",
    [0xA4] = "@Bonus Achievements/KO Type Bonuses/Metal KO",
    [0xA5] = "@Bonus Achievements/KO Type Bonuses/Freezie KO",
    [0xA6] = "@Bonus Achievements/KO Type Bonuses/Flipper KO",
    [0xA3] = "@Bonus Achievements/KO Type Bonuses/Invincible KO",
    [0x8C] = "@Bonus Achievements/KO Type Bonuses/Capsule KO",
    [0xB1] = "@Bonus Achievements/KO Type Bonuses/Warp-Star KO",
    [0x9F] = "@Bonus Achievements/KO Type Bonuses/Bunny-hood Blast",
    [0xC4] = "@Bonus Achievements/KO Type Bonuses/Paratroopa KO",
    [0xC5] = "@Bonus Achievements/KO Type Bonuses/ReDead KO",
    [0xC6] = "@Bonus Achievements/KO Type Bonuses/Like Like KO",
    [0xC7] = "@Bonus Achievements/KO Type Bonuses/Octorok KO",
    [0xC8] = "@Bonus Achievements/KO Type Bonuses/Topi KO",
    [0xC9] = "@Bonus Achievements/KO Type Bonuses/Polar Bear KO",
    [0xCA] = "@Bonus Achievements/KO Type Bonuses/Shy Guy KO",
    [0xCD] = "@Bonus Achievements/KO Type Bonuses/Pokémon KO",
    [0xD0] = "@Bonus Achievements/KO Type Bonuses/Goomba KO",
    [0xD1] = "@Bonus Achievements/KO Type Bonuses/Koopa KO",

    -- Item-Related Bonuses
    [0x84] = "@Bonus Achievements/Item-Related Bonuses/Item Hog",
    [0x85] = "@Bonus Achievements/Item-Related Bonuses/Item Collector",
    [0x88] = "@Bonus Achievements/Item-Related Bonuses/Item-less",
    [0x89] = "@Bonus Achievements/Item-Related Bonuses/Item Specialist",
    [0x83] = "@Bonus Achievements/Item-Related Bonuses/Triple Items",
    [0x86] = "@Bonus Achievements/Item-Related Bonuses/Lucky Threes",
    [0x87] = "@Bonus Achievements/Item-Related Bonuses/Jackpot",
    [0x3C] = "@Bonus Achievements/Item-Related Bonuses/Pitcher",
    [0x3D] = "@Bonus Achievements/Item-Related Bonuses/Butterfingers",
    [0x3E] = "@Bonus Achievements/Item-Related Bonuses/All Thumbs",
    [0x7F] = "@Bonus Achievements/Item-Related Bonuses/Weight Lifter",
    [0x80] = "@Bonus Achievements/Item-Related Bonuses/Item Catcher",
    [0x81] = "@Bonus Achievements/Item-Related Bonuses/Reciprocator",
    [0x82] = "@Bonus Achievements/Item-Related Bonuses/Item Self-Destruct",
    [0x8A] = "@Bonus Achievements/Item-Related Bonuses/Item Chucker",
    [0x8B] = "@Bonus Achievements/Item-Related Bonuses/Item Smasher",
    [0xD2] = "@Bonus Achievements/Item-Related Bonuses/Beam Swordsman",
    [0xD3] = "@Bonus Achievements/Item-Related Bonuses/Home-Run King",
    [0xD4] = "@Bonus Achievements/Item-Related Bonuses/Laser Marksman",
    [0xD5] = "@Bonus Achievements/Item-Related Bonuses/Flame Thrower",
    [0xD7] = "@Bonus Achievements/Item-Related Bonuses/Headless Hammer",
    [0xD8] = "@Bonus Achievements/Item-Related Bonuses/Super Spy",
    [0xD9] = "@Bonus Achievements/Item-Related Bonuses/Bob-omb's Away",
    [0xCC] = "@Bonus Achievements/Item-Related Bonuses/Bob-omb Squad",
    [0xA7] = "@Bonus Achievements/Item-Related Bonuses/Mr. Saturn Fan",
    [0xA8] = "@Bonus Achievements/Item-Related Bonuses/Mrs. Saturn",
    [0xA9] = "@Bonus Achievements/Item-Related Bonuses/Saturn Siblings",
    [0xAA] = "@Bonus Achievements/Item-Related Bonuses/Saturn Ringer",
    [0xDF] = "@Bonus Achievements/Item-Related Bonuses/Minimalist",
    [0xE0] = "@Bonus Achievements/Item-Related Bonuses/Materialist",

    -- Mode-Specific Bonuses
    [0xEE] = "@Bonus Achievements/Mode-Specific Bonuses/Classic Clear",
    [0xEF] = "@Bonus Achievements/Mode-Specific Bonuses/Adventure Clear",
    [0xF0] = "@Bonus Achievements/Mode-Specific Bonuses/All-Star Clear",
    [0xE9] = "@Bonus Achievements/Mode-Specific Bonuses/Giga Bowser KO",
    [0xE4] = "@Bonus Achievements/Mode-Specific Bonuses/Crazy Hand KO",
    [0xE5] = "@Bonus Achievements/Mode-Specific Bonuses/Luigi KO",
    [0xE7] = "@Bonus Achievements/Mode-Specific Bonuses/Giant Kirby KO",
    [0xE8] = "@Bonus Achievements/Mode-Specific Bonuses/Metal Bros. KO",
    [0xE1] = "@Bonus Achievements/Mode-Specific Bonuses/Collector",
    [0xE2] = "@Bonus Achievements/Mode-Specific Bonuses/Target Master",
    [0xE3] = "@Bonus Achievements/Mode-Specific Bonuses/Hobbyist",
    [0xE6] = "@Bonus Achievements/Mode-Specific Bonuses/Link Master",
    [0xEA] = "@Bonus Achievements/Mode-Specific Bonuses/Continuation",
    [0xEC] = "@Bonus Achievements/Mode-Specific Bonuses/Speed Demon",
    [0xED] = "@Bonus Achievements/Mode-Specific Bonuses/Melee Master",
    [0xF1] = "@Bonus Achievements/Mode-Specific Bonuses/Very Hard Clear",
    [0xF6] = "@Bonus Achievements/Mode-Specific Bonuses/No-Miss Clear",
    [0x47] = "@Bonus Achievements/Mode-Specific Bonuses/Half-Minute Man",
    [0x93] = "@Bonus Achievements/Mode-Specific Bonuses/Lucky Number Seven",
    [0x94] = "@Bonus Achievements/Mode-Specific Bonuses/Last Second",
    [0x8D] = "@Bonus Achievements/Mode-Specific Bonuses/Environmental Hazard",
    [0x8E] = "@Bonus Achievements/Mode-Specific Bonuses/Angelic",
    [0x8F] = "@Bonus Achievements/Mode-Specific Bonuses/Magnified Finish",
    [0x90] = "@Bonus Achievements/Mode-Specific Bonuses/Fighter Stance",
    [0x91] = "@Bonus Achievements/Mode-Specific Bonuses/Mystic",
    [0x92] = "@Bonus Achievements/Mode-Specific Bonuses/Shooting Star",
    [0x96] = "@Bonus Achievements/Mode-Specific Bonuses/Foresight",
    [0x97] = "@Bonus Achievements/Mode-Specific Bonuses/First to Fall",
    [0x98] = "@Bonus Achievements/Mode-Specific Bonuses/Cliff Diver",
    [0x99] = "@Bonus Achievements/Mode-Specific Bonuses/Quitter",
    [0x9A] = "@Bonus Achievements/Mode-Specific Bonuses/Shameful Fall",
    [0x9B] = "@Bonus Achievements/Mode-Specific Bonuses/World Traveler",
    [0x9C] = "@Bonus Achievements/Mode-Specific Bonuses/Ground Pounded",
    [0xA0] = "@Bonus Achievements/Mode-Specific Bonuses/Vegetarian",
    [0xA1] = "@Bonus Achievements/Mode-Specific Bonuses/Heartthrob",
    [0xA2] = "@Bonus Achievements/Mode-Specific Bonuses/Invincible Finish",
    [0xAC] = "@Bonus Achievements/Mode-Specific Bonuses/Gardener Finish",
    [0xAD] = "@Bonus Achievements/Mode-Specific Bonuses/Flower Finish",
    [0xAE] = "@Bonus Achievements/Mode-Specific Bonuses/Super Scoper",
    [0xAF] = "@Bonus Achievements/Mode-Specific Bonuses/Screwed Up",
    [0xB2] = "@Bonus Achievements/Mode-Specific Bonuses/Mycologist",
    [0xB3] = "@Bonus Achievements/Mode-Specific Bonuses/Mario Maniac",
    [0xB4] = "@Bonus Achievements/Mode-Specific Bonuses/Connoisseur",
    [0xB5] = "@Bonus Achievements/Mode-Specific Bonuses/Gourmet",
    [0xB6] = "@Bonus Achievements/Mode-Specific Bonuses/Battering Ram",
    [0xB7] = "@Bonus Achievements/Mode-Specific Bonuses/Straight Shooter",
    [0xB8] = "@Bonus Achievements/Mode-Specific Bonuses/Wimp",
    [0xB9] = "@Bonus Achievements/Mode-Specific Bonuses/Shape-Shifter",
    [0xBA] = "@Bonus Achievements/Mode-Specific Bonuses/Chuck Wagon",
    [0xBB] = "@Bonus Achievements/Mode-Specific Bonuses/Parasol Finish",
    [0xBC] = "@Bonus Achievements/Mode-Specific Bonuses/Last Place",
    [0xBD] = "@Bonus Achievements/Mode-Specific Bonuses/Wire to Wire",
    [0xBE] = "@Bonus Achievements/Mode-Specific Bonuses/Whipping Boy",
    [0xC3] = "@Bonus Achievements/Mode-Specific Bonuses/Frequent Faller",
    [0xCB] = "@Bonus Achievements/Mode-Specific Bonuses/First Place",
    [0xDB] = "@Bonus Achievements/Mode-Specific Bonuses/Peaceful Warrior",
    [0xDC] = "@Bonus Achievements/Mode-Specific Bonuses/Down, But Not Out",
    [0xDD] = "@Bonus Achievements/Mode-Specific Bonuses/Merciful Master",
    [0xF2] = "@Bonus Achievements/Mode-Specific Bonuses/Fall Guy",
    [0xF3] = "@Bonus Achievements/Mode-Specific Bonuses/Self-Destructor",
    [0xF4] = "@Bonus Achievements/Mode-Specific Bonuses/Master of Disaster",

    -- =====================================
    -- GENERAL ACHIEVEMENTS
    -- =====================================
    [0x1A5] = "@General Game Achievements/Gameplay Milestones/100 Coins",
    [0x1A6] = "@General Game Achievements/Gameplay Milestones/10 KO's",
    [0x260] = "@General Game Achievements/Gameplay Milestones/50 KO's",
    [0x1A7] = "@General Game Achievements/Gameplay Milestones/Walk 100 Meters",
    [0x1A8] = "@General Game Achievements/Gameplay Milestones/See Mew",
    [0x1A9] = "@General Game Achievements/Gameplay Milestones/See Celebi",

    -- Game Completion Goals
    [0x1B1] = "@General Game Achievements/General Game Goals/All Stages + Secret Characters",
    [0x1B2] = "@General Game Achievements/Game Goals/Unlock Luigi, Jigglypuff, Mewtwo, Mr. Game & Watch, and Marth",
    [0x1B3] = "@General Game Achievements/General Game Goals/Unlock Roy, Pichu, Ganondorf, Dr. Mario, Young Link, and Falco",
    [0x261] = "@General Game Achievements/General Game Goals/Unlock All Regular Stages",

    -- Special Trophy Requirements
    [0x1B4] = "@General Game Achievements/Special Trophy Requirements/Have Birdo Trophy",
    [0x1B5] = "@General Game Achievements/Special Trophy Requirements/Have Kraid Trophy",
    [0x1B6] = "@General Game Achievements/Special Trophy Requirements/Have Falcon Flyer Trophy",
    [0x1B7] = "@General Game Achievements/Special Trophy Requirements/Have UFO Trophy",
    [0x1B8] = "@General Game Achievements/Special Trophy Requirements/Have Sudowoodo Trophy",
    [0x1CB] = "@General Game Achievements/Special Trophy Requirements/Pikmin Memory Card Data",

    -- VS Match Milestones
    [0x1C4] = "@General Game Achievements/VS Mode Milestones/10 VS. Matches",
    [0x1C5] = "@General Game Achievements/VS Mode Milestones/50 VS. Matches",
    [0x1C6] = "@General Game Achievements/VS Mode Milestones/100 VS. Matches",
    [0x1C7] = "@General Game Achievements/VS Mode Milestones/100 Coin Battles",
    [0x1C8] = "@General Game Achievements/VS Mode Milestones/150 VS. Matches",
    [0x1C9] = "@General Game Achievements/VS Mode Milestones/200 VS. Matches",
    [0x1CA] = "@General Game Achievements/VS Mode Milestones/1000 VS. Matches",
}

-- Function to update character unlock from item receipt
function updateCharacterFromItem(item_id, item_name)
    debugPrint("Attempting character unlock - ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name))
    
    local character_code = nil
    
    -- Try ID-based mapping first (both hex and decimal)
    if item_id and CHARACTER_ITEM_MAPPING[item_id] then
        character_code = CHARACTER_ITEM_MAPPING[item_id]
        debugPrint("Found character by ID: " .. character_code)
    -- Try name-based mapping as fallback
    elseif item_name and CHARACTER_NAME_MAPPING[item_name] then
        character_code = CHARACTER_NAME_MAPPING[item_name]
        debugPrint("Found character by name: " .. character_code)
    end
    
    if character_code then
        local character_obj = Tracker:FindObjectForCode(character_code)
        if character_obj then
            if not character_obj.Active then
                character_obj.Active = true
                debugPrint("SUCCESS: Character unlocked via item: " .. character_code)
                
                -- Update character counter
                local unlock_counter = Tracker:FindObjectForCode("characters_unlocked")
                if unlock_counter then
                    unlock_counter.AcquiredCount = unlock_counter.AcquiredCount + 1
                    debugPrint("Total characters unlocked: " .. unlock_counter.AcquiredCount)
                end
                return true
            else
                debugPrint("Character already unlocked: " .. character_code)
            end
        else
            debugPrint("ERROR: Could not find tracker object for character: " .. character_code)
        end
    else
        debugPrint("No character mapping found for ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name))
    end
    return false
end

-- Function to update trophy counters
function updateTrophyCounters(location_id)
    -- Check if it's a trophy location (0x12A-0x271 range)
    if location_id >= 0x12A and location_id <= 0x271 then
        local total_counter = Tracker:FindObjectForCode("total_trophies")
        if total_counter then
            total_counter.AcquiredCount = total_counter.AcquiredCount + 1
            debugPrint("Total trophies: " .. total_counter.AcquiredCount)
        end
        
        -- Update specific trophy category counters based on ID ranges
        if location_id >= 0x12A and location_id <= 0x177 then
            -- Character trophies - determine type by pattern (every 3rd is adventure, classic, all-star)
            local trophy_index = ((location_id - 0x12A) % 3)
            local category_counter = nil
            
            if trophy_index == 0 then -- Adventure trophy
                category_counter = Tracker:FindObjectForCode("adventure_trophies")
            elseif trophy_index == 1 then -- Classic trophy  
                category_counter = Tracker:FindObjectForCode("classic_trophies")
            elseif trophy_index == 2 then -- All-Star trophy
                category_counter = Tracker:FindObjectForCode("allstar_trophies")
            end
            
            if category_counter then
                category_counter.AcquiredCount = category_counter.AcquiredCount + 1
            end
        end
    end
end

-- Function to update bonus achievement counters
function updateBonusCounters(location_id)
    -- Check if it's a bonus achievement (0x01-0xF6 range)
    if location_id >= 0x01 and location_id <= 0xF6 then
        local total_bonus_counter = Tracker:FindObjectForCode("bonus_achievements")
        if total_bonus_counter then
            total_bonus_counter.AcquiredCount = total_bonus_counter.AcquiredCount + 1
            debugPrint("Total bonus achievements: " .. total_bonus_counter.AcquiredCount)
        end
    end
end

-- Function to update event/target counters
function updateEventTargetCounters(location_id)
    -- Event matches (0xF7-0x129 range)
    if location_id >= 0xF7 and location_id <= 0x129 then
        local event_counter = Tracker:FindObjectForCode("events_cleared")
        if event_counter then
            event_counter.AcquiredCount = event_counter.AcquiredCount + 1
            debugPrint("Events cleared: " .. event_counter.AcquiredCount)
        end
    end
    
    -- Target tests (0x184-0x19C range) 
    if location_id >= 0x184 and location_id <= 0x19C then
        local target_counter = Tracker:FindObjectForCode("targets_cleared")
        if target_counter then
            target_counter.AcquiredCount = target_counter.AcquiredCount + 1
            debugPrint("Target tests cleared: " .. target_counter.AcquiredCount)
        end
    end
end

-- Main location handler
function onLocation(location_id, location_name)
    debugPrint("=== LOCATION CLEARED ===")
    debugPrint("ID: " .. tostring(location_id) .. ", Name: " .. tostring(location_name or "unknown"))
    
    -- Update counters first
    updateTrophyCounters(location_id)
    updateBonusCounters(location_id)
    updateEventTargetCounters(location_id)
    
    -- Handle location mapping from your existing system
    if LOCATION_TO_TRACKER_MAP[location_id] then
        local tracker_code = LOCATION_TO_TRACKER_MAP[location_id]
        debugPrint("Using mapped tracker code: " .. tracker_code)
        
        local obj = Tracker:FindObjectForCode(tracker_code)
        if obj then
            if obj.AvailableChestCount and obj.AvailableChestCount > 0 then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
                debugPrint("SUCCESS: Decremented chest count for: " .. tracker_code)
                return
            elseif obj.Owner and obj.Owner.AvailableChestCount and obj.Owner.AvailableChestCount > 0 then
                obj.Owner.AvailableChestCount = obj.Owner.AvailableChestCount - 1
                debugPrint("SUCCESS: Decremented parent chest count for: " .. tracker_code)
                return
            elseif obj.Active ~= nil then
                obj.Active = true
                debugPrint("SUCCESS: Activated: " .. tracker_code)
                return
            end
        else
            debugPrint("ERROR: Could not find object for mapped code: " .. tracker_code)
        end
    else
        debugPrint("WARNING: No mapping found for location ID: " .. tostring(location_id))
    end
end

-- Main item handler 
function onItem(index, item_id, item_name, player_number)
    debugPrint("=== ITEM HANDLER CALLED ===")
    debugPrint("Index: " .. tostring(index) .. ", CUR_INDEX: " .. tostring(CUR_INDEX))
    debugPrint("Item ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name or "unknown"))
    debugPrint("Player: " .. tostring(player_number) .. ", Local Player: " .. tostring(Archipelago.PlayerNumber or "unknown"))
    

    
    -- Update index tracking
    if index > CUR_INDEX then
        CUR_INDEX = index
    end
    
    -- Check if this is for a local player
    local is_local = (player_number == Archipelago.PlayerNumber) or (Archipelago.PlayerNumber == nil)
    debugPrint("Is local item: " .. tostring(is_local))
    

        debugPrint("Processing item...")
        
        -- Handle character unlocks
        local success = updateCharacterFromItem(item_id, item_name)
        if success then
            debugPrint("Character unlock successful!")
        else
            debugPrint("No character unlocked for this item")
        end
        
        -- Handle other item types (coins, etc.)
        if item_name then
            if item_name == "Coin" then
                local coin_counter = Tracker:FindObjectForCode("coins_collected")
                if coin_counter then
                    coin_counter.AcquiredCount = coin_counter.AcquiredCount + 1
                    debugPrint("Added 1 coin, total: " .. coin_counter.AcquiredCount)
                end
            elseif item_name == "10 Coins" then
                local coin_counter = Tracker:FindObjectForCode("coins_collected")
                if coin_counter then
                    coin_counter.AcquiredCount = coin_counter.AcquiredCount + 10
                    debugPrint("Added 10 coins, total: " .. coin_counter.AcquiredCount)
                end
            elseif item_name == "20 Coins" then
                local coin_counter = Tracker:FindObjectForCode("coins_collected")
                if coin_counter then
                    coin_counter.AcquiredCount = coin_counter.AcquiredCount + 20
                    debugPrint("Added 20 coins, total: " .. coin_counter.AcquiredCount)
                end
            end
        end
    -- else
    --     debugPrint("Skipping non-local item")
    -- end
end

-- Clear handler for reset
function onClear(slot_data)
    debugPrint("=== CLEARING TRACKER STATE ===")
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    
    -- Reset all character unlock states
    for _, character_code in pairs(CHARACTER_ITEM_MAPPING) do
        local obj = Tracker:FindObjectForCode(character_code)
        if obj then
            obj.Active = false
        end
    end
    
    -- Reset counters
    local counters = {
        "total_trophies", "bonus_achievements", "events_cleared", 
        "targets_cleared", "classic_trophies", "adventure_trophies", 
        "allstar_trophies", "characters_unlocked", "coins_collected"
    }
    
    for _, counter_code in ipairs(counters) do
        local counter = Tracker:FindObjectForCode(counter_code)
        if counter then
            counter.AcquiredCount = 0
        end
    end
    
    -- Set character counter to 1 (starting with 1 random character)
    local unlock_counter = Tracker:FindObjectForCode("characters_unlocked")
    if unlock_counter then
        unlock_counter.AcquiredCount = 1
        debugPrint("Reset complete - starting with 1 character unlocked")
    end
    
    debugPrint("=== TRACKER RESET COMPLETE ===")
end

-- Helper function to count table entries
function table_length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- Initialize autotracking
if Archipelago then
    Archipelago:AddClearHandler("ssbm_clear", onClear)
    Archipelago:AddItemHandler("ssbm_item", onItem)
    Archipelago:AddLocationHandler("ssbm_location", onLocation)
    
    print("==========================================")
    print("Super Smash Bros. Melee Auto-Tracker")
    print("Character tracking")
    print("Location mappings: " .. table_length(LOCATION_TO_TRACKER_MAP))
    print("Character items: " .. table_length(CHARACTER_ITEM_MAPPING))
    print("Counter tracking: ENABLED")
    print("Debug mode: " .. tostring(DEBUG_ENABLED))
    print("==========================================")
else
    print("ERROR: Archipelago object not found!")
end