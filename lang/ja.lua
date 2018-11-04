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


-- Craftable Equipment -------------------------------------------------------
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
  ["H1_AXE"         ] = { name="斧"                    , master_name="斧"                         , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="メイス"                  , master_name="メイス"                       , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="剣"                    , master_name="剣"                         , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="両手斧"                  , master_name="両手斧"                       , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="大槌"                   , master_name="大槌"                        , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="大剣"                   , master_name="大剣"                        , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="短剣"                   , master_name="短剣"                        , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="胸当て"                  , master_name="胸当て"                       , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="サバトン"                 , master_name="サバトン"                      , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="篭手"                   , master_name="篭手"                        , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="兜"                    , master_name="兜"                         , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="グリーヴ"                 , master_name="グリーヴ"                      , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="ポールドロン"               , master_name="ポールドロン"                    , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="ガードル"                 , master_name="ガードル"                      , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="ローブ"                  , master_name="ローブ"                       , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="ジャーキン"                , master_name="ジャーキン"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="靴"                    , master_name="靴"                         , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="手袋"                   , master_name="手袋"                        , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="帽子"                   , master_name="帽子"                        , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="パンツ"                  , master_name="パンツ"                       , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="肩当て"                  , master_name="肩当て"                       , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="肩当て"       }
, ["SASH"           ] = { name="サッシュ"                 , master_name="サッシュ"                      , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="サッシュ"      }
, ["JACK"           ] = { name="胴当て"                  , master_name="胴当て"                       , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="ブーツ"                  , master_name="ブーツ"                       , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="腕当て"                  , master_name="腕当て"                       , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="腕当て"       }
, ["HELMET"         ] = { name="兜"                    , master_name="兜"                         , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="兜"         }
, ["GUARDS"         ] = { name="すね当て"                 , master_name="すね当て"                      , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="アームカップ"               , master_name="アームカップ"                    , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="ベルト"                  , master_name="ベルト"                       , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="弓"                    , master_name="弓"                         , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="業火の杖"                 , master_name="業火の杖"                      , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="氷の杖"                  , master_name="氷の杖"                       , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="稲妻の杖"                 , master_name="稲妻の杖"                      , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="回復の杖"                 , master_name="回復の杖"                      , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="盾"                    , master_name="盾"                         , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="ネックレス"                , master_name="ネックレス"                     , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="ネックレス"     }
, ["RING"           ] = { name="リング"                  , master_name="指輪"                        , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

, ["AETHERIAL_TEA"  ] = { name="Aetherial Tea"        ,                                                                              crafting_type=pr,                                              }
}


-- Materials for Craftable Equipment -----------------------------------------
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
  ["IRON"          ] = { name="鉄"                 , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy  }
