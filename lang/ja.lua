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

-- Craftable Food and Drink --------------------------------------------------
--
-- name             string that appears in "Craft Banana Surprise"
--
-- recipe_list_index    API value for GetRecipeResultItemInfo() and others
--
-- recipe_index     API value for GetRecipeResultItemInfo() and others
--
LibCraftText.RECIPE = {
  ["AETHERIAL_TEA"                   ] = { name="エセリアルティー"                              , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="エセリアルティー"    }
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="アリクルのビートの山羊乳チーズ添え"                     , food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="焼きリンゴ"                                 , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="ベイクドポテト"                               , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="びっくりバナナ"                               , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="大麦のビール"                                , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="バタグリアのチャウダー"                           , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="ビターレモンティー"                             , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="泥鉄鉱のエール"                               , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="ブレトンのポークソーセージ"                         , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="ニンジンスープ"                               , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="鶏の胸肉"                                  , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="コロールの軸付きトウモロコシ"                        , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="グレープシナモンゼリー"                           , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="シラーワインの蒸留酒"                            , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="シラーワインの蒸留酒"  }
, ["COMELY_WENCH_WHISKEY"            ] = { name="カムリーウェンチ・ウイスキー"                        , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="シロディールのコーンブレッド"                        , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="シロディールのカボチャのフリッター"                     , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="エリンヒルの羚羊の肉のロースト"                       , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="エルセリックの安酒"                             , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="エルセリックの安酒"   }
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="ファーストホールドの果実とチーズのプレート"                 , food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="魚のフライ"                                 , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="4つ目のグロッグ"                              , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="ガーリックマッシュポテト"                          , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="カボチャの種のニンニク炒め"                         , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="ジンジャービール"                              , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="ゴッズ・ブラインド・ミー"                          , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="ゴッズ・ブラインド・ミー"}
, ["GOLDEN_LAGER"                    ] = { name="ゴールデンラガー"                              , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="手の込んだマッツェ"                             , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="グランパのベッドタイム・トニック"                      , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="ブドウのジャム"                               , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="ハグレイヴンのトニック"                           , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="野兎のガーリックソース添え"                         , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="野兎のガーリックソース添え"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="ヘルシーなガーリックとコーンのチャウダー"                  , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="ハニーライ・ウイスキー"                           , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="宿屋〈ジェラールビュー〉のニンジンケーキ"                  , food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="レモンフラワーのマッツェ"                          , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="リルモスのニンニクのヌタウナギ焼き"                     , food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="マンモスの鼻のパイ"                             , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="マオマーティー"                               , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="マルカルスのハチミツ酒"                           , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="マッツェ"                                  , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="マーメイド・ウイスキー"                           , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="雑穀の豚腰肉包み焼き"                            , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="ホットワイン"                                , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="ムスセラの良心の呵責"                            , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="ネレイドワイン"                               , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="ニベン人のニンジンのニンニク炒め"                      , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="ナット・ブラウンエール"                           , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="オークレストのニンニクとリンゴのゼリー"                   , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="ペレタインのトマトライス"                          , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="赤いライ麦ビール"                              , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="レドランのペッパードメロン"                         , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="焼きトウモロコシ"                              , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="瞳に映るライ・ウイスキー"                          , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="海花茶"                                   , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="センシャルのシーフードカレー"                        , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="ソーリー、ハニーラガー"                           , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="すっぱい麦芽汁"                               , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="スパイスベリーのチャイ"                           , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="香辛料入りマッツェ"                             , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="ストームホールドの焼きバナナ"                        , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="スリリーのシラーワイン"                           , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="トルヴァルミントティー"                           , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="トリークルベリーティー"                           , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="トゥーゼファーティー"                            , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="鹿肉のパスティ"                               , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="ウェストウィールドのコーンチャウダー"                    , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="ホワイトランのマスのチーズ焼き"                       , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
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

, ["NATURAL_WATER"           ] = { name="自然水"                            , crafting_type=al, item_id=   883 , name_2="自然水"                , rank=1, potion_name="雫"                       }
, ["CLEAR_WATER"             ] = { name="清水"                             , crafting_type=al, item_id=  1187                               , rank=2, potion_name="生薬"                      }
, ["PRISTINE_WATER"          ] = { name="清浄水"                            , crafting_type=al, item_id=  4570 , name_2="清浄水"                , rank=3, potion_name="飲み薬"                     , potion_name2="飲み薬"                      }
, ["CLEANSED_WATER"          ] = { name="浄化水"                            , crafting_type=al, item_id= 23265 , name_2="浄化水"                , rank=4, potion_name="薬"                       }
, ["FILTERED_WATER"          ] = { name="ろ過水"                            , crafting_type=al, item_id= 23266 , name_2="ろ過水"                , rank=5, potion_name="液体薬"                     }
, ["PURIFIED_WATER"          ] = { name="神聖水"                            , crafting_type=al, item_id= 23267 , name_2="神聖水"                , rank=6, potion_name="霊薬"                      }
, ["CLOUD_MIST"              ] = { name="霧の雲"                            , crafting_type=al, item_id= 23268                               , rank=7, potion_name="万能薬"                     }
, ["STAR_DEW"                ] = { name="星のしずく"                          , crafting_type=al, item_id= 64500                               , rank=8, potion_name="蒸留"                      }
, ["LORKHANS_TEARS"          ] = { name="ロルカーンの涙"                        , crafting_type=al, item_id= 64501                               , rank=9, potion_name="エキス"                     }

, ["GREASE"                  ] = { name="獣油"                             , crafting_type=al, item_id= 75357                               , rank=1, poison_name="1"                       }
, ["ICHOR"                   ] = { name="イコル"                            , crafting_type=al, item_id= 75358                               , rank=2, poison_name="2"                       }
, ["SLIME"                   ] = { name="粘液"                             , crafting_type=al, item_id= 75359                               , rank=3, poison_name="3"                       }
, ["GALL"                    ] = { name="胆嚢"                             , crafting_type=al, item_id= 75360                               , rank=4, poison_name="4"                       }
, ["TEREBINTHINE"            ] = { name="テレピン"                           , crafting_type=al, item_id= 75361                               , rank=5, poison_name="5"                       }
, ["PITCH_BILE"              ] = { name="黒の胆汁"                           , crafting_type=al, item_id= 75362                               , rank=6, poison_name="6"                       }
, ["TARBLACK"                ] = { name="ターブラック"                         , crafting_type=al, item_id= 75363                               , rank=7, poison_name="7"                       }
, ["NIGHT_OIL"               ] = { name="夜の油"                            , crafting_type=al, item_id= 75364                               , rank=8, poison_name="8"                       }
, ["ALKAHEST"                ] = { name="アルカヘスト"                         , crafting_type=al, item_id= 75365                               , rank=9, poison_name="9"                       }

, ["JORA"                    ] = { name="ジョラ"                            , crafting_type=en, item_id= 45855 , name_2="初歩"            }
, ["PORADE"                  ] = { name="ポラデ"                            , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="ジェラ"                            , crafting_type=en, item_id= 45857 , name_2="不出来"           }
, ["JEJORA"                  ] = { name="ジェジョラ"                          , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="オドラ"                            , crafting_type=en, item_id= 45807 , name_2="一般的"           }
, ["POJORA"                  ] = { name="ポジョラ"                           , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="エドラ"                            , crafting_type=en, item_id= 45809 , name_2="中堅"            }
, ["JAERA"                   ] = { name="ジャエラ"                           , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="ポラ"                             , crafting_type=en, item_id= 45811 , name_2="強力"            }
, ["DENARA"                  ] = { name="デナラ"                            , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="レラ"                             , crafting_type=en, item_id= 45813 , name_2="希少"            }
, ["DERADO"                  ] = { name="デラド"                            , crafting_type=en, item_id= 45814 , name_2="至高"           , name_3="至高"             }
, ["REKURA"                  ] = { name="レクラ"                            , crafting_type=en, item_id= 45815 , name_2="究極"            }
, ["KURA"                    ] = { name="クラ"                             , crafting_type=en, item_id= 45816 , name_2="伝説"            }
, ["REJERA"                  ] = { name="レジェラ"                           , crafting_type=en, item_id= 64509 , name_2="最上"            }
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

, ["DEKEIPA"                 ] = { name="デケイパ"                           , crafting_type=en, item_id= 45839 , name_2="氷結"            }
, ["DENI"                    ] = { name="デニ"                             , crafting_type=en, item_id= 45833 , name_2="スタミナ"         , name_3="スタミナ"           }
, ["DENIMA"                  ] = { name="デニマ"                            , crafting_type=en, item_id= 45836 , name_2="スタミナ再生"        }
, ["DETERI"                  ] = { name="デテリ"                            , crafting_type=en, item_id= 45842 , name_2="硬化"            }
, ["HAOKO"                   ] = { name="ハオコ"                            , crafting_type=en, item_id= 45841 , name_2="不浄"            }
, ["HAKEIJO"                 ] = { name="ハケイジョ"                          , crafting_type=en, item_id= 68342 , name_2="分光防御"          }
, ["KADERI"                  ] = { name="カデリ"                            , crafting_type=en, item_id= 45849 , name_2="強撃"            }
, ["KUOKO"                   ] = { name="クオコ"                            , crafting_type=en, item_id= 45837 , name_2="毒"             }
, ["MAKDERI"                 ] = { name="マクデリ"                           , crafting_type=en, item_id= 45848 , name_2="魔法攻撃強化"        }
, ["MAKKO"                   ] = { name="マッコ"                            , crafting_type=en, item_id= 45832 , name_2="マジカ"          , name_3="マジカ"            }
, ["MAKKOMA"                 ] = { name="マッコマ"                           , crafting_type=en, item_id= 45835 , name_2="マジカ再生"         }
, ["MEIP"                    ] = { name="メイプ"                            , crafting_type=en, item_id= 45840 , name_2="雷撃"            }
, ["OKO"                     ] = { name="オコ"                             , crafting_type=en, item_id= 45831 , name_2="体力"           , name_3="体力"             }
, ["OKOMA"                   ] = { name="オコマ"                            , crafting_type=en, item_id= 45834 , name_2="体力再生"          }
, ["OKORI"                   ] = { name="オコリ"                            , crafting_type=en, item_id= 45843 , name_2="武器強化"          }
, ["ORU"                     ] = { name="オル"                             , crafting_type=en, item_id= 45846 , name_2="薬品強化"          }
, ["RAKEIPA"                 ] = { name="ラケイパ"                           , crafting_type=en, item_id= 45838 , name_2="炎"             }
, ["TADERI"                  ] = { name="タデリ"                            , crafting_type=en, item_id= 45847 , name_2="物理攻撃強化"        }

, ["TA"                      ] = { name="ター"                             , crafting_type=en, item_id= 45850 , name_2="Normal"   }
, ["JEJOTA"                  ] = { name="ジェジョタ"                          , crafting_type=en, item_id= 45851 , name_2="Fine"     }
, ["DENATA"                  ] = { name="デナタ"                            , crafting_type=en, item_id= 45852 , name_2="Superior" }
, ["REKUTA"                  ] = { name="レクタ"                            , crafting_type=en, item_id= 45853 , name_2="Epic"     }
, ["KUTA"                    ] = { name="クター"                            , crafting_type=en, item_id= 45854 , name_2="Legendary"}
}


