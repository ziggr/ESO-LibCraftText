
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Commande de forge"              -- "Blacksmith Writ"
,   [cl] = "Commande de tailleur"           -- "Clothier Writ"
,   [en] = "Commandes d'enchantement"       -- "Enchanter Writ"
,   [al] = "Commande d'alchimie"            -- "Alchemist Writ"
,   [pr] = "Commande de cuisine"            -- "Provisioner Writ"
,   [ww] = "Commande de travail du bois"    -- "Woodworker Writ"
,   [jw] = "Commande de joaillerie"         -- "Jewelry Crafting Writ"
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
    [bs] = { "Une protection magistrale"          -- "A Masterful Plate"
           , "Une arme magistrale"              } -- "A Masterful Weapon"
,   [cl] = { "Une tenue magistrale"               -- "Masterful Tailoring"
           , "Un vêtement de cuir magistral"   } -- "Masterful Leatherwear"
,   [en] = { "Un glyphe magistral"              } -- "A Masterful Glyph"
,   [al] = { "Une concoction magistrale"        } -- "A Masterful Concoction"
,   [pr] = { "Un festin magistral"              } -- "A Masterful Feast"
,   [ww] = { "Un bouclier magistral"              -- "A Masterful Shield"
           , "Une arme magistrale"              } -- "A Masterful Weapon"
,   [jw] = { "Joaillerie magistrale"            } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualité"                        -- "Quality"
,   ["set"    ] =  "Ensemble"                        -- "Set"
,   ["style"  ] =  "Style"                           -- "Style"
,   ["trait"  ] =  "Trait"                           -- "Trait"
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"              -- "Rolis Hlaalu"
,   ["accept"]         = "<Accepter le contrat>"     -- "<Accept the contract.>"
,   ["finish"]         = "<Finir le travail.>"       -- "<Finish the job.>"
,   ["deliver_substr"] = "Livrez"                    -- "Deliver"

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
    ["bs" ] = { "fer"                -- "iron"
              , "acier"              -- "steel"
              , "orichalque"         -- "orichalc"
              , "dwemère"           -- "dwarven"
              , "ébonite"           -- "ebon"
              , "calcinium"          -- "calcinium"
              , "galatite"           -- "galatite"
              , "mercure"            -- "quicksilver"
              , "acier du néant"    -- "voidsteel"
              , "cuprite"            -- "Rubedite"
              }
,   ["lgt"] = { "artisanales"        -- "homespun"
              , "lin"                -- "linen"
              , "coton"              -- "cotton"
              , "soie d'araignée"    -- "spidersilk"
              , "fil d'ébonite"     -- "ebonthread"
              , "kresh"              -- "kresh"
              , "fil de fer"         -- "ironthread"
              , "fil d'argent"       -- "silverweave"
              , "tissombre"          -- "shadowspun"
              , "soie ancestrales"    -- "Ancestor Silk"
              }
,   ["med"] = { "cuir brut"          -- "rawhide"
              , "peau"               -- "hide"
              , "cuir"               -- "leather"
              , "cuir complet"       -- "full-leather"
              , "déchu"             -- "fell"
              , "cuir clouté"       -- "brigandine"
              , "peau de fer"        -- "ironhide"
              , "superbe"            -- "superb"
              , "peau d'ombre"       -- "shadowhide"
              , "cuir pourpre"       -- "Rubedo Leather"
              }
,   ["ww" ] = { "érable"            -- "maple"
              , "chêne"             -- "oak"
              , "hêtre"             -- "beech"
              , "noyer"              -- "hickory"
              , "if"                 -- "yew"
              , "bouleau"            -- "birch"
              , "frêne"             -- "ash"
              , "acajou"             -- "mahogany"
              , "bois de nuit"       -- "nightwood"
              , "frêne roux"        -- "Ruby Ash"
              }
,   ["jw" ] = { "étain"             -- "pewter"
              , "cuivre"             -- "copper"
              , "argent"             -- "silver"
              , "électrum"          -- "electrum"
              , "platine"            -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "hache"                     -- "Axe"
         , [56] = "masse"                     -- "Mace"
         , [59] = "épée"                    -- "Sword"
         , [68] = "Hache de bataille"         -- "Battle Axe"
         , [69] = "masse d'arme"              -- "Maul"
         , [67] = "épée longue"             -- "Greatsword"
         , [62] = "dague"                     -- "Dagger"
         , [46] = "cuirasse"                  -- "Cuirass"
         , [50] = "Soleret"                   -- "Sabatons"
         , [52] = "Gantelets"                 -- "Gauntlets"
         , [44] = "casque"                    -- "Helm"
         , [49] = "Grèves"                   -- "Greaves"
         , [47] = "Spallière"                -- "Pauldron"
         , [48] = "gaine"                     -- "Girdle"
         }
