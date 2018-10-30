
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
    ["quality"] =  "Quality"                         -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Style"                           -- "Style"
,   ["trait"  ] =  "Trait"                           -- "Trait"
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

LibCraftText.ITEMS = {
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
, [28] = "Robe"                      -- "Robe"
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
, [70] = "Bow"                       -- "Bow"
, [72] = "Inferno Staff"             -- "Inferno Staff"
, [73] = "Ice Staff"                 -- "Ice Staff"
, [74] = "Lightning Staff"           -- "Lightning Staff"
, [71] = "Restoration Staff"         -- "Restoration Staff"
, [65] = "Shield"                    -- "Shield"
, [18] = "Necklace"                  -- "Necklace"
, [24] = "Ring"                      -- "Ring"
}

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Fine"                     -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Epic"                     -- "Epic"
,   [5] = "Legendary"                -- "Legendary"
}