-- Alchemy Traits ------------------------------------------------------------

-- Answering "which trait?" for "Craft a potion/poison with the following traits".
--
-- trait_index      integer 1 through 30. Appears in one of the 4 bytes of
--                  itemLink for potions/poisons with this trait.
--
-- name             user-visible name of this trait. Often appears as part of
--                  potion name. Sometimes appears as part of poison name.
--
-- master_potion    name of a rank 9 potion with this trait. Appears as part
--                  of master writ requests.
--
-- master_poison    name of a rank 9 poison with this trait. Appears as part
--                  of master writ requests.
--
LibCraftText.ALCHEMY_TRAIT = {
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="体力回復"                     , master_potion="体力 のエキス"                           , master_poison="体力吸収の毒 9"                          , daily_potion_name="体力"                           , daily_poison_name="体力吸収"                         }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="体力減少"                     , master_potion="体力減少 のエキス"                         , master_poison="体力減少の毒 9"                          , daily_potion_name="体力減少"                         , daily_poison_name="体力減少"                         , daily_poison_name2="体力減少"                         }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="マジカ回復"                    , master_potion="マジカ のエキス"                          , master_poison="マジカ吸収の毒 9"                         , daily_potion_name="マジカ"                          , daily_poison_name="マジカ吸収"                        }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="マジカ減少"                    , master_potion="マジカ減少 のエキス"                        , master_poison="マジカ減少の毒 9"                         , daily_potion_name="マジカ減少"                        , daily_poison_name="マジカ減少"                        }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="スタミナ回復"                   , master_potion="スタミナ のエキス"                         , master_poison="スタミナ吸収の毒 9"                        , daily_potion_name="スタミナ"                         , daily_poison_name="スタミナ吸収"                       }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="スタミナ減少"                   , master_potion="スタミナ減少 のエキス"                       , master_poison="スタミナ減少の毒 9"                        , daily_potion_name="スタミナ減少"                       , daily_poison_name="スタミナ減少"                       }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="呪文耐性増大"                   , master_potion="呪文防御 のエキス"                         , master_poison="結界吸収の毒 9"                          }
,   ["BREACH"                 ] = { trait_index=08, name="侵害"                       , master_potion="呪文防御減少 のエキス"                       , master_poison="侵害の毒 9"                            }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="防御力増大"                    , master_potion="防具 のエキス"                           , master_poison="強固吸収の毒 9"                          }
,   ["FRACTURE"               ] = { trait_index=10, name="破砕"                       , master_potion="鎧破損度 のエキス"                         , master_poison="破砕の毒 9"                            }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="呪文攻撃力上昇"                  , master_potion="呪文攻撃力 のエキス"                        , master_poison="魔術吸収の毒 9"                          }
,   ["COWARDICE"              ] = { trait_index=12, name="臆病"                       , master_potion="臆病 のエキス"                           , master_poison="臆病の毒 9"                            }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="武器攻撃力上昇"                  , master_potion="武器攻撃力 のエキス"                        , master_poison="残忍吸収の毒 9"                          }
,   ["MAIM"                   ] = { trait_index=14, name="不自由"                      , master_potion="不自由 のエキス"                          , master_poison="不自由の毒 9"                           }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="呪文クリティカル"                 , master_potion="呪文クリティカル のエキス"                     , master_poison="予言吸収の毒 9"                          }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="不信"                       , master_potion="不信 のエキス"                           , master_poison="不信の毒 9"                            }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="武器クリティカル"                 , master_potion="武器クリティカル のエキス"                     , master_poison="獰猛吸収の毒 9"                          }
,   ["ENERVATION"             ] = { trait_index=18, name="弱体化"                      , master_potion="弱体化 のエキス"                          , master_poison="弱体化の毒 9"                           }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="猪突猛進"                     , master_potion="不動性 のエキス"                          , master_poison="逃避者の毒 9"                           }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="罠"                        , master_potion="罠 のエキス"                            , master_poison="罠の毒 9"                             }
,   ["DETECTION"              ] = { trait_index=21, name="探知"                       , master_potion="探知 のエキス"                           , master_poison="ステルス吸収の毒 9"                        }
,   ["INVISIBLE"              ] = { trait_index=22, name="透明化"                      , master_potion="透明化 のエキス"                          , master_poison="露見の毒 9"                            }
,   ["SPEED"                  ] = { trait_index=23, name="加速"                       , master_potion="加速 のエキス"                           , master_poison="速度吸収の毒 9"                          }
,   ["HINDRANCE"              ] = { trait_index=24, name="妨害"                       , master_potion="妨害 のエキス"                           , master_poison="妨害の毒 9"                            }
,   ["PROTECTION"             ] = { trait_index=25, name="防護"                       , master_potion="防御 のエキス"                           , master_poison="防御逆転の毒 9"                          }
,   ["VULNERABILITY"          ] = { trait_index=26, name="脆弱"                       , master_potion="脆弱 のエキス"                           , master_poison="脆弱の毒 9"                            }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="体力継続"                     , master_potion="体力継続 のエキス"                         , master_poison="体力吸収継続の毒 9"                        }
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="体力漸減"                     , master_potion="体力減少継続 のエキス"                       , master_poison="体力減少継続の毒 9"                        }
,   ["VITALITY"               ] = { trait_index=29, name="生命力"                      , master_potion="生命力 のエキス"                          , master_poison="生命力吸収の毒 9"                         }
,   ["DEFILE"                 ] = { trait_index=30, name="汚染"                       , master_potion="汚染 のエキス"                           , master_poison="汚染の毒 9"                            }
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

