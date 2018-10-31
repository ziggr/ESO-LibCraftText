
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Blacksmith Writ"                -- "Blacksmith Writ"
,   [cl] = "Clothier Writ"                  -- "Clothier Writ"
,   [en] = "Enchanter Writ"                 -- "Enchanter Writ"
,   [al] = "Alchemist Writ"                 -- "Alchemist Writ"
,   [pr] = "Provisioner Writ"               -- "Provisioner Writ"
,   [ww] = "Woodworker Writ"                -- "Woodworker Writ"
,   [jw] = "Jewelry Crafting Writ"          -- "Jewelry Crafting Writ"
}

                        -- SURPRISE! "A Masterful Weapon" is used
                        -- by both Blacksmithing and Woodworking.
                        --
                        -- Why a list? Because BS, CL, and WW can all
                        -- use different quest titles depending on what
                        -- item they requested (armor vs. weapon,
                        -- light vs. medium armor)
                        --
LibCraftText.MASTER_QUEST_TITLES = {
    [bs] = { "A Masterful Plate"                  -- "A Masterful Plate"
           , "A Masterful Weapon"               } -- "A Masterful Weapon"
,   [cl] = { "Masterful Tailoring"                -- "Masterful Tailoring"
           , "Masterful Leatherwear"            } -- "Masterful Leatherwear"
,   [en] = { "A Masterful Glyph"                } -- "A Masterful Glyph"
,   [al] = { "A Masterful Concoction"           } -- "A Masterful Concoction"
,   [pr] = { "A Masterful Feast"                } -- "A Masterful Feast"
,   [ww] = { "A Masterful Shield"                 -- "A Masterful Shield"
           , "A Masterful Weapon"               } -- "A Masterful Weapon"
,   [jw] = { "Masterful Jewelry"                } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualità"                        -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Stile"                           -- "Style"
,   ["trait"  ] =  "Tratti"                          -- "Trait"
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"              -- "Rolis Hlaalu"
,   ["accept"]         = "<Accept the contract.>"    -- "<Accept the contract.>"
,   ["finish"]         = "<Finish the job.>"         -- "<Finish the job.>"
,   ["deliver_substr"] = "Deliver"                   -- "Deliver"

,   [bs] = "I've finished the Blacksmithing job."    -- "I've finished the Blacksmithing job."
,   [cl] = "I've finished the Clothier job."         -- "I've finished the Clothier job."
,   [en] = "I've finished the Enchanting job."       -- "I've finished the Enchanting job."
,   [al] = "I've finished the Alchemy job."          -- "I've finished the Alchemy job."
,   [pr] = "I've finished the Provisioning job."     -- "I've finished the Provisioning job."
,   [ww] = "I've finished the Woodworking job."      -- "I've finished the Woodworking job."
,   [jw] = "I've finished the Jewelry job."          -- "I've finished the Jewelry job."
}

--
-- Generatable strings
--
-- ziggr suspects that NONE of these are necessary, and will eventually be
-- replaced by language-specific regexes to parse quest condition text, and
-- (hopefully) small extractor/generator functions that can generate tables
-- of crafting values at runtime. There's no way ziggr is including a 79-entry
-- motif table, or a 45-entry set bonus table.
--

