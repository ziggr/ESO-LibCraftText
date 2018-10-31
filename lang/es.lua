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
    [bs] = "Encargo de herrería"           -- "Blacksmith Writ"
,   [cl] = "Encargo de sastrería"          -- "Clothier Writ"
,   [en] = "Encargo de encantamiento"       -- "Enchanter Writ"
,   [al] = "Encargo de alquimia"            -- "Alchemist Writ"
,   [pr] = "Encargo de provisiones"         -- "Provisioner Writ"
,   [ww] = "Encargo de carpintería"        -- "Woodworker Writ"
,   [jw] = "Encargo de artesanía de joyería"    -- "Jewelry Crafting Writ"
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
  ["H1_AXE"         ] = { name="Hacha"                , master_name="Hacha"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="Espada"               , master_name="Espada"                    , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="hacha de batalla"     , master_name="Hacha de batalla"          , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="Mandoble"             , master_name="Mandoble"                  , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="Daga"                 , master_name="Daga"                      , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy , trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="Coraza"               , master_name="Coraza"                    , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="escarpes"             , master_name="Escarpes"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="guanteletes"          , master_name="Guanteletes"               , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="yelmo"                , master_name="Casco"                     , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="grebas"               , master_name="Grebas"                    , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="espaldarones"         , master_name="Espaldarones"              , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="Faja"                 , master_name="Faja"                      , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy , trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="Túnica"              , master_name="Túnica"                   , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="Jubón"               , master_name="Jubón"                    , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="Zapatos"              , master_name="Zapatos"                   , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="guantes"              , master_name="Guantes"                   , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="Capucha"              , master_name="Capucha"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="calzones"             , master_name="Calzones"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="Cubrehombros"         , master_name="Cubrehombros"              , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="banda"                , master_name="Banda"                     , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt , trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="pechera"              , master_name="Pechera"                   , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="botas"                , master_name="Botas"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="brazales"             , master_name="Brazales"                  , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="Casco"                , master_name="Casco"                     , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="musleras"             , master_name="Musleras"                  , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="Hombreras"            , master_name="Hombreras"                 , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="Cinturón"            , master_name="Cinturón"                 , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med , trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="Arco"                 , master_name="Arco"                      , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="Vara infernal"        , master_name="Vara infernal"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="vara glaciar"         , master_name="Vara glaciar"              , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="vara eléctrica"      , master_name="Vara eléctrica"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="vara restauradora"    , master_name="Vara restauradora"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=wood, trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="Escudo"               , master_name="Escudo"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=wood, trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="collar"               , master_name="Collar"                    , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jewl, trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="anillo"               , master_name="Anillo"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jewl, trait_set_id=jewl } -- "ring"
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
  ["IRON"          ] = { name="hierro"            , crafting_type=bs, mat_set_id=hvy , material_index= 1, master_writ2=  1, level_index= 1  } -- "iron"
, ["STEEL"         ] = { name="acero"             , crafting_type=bs, mat_set_id=hvy , material_index= 8, master_writ2=  9, level_index= 2  } -- "steel"
, ["ORICHALC"      ] = { name="oricalco"          , crafting_type=bs, mat_set_id=hvy , material_index=13, master_writ2=156, level_index= 3  } -- "orichalc"
, ["DWARVEN"       ] = { name="acero enano"       , crafting_type=bs, mat_set_id=hvy , material_index=18, master_writ2=160, level_index= 4  } -- "dwarven"
, ["EBON"          ] = { name="ébano"            , crafting_type=bs, mat_set_id=hvy , material_index=23, master_writ2=164, level_index= 5  } -- "ebon"
, ["CALCINIUM"     ] = { name="calcinio"          , crafting_type=bs, mat_set_id=hvy , material_index=26, master_writ2=168, level_index= 6  } -- "calcinium"
, ["GALATITE"      ] = { name="galatita"          , crafting_type=bs, mat_set_id=hvy , material_index=29, master_writ2=172, level_index= 7  } -- "galatite"
, ["QUICKSILVER"   ] = { name="azogue"            , crafting_type=bs, mat_set_id=hvy , material_index=32, master_writ2=176, level_index= 8  } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="acero del vacío"    , crafting_type=bs, mat_set_id=hvy , material_index=34, master_writ2=180, level_index= 9  } -- "voidsteel"
, ["RUBEDITE"      ] = { name="rubedita"          , crafting_type=bs, mat_set_id=hvy , material_index=40, master_writ2=188, level_index=10  } -- "Rubedite"