, [cl] = {
           [28] = "robe"                      -- "Robe"
         , [75] = "Pourpoint"                 -- "Jerkin"
         , [32] = "Chaussures"                -- "Shoes"
         , [34] = "Gants"                     -- "Gloves"
         , [26] = "chapeau"                   -- "Hat"
         , [31] = "Braies"                    -- "Breeches"
         , [29] = "Épaulettes"               -- "Epaulets"
         , [30] = "Baudrier"                  -- "Sash"
         , [37] = "gilet"                     -- "Jack"
         , [41] = "Bottes"                    -- "Boots"
         , [43] = "Brassards"                 -- "Bracers"
         , [35] = "casque"                    -- "Helmet"
         , [40] = "Gardes"                    -- "Guards"
         , [38] = "Coques d'épaules"         -- "Arm Cops"
         , [39] = "ceinture"                  -- "Belt"
         }
, [ww] = {
           [70] = "arc"                       -- "Bow"
         , [72] = "bâton infernal"           -- "Inferno Staff"
         , [73] = "Bâton de glace"           -- "Ice Staff"
         , [74] = "Bâton de foudre"          -- "Lightning Staff"
         , [71] = "Bâton de rétablissement"    -- "Restoration Staff"
         , [65] = "bouclier"                  -- "Shield"
         }
, [jw] = {
           [18] = "Collier"                   -- "Necklace"
         , [24] = "Anneau"                    -- "Ring"
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
           [ 1] = "hache"                     -- "axe"
         , [ 2] = "masse"                     -- "mace"
         , [ 3] = "épée"                    -- "wword"
         , [ 4] = "hache de bataille"         -- "battle Axe"
         , [ 5] = "masse d'arme"              -- "maul"
         , [ 6] = "épée longue"             -- "greatsword"
         , [ 7] = "dague"                     -- "dagger"
         , [ 8] = "cuirasse"                  -- "cuirass"
         , [ 9] = "solerets"                  -- "sabatons"
         , [10] = "gantelets"                 -- "gauntlets"
         , [11] = "heaume"                    -- "helm"
         , [12] = "grèves"                   -- "greaves"
         , [13] = "spallière"                -- "pauldron"
         , [14] = "gaine"                     -- "girdle"
         }
, [cl] = {
           [ 1] = "robe"                      -- "robe"
         , [ 2] = "pourpoint"                 -- "jerkin"
         , [ 3] = "chaussures"                -- "shoes"
         , [ 4] = "gants"                     -- "gloves"
         , [ 5] = "chapeau"                   -- "hat"
         , [ 6] = "braies"                    -- "breeches"
         , [ 7] = "épaulettes"               -- "epaulets"
         , [ 8] = "baudrier"                  -- "sash"
         , [ 9] = "gilet"                     -- "jack"
         , [10] = "bottes"                    -- "boots"
         , [11] = "brassards"                 -- "bracers"
         , [12] = "casque"                    -- "helmet"
         , [13] = "gardes"                    -- "guards"
         , [14] = "coques d'épaules"         -- "arm cops"
         , [15] = "ceinture"                  -- "belt"
         }
, [ww] = {
           [ 1] = "arc"                       -- "bow"
         , [ 3] = "bâton infernal"           -- "inferno staff"
         , [ 4] = "bâton de glace"           -- "ice staff"
         , [ 5] = "bâton de foudre"          -- "lightning staff"
         , [ 6] = "bâton de rétablissement"    -- "restoration staff"
         , [ 2] = "bouclier"                  -- "shield"
         }
, [jw] = {
           [ 2] = "collier"                   -- "necklace"
         , [ 1] = "anneau"                    -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Raffiné"                 -- "Fine"
,   [3] = "Supérieur"               -- "Superior"
,   [4] = "Épique"                  -- "Epic"
,   [5] = "Légendaire"              -- "Legendary"
}

