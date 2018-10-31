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
    [bs] = "Blacksmith Writ"                -- "Blacksmith Writ"
,   [cl] = "Clothier Writ"                  -- "Clothier Writ"
,   [en] = "Enchanter Writ"                 -- "Enchanter Writ"
,   [al] = "Alchemist Writ"                 -- "Alchemist Writ"
,   [pr] = "Provisioner Writ"               -- "Provisioner Writ"
,   [ww] = "Woodworker Writ"                -- "Woodworker Writ"
,   [jw] = "Jewelry Crafting Writ"          -- "Jewelry Crafting Writ"
}

                        -- Identify which list of crafting materials.
LibCraftText.MAT_SET_ID = {
  ["LIGHT"  ] = "mat_lgt"
, ["MEDIUM" ] = "mat_med"
, ["HEAVY"  ] = "mat_hvy"
, ["WOOD"   ] = "wd"
, ["JEWELRY"] = "jw"
}
                        -- For less typing
local mat_lgt  = LibCraftText.MAT_SET_ID.LIGHT
local mat_med  = LibCraftText.MAT_SET_ID.MEDIUM
local mat_hvy  = LibCraftText.MAT_SET_ID.HEAVY
local mat_wood = LibCraftText.MAT_SET_ID.WOOD
local mat_jewl = LibCraftText.MAT_SET_ID.JEWELRY

                        -- Identify which list of traits.
LibCraftText.TRAIT_SET_ID = {
    ["WEAPON" ] = "trait_weap"
,   ["ARMOR"  ] = "trait_armr"
,   ["JEWELRY"] = "trait_jewl"
}
                        -- For less typing
