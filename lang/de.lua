
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Schmiedeschrieb"                -- "Blacksmith Writ"
,   [cl] = "Schneiderschrieb"               -- "Clothier Writ"
,   [en] = "Verzaubererschrieb"             -- "Enchanter Writ"
,   [al] = "Alchemistenschrieb"             -- "Alchemist Writ"
,   [pr] = "Versorgerschrieb"               -- "Provisioner Writ"
,   [ww] = "Schreinerschrieb"               -- "Woodworker Writ"
,   [jw] = "Schmuckhandwerksschrieb"        -- "Jewelry Crafting Writ"
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
    [bs] = { "Eine meisterhafte Rüstung"         -- "A Masterful Plate"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [cl] = { "Ein meisterhaftes Gewand"           -- "Masterful Tailoring"
           , "Meisterhafte Lederwaren"          } -- "Masterful Leatherwear"
,   [en] = { "Eine meisterhafte Glyphe"         } -- "A Masterful Glyph"
,   [al] = { "Ein meisterhaftes Gebräu"        } -- "A Masterful Concoction"
,   [pr] = { "Ein meisterhaftes Mahl"           } -- "A Masterful Feast"
,   [ww] = { "Ein meisterhafter Schild"           -- "A Masterful Shield"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [jw] = { "Ein meisterhaftes Schmuckstück"  } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualität"                       -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Stil"                            -- "Style"
,   ["trait"  ] =  "Eigenschaft"                     -- "Trait"
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"              -- "Rolis Hlaalu"
,   ["accept"]         = "<Nehmt den Auftrag an.>"    -- "<Accept the contract.>"
,   ["finish"]         = "<Auftrag abschließen.>"    -- "<Finish the job.>"
,   ["deliver_substr"] = "Beliefert"                 -- "Deliver"

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
    ["bs" ] = { "Eisen"              -- "iron"
              , "Stahl"              -- "steel"
              , "Oreichalkos"        -- "orichalc"
              , "Dwemer"             -- "dwarven"
              , "Ebenerz"            -- "ebon"
              , "Kalzinium"          -- "calcinium"
              , "Galatit"            -- "galatite"
              , "Flinksilber"        -- "quicksilver"
              , "Leerenstahl"        -- "voidsteel"
              , "Rubedit"            -- "Rubedite"
              }
,   ["lgt"] = { "Jute"               -- "homespun"
              , "Flachs"             -- "linen"
              , "Baumwoll"           -- "cotton"
              , "Spinnenseiden"      -- "spidersilk"
              , "Ebengarn"           -- "ebonthread"
              , "Kresh"              -- "kresh"
              , "Eisenstoff"         -- "ironthread"
              , "Silberstoff"        -- "silverweave"
              , "Leerenstoff"        -- "shadowspun"
              , "Ahnenseiden"        -- "Ancestor Silk"
              }
,   ["med"] = { "Rohleder"           -- "rawhide"
              , "Halbleder"          -- "hide"
              , "Leder"              -- "leather"
              , "Hartleder"          -- "full-leather"
              , "Wildleder"          -- "fell"
              , "Rauleder"           -- "brigandine"
              , "Eisenleder"         -- "ironhide"
              , "prächtiges "       -- "superb"
              , "Schattenleder"      -- "shadowhide"
              , "Rubedoleder"        -- "Rubedo Leather"
              }
,   ["ww" ] = { "Ahorn"              -- "maple"
              , "Eichen"             -- "oak"
              , "Buchen"             -- "beech"
              , "Hickory"            -- "hickory"
              , "Eiben"              -- "yew"
              , "Birken"             -- "birch"
              , "Eschen"             -- "ash"
              , "Mahagoni"           -- "mahogany"
              , "Nachtholz"          -- "nightwood"
              , "Rubineschen"        -- "Ruby Ash"
              }
,   ["jw" ] = { "Zinn"               -- "pewter"
              , "Kupfer"             -- "copper"
              , "Silber"             -- "silver"
              , "Elektrum"           -- "electrum"
              , "Platin"             -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "axt"                       -- "Axe"
         , [56] = "keule"                     -- "Mace"
         , [59] = "schwert"                   -- "Sword"
         , [68] = "streitaxt"                 -- "Battle Axe"
         , [69] = "streitkolben"              -- "Maul"
         , [67] = "bidenhänder"              -- "Greatsword"
         , [62] = "dolch"                     -- "Dagger"
         , [46] = "kürass"                   -- "Cuirass"
         , [50] = "panzerschuhe"              -- "Sabatons"
         , [52] = "hentzen"                   -- "Gauntlets"
         , [44] = "haube"                     -- "Helm"
         , [49] = "beinschienen"              -- "Greaves"
         , [47] = "schulterschutz"            -- "Pauldron"
         , [48] = "gürtel"                   -- "Girdle"
         }
, [cl] = {
           [28] = "robe"                      -- "Robe"
         , [75] = "jacke"                     -- "Jerkin"
         , [32] = "schuhe"                    -- "Shoes"
         , [34] = "handschuhe"                -- "Gloves"
         , [26] = "hut"                       -- "Hat"
         , [31] = "beinkleider"               -- "Breeches"
         , [29] = "schulterpolster"           -- "Epaulets"
         , [30] = "schärpe"                  -- "Sash"
         , [37] = "wams"                      -- "Jack"
         , [41] = "stiefel"                   -- "Boots"
         , [43] = "armschienen"               -- "Bracers"
         , [35] = "helm"                      -- "Helmet"
         , [40] = "schoner"                   -- "Guards"
         , [38] = "schulterkappen"            -- "Arm Cops"
         , [39] = "riemen"                    -- "Belt"
         }
, [ww] = {
           [70] = "bogen"                     -- "Bow"
         , [72] = "flammenstab"               -- "Inferno Staff"
         , [73] = "froststab"                 -- "Ice Staff"
         , [74] = "blitzstab"                 -- "Lightning Staff"
         , [71] = "heilungsstab"              -- "Restoration Staff"
         , [65] = "schild"                    -- "Shield"
         }
, [jw] = {
           [18] = "kette"                     -- "Necklace"
         , [24] = "ring"                      -- "Ring"
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
           [ 1] = "axt"                       -- "axe"
         , [ 2] = "keule"                     -- "mace"
         , [ 3] = "schwert"                   -- "wword"
         , [ 4] = "streitaxt"                 -- "battle Axe"
         , [ 5] = "streitkolben"              -- "maul"
         , [ 6] = "bidenhänder"              -- "greatsword"
         , [ 7] = "dolch"                     -- "dagger"
         , [ 8] = "kürass"                   -- "cuirass"
         , [ 9] = "panzerschuhe"              -- "sabatons"
         , [10] = "hentzen"                   -- "gauntlets"
         , [11] = "haube"                     -- "helm"
         , [12] = "beinschienen"              -- "greaves"
         , [13] = "schulterschutz"            -- "pauldron"
         , [14] = "gürtel"                   -- "girdle"
         }
, [cl] = {
           [ 1] = "robe"                      -- "robe"
         , [ 2] = "jacke"                     -- "jerkin"
         , [ 3] = "schuhe"                    -- "shoes"
         , [ 4] = "handschuhe"                -- "gloves"
         , [ 5] = "hut"                       -- "hat"
         , [ 6] = "beinkleider"               -- "breeches"
         , [ 7] = "schulterpolster"           -- "epaulets"
         , [ 8] = "schärpe"                  -- "sash"
         , [ 9] = "wams"                      -- "jack"
         , [10] = "stiefel"                   -- "boots"
         , [11] = "armschienen"               -- "bracers"
         , [12] = "helm"                      -- "helmet"
         , [13] = "schoner"                   -- "guards"
         , [14] = "schulterkappen"            -- "arm cops"
         , [15] = "riemen"                    -- "belt"
         }
, [ww] = {
           [ 1] = "bogen"                     -- "bow"
         , [ 3] = "flammenstab"               -- "inferno staff"
         , [ 4] = "froststab"                 -- "ice staff"
         , [ 5] = "blitzstab"                 -- "lightning staff"
         , [ 6] = "heilungsstab"              -- "restoration staff"
         , [ 2] = "schild"                    -- "shield"
         }
, [jw] = {
           [ 2] = "halskette"                 -- "necklace"
         , [ 1] = "ring"                      -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Erlesen"                  -- "Fine"
,   [3] = "Überlegen"               -- "Superior"
,   [4] = "Episch"                   -- "Epic"
,   [5] = "Legendär"                -- "Legendary"
}

