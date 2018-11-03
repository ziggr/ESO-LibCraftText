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

                        -- Identify which list of crafting materials.
LibCraftText.MAT_SET_ID = {
    LIGHT           = "mat_lgt"
,   MEDIUM          = "mat_med"
,   HEAVY           = "mat_hvy"
,   WOOD            = "mat_wood"
,   JEWELRY         = "mat_jewl"
}
                        -- For less typing
local mat_lgt       = LibCraftText.MAT_SET_ID.LIGHT
local mat_med       = LibCraftText.MAT_SET_ID.MEDIUM
local mat_hvy       = LibCraftText.MAT_SET_ID.HEAVY
local mat_wood      = LibCraftText.MAT_SET_ID.WOOD
local mat_jewl      = LibCraftText.MAT_SET_ID.JEWELRY

                        -- Identify which list of traits.
LibCraftText.TRAIT_SET_ID = {
    WEAPON          = "trait_weap"
,   ARMOR           = "trait_armr"
,   JEWELRY         = "trait_jewl"
}
                        -- For less typing
local trait_weap    = LibCraftText.TRAIT_SET_ID.WEAPON
local trait_armr    = LibCraftText.TRAIT_SET_ID.ARMOR
local trait_jewl    = LibCraftText.TRAIT_SET_ID.JEWELRY


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
--                  throughout different languages. Or the particularly evil
--                  JP Japanese ring, which uses "リング" (phonetic "ringu")
--                  at the crafting station, but kanji "指輪" (yubi-wa, aka
--                  finger-ring) within daily crafting request condition text.
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
-- name_2           FR French has a typo for Sash: "baudier" when it should be "baudrier"
LibCraftText.ITEM = {
  ["H1_AXE"         ] = { name="axe"                  , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "axe"
, ["H1_MACE"        ] = { name="mace"                 , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "mace"
, ["H1_SWORD"       ] = { name="sword"                , master_name="Sword"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="battle axe"           , master_name="Battle Axe"                , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="maul"                 , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="greatsword"           , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "greatsword"
, ["DAGGER"         ] = { name="dagger"               , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "dagger"
, ["CUIRASS"        ] = { name="cuirass"              , master_name="Cuirass"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "cuirass"
, ["SABATONS"       ] = { name="sabatons"             , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="gauntlets"            , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "gauntlets"
, ["HELM"           ] = { name="helm"                 , master_name="Helm"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "helm"
, ["GREAVES"        ] = { name="greaves"              , master_name="Greaves"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "greaves"
, ["PAULDRON"       ] = { name="pauldron"             , master_name="Pauldron"                  , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "pauldron"
, ["GIRDLE"         ] = { name="girdle"               , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="Robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "robe"
, ["JERKIN"         ] = { name="jerkin"               , master_name="Jerkin"                    , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "jerkin"
, ["SHOES"          ] = { name="shoes"                , master_name="Shoes"                     , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "shoes"
, ["GLOVES"         ] = { name="gloves"               , master_name="Gloves"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "gloves"
, ["HAT"            ] = { name="hat"                  , master_name="Hat"                       , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "hat"
, ["BREECHES"       ] = { name="breeches"             , master_name="Breeches"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "breeches"
, ["EPAULETS"       ] = { name="epaulets"             , master_name="Epaulets"                  , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "epaulets"
, ["SASH"           ] = { name="sash"                 , master_name="Sash"                      , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2=$ITEM_CL_B08} -- "sash"
, ["JACK"           ] = { name="jack"                 , master_name="Jack"                      , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "jack"
, ["BOOTS"          ] = { name="boots"                , master_name="Boots"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "boots"
, ["BRACERS"        ] = { name="bracers"              , master_name="Bracers"                   , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "bracers"
, ["HELMET"         ] = { name="helmet"               , master_name="Helmet"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "helmet"
, ["GUARDS"         ] = { name="guards"               , master_name="Guards"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "guards"
, ["ARM_COPS"       ] = { name="arm cops"             , master_name="Arm Cops"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "arm cops"
, ["BELT"           ] = { name="belt"                 , master_name="Belt"                      , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "belt"

, ["BOW"            ] = { name="bow"                  , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="inferno staff"        , master_name="Inferno Staff"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="ice staff"            , master_name="Ice Staff"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="lightning staff"      , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="restoration staff"    , master_name="Restoration Staff"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "restoration staff"
, ["SHIELD"         ] = { name="shield"               , master_name="Shield"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr } -- "shield"

, ["NECKLACE"       ] = { name="necklace"             , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "necklace"
, ["RING"           ] = { name="ring"                 , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "ring"
}


-- Materials for Craftable Gear ----------------------------------------------
--
-- Answer the question "what material does this crafting quest require?"
-- Rubetite? Jute? Maple?
--
-- name             string that appears in material requested in daily
--                  crafting quests and master writ conditions.
--
-- level_index      ordinal 1..10 (or 1..5) to sort materials by level.
--
-- material_index   crafting index passed as an argument to ZOS API functions
--                  like GetSmithingPatternResultLink() and others
--
-- master_writ2     value for `writ2` field in sealed master writ item links.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- mat_set_id       What set of crafting materials is this material in?
--
-- name_2           A second name to search for when parsing materials from
--                  writ text. FR French uses "soie ancestrales" for the main
--                  name of Ancestor Silk, but strips the plural "s" when
--                  used as an adjective for a singular crafting item.
--

LibCraftText.MATERIAL = {
  ["IRON"          ] = { name="iron"              , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy   } -- "iron"
, ["STEEL"         ] = { name="steel"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy   } -- "steel"
, ["ORICHALC"      ] = { name="orichalc"          , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy   } -- "orichalc"
, ["DWARVEN"       ] = { name="dwarven"           , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy   } -- "dwarven"
, ["EBON"          ] = { name="ebon"              , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy   } -- "ebon"
, ["CALCINIUM"     ] = { name="calcinium"         , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy   } -- "calcinium"
, ["GALATITE"      ] = { name="galatite"          , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy   } -- "galatite"
, ["QUICKSILVER"   ] = { name="quicksilver"       , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy   } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="voidsteel"         , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy   } -- "voidsteel"
, ["RUBEDITE"      ] = { name="Rubedite"          , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy   } -- "Rubedite"

, ["HOMESPUN"      ] = { name="homespun"          , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  } -- "homespun"
, ["LINEN"         ] = { name="linen"             , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  } -- "linen"
, ["COTTON"        ] = { name="cotton"            , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  } -- "cotton"
, ["SPIDERSILK"    ] = { name="spidersilk"        , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="ebonthread"        , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  } -- "ebonthread"
, ["KRESH"         ] = { name="kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  } -- "kresh"
, ["IRONTHREAD"    ] = { name="ironthread"        , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="silverweave"       , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="shadowspun"        , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="Ancestor Silk"     , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt , name_2="Ancestor Silk" B } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="rawhide"           , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  } -- "rawhide"
, ["HIDE"          ] = { name="hide"              , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  } -- "hide"
, ["LEATHER"       ] = { name="leather"           , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  } -- "leather"
, ["FULL_LEATHER"  ] = { name="full-leather"      , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  } -- "full-leather"
, ["FELL"          ] = { name="fell"              , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  } -- "fell"
, ["BRIGANDINE"    ] = { name="brigandine"        , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  } -- "brigandine"
, ["IRONHIDE"      ] = { name="ironhide"          , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  } -- "ironhide"
, ["SUPERB"        ] = { name="superb"            , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  } -- "superb"
, ["SHADOWHIDE"    ] = { name="shadowhide"        , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="Rubedo Leather"    , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="maple"             , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood  } -- "maple"
, ["OAK"           ] = { name="oak"               , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood  } -- "oak"
, ["BEECH"         ] = { name="beech"             , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood  } -- "beech"
, ["HICKORY"       ] = { name="hickory"           , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood  } -- "hickory"
, ["YEW"           ] = { name="yew"               , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood  } -- "yew"
, ["BIRCH"         ] = { name="birch"             , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood  } -- "birch"
, ["ASH"           ] = { name="ash"               , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood  } -- "ash"
, ["MAHOGANY"      ] = { name="mahogany"          , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="nightwood"         , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="Ruby Ash"          , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="pewter"            , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl  } -- "pewter"
, ["COPPER"        ] = { name="copper"            , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl  } -- "copper"
, ["SILVER"        ] = { name="silver"            , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl  } -- "silver"
, ["ELECTRUM"      ] = { name="electrum"          , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl  } -- "electrum"
, ["PLATINUM"      ] = { name="platinum"          , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl  } -- "platinum"
}


-- Quest Titles --------------------------------------------------------------

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Заказ кузнецу"                  -- "Blacksmith Writ"
,   [cl] = "Заказ портному"                 -- "Clothier Writ"
,   [en] = "Заказ зачарователю"             -- "Enchanter Writ"
,   [al] = "Заказ алхимику"                 -- "Alchemist Writ"
,   [pr] = "Заказ снабженцу"                -- "Provisioner Writ"
,   [ww] = "Заказ столяру"                  -- "Woodworker Writ"
,   [jw] = "Заказ ювелиру"                  -- "Jewelry Crafting Writ"
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
    [bs] = { "Искусные латы"                      -- "A Masterful Plate"
           , "Искусное оружие"                  } -- "A Masterful Weapon"
,   [cl] = { "Искусные тканевые доспехи"          -- "Masterful Tailoring"
           , "Искусные кожаные доспехи"         } -- "Masterful Leatherwear"
,   [en] = { "Искусный глиф"                    } -- "A Masterful Glyph"
,   [al] = { "Искусное варево"                  } -- "A Masterful Concoction"
,   [pr] = { "Искусный пир"                     } -- "A Masterful Feast"
,   [ww] = { "Искусный щит"                       -- "A Masterful Shield"
           , "Искусное оружие"                  } -- "A Masterful Weapon"
,   [jw] = { "Искусные ювелирные изделия"       } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Качество"                        -- "Quality"
,   ["set"    ] =  "Комплект"                        -- "Set"
,   ["style"  ] =  "Стиль"                           -- "Style"
,   ["trait"  ] =  "Особенность"                     -- "Trait"
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
    [1] = "Обычное"                  -- "Normal"
,   [2] = "Хорошее"                  -- "Fine"
,   [3] = "Превосходное"             -- "Superior"
,   [4] = "Эпическое"                -- "Epic"
,   [5] = "Легендарное"              -- "Legendary"
}