, ["HOMESPUN"      ] = { name="tejido artesanal"    , crafting_type=cl, mat_set_id=lgt , material_index= 1, master_writ2=  5, level_index= 1 } -- "homespun"
, ["LINEN"         ] = { name="lino"              , crafting_type=cl, mat_set_id=lgt , material_index= 8, master_writ2= 45, level_index= 2 } -- "linen"
, ["COTTON"        ] = { name="algodón"          , crafting_type=cl, mat_set_id=lgt , material_index=13, master_writ2= 47, level_index= 3 } -- "cotton"
, ["SPIDERSILK"    ] = { name="seda de araña"    , crafting_type=cl, mat_set_id=lgt , material_index=18, master_writ2= 49, level_index= 4 } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="hilo de ébano"    , crafting_type=cl, mat_set_id=lgt , material_index=23, master_writ2= 51, level_index= 5 } -- "ebonthread"
, ["KRESH"         ] = { name="kresh"             , crafting_type=cl, mat_set_id=lgt , material_index=26, master_writ2=125, level_index= 6 } -- "kresh"
, ["IRONTHREAD"    ] = { name="hilo de hierro"    , crafting_type=cl, mat_set_id=lgt , material_index=29, master_writ2=126, level_index= 7 } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="hilo de plata"     , crafting_type=cl, mat_set_id=lgt , material_index=32, master_writ2=127, level_index= 8 } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="tejido sombrío"    , crafting_type=cl, mat_set_id=lgt , material_index=34, master_writ2=128, level_index= 9 } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="seda ancestral"    , crafting_type=cl, mat_set_id=lgt , material_index=40, master_writ2=194, level_index=10 } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="piel cruda"        , crafting_type=cl, mat_set_id=med , material_index= 1, master_writ2=148, level_index= 1 } -- "rawhide"
, ["HIDE"          ] = { name="piel"              , crafting_type=cl, mat_set_id=med , material_index= 8, master_writ2=154, level_index= 2 } -- "hide"
, ["LEATHER"       ] = { name="cuero"             , crafting_type=cl, mat_set_id=med , material_index=13, master_writ2=158, level_index= 3 } -- "leather"
, ["FULL_LEATHER"  ] = { name="cuero tratado"     , crafting_type=cl, mat_set_id=med , material_index=18, master_writ2=162, level_index= 4 } -- "full-leather"
, ["FELL"          ] = { name="piel impía"       , crafting_type=cl, mat_set_id=med , material_index=23, master_writ2=166, level_index= 5 } -- "fell"
, ["BRIGANDINE"    ] = { name="brigantina"        , crafting_type=cl, mat_set_id=med , material_index=26, master_writ2=170, level_index= 6 } -- "brigandine"
, ["IRONHIDE"      ] = { name="piel férrea"      , crafting_type=cl, mat_set_id=med , material_index=29, master_writ2=174, level_index= 7 } -- "ironhide"
, ["SUPERB"        ] = { name="soberbio"          , crafting_type=cl, mat_set_id=med , material_index=32, master_writ2=131, level_index= 8 } -- "superb"
, ["SHADOWHIDE"    ] = { name="piel sombría"     , crafting_type=cl, mat_set_id=med , material_index=34, master_writ2=132, level_index= 9 } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="cuero rubedo"      , crafting_type=cl, mat_set_id=med , material_index=40, master_writ2=190, level_index=10 } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="arce"              , crafting_type=ww, mat_set_id=wood, material_index= 1, master_writ2=  2, level_index= 1  } -- "maple"
, ["OAK"           ] = { name="roble"             , crafting_type=ww, mat_set_id=wood, material_index= 8, master_writ2= 18, level_index= 2  } -- "oak"
, ["BEECH"         ] = { name="haya"              , crafting_type=ww, mat_set_id=wood, material_index=13, master_writ2= 20, level_index= 3  } -- "beech"
, ["HICKORY"       ] = { name="nogal"             , crafting_type=ww, mat_set_id=wood, material_index=18, master_writ2= 22, level_index= 4  } -- "hickory"
, ["YEW"           ] = { name="tejo"              , crafting_type=ww, mat_set_id=wood, material_index=23, master_writ2= 24, level_index= 5  } -- "yew"
, ["BIRCH"         ] = { name="abedul"            , crafting_type=ww, mat_set_id=wood, material_index=26, master_writ2=133, level_index= 6  } -- "birch"
, ["ASH"           ] = { name="fresno"            , crafting_type=ww, mat_set_id=wood, material_index=29, master_writ2=134, level_index= 7  } -- "ash"
, ["MAHOGANY"      ] = { name="caoba"             , crafting_type=ww, mat_set_id=wood, material_index=32, master_writ2=135, level_index= 8  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="nocteca"           , crafting_type=ww, mat_set_id=wood, material_index=34, master_writ2=136, level_index= 9  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="fresno rubí"      , crafting_type=ww, mat_set_id=wood, material_index=40, master_writ2=192, level_index=10  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="peltre"            , crafting_type=jw, mat_set_id=jewl, material_index= 1, master_writ2=  6, level_index= 1  } -- "pewter"
, ["COPPER"        ] = { name="cobre"             , crafting_type=jw, mat_set_id=jewl, material_index=13, master_writ2= 56, level_index= 2  } -- "copper"
, ["SILVER"        ] = { name="plata"             , crafting_type=jw, mat_set_id=jewl, material_index=26, master_writ2=137, level_index= 3  } -- "silver"
, ["ELECTRUM"      ] = { name="electro"           , crafting_type=jw, mat_set_id=jewl, material_index=33, master_writ2=139, level_index= 4  } -- "electrum"
, ["PLATINUM"      ] = { name="platino"           , crafting_type=jw, mat_set_id=jewl, material_index=40, master_writ2=255, level_index= 5  } -- "platinum"
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
    [bs] = { "Una protección magistral"          -- "A Masterful Plate"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [cl] = { "Una prenda de tela magistral"       -- "Masterful Tailoring"
           , "Una prenda de cuero magistral"    } -- "Masterful Leatherwear"
,   [en] = { "Un glifo magistral"               } -- "A Masterful Glyph"
,   [al] = { "Una mezcla magistral"             } -- "A Masterful Concoction"
,   [pr] = { "Un festín magistral"             } -- "A Masterful Feast"
,   [ww] = { "Un escudo magistral"                -- "A Masterful Shield"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [jw] = { "Joyería magistral"               } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Calidad"                         -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Estilo"                          -- "Style"
,   ["trait"  ] =  "Rasgo"                           -- "Trait"
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
    [1] = "Normal"                   -- "Normal"
,   [2] = "Bueno"                    -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Épico"                   -- "Epic"
,   [5] = "Legendario"               -- "Legendary"
}

