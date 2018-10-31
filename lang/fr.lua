LibCraftText = LibCraftText or {}


-- Table Setup ---------------------------------------------------------------
--
-- Constants and index values we use in later tables

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
  ["H1_AXE"         ] = { name="hache"                , master_name="hache"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="masse"                , master_name="masse"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="épée"               , master_name="épée"                    , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="hache de bataille"    , master_name="Hache de bataille"         , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="masse d'arme"         , master_name="masse d'arme"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="épée longue"        , master_name="épée longue"             , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="dague"                , master_name="dague"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="cuirasse"             , master_name="cuirasse"                  , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="solerets"             , master_name="Soleret"                   , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="gantelets"            , master_name="Gantelets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="heaume"               , master_name="casque"                    , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="grèves"              , master_name="Grèves"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="spallière"           , master_name="Spallière"                , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="gaine"                , master_name="gaine"                     , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="pourpoint"            , master_name="Pourpoint"                 , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="chaussures"           , master_name="Chaussures"                , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="gants"                , master_name="Gants"                     , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="chapeau"              , master_name="chapeau"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="braies"               , master_name="Braies"                    , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="épaulettes"          , master_name="Épaulettes"               , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="baudrier"             , master_name="Baudrier"                  , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="gilet"                , master_name="gilet"                     , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="bottes"               , master_name="Bottes"                    , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="brassards"            , master_name="Brassards"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="casque"               , master_name="casque"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="gardes"               , master_name="Gardes"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="coques d'épaules"    , master_name="Coques d'épaules"         , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="ceinture"             , master_name="ceinture"                  , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="arc"                  , master_name="arc"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="bâton infernal"      , master_name="bâton infernal"           , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="bâton de glace"      , master_name="Bâton de glace"           , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="bâton de foudre"     , master_name="Bâton de foudre"          , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="bâton de rétablissement"    , master_name="Bâton de rétablissement"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="bouclier"             , master_name="bouclier"                  , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=wood, trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="collier"              , master_name="Collier"                   , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jewl, trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="anneau"               , master_name="Anneau"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jewl, trait_set_id=jewl } -- "ring"
}


-- Materials for Craftable Gear ----------------------------------------------
--
-- Answer the question "what material does this crafting quest require?"
-- Rubetite? Jute? Maple?
--
-- name             string that appears in material requested in daily
--                  crafting quests and master writ conditions.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- mat_set_id       What set of crafting materials is this material in?
--
-- material_index   crafting index passed as an argument to ZOS API functions
--                  like GetSmithingPatternResultLink() and others
--
-- master_writ2     value for `writ2` field in sealed master writ item links.
--
-- level_index      ordinal 1..10 (or 1..5) to sort materials by level.
--

LibCraftText.MATERIAL = {
  ["IRON"          ] = { name="fer"               , crafting_type=bs, mat_set_id=hvy , material_index= 1, master_writ2=  1, level_index= 1  } -- "iron"
, ["STEEL"         ] = { name="acier"             , crafting_type=bs, mat_set_id=hvy , material_index= 8, master_writ2=  9, level_index= 2  } -- "steel"
, ["ORICHALC"      ] = { name="orichalque"        , crafting_type=bs, mat_set_id=hvy , material_index=13, master_writ2=156, level_index= 3  } -- "orichalc"
, ["DWARVEN"       ] = { name="dwemère"          , crafting_type=bs, mat_set_id=hvy , material_index=18, master_writ2=160, level_index= 4  } -- "dwarven"
, ["EBON"          ] = { name="ébonite"          , crafting_type=bs, mat_set_id=hvy , material_index=23, master_writ2=164, level_index= 5  } -- "ebon"
, ["CALCINIUM"     ] = { name="calcinium"         , crafting_type=bs, mat_set_id=hvy , material_index=26, master_writ2=168, level_index= 6  } -- "calcinium"
, ["GALATITE"      ] = { name="galatite"          , crafting_type=bs, mat_set_id=hvy , material_index=29, master_writ2=172, level_index= 7  } -- "galatite"
, ["QUICKSILVER"   ] = { name="mercure"           , crafting_type=bs, mat_set_id=hvy , material_index=32, master_writ2=176, level_index= 8  } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="acier du néant"    , crafting_type=bs, mat_set_id=hvy , material_index=34, master_writ2=180, level_index= 9  } -- "voidsteel"
, ["RUBEDITE"      ] = { name="cuprite"           , crafting_type=bs, mat_set_id=hvy , material_index=40, master_writ2=188, level_index=10  } -- "Rubedite"

