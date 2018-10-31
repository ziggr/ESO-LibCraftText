LibCraftText = LibCraftText or {}

                        -- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   or 1
local cl = CRAFTING_TYPE_CLOTHIER        or 2
local en = CRAFTING_TYPE_ENCHANTING      or 3
local al = CRAFTING_TYPE_ALCHEMY         or 4
local pr = CRAFTING_TYPE_PROVISIONING    or 5
local ww = CRAFTING_TYPE_WOODWORKING     or 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING or 7

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

                        -- Identify which list of crafting materials.
LibCraftText.MAT_SET_ID = {
  ["LIGHT"  ] = "lgt"
, ["MEDIUM" ] = "med"
, ["HEAVY"  ] = "hvy"
, ["WOOD"   ] = "wd"
, ["JEWELRY"] = "jw"
}
                        -- For less typing
local lgt = LibCraftText.MAT_SET_ID.LIGHT
local med = LibCraftText.MAT_SET_ID.MEDIUM
local hvy = LibCraftText.MAT_SET_ID.HEAVY
local ww  = LibCraftText.MAT_SET_ID.WOOD
local jw  = LibCraftText.MAT_SET_ID.JEWELRY

                        -- Identify which list of traits.
LibCraftText.TRAIT_SET_ID = {
    ["WEAPON" ] = "weap"
,   ["ARMOR"  ] = "arm"
,   ["JEWELRY"] = "jw"
}
                        -- For less typing
local weap = LibCraftText.TRAIT_SET_ID.WEAPON
local armr = LibCraftText.TRAIT_SET_ID.ARMOR
local jewl = LibCraftText.TRAIT_SET_ID.JEWELRY

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
    [hvy] =   { "fer"                -- "iron"
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
,   [lgt] =   { "artisanales"        -- "homespun"
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
,   [med] =   { "cuir brut"          -- "rawhide"
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
,   [ww ] =   { "érable"            -- "maple"
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
,   [jw ] =   { "étain"             -- "pewter"
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




-- Craftable Gear ------------------------------------------------------------
--
-- Answer the question "what gear item does this crafting quest require?"
-- An axe? Light robe? Wooden shield?

-- name             string that appears in daily crafting writs and tooltip
--                  text when crafting this item at a crafting station.
--
-- master_name      string that appears in a sealed master writ's tooltip,
--                  or an accepted master writ quest's conditions.
--                  SURPRISE! `master_name` does not always match `name`
--                  value in all languages. FR French heavy head piece
--                  is "heaume" most of the time, but "casque" in master writs.
--                  There are several examples of this mismatch, scattered
--                  throughout different languages.
--
-- pattern_index    crafting index passed as an argument to ZOS API functions
--                  like GetSmithingPatternInfo() and others.
--
-- master_writ1     value for `writ1` field in sealed master writ item links.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- mat_set_id       Which set of crafting materials to use for this item?
--
-- trait_set_id     Which set of traits apply to this item?
--
LibCraftText.ITEM = {
  ["H1_AXE"         ] = { name="hache"                , master_name="hache"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="masse"                , master_name="masse"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="épée"               , master_name="épée"                    , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="hache de bataille"    , master_name="Hache de bataille"         , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="masse d'arme"         , master_name="masse d'arme"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="épée longue"        , master_name="épée longue"             , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="dague"                , master_name="dague"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="cuirasse"             , master_name="cuirasse"                  , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="solerets"             , master_name="Soleret"                   , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="gantelets"            , master_name="Gantelets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="heaume"               , master_name="casque"                    , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="grèves"              , master_name="Grèves"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="spallière"           , master_name="Spallière"                , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="gaine"                , master_name="gaine"                     , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="pourpoint"            , master_name="Pourpoint"                 , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="chaussures"           , master_name="Chaussures"                , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="gants"                , master_name="Gants"                     , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="chapeau"              , master_name="chapeau"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="braies"               , master_name="Braies"                    , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="épaulettes"          , master_name="Épaulettes"               , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="baudrier"             , master_name="Baudrier"                  , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="gilet"                , master_name="gilet"                     , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="bottes"               , master_name="Bottes"                    , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="brassards"            , master_name="Brassards"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="casque"               , master_name="casque"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="gardes"               , master_name="Gardes"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="coques d'épaules"    , master_name="Coques d'épaules"         , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="ceinture"             , master_name="ceinture"                  , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="arc"                  , master_name="arc"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="bâton infernal"      , master_name="bâton infernal"           , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="bâton de glace"      , master_name="Bâton de glace"           , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="bâton de foudre"     , master_name="Bâton de foudre"          , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="bâton de rétablissement"    , master_name="Bâton de rétablissement"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="bouclier"             , master_name="bouclier"                  , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="collier"              , master_name="Collier"                   , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="anneau"               , master_name="Anneau"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