, ["STEEL"         ] = { name="鋼鉄"                , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy  }
, ["ORICHALC"      ] = { name="オリハルコン"            , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy  }
, ["DWARVEN"       ] = { name="ドワーフ"              , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ドワーフ"           }
, ["EBONY"         ] = { name="黒檀"                , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="黒檀"             }
, ["CALCINIUM"     ] = { name="カルシニウム"            , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy  }
, ["GALATITE"      ] = { name="ガラタイト"             , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy  }
, ["QUICKSILVER"   ] = { name="水銀"                , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy  }
, ["VOIDSTEEL"     ] = { name="虚無の鉄"              , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy  }
, ["RUBEDITE"      ] = { name="ルベダイト"             , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy  }

, ["JUTE"          ] = { name="手織り布"              , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  , name_2="手織り布"            }
, ["LINEN"         ] = { name="リネン"               , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  }
, ["COTTON"        ] = { name="コットン"              , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SPIDERSILK"    ] = { name="スパイダーシルク"          , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  }
, ["EBONTHREAD"    ] = { name="エボンスレッド"           , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  }
, ["KRESH"         ] = { name="クレッシュ"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  }
, ["IRONTHREAD"    ] = { name="アイアンスレッド"          , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  , name_2="アイアンスレッド"        }
, ["SILVERWEAVE"   ] = { name="シルバーウィーブ"          , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SHADOWSPUN"    ] = { name="影の布"               , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  }
, ["ANCESTOR_SILK" ] = { name="先人のシルク"            , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt  , name_2="先人のシルク"          }

, ["RAWHIDE"       ] = { name="生皮"                , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  }
, ["HIDE"          ] = { name="皮"                 , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  }
, ["LEATHER"       ] = { name="革"                 , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  }
, ["FULL_LEATHER"  ] = { name="フルレザー"             , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  }
, ["FELL_HIDE"     ] = { name="フェルハイド"            , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  }
, ["BRIGANDINE"    ] = { name="ブリガンダイン"           , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  , name_2="ブリガンダイン"         }
, ["IRONHIDE"      ] = { name="アイアンハイド"           , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  }
, ["SUPERB"        ] = { name="最上"                , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  , name_2="最上"              }
, ["SHADOWHIDE"    ] = { name="シャドウハイド"           , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  }
, ["RUBEDO_LEATHER"] = { name="ルベドレザー"            , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  }

, ["MAPLE"         ] = { name="カエデ"               , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood }
, ["OAK"           ] = { name="カシ"                , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood }
, ["BEECH"         ] = { name="ブナノキ"              , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood }
, ["HICKORY"       ] = { name="ヒッコリー"             , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood }
, ["YEW"           ] = { name="イチイ"               , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood }
, ["BIRCH"         ] = { name="カバノキ"              , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood }
, ["ASH"           ] = { name="アッシュ"              , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood }
, ["MAHOGANY"      ] = { name="マホガニー"             , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood }
, ["NIGHTWOOD"     ] = { name="ナイトウッド"            , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood }
, ["RUBY_ASH"      ] = { name="ルビーアッシュ"           , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood }

, ["PEWTER"        ] = { name="ピューター"             , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl }
, ["COPPER"        ] = { name="銅"                 , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl }
, ["SILVER"        ] = { name="銀"                 , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl }
, ["ELECTRUM"      ] = { name="琥珀金"               , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="琥珀金"            }
, ["PLATINUM"      ] = { name="プラチナ"              , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl }
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
-- item_id          ZOS itemId for use in itemLinks and other APIness.
--
-- name_2           German and Russian alternate spellings.
--
LibCraftText.CONSUMABLE_MATERIAL = {
  ["BLESSED_THISTLE"         ] = { name="聖なるシッスル"                        , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="アオイッポンシメジ"                      , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="ムラサキ草"                          , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="オダマキ"                           , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="コーンフラワー"                        , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="ドラゴンソーン"                        , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="ドクベニタケ"                         , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="木椅子キノコ"                         , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="タネツケバナ"                         , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="光ベニタケ"                          , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="山の花"                            , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="ナミラキノコ"                         , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="ニルンルート"                         , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="スッポンタケ"                         , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="ムラサキヒトヨタケ"                      , crafting_type=al, item_id= 30152 , name_2="ムラサキヒトヨタケ"          }
, ["WATER_HYACINTH"          ] = { name="ホテイアオイ"                         , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="白かさキノコ"                         , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="ニガヨモギ"                          , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="ビートルスカトル"                       , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="蝶の羽"                            , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="ニクバエの幼虫"                        , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="マッドクラブキチン"                      , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="ベラドンナ"                          , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="スクリブのゼリー"                       , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="蜘蛛の卵"                           , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="ホタルの腹部"                         , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="クラム・ゴル"                         , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="真珠貝のパウダー"                       , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="自然水"                            , crafting_type=al, item_id=   883 , name_2="自然水"                }
, ["CLEAR_WATER"             ] = { name="清水"                             , crafting_type=al, item_id=  1187 }
, ["PRISTINE_WATER"          ] = { name="清浄水"                            , crafting_type=al, item_id=  4570 , name_2="清浄水"                }
, ["CLEANSED_WATER"          ] = { name="浄化水"                            , crafting_type=al, item_id= 23265 , name_2="浄化水"                }
, ["FILTERED_WATER"          ] = { name="ろ過水"                            , crafting_type=al, item_id= 23266 }
, ["PURIFIED_WATER"          ] = { name="神聖水"                            , crafting_type=al, item_id= 23267 , name_2="神聖水"                }
, ["CLOUD_MIST"              ] = { name="霧の雲"                            , crafting_type=al, item_id= 23268 }
, ["STAR_DEW"                ] = { name="星のしずく"                          , crafting_type=al, item_id= 64500 }
, ["LORKHANS_TEARS"          ] = { name="ロルカーンの涙"                        , crafting_type=al, item_id= 64501 }

, ["GREASE"                  ] = { name="獣油"                             , crafting_type=al, item_id= 75357 }
, ["ICHOR"                   ] = { name="イコル"                            , crafting_type=al, item_id= 75358 }
, ["SLIME"                   ] = { name="粘液"                             , crafting_type=al, item_id= 75359 }
, ["GALL"                    ] = { name="胆嚢"                             , crafting_type=al, item_id= 75360 }
, ["TEREBINTHINE"            ] = { name="テレピン"                           , crafting_type=al, item_id= 75361 }
, ["PITCH_BILE"              ] = { name="黒の胆汁"                           , crafting_type=al, item_id= 75362 }
, ["TARBLACK"                ] = { name="ターブラック"                         , crafting_type=al, item_id= 75363 }
, ["NIGHT_OIL"               ] = { name="夜の油"                            , crafting_type=al, item_id= 75364 }
, ["ALKAHEST"                ] = { name="アルカヘスト"                         , crafting_type=al, item_id= 75365 }

, ["JORA"                    ] = { name="ジョラ"                            , crafting_type=en, item_id= 45855 }
, ["PORADE"                  ] = { name="ポラデ"                            , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="ジェラ"                            , crafting_type=en, item_id= 45857 }
, ["JEJORA"                  ] = { name="ジェジョラ"                          , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="オドラ"                            , crafting_type=en, item_id= 45807 }
, ["POJORA"                  ] = { name="ポジョラ"                           , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="エドラ"                            , crafting_type=en, item_id= 45809 }
, ["JAERA"                   ] = { name="ジャエラ"                           , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="ポラ"                             , crafting_type=en, item_id= 45811 }
, ["DENARA"                  ] = { name="デナラ"                            , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="レラ"                             , crafting_type=en, item_id= 45813 }
, ["DERADO"                  ] = { name="デラド"                            , crafting_type=en, item_id= 45814 }
, ["REKURA"                  ] = { name="レクラ"                            , crafting_type=en, item_id= 45815 }
, ["KURA"                    ] = { name="クラ"                             , crafting_type=en, item_id= 45816 }
, ["REJERA"                  ] = { name="レジェラ"                           , crafting_type=en, item_id= 64509 }
, ["REPORA"                  ] = { name="レポラ"                            , crafting_type=en, item_id= 68341 }

, ["JODE"                    ] = { name="ジョーデ"                           , crafting_type=en, item_id= 45817 }
, ["NOTADE"                  ] = { name="ノタデ"                            , crafting_type=en, item_id= 45818 }
, ["ODE"                     ] = { name="オデ"                             , crafting_type=en, item_id= 45819 }
, ["TADE"                    ] = { name="タデ"                             , crafting_type=en, item_id= 45820 }
, ["JAYDE"                   ] = { name="ジェイデ"                           , crafting_type=en, item_id= 45821 }
, ["EDODE"                   ] = { name="エドデ"                            , crafting_type=en, item_id= 45822 }
, ["POJODE"                  ] = { name="ポジョデ"                           , crafting_type=en, item_id= 45823 }
, ["REKUDE"                  ] = { name="レクデ"                            , crafting_type=en, item_id= 45824 }
, ["HADE"                    ] = { name="ハデ"                             , crafting_type=en, item_id= 45825 }
, ["IDODE"                   ] = { name="イドデ"                            , crafting_type=en, item_id= 45826 }
, ["PODE"                    ] = { name="ポデ"                             , crafting_type=en, item_id= 45827 }
, ["KEDEKO"                  ] = { name="ケデコ"                            , crafting_type=en, item_id= 45828 }
, ["REDE"                    ] = { name="レデ"                             , crafting_type=en, item_id= 45829 }
, ["KUDE"                    ] = { name="クデ"                             , crafting_type=en, item_id= 45830 }
, ["JEHADE"                  ] = { name="ジェハデ"                           , crafting_type=en, item_id= 64508 }
, ["ITADE"                   ] = { name="イタデ"                            , crafting_type=en, item_id= 68340 }

, ["DEKEIPA"                 ] = { name="デケイパ"                           , crafting_type=en, item_id= 45839 }
, ["DENI"                    ] = { name="デニ"                             , crafting_type=en, item_id= 45833 }
, ["DENIMA"                  ] = { name="デニマ"                            , crafting_type=en, item_id= 45836 }
, ["DETERI"                  ] = { name="デテリ"                            , crafting_type=en, item_id= 45842 }
, ["HAOKO"                   ] = { name="ハオコ"                            , crafting_type=en, item_id= 45841 }
, ["HAKEIJO"                 ] = { name="ハケイジョ"                          , crafting_type=en, item_id= 68342 }
, ["KADERI"                  ] = { name="カデリ"                            , crafting_type=en, item_id= 45849 }
, ["KUOKO"                   ] = { name="クオコ"                            , crafting_type=en, item_id= 45837 }
, ["MAKDERI"                 ] = { name="マクデリ"                           , crafting_type=en, item_id= 45848 }
, ["MAKKO"                   ] = { name="マッコ"                            , crafting_type=en, item_id= 45832 }
, ["MAKKOMA"                 ] = { name="マッコマ"                           , crafting_type=en, item_id= 45835 }
, ["MEIP"                    ] = { name="メイプ"                            , crafting_type=en, item_id= 45840 }
, ["OKO"                     ] = { name="オコ"                             , crafting_type=en, item_id= 45831 }
, ["OKOMA"                   ] = { name="オコマ"                            , crafting_type=en, item_id= 45834 }
, ["OKORI"                   ] = { name="オコリ"                            , crafting_type=en, item_id= 45843 }
, ["ORU"                     ] = { name="オル"                             , crafting_type=en, item_id= 45846 }
, ["RAKEIPA"                 ] = { name="ラケイパ"                           , crafting_type=en, item_id= 45838 }
, ["TADERI"                  ] = { name="タデリ"                            , crafting_type=en, item_id= 45847 }

, ["TA"                      ] = { name="ター"                             , crafting_type=en, item_id= 45850 }
, ["JEJOTA"                  ] = { name="ジェジョタ"                          , crafting_type=en, item_id= 45851 }
, ["DENATA"                  ] = { name="デナタ"                            , crafting_type=en, item_id= 45852 }
, ["REKUTA"                  ] = { name="レクタ"                            , crafting_type=en, item_id= 45853 }
, ["KUTA"                    ] = { name="クター"                            , crafting_type=en, item_id= 45854 }
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