, ["HOMESPUN"      ] = { name="artisanales"       , crafting_type=cl, mat_set_id=lgt , material_index= 1, master_writ2=  5, level_index= 1 } -- "homespun"
, ["LINEN"         ] = { name="lin"               , crafting_type=cl, mat_set_id=lgt , material_index= 8, master_writ2= 45, level_index= 2 } -- "linen"
, ["COTTON"        ] = { name="coton"             , crafting_type=cl, mat_set_id=lgt , material_index=13, master_writ2= 47, level_index= 3 } -- "cotton"
, ["SPIDERSILK"    ] = { name="soie d'araignée"    , crafting_type=cl, mat_set_id=lgt , material_index=18, master_writ2= 49, level_index= 4 } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="fil d'ébonite"    , crafting_type=cl, mat_set_id=lgt , material_index=23, master_writ2= 51, level_index= 5 } -- "ebonthread"
, ["KRESH"         ] = { name="kresh"             , crafting_type=cl, mat_set_id=lgt , material_index=26, master_writ2=125, level_index= 6 } -- "kresh"
, ["IRONTHREAD"    ] = { name="fil de fer"        , crafting_type=cl, mat_set_id=lgt , material_index=29, master_writ2=126, level_index= 7 } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="fil d'argent"      , crafting_type=cl, mat_set_id=lgt , material_index=32, master_writ2=127, level_index= 8 } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="tissombre"         , crafting_type=cl, mat_set_id=lgt , material_index=34, master_writ2=128, level_index= 9 } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="soie ancestrales"    , crafting_type=cl, mat_set_id=lgt , material_index=40, master_writ2=194, level_index=10 } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="cuir brut"         , crafting_type=cl, mat_set_id=med , material_index= 1, master_writ2=148, level_index= 1 } -- "rawhide"
, ["HIDE"          ] = { name="peau"              , crafting_type=cl, mat_set_id=med , material_index= 8, master_writ2=154, level_index= 2 } -- "hide"
, ["LEATHER"       ] = { name="cuir"              , crafting_type=cl, mat_set_id=med , material_index=13, master_writ2=158, level_index= 3 } -- "leather"
, ["FULL_LEATHER"  ] = { name="cuir complet"      , crafting_type=cl, mat_set_id=med , material_index=18, master_writ2=162, level_index= 4 } -- "full-leather"
, ["FELL"          ] = { name="déchu"            , crafting_type=cl, mat_set_id=med , material_index=23, master_writ2=166, level_index= 5 } -- "fell"
, ["BRIGANDINE"    ] = { name="cuir clouté"      , crafting_type=cl, mat_set_id=med , material_index=26, master_writ2=170, level_index= 6 } -- "brigandine"
, ["IRONHIDE"      ] = { name="peau de fer"       , crafting_type=cl, mat_set_id=med , material_index=29, master_writ2=174, level_index= 7 } -- "ironhide"
, ["SUPERB"        ] = { name="superbe"           , crafting_type=cl, mat_set_id=med , material_index=32, master_writ2=131, level_index= 8 } -- "superb"
, ["SHADOWHIDE"    ] = { name="peau d'ombre"      , crafting_type=cl, mat_set_id=med , material_index=34, master_writ2=132, level_index= 9 } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="cuir pourpre"      , crafting_type=cl, mat_set_id=med , material_index=40, master_writ2=190, level_index=10 } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="érable"           , crafting_type=ww, mat_set_id=wood, material_index= 1, master_writ2=  2, level_index= 1  } -- "maple"
, ["OAK"           ] = { name="chêne"            , crafting_type=ww, mat_set_id=wood, material_index= 8, master_writ2= 18, level_index= 2  } -- "oak"
, ["BEECH"         ] = { name="hêtre"            , crafting_type=ww, mat_set_id=wood, material_index=13, master_writ2= 20, level_index= 3  } -- "beech"
, ["HICKORY"       ] = { name="noyer"             , crafting_type=ww, mat_set_id=wood, material_index=18, master_writ2= 22, level_index= 4  } -- "hickory"
, ["YEW"           ] = { name="if"                , crafting_type=ww, mat_set_id=wood, material_index=23, master_writ2= 24, level_index= 5  } -- "yew"
, ["BIRCH"         ] = { name="bouleau"           , crafting_type=ww, mat_set_id=wood, material_index=26, master_writ2=133, level_index= 6  } -- "birch"
, ["ASH"           ] = { name="frêne"            , crafting_type=ww, mat_set_id=wood, material_index=29, master_writ2=134, level_index= 7  } -- "ash"
, ["MAHOGANY"      ] = { name="acajou"            , crafting_type=ww, mat_set_id=wood, material_index=32, master_writ2=135, level_index= 8  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="bois de nuit"      , crafting_type=ww, mat_set_id=wood, material_index=34, master_writ2=136, level_index= 9  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="frêne roux"       , crafting_type=ww, mat_set_id=wood, material_index=40, master_writ2=192, level_index=10  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="étain"            , crafting_type=jw, mat_set_id=jewl, material_index= 1, master_writ2=  6, level_index= 1  } -- "pewter"
, ["COPPER"        ] = { name="cuivre"            , crafting_type=jw, mat_set_id=jewl, material_index=13, master_writ2= 56, level_index= 2  } -- "copper"
, ["SILVER"        ] = { name="argent"            , crafting_type=jw, mat_set_id=jewl, material_index=26, master_writ2=137, level_index= 3  } -- "silver"
, ["ELECTRUM"      ] = { name="électrum"         , crafting_type=jw, mat_set_id=jewl, material_index=33, master_writ2=139, level_index= 4  } -- "electrum"
, ["PLATINUM"      ] = { name="platine"           , crafting_type=jw, mat_set_id=jewl, material_index=40, master_writ2=255, level_index= 5  } -- "platinum"
}


-- Quest Titles --------------------------------------------------------------

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


-- Random Unsorted Stuff -----------------------------------------------------

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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Raffiné"                 -- "Fine"
,   [3] = "Supérieur"               -- "Superior"
,   [4] = "Épique"                  -- "Epic"
,   [5] = "Légendaire"              -- "Legendary"
}

