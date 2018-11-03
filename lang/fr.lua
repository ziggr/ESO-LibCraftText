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
-- name_2           FR French has a typo for Sash: "baudier" when it should
--                  be "baudrier". An extra name column helps match these
--                  surprises.
--
LibCraftText.ITEM = {
  ["H1_AXE"         ] = { name="hache"                , master_name="hache"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "axe"
, ["H1_MACE"        ] = { name="masse"                , master_name="masse"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "mace"
, ["H1_SWORD"       ] = { name="épée"                 , master_name="épée"                      , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="hache de bataille"    , master_name="Hache de bataille"         , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="masse d'arme"         , master_name="masse d'arme"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="épée longue"          , master_name="épée longue"               , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "greatsword"
, ["DAGGER"         ] = { name="dague"                , master_name="dague"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "dagger"
, ["CUIRASS"        ] = { name="cuirasse"             , master_name="cuirasse"                  , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "cuirass"
, ["SABATONS"       ] = { name="solerets"             , master_name="Soleret"                   , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="gantelets"            , master_name="Gantelets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "gauntlets"
, ["HELM"           ] = { name="heaume"               , master_name="casque"                    , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "helm"
, ["GREAVES"        ] = { name="grèves"               , master_name="Grèves"                    , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "greaves"
, ["PAULDRON"       ] = { name="spallière"            , master_name="Spallière"                 , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "pauldron"
, ["GIRDLE"         ] = { name="gaine"                , master_name="gaine"                     , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "robe"
, ["JERKIN"         ] = { name="pourpoint"            , master_name="Pourpoint"                 , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "jerkin"
, ["SHOES"          ] = { name="chaussures"           , master_name="Chaussures"                , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "shoes"
, ["GLOVES"         ] = { name="gants"                , master_name="Gants"                     , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "gloves"
, ["HAT"            ] = { name="chapeau"              , master_name="chapeau"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "hat"
, ["BREECHES"       ] = { name="braies"               , master_name="Braies"                    , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "breeches"
, ["EPAULETS"       ] = { name="épaulettes"           , master_name="Épaulettes"                , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="épaulettes"} -- "epaulets"
, ["SASH"           ] = { name="baudrier"             , master_name="Baudrier"                  , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="baudier"   } -- "sash"
, ["JACK"           ] = { name="gilet"                , master_name="gilet"                     , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "jack"
, ["BOOTS"          ] = { name="bottes"               , master_name="Bottes"                    , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "boots"
, ["BRACERS"        ] = { name="brassards"            , master_name="Brassards"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="brassards" } -- "bracers"
, ["HELMET"         ] = { name="casque"               , master_name="casque"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="casque"    } -- "helmet"
, ["GUARDS"         ] = { name="gardes"               , master_name="Gardes"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "guards"
, ["ARM_COPS"       ] = { name="coques d'épaules"     , master_name="Coques d'épaules"          , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "arm cops"
, ["BELT"           ] = { name="ceinture"             , master_name="ceinture"                  , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "belt"

, ["BOW"            ] = { name="arc"                  , master_name="arc"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="bâton infernal"       , master_name="bâton infernal"            , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="bâton de glace"       , master_name="Bâton de glace"            , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="bâton de foudre"      , master_name="Bâton de foudre"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="bâton de rétablissement", master_name="Bâton de rétablissement"   , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "restoration staff"
, ["SHIELD"         ] = { name="bouclier"             , master_name="bouclier"                  , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr } -- "shield"

, ["NECKLACE"       ] = { name="collier"              , master_name="Collier"                   , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="collier"   } -- "necklace"
, ["RING"           ] = { name="anneau"               , master_name="Anneau"                    , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "ring"
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
  ["IRON"          ] = { name="fer"               , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy   } -- "iron"
, ["STEEL"         ] = { name="acier"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy   } -- "steel"
, ["ORICHALC"      ] = { name="orichalque"        , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy   } -- "orichalc"
, ["DWARVEN"       ] = { name="dwemère"           , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="dwemer"         } -- "dwarven"
, ["EBON"          ] = { name="ébonite"           , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy   } -- "ebon"
, ["CALCINIUM"     ] = { name="calcinium"         , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy   } -- "calcinium"
, ["GALATITE"      ] = { name="galatite"          , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy   } -- "galatite"
, ["QUICKSILVER"   ] = { name="mercure"           , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy   } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="acier du néant"    , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy   } -- "voidsteel"
, ["RUBEDITE"      ] = { name="cuprite"           , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy   } -- "Rubedite"

, ["HOMESPUN"      ] = { name="artisanales"       , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  } -- "homespun"
, ["LINEN"         ] = { name="lin"               , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  } -- "linen"
, ["COTTON"        ] = { name="coton"             , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  } -- "cotton"
, ["SPIDERSILK"    ] = { name="soie d'araignée"   , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="fil d'ébonite"     , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  } -- "ebonthread"
, ["KRESH"         ] = { name="kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  } -- "kresh"
, ["IRONTHREAD"    ] = { name="fil de fer"        , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt , name_2="fil de fer"      } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="fil d'argent"      , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="tissombre"         , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="soie ancestrales"  , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt , name_2="soie ancestral"  } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="cuir brut"         , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  } -- "rawhide"
, ["HIDE"          ] = { name="peau"              , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  } -- "hide"
, ["LEATHER"       ] = { name="cuir"              , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  } -- "leather"
, ["FULL_LEATHER"  ] = { name="cuir complet"      , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  } -- "full-leather"
, ["FELL"          ] = { name="déchu"             , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  } -- "fell"
, ["BRIGANDINE"    ] = { name="cuir clouté"       , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med , name_2="brigandine"      } -- "brigandine"
, ["IRONHIDE"      ] = { name="peau de fer"       , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  } -- "ironhide"
, ["SUPERB"        ] = { name="superbe"           , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med , name_2="superbe"         } -- "superb"
, ["SHADOWHIDE"    ] = { name="peau d'ombre"      , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="cuir pourpre"      , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="érable"            , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood  } -- "maple"
, ["OAK"           ] = { name="chêne"             , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood  } -- "oak"
, ["BEECH"         ] = { name="hêtre"             , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood  } -- "beech"
, ["HICKORY"       ] = { name="noyer"             , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood  } -- "hickory"
, ["YEW"           ] = { name="if"                , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood  } -- "yew"
, ["BIRCH"         ] = { name="bouleau"           , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood  } -- "birch"
, ["ASH"           ] = { name="frêne"             , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood  } -- "ash"
, ["MAHOGANY"      ] = { name="acajou"            , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="bois de nuit"      , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="frêne roux"        , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="étain"             , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl  } -- "pewter"
, ["COPPER"        ] = { name="cuivre"            , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl  } -- "copper"
, ["SILVER"        ] = { name="argent"            , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl  } -- "silver"
, ["ELECTRUM"      ] = { name="électrum"          , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="électrum"       } -- "electrum"
, ["PLATINUM"      ] = { name="platine"           , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl  } -- "platinum"
}

-- Alchemy and Enchanting Materials
--
-- For "Acquire Mudcrab Chitin"
--
--
-- name             string that appears in material requested in daily
--                  crafting quests and master writ conditions.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- item_id          ZOS itemId for use in itemLinks and other APInes.
--
LibCraftText.CONSUMABLE_MATERIAL = {
  ["BLESSED_THISTLE"         ] = { "chardon béni"                   , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { "entoloma bleue"                 , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { "noctuelle"                      , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { "ancolie"                        , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { "bleuet"                         , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { "épine-de-dragon"                , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { "russule émétique"               , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { "pied-de-lutin"                  , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { "cardamine des prés"             , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { "russule phosphorescente"        , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { "lys des cimes"                  , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { "truffe de Namira"               , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { "nirnrave"                       , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { "mutinus elegans"                , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { "coprin violet"                  , crafting_type=al, item_id= 30152 }
, ["WATER_HYACINTH"          ] = { "jacinthe d'eau"                 , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { "Chapeau blanc"                  , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { "absinthe"                       , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { "cloaque de scarabée"            , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { "aile de papillon"               , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { "larve de mouche à viande"       , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { "chitine de vasard"              , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { "Belladone"                      , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { "gelée de scrib"                 , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { "œuf d'araignée"                 , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { "thorax de flammouche"           , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { "impureté de palourde"           , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { "poudre de nacre"                , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { "eau naturelle"                  , crafting_type=al, item_id=   883 }
, ["CLEAR_WATER"             ] = { "eau claire"                     , crafting_type=al, item_id=  1187 }
, ["PRISTINE_WATER"          ] = { "eau limpide"                    , crafting_type=al, item_id=  4570 }
, ["CLEANSED_WATER"          ] = { "eau assainie"                   , crafting_type=al, item_id= 23265 }
, ["FILTERED_WATER"          ] = { "eau filtrée"                    , crafting_type=al, item_id= 23266 }
, ["PURIFIED_WATER"          ] = { "eau purifiée"                   , crafting_type=al, item_id= 23267 }
, ["CLOUD_MIST"              ] = { "brume"                          , crafting_type=al, item_id= 23268 }
, ["STAR_DEW"                ] = { "rosée stellaire"                , crafting_type=al, item_id= 64500 }
, ["LORKHANS_TEARS"          ] = { "larmes de Lorkhan"              , crafting_type=al, item_id= 64501 }

, ["GREASE"                  ] = { "graisse"                        , crafting_type=al, item_id= 75357 }
, ["ICHOR"                   ] = { "sanie"                          , crafting_type=al, item_id= 75358 }
, ["SLIME"                   ] = { "fluide visqueux"                , crafting_type=al, item_id= 75359 }
, ["GALL"                    ] = { "bile"                           , crafting_type=al, item_id= 75360 }
, ["TEREBINTHINE"            ] = { "térébenthine"                   , crafting_type=al, item_id= 75361 }
, ["PITCH_BILE"              ] = { "bile-poix"                      , crafting_type=al, item_id= 75362 }
, ["TARBLACK"                ] = { "goudron"                        , crafting_type=al, item_id= 75363 }
, ["NIGHT_OIL"               ] = { "nocthuile"                      , crafting_type=al, item_id= 75364 }
, ["ALKAHEST"                ] = { "alcaleste"                      , crafting_type=al, item_id= 75365 }

, ["JORA"                    ] = { "Jora"                           , crafting_type=en, item_id= 45855 }
, ["PORADE"                  ] = { "Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { "Jéra"                           , crafting_type=en, item_id= 45857 }
, ["JEJORA"                  ] = { "Jéjora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { "Odra"                           , crafting_type=en, item_id= 45807 }
, ["POJORA"                  ] = { "Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { "Edora"                          , crafting_type=en, item_id= 45809 }
, ["JAERA"                   ] = { "Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { "Pora"                           , crafting_type=en, item_id= 45811 }
, ["DENARA"                  ] = { "Dénara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { "Réra"                           , crafting_type=en, item_id= 45813 }
, ["DERADO"                  ] = { "Dérado"                         , crafting_type=en, item_id= 45814 }
, ["REKURA"                  ] = { "Rekura"                         , crafting_type=en, item_id= 45815 }
, ["KURA"                    ] = { "Kura"                           , crafting_type=en, item_id= 45816 }
, ["REJERA"                  ] = { "Rejera"                         , crafting_type=en, item_id= 64509 }
, ["REPORA"                  ] = { "Repora"                         , crafting_type=en, item_id= 68341 }

, ["JODE"                    ] = { "Jode"                           , crafting_type=en, item_id= 45817 }
, ["NOTADE"                  ] = { "Notade"                         , crafting_type=en, item_id= 45818 }
, ["ODE"                     ] = { "Ode"                            , crafting_type=en, item_id= 45819 }
, ["TADE"                    ] = { "Tade"                           , crafting_type=en, item_id= 45820 }
, ["JAYDE"                   ] = { "Jayde"                          , crafting_type=en, item_id= 45821 }
, ["EDODE"                   ] = { "Edode"                          , crafting_type=en, item_id= 45822 }
, ["POJODE"                  ] = { "Pojode"                         , crafting_type=en, item_id= 45823 }
, ["REKUDE"                  ] = { "Rekudé"                         , crafting_type=en, item_id= 45824 }
, ["HADE"                    ] = { "Hade"                           , crafting_type=en, item_id= 45825 }
, ["IDODE"                   ] = { "Idode"                          , crafting_type=en, item_id= 45826 }
, ["PODE"                    ] = { "Pode"                           , crafting_type=en, item_id= 45827 }
, ["KEDEKO"                  ] = { "Kédéko"                         , crafting_type=en, item_id= 45828 }
, ["REDE"                    ] = { "Rede"                           , crafting_type=en, item_id= 45829 }
, ["KUDE"                    ] = { "Kudé"                           , crafting_type=en, item_id= 45830 }
, ["JEHADE"                  ] = { "Jehade"                         , crafting_type=en, item_id= 64508 }
, ["ITADE"                   ] = { "Itade"                          , crafting_type=en, item_id= 68340 }

, ["DEKEIPA"                 ] = { "Dekeïpa"                        , crafting_type=en, item_id= 45839 }
, ["DENI"                    ] = { "Deni"                           , crafting_type=en, item_id= 45833 }
, ["DENIMA"                  ] = { "Denima"                         , crafting_type=en, item_id= 45836 }
, ["DETERI"                  ] = { "Deteri"                         , crafting_type=en, item_id= 45842 }
, ["HAOKO"                   ] = { "Haoko"                          , crafting_type=en, item_id= 45841 }
, ["HAKEIJO"                 ] = { "Hakeijo"                        , crafting_type=en, item_id= 68342 }
, ["KADERI"                  ] = { "Kadéri"                         , crafting_type=en, item_id= 45849 }
, ["KUOKO"                   ] = { "Kuoko"                          , crafting_type=en, item_id= 45837 }
, ["MAKDERI"                 ] = { "Makdéri"                        , crafting_type=en, item_id= 45848 }
, ["MAKKO"                   ] = { "Makko"                          , crafting_type=en, item_id= 45832 }
, ["MAKKOMA"                 ] = { "Makkoma"                        , crafting_type=en, item_id= 45835 }
, ["MEIP"                    ] = { "Méip"                           , crafting_type=en, item_id= 45840 }
, ["OKO"                     ] = { "Oko"                            , crafting_type=en, item_id= 45831 }
, ["OKOMA"                   ] = { "Okoma"                          , crafting_type=en, item_id= 45834 }
, ["OKORI"                   ] = { "Okori"                          , crafting_type=en, item_id= 45843 }
, ["ORU"                     ] = { "Oru"                            , crafting_type=en, item_id= 45846 }
, ["RAKEIPA"                 ] = { "Rakeïpa"                        , crafting_type=en, item_id= 45838 }
, ["TADERI"                  ] = { "Taderi"                         , crafting_type=en, item_id= 45847 }

, ["TA"                      ] = { "Ta"                             , crafting_type=en, item_id= 45850 }
, ["JEJOTA"                  ] = { "Jéjota"                         , crafting_type=en, item_id= 45851 }
, ["DENATA"                  ] = { "Denata"                         , crafting_type=en, item_id= 45852 }
, ["REKUTA"                  ] = { "Rekuta"                         , crafting_type=en, item_id= 45853 }
, ["KUTA"                    ] = { "Kuta"                           , crafting_type=en, item_id= 45854 }

}
-- Quest Titles --------------------------------------------------------------

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
           , "Un vêtement de cuir magistral"    } -- "Masterful Leatherwear"
,   [en] = { "Un glyphe magistral"              } -- "A Masterful Glyph"
,   [al] = { "Une concoction magistrale"        } -- "A Masterful Concoction"
,   [pr] = { "Un festin magistral"              } -- "A Masterful Feast"
,   [ww] = { "Un bouclier magistral"              -- "A Masterful Shield"
           , "Une arme magistrale"              } -- "A Masterful Weapon"
,   [jw] = { "Joaillerie magistrale"            } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualité"                         -- "Quality"
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
,   [2] = "Raffiné"                  -- "Fine"
,   [3] = "Supérieur"                -- "Superior"
,   [4] = "Épique"                   -- "Epic"
,   [5] = "Légendaire"               -- "Legendary"
}

