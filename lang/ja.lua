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
  ["H1_AXE"         ] = { name="斧"                    , master_name="斧"                         , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "axe"
, ["H1_MACE"        ] = { name="メイス"                  , master_name="メイス"                       , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "mace"
, ["H1_SWORD"       ] = { name="剣"                    , master_name="剣"                         , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="両手斧"                  , master_name="両手斧"                       , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="大槌"                   , master_name="大槌"                        , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="大剣"                   , master_name="大剣"                        , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "greatsword"
, ["DAGGER"         ] = { name="短剣"                   , master_name="短剣"                        , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "dagger"
, ["CUIRASS"        ] = { name="胸当て"                  , master_name="胸当て"                       , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "cuirass"
, ["SABATONS"       ] = { name="サバトン"                 , master_name="サバトン"                      , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="篭手"                   , master_name="篭手"                        , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "gauntlets"
, ["HELM"           ] = { name="兜"                    , master_name="兜"                         , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "helm"
, ["GREAVES"        ] = { name="グリーヴ"                 , master_name="グリーヴ"                      , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "greaves"
, ["PAULDRON"       ] = { name="ポールドロン"               , master_name="ポールドロン"                    , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "pauldron"
, ["GIRDLE"         ] = { name="ガードル"                 , master_name="ガードル"                      , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "girdle"

, ["ROBE"           ] = { name="ローブ"                  , master_name="ローブ"                       , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "robe"
, ["JERKIN"         ] = { name="ジャーキン"                , master_name="ジャーキン"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "jerkin"
, ["SHOES"          ] = { name="靴"                    , master_name="靴"                         , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "shoes"
, ["GLOVES"         ] = { name="手袋"                   , master_name="手袋"                        , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "gloves"
, ["HAT"            ] = { name="帽子"                   , master_name="帽子"                        , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "hat"
, ["BREECHES"       ] = { name="パンツ"                  , master_name="パンツ"                       , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "breeches"
, ["EPAULETS"       ] = { name="肩当て"                  , master_name="肩当て"                       , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="肩当て"       } -- "epaulets"
, ["SASH"           ] = { name="サッシュ"                 , master_name="サッシュ"                      , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="サッシュ"      } -- "sash"
, ["JACK"           ] = { name="胴当て"                  , master_name="胴当て"                       , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "jack"
, ["BOOTS"          ] = { name="ブーツ"                  , master_name="ブーツ"                       , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "boots"
, ["BRACERS"        ] = { name="腕当て"                  , master_name="腕当て"                       , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="腕当て"       } -- "bracers"
, ["HELMET"         ] = { name="兜"                    , master_name="兜"                         , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="兜"         } -- "helmet"
, ["GUARDS"         ] = { name="すね当て"                 , master_name="すね当て"                      , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "guards"
, ["ARM_COPS"       ] = { name="アームカップ"               , master_name="アームカップ"                    , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "arm cops"
, ["BELT"           ] = { name="ベルト"                  , master_name="ベルト"                       , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "belt"

, ["BOW"            ] = { name="弓"                    , master_name="弓"                         , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="業火の杖"                 , master_name="業火の杖"                      , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="氷の杖"                  , master_name="氷の杖"                       , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="稲妻の杖"                 , master_name="稲妻の杖"                      , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="回復の杖"                 , master_name="回復の杖"                      , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "restoration staff"
, ["SHIELD"         ] = { name="盾"                    , master_name="盾"                         , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr } -- "shield"

, ["NECKLACE"       ] = { name="ネックレス"                , master_name="ネックレス"                     , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="ネックレス"     } -- "necklace"
, ["RING"           ] = { name="リング"                  , master_name="指輪"                        , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "ring"
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
  ["IRON"          ] = { name="鉄"                 , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy   } -- "iron"
, ["STEEL"         ] = { name="鋼鉄"                , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy   } -- "steel"
, ["ORICHALC"      ] = { name="オリハルコン"            , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy   } -- "orichalc"
, ["DWARVEN"       ] = { name="ドワーフ"              , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ドワーフ"           } -- "dwarven"
, ["EBON"          ] = { name="黒檀"                , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy   } -- "ebon"
, ["CALCINIUM"     ] = { name="カルシニウム"            , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy   } -- "calcinium"
, ["GALATITE"      ] = { name="ガラタイト"             , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy   } -- "galatite"
, ["QUICKSILVER"   ] = { name="水銀"                , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy   } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="虚無の鉄"              , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy   } -- "voidsteel"
, ["RUBEDITE"      ] = { name="ルベダイト"             , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy   } -- "Rubedite"

, ["HOMESPUN"      ] = { name="手織り布"              , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  } -- "homespun"
, ["LINEN"         ] = { name="リネン"               , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  } -- "linen"
, ["COTTON"        ] = { name="コットン"              , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  } -- "cotton"
, ["SPIDERSILK"    ] = { name="スパイダーシルク"          , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="エボンスレッド"           , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  } -- "ebonthread"
, ["KRESH"         ] = { name="クレッシュ"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  } -- "kresh"
, ["IRONTHREAD"    ] = { name="アイアンスレッド"          , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt , name_2="アイアンスレッド"        } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="シルバーウィーブ"          , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="影の布"               , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="先人のシルク"            , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt , name_2="先人のシルク"          } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="生皮"                , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  } -- "rawhide"
, ["HIDE"          ] = { name="皮"                 , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  } -- "hide"
, ["LEATHER"       ] = { name="革"                 , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  } -- "leather"
, ["FULL_LEATHER"  ] = { name="フルレザー"             , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  } -- "full-leather"
, ["FELL"          ] = { name="フェルハイド"            , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  } -- "fell"
, ["BRIGANDINE"    ] = { name="ブリガンダイン"           , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med , name_2="ブリガンダイン"         } -- "brigandine"
, ["IRONHIDE"      ] = { name="アイアンハイド"           , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  } -- "ironhide"
, ["SUPERB"        ] = { name="最上"                , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med , name_2="最上"              } -- "superb"
, ["SHADOWHIDE"    ] = { name="シャドウハイド"           , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="ルベドレザー"            , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="カエデ"               , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood  } -- "maple"
, ["OAK"           ] = { name="カシ"                , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood  } -- "oak"
, ["BEECH"         ] = { name="ブナノキ"              , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood  } -- "beech"
, ["HICKORY"       ] = { name="ヒッコリー"             , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood  } -- "hickory"
, ["YEW"           ] = { name="イチイ"               , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood  } -- "yew"
, ["BIRCH"         ] = { name="カバノキ"              , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood  } -- "birch"
, ["ASH"           ] = { name="アッシュ"              , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood  } -- "ash"
, ["MAHOGANY"      ] = { name="マホガニー"             , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="ナイトウッド"            , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="ルビーアッシュ"           , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="ピューター"             , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl  } -- "pewter"
, ["COPPER"        ] = { name="銅"                 , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl  } -- "copper"
, ["SILVER"        ] = { name="銀"                 , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl  } -- "silver"
, ["ELECTRUM"      ] = { name="琥珀金"               , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="琥珀金"            } -- "electrum"
, ["PLATINUM"      ] = { name="プラチナ"              , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl  } -- "platinum"
}


-- Quest Titles --------------------------------------------------------------

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "鍛冶師の依頼"                         -- "Blacksmith Writ"
,   [cl] = "仕立師の依頼"                         -- "Clothier Writ"
,   [en] = "付呪師の依頼"                         -- "Enchanter Writ"
,   [al] = "錬金術師の依頼"                        -- "Alchemist Writ"
,   [pr] = "調理師の依頼"                         -- "Provisioner Writ"
,   [ww] = "木工師の依頼"                         -- "Woodworker Writ"
,   [jw] = "宝飾師のクラフト依頼"                     -- "Jewelry Crafting Writ"
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
    [bs] = { "優れた防具"                              -- "A Masterful Plate"
           , "優れた武器"                            } -- "A Masterful Weapon"
,   [cl] = { "優れた服"                               -- "Masterful Tailoring"
           , "優れた革装備"                           } -- "Masterful Leatherwear"
,   [en] = { "優れたグリフ"                           } -- "A Masterful Glyph"
,   [al] = { "優れた調合薬"                           } -- "A Masterful Concoction"
,   [pr] = { "優れた料理"                            } -- "A Masterful Feast"
,   [ww] = { "優れた盾"                               -- "A Masterful Shield"
           , "優れた武器"                            } -- "A Masterful Weapon"
,   [jw] = { "優れた宝飾"                            } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Fine"                     -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Epic"                     -- "Epic"
,   [5] = "Legendary"                -- "Legendary"
}