LibCraftText.MATERIALS = {
    ["bs" ] = { "iron"               -- "iron"
              , "steel"              -- "steel"
              , "orichalc"           -- "orichalc"
              , "dwarven"            -- "dwarven"
              , "ebon"               -- "ebon"
              , "calcinium"          -- "calcinium"
              , "galatite"           -- "galatite"
              , "quicksilver"        -- "quicksilver"
              , "voidsteel"          -- "voidsteel"
              , "Rubedite"           -- "Rubedite"
              }
,   ["lgt"] = { "homespun"           -- "homespun"
              , "linen"              -- "linen"
              , "cotton"             -- "cotton"
              , "spidersilk"         -- "spidersilk"
              , "ebonthread"         -- "ebonthread"
              , "kresh"              -- "kresh"
              , "ironthread"         -- "ironthread"
              , "silverweave"        -- "silverweave"
              , "shadowspun"         -- "shadowspun"
              , "Ancestor Silk"      -- "Ancestor Silk"
              }
,   ["med"] = { "rawhide"            -- "rawhide"
              , "hide"               -- "hide"
              , "leather"            -- "leather"
              , "full-leather"       -- "full-leather"
              , "fell"               -- "fell"
              , "brigandine"         -- "brigandine"
              , "ironhide"           -- "ironhide"
              , "superb"             -- "superb"
              , "shadowhide"         -- "shadowhide"
              , "Rubedo Leather"     -- "Rubedo Leather"
              }
,   ["ww" ] = { "maple"              -- "maple"
              , "oak"                -- "oak"
              , "beech"              -- "beech"
              , "hickory"            -- "hickory"
              , "yew"                -- "yew"
              , "birch"              -- "birch"
              , "ash"                -- "ash"
              , "mahogany"           -- "mahogany"
              , "nightwood"          -- "nightwood"
              , "Ruby Ash"           -- "Ruby Ash"
              }
,   ["jw" ] = { "pewter"             -- "pewter"
              , "copper"             -- "copper"
              , "silver"             -- "silver"
              , "electrum"           -- "electrum"
              , "platinum"           -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "Axe"                       -- "Axe"
         , [56] = "Mace"                      -- "Mace"
         , [59] = "Spada"                     -- "Sword"
         , [68] = "Grande Ascia"              -- "Battle Axe"
         , [69] = "Maul"                      -- "Maul"
         , [67] = "Greatsword"                -- "Greatsword"
         , [62] = "Dagger"                    -- "Dagger"
         , [46] = "Corazza"                   -- "Cuirass"
         , [50] = "Sabatons"                  -- "Sabatons"
         , [52] = "Gauntlets"                 -- "Gauntlets"
         , [44] = "Elmo"                      -- "Helm"
         , [49] = "Gambali"                   -- "Greaves"
         , [47] = "Spallaccio"                -- "Pauldron"
         , [48] = "Girdle"                    -- "Girdle"
         }
, [cl] = {
           [28] = "Veste"                     -- "Robe"
         , [75] = "Giaco"                     -- "Jerkin"
         , [32] = "Scarpe"                    -- "Shoes"
         , [34] = "Guanti"                    -- "Gloves"
         , [26] = "Cappello"                  -- "Hat"
         , [31] = "Calzoni"                   -- "Breeches"
         , [29] = "Coprispalle"               -- "Epaulets"
         , [30] = "Fascia"                    -- "Sash"
         , [37] = "Corpetto"                  -- "Jack"
         , [41] = "Stivali"                   -- "Boots"
         , [43] = "Bracciali"                 -- "Bracers"
         , [35] = "Elmetto"                   -- "Helmet"
         , [40] = "Pantaloni"                 -- "Guards"
         , [38] = "Spalline"                  -- "Arm Cops"
         , [39] = "Cintura"                   -- "Belt"
         }
, [ww] = {
           [70] = "Bow"                       -- "Bow"
         , [72] = "Bastone del Fuoco"         -- "Inferno Staff"
         , [73] = "Frost Staff"               -- "Ice Staff"
         , [74] = "Lightning Staff"           -- "Lightning Staff"
         , [71] = "Healing Staff"             -- "Restoration Staff"
         , [65] = "Scudo"                     -- "Shield"
         }
, [jw] = {
           [18] = "Necklace"                  -- "Necklace"
         , [24] = "Ring"                      -- "Ring"
         }
}

-- These are the item names from crafting stations. Surprise! They occasionally
-- differ from what master writs use. For example, blacksmithing head piece,
-- in FR French is called "heaume" at the crafting station, but "casque" in
-- a sealed master blacksmithing writ. Grrr.
--
-- Numeric index is the pattern_index used as arg1 to
-- GetSmithingPatternItemLink() and other crafting station APIs.
--
LibCraftText.ITEMS_STATION = {
  [bs] = {
           [ 1] = "ascia"                     -- "axe"
         , [ 2] = "mazza"                     -- "mace"
         , [ 3] = "spada"                     -- "wword"
         , [ 4] = "ascia da battaglia"        -- "battle Axe"
         , [ 5] = "maglio"                    -- "maul"
         , [ 6] = "spadone"                   -- "greatsword"
         , [ 7] = "pugnale"                   -- "dagger"
         , [ 8] = "corazza"                   -- "cuirass"
         , [ 9] = "schinieri"                 -- "sabatons"
         , [10] = "mittene"                   -- "gauntlets"
         , [11] = "elmo"                      -- "helm"
         , [12] = "gambali"                   -- "greaves"
         , [13] = "spallaccio"                -- "pauldron"
         , [14] = "cinturone"                 -- "girdle"
         }
, [cl] = {
           [ 1] = "veste"                     -- "robe"
         , [ 2] = "giaco"                     -- "jerkin"
         , [ 3] = "scarpe"                    -- "shoes"
         , [ 4] = "guanti"                    -- "gloves"
         , [ 5] = "cappello"                  -- "hat"
         , [ 6] = "calzoni"                   -- "breeches"
         , [ 7] = "coprispalle"               -- "epaulets"
         , [ 8] = "fascia"                    -- "sash"
         , [ 9] = "corpetto"                  -- "jack"
         , [10] = "stivali"                   -- "boots"
         , [11] = "bracciali"                 -- "bracers"
         , [12] = "elmetto"                   -- "helmet"
         , [13] = "pantaloni"                 -- "guards"
         , [14] = "spalline"                  -- "arm cops"
         , [15] = "cintura"                   -- "belt"
         }
, [ww] = {
           [ 1] = "arco"                      -- "bow"
         , [ 3] = "bastone del fuoco"         -- "inferno staff"
         , [ 4] = "bastone del gelo"          -- "ice staff"
         , [ 5] = "bastone del fulmine"       -- "lightning staff"
         , [ 6] = "bastone di cura"           -- "restoration staff"
         , [ 2] = "scudo"                     -- "shield"
         }
, [jw] = {
           [ 2] = "collana"                   -- "necklace"
         , [ 1] = "anello"                    -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normale"                  -- "Normal"
,   [2] = "Buono"                    -- "Fine"
,   [3] = "Superiore"                -- "Superior"
,   [4] = "Epico"                    -- "Epic"
,   [5] = "Leggendario"              -- "Legendary"
}

