
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Заказ кузнецу"      -- "Blacksmith Writ"
,   [cl] = "Заказ портному"    -- "Clothier Writ"
,   [en] = "Заказ зачарователю"    -- "Enchanter Writ"
,   [al] = "Заказ алхимику"    -- "Alchemist Writ"
,   [pr] = "Заказ снабженцу"    -- "Provisioner Writ"
,   [ww] = "Заказ столяру"      -- "Woodworker Writ"
,   [jw] = "Заказ ювелиру"      -- "Jewelry Crafting Writ"
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
    [bs] = { "Искусные латы"          -- "A Masterful Plate"
           , "Искусное оружие"    } -- "A Masterful Weapon"
,   [cl] = { "Искусные тканевые доспехи"    -- "Masterful Tailoring"
           , "Искусные кожаные доспехи"  } -- "Masterful Leatherwear"
,   [en] = { "Искусный глиф"        } -- "A Masterful Glyph"
,   [al] = { "Искусное варево"    } -- "A Masterful Concoction"
,   [pr] = { "Искусный пир"          } -- "A Masterful Feast"
,   [ww] = { "Искусный щит"            -- "A Masterful Shield"
           , "Искусное оружие"    } -- "A Masterful Weapon"
,   [jw] = { "Искусные ювелирные изделия"  } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Качество"                -- "Quality"
,   ["set"    ] =  "Комплект"                -- "Set"
,   ["style"  ] =  "Стиль"                      -- "Style"
,   ["trait"  ] =  "Особенность"          -- "Trait"
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
         , [59] = "Sword"                     -- "Sword"
         , [68] = "Battle Axe"                -- "Battle Axe"
         , [69] = "Maul"                      -- "Maul"
         , [67] = "Greatsword"                -- "Greatsword"
         , [62] = "Dagger"                    -- "Dagger"
         , [46] = "Cuirass"                   -- "Cuirass"
         , [50] = "Sabatons"                  -- "Sabatons"
         , [52] = "Gauntlets"                 -- "Gauntlets"
         , [44] = "Helm"                      -- "Helm"
         , [49] = "Greaves"                   -- "Greaves"
         , [47] = "Pauldron"                  -- "Pauldron"
         , [48] = "Girdle"                    -- "Girdle"
         }
, [cl] = {
           [28] = "Robe"                      -- "Robe"
         , [75] = "Jerkin"                    -- "Jerkin"
         , [32] = "Shoes"                     -- "Shoes"
         , [34] = "Gloves"                    -- "Gloves"
         , [26] = "Hat"                       -- "Hat"
         , [31] = "Breeches"                  -- "Breeches"
         , [29] = "Epaulets"                  -- "Epaulets"
         , [30] = "Sash"                      -- "Sash"
         , [37] = "Jack"                      -- "Jack"
         , [41] = "Boots"                     -- "Boots"
         , [43] = "Bracers"                   -- "Bracers"
         , [35] = "Helmet"                    -- "Helmet"
         , [40] = "Guards"                    -- "Guards"
         , [38] = "Arm Cops"                  -- "Arm Cops"
         , [39] = "Belt"                      -- "Belt"
         }
, [ww] = {
           [70] = "Bow"                       -- "Bow"
         , [72] = "Inferno Staff"             -- "Inferno Staff"
         , [73] = "Ice Staff"                 -- "Ice Staff"
         , [74] = "Lightning Staff"           -- "Lightning Staff"
         , [71] = "Restoration Staff"         -- "Restoration Staff"
         , [65] = "Shield"                    -- "Shield"
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
           [ 1] = "axe"                       -- "axe"
         , [ 2] = "mace"                      -- "mace"
         , [ 3] = "sword"                     -- "wword"
         , [ 4] = "battle axe"                -- "battle Axe"
         , [ 5] = "maul"                      -- "maul"
         , [ 6] = "greatsword"                -- "greatsword"
         , [ 7] = "dagger"                    -- "dagger"
         , [ 8] = "cuirass"                   -- "cuirass"
         , [ 9] = "sabatons"                  -- "sabatons"
         , [10] = "gauntlets"                 -- "gauntlets"
         , [11] = "helm"                      -- "helm"
         , [12] = "greaves"                   -- "greaves"
         , [13] = "pauldron"                  -- "pauldron"
         , [14] = "girdle"                    -- "girdle"
         }
, [cl] = {
           [ 1] = "robe"                      -- "robe"
         , [ 2] = "jerkin"                    -- "jerkin"
         , [ 3] = "shoes"                     -- "shoes"
         , [ 4] = "gloves"                    -- "gloves"
         , [ 5] = "hat"                       -- "hat"
         , [ 6] = "breeches"                  -- "breeches"
         , [ 7] = "epaulets"                  -- "epaulets"
         , [ 8] = "sash"                      -- "sash"
         , [ 9] = "jack"                      -- "jack"
         , [10] = "boots"                     -- "boots"
         , [11] = "bracers"                   -- "bracers"
         , [12] = "helmet"                    -- "helmet"
         , [13] = "guards"                    -- "guards"
         , [14] = "arm cops"                  -- "arm cops"
         , [15] = "belt"                      -- "belt"
         }
, [ww] = {
           [ 1] = "bow"                       -- "bow"
         , [ 3] = "inferno staff"             -- "inferno staff"
         , [ 4] = "ice staff"                 -- "ice staff"
         , [ 5] = "lightning staff"           -- "lightning staff"
         , [ 6] = "restoration staff"         -- "restoration staff"
         , [ 2] = "shield"                    -- "shield"
         }
, [jw] = {
           [ 2] = "necklace"                  -- "necklace"
         , [ 1] = "ring"                      -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Обычное"           -- "Normal"
,   [2] = "Хорошее"           -- "Fine"
,   [3] = "Превосходное"    -- "Superior"
,   [4] = "Эпическое"       -- "Epic"
,   [5] = "Легендарное"    -- "Legendary"
}