local trait_weap = LibCraftText.TRAIT_SET_ID.WEAPON
local trait_armr = LibCraftText.TRAIT_SET_ID.ARMOR
local trait_jewl = LibCraftText.TRAIT_SET_ID.JEWELRY


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
  ["H1_AXE"         ] = { name="ascia"                , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "axe"
, ["H1_MACE"        ] = { name="mazza"                , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "mace"
, ["H1_SWORD"       ] = { name="spada"                , master_name="Spada"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="ascia da battaglia"    , master_name="Grande Ascia"              , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="maglio"               , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="spadone"              , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "greatsword"
, ["DAGGER"         ] = { name="pugnale"              , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "dagger"
, ["CUIRASS"        ] = { name="corazza"              , master_name="Corazza"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "cuirass"
, ["SABATONS"       ] = { name="schinieri"            , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="mittene"              , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "gauntlets"
, ["HELM"           ] = { name="elmo"                 , master_name="Elmo"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "helm"
, ["GREAVES"        ] = { name="gambali"              , master_name="Gambali"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "greaves"
, ["PAULDRON"       ] = { name="spallaccio"           , master_name="Spallaccio"                , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "pauldron"
, ["GIRDLE"         ] = { name="cinturone"            , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "girdle"

, ["ROBE"           ] = { name="veste"                , master_name="Veste"                     , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "robe"
, ["JERKIN"         ] = { name="giaco"                , master_name="Giaco"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "jerkin"
, ["SHOES"          ] = { name="scarpe"               , master_name="Scarpe"                    , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "shoes"
, ["GLOVES"         ] = { name="guanti"               , master_name="Guanti"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "gloves"
, ["HAT"            ] = { name="cappello"             , master_name="Cappello"                  , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "hat"
, ["BREECHES"       ] = { name="calzoni"              , master_name="Calzoni"                   , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "breeches"
, ["EPAULETS"       ] = { name="coprispalle"          , master_name="Coprispalle"               , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "epaulets"
, ["SASH"           ] = { name="fascia"               , master_name="Fascia"                    , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "sash"
, ["JACK"           ] = { name="corpetto"             , master_name="Corpetto"                  , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "jack"
, ["BOOTS"          ] = { name="stivali"              , master_name="Stivali"                   , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "boots"
, ["BRACERS"        ] = { name="bracciali"            , master_name="Bracciali"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "bracers"
, ["HELMET"         ] = { name="elmetto"              , master_name="Elmetto"                   , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "helmet"
, ["GUARDS"         ] = { name="pantaloni"            , master_name="Pantaloni"                 , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "guards"
, ["ARM_COPS"       ] = { name="spalline"             , master_name="Spalline"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "arm cops"
, ["BELT"           ] = { name="cintura"              , master_name="Cintura"                   , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "belt"

, ["BOW"            ] = { name="arco"                 , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="bastone del fuoco"    , master_name="Bastone del Fuoco"         , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="bastone del gelo"     , master_name="Frost Staff"               , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="bastone del fulmine"    , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="bastone di cura"      , master_name="Healing Staff"             , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "restoration staff"
, ["SHIELD"         ] = { name="scudo"                , master_name="Scudo"                     , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr } -- "shield"

, ["NECKLACE"       ] = { name="collana"              , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "necklace"
, ["RING"           ] = { name="anello"               , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "ring"
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
  ["IRON"          ] = { name="iron"              , crafting_type=bs, mat_set_id=mat_hvy , material_index= 1, master_writ2=  1, level_index= 1  } -- "iron"
, ["STEEL"         ] = { name="steel"             , crafting_type=bs, mat_set_id=mat_hvy , material_index= 8, master_writ2=  9, level_index= 2  } -- "steel"
, ["ORICHALC"      ] = { name="orichalc"          , crafting_type=bs, mat_set_id=mat_hvy , material_index=13, master_writ2=156, level_index= 3  } -- "orichalc"
, ["DWARVEN"       ] = { name="dwarven"           , crafting_type=bs, mat_set_id=mat_hvy , material_index=18, master_writ2=160, level_index= 4  } -- "dwarven"
, ["EBON"          ] = { name="ebon"              , crafting_type=bs, mat_set_id=mat_hvy , material_index=23, master_writ2=164, level_index= 5  } -- "ebon"
, ["CALCINIUM"     ] = { name="calcinium"         , crafting_type=bs, mat_set_id=mat_hvy , material_index=26, master_writ2=168, level_index= 6  } -- "calcinium"
, ["GALATITE"      ] = { name="galatite"          , crafting_type=bs, mat_set_id=mat_hvy , material_index=29, master_writ2=172, level_index= 7  } -- "galatite"
, ["QUICKSILVER"   ] = { name="quicksilver"       , crafting_type=bs, mat_set_id=mat_hvy , material_index=32, master_writ2=176, level_index= 8  } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="voidsteel"         , crafting_type=bs, mat_set_id=mat_hvy , material_index=34, master_writ2=180, level_index= 9  } -- "voidsteel"
, ["RUBEDITE"      ] = { name="Rubedite"          , crafting_type=bs, mat_set_id=mat_hvy , material_index=40, master_writ2=188, level_index=10  } -- "Rubedite"

, ["HOMESPUN"      ] = { name="homespun"          , crafting_type=cl, mat_set_id=mat_lgt , material_index= 1, master_writ2=  5, level_index= 1 } -- "homespun"
, ["LINEN"         ] = { name="linen"             , crafting_type=cl, mat_set_id=mat_lgt , material_index= 8, master_writ2= 45, level_index= 2 } -- "linen"
, ["COTTON"        ] = { name="cotton"            , crafting_type=cl, mat_set_id=mat_lgt , material_index=13, master_writ2= 47, level_index= 3 } -- "cotton"
, ["SPIDERSILK"    ] = { name="spidersilk"        , crafting_type=cl, mat_set_id=mat_lgt , material_index=18, master_writ2= 49, level_index= 4 } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="ebonthread"        , crafting_type=cl, mat_set_id=mat_lgt , material_index=23, master_writ2= 51, level_index= 5 } -- "ebonthread"
, ["KRESH"         ] = { name="kresh"             , crafting_type=cl, mat_set_id=mat_lgt , material_index=26, master_writ2=125, level_index= 6 } -- "kresh"
, ["IRONTHREAD"    ] = { name="ironthread"        , crafting_type=cl, mat_set_id=mat_lgt , material_index=29, master_writ2=126, level_index= 7 } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="silverweave"       , crafting_type=cl, mat_set_id=mat_lgt , material_index=32, master_writ2=127, level_index= 8 } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="shadowspun"        , crafting_type=cl, mat_set_id=mat_lgt , material_index=34, master_writ2=128, level_index= 9 } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="Ancestor Silk"     , crafting_type=cl, mat_set_id=mat_lgt , material_index=40, master_writ2=194, level_index=10 } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="rawhide"           , crafting_type=cl, mat_set_id=mat_med , material_index= 1, master_writ2=148, level_index= 1 } -- "rawhide"
, ["HIDE"          ] = { name="hide"              , crafting_type=cl, mat_set_id=mat_med , material_index= 8, master_writ2=154, level_index= 2 } -- "hide"
, ["LEATHER"       ] = { name="leather"           , crafting_type=cl, mat_set_id=mat_med , material_index=13, master_writ2=158, level_index= 3 } -- "leather"
, ["FULL_LEATHER"  ] = { name="full-leather"      , crafting_type=cl, mat_set_id=mat_med , material_index=18, master_writ2=162, level_index= 4 } -- "full-leather"
, ["FELL"          ] = { name="fell"              , crafting_type=cl, mat_set_id=mat_med , material_index=23, master_writ2=166, level_index= 5 } -- "fell"
, ["BRIGANDINE"    ] = { name="brigandine"        , crafting_type=cl, mat_set_id=mat_med , material_index=26, master_writ2=170, level_index= 6 } -- "brigandine"
, ["IRONHIDE"      ] = { name="ironhide"          , crafting_type=cl, mat_set_id=mat_med , material_index=29, master_writ2=174, level_index= 7 } -- "ironhide"
, ["SUPERB"        ] = { name="superb"            , crafting_type=cl, mat_set_id=mat_med , material_index=32, master_writ2=131, level_index= 8 } -- "superb"
, ["SHADOWHIDE"    ] = { name="shadowhide"        , crafting_type=cl, mat_set_id=mat_med , material_index=34, master_writ2=132, level_index= 9 } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="Rubedo Leather"    , crafting_type=cl, mat_set_id=mat_med , material_index=40, master_writ2=190, level_index=10 } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="maple"             , crafting_type=ww, mat_set_id=mat_wood, material_index= 1, master_writ2=  2, level_index= 1  } -- "maple"
, ["OAK"           ] = { name="oak"               , crafting_type=ww, mat_set_id=mat_wood, material_index= 8, master_writ2= 18, level_index= 2  } -- "oak"
, ["BEECH"         ] = { name="beech"             , crafting_type=ww, mat_set_id=mat_wood, material_index=13, master_writ2= 20, level_index= 3  } -- "beech"
, ["HICKORY"       ] = { name="hickory"           , crafting_type=ww, mat_set_id=mat_wood, material_index=18, master_writ2= 22, level_index= 4  } -- "hickory"
, ["YEW"           ] = { name="yew"               , crafting_type=ww, mat_set_id=mat_wood, material_index=23, master_writ2= 24, level_index= 5  } -- "yew"
, ["BIRCH"         ] = { name="birch"             , crafting_type=ww, mat_set_id=mat_wood, material_index=26, master_writ2=133, level_index= 6  } -- "birch"
, ["ASH"           ] = { name="ash"               , crafting_type=ww, mat_set_id=mat_wood, material_index=29, master_writ2=134, level_index= 7  } -- "ash"
, ["MAHOGANY"      ] = { name="mahogany"          , crafting_type=ww, mat_set_id=mat_wood, material_index=32, master_writ2=135, level_index= 8  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="nightwood"         , crafting_type=ww, mat_set_id=mat_wood, material_index=34, master_writ2=136, level_index= 9  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="Ruby Ash"          , crafting_type=ww, mat_set_id=mat_wood, material_index=40, master_writ2=192, level_index=10  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="pewter"            , crafting_type=jw, mat_set_id=mat_jewl, material_index= 1, master_writ2=  6, level_index= 1  } -- "pewter"
, ["COPPER"        ] = { name="copper"            , crafting_type=jw, mat_set_id=mat_jewl, material_index=13, master_writ2= 56, level_index= 2  } -- "copper"
, ["SILVER"        ] = { name="silver"            , crafting_type=jw, mat_set_id=mat_jewl, material_index=26, master_writ2=137, level_index= 3  } -- "silver"
, ["ELECTRUM"      ] = { name="electrum"          , crafting_type=jw, mat_set_id=mat_jewl, material_index=33, master_writ2=139, level_index= 4  } -- "electrum"
, ["PLATINUM"      ] = { name="platinum"          , crafting_type=jw, mat_set_id=mat_jewl, material_index=40, master_writ2=255, level_index= 5  } -- "platinum"
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


-- Random Unsorted Stuff -----------------------------------------------------

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

LibCraftText.QUALITIES = {
    [1] = "Normale"                  -- "Normal"
,   [2] = "Buono"                    -- "Fine"
,   [3] = "Superiore"                -- "Superior"
,   [4] = "Epico"                    -- "Epic"
,   [5] = "Leggendario"              -- "Legendary"
}

