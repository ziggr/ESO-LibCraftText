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
    [bs] = "鍛冶師の依頼"             -- "Blacksmith Writ"
,   [cl] = "仕立師の依頼"             -- "Clothier Writ"
,   [en] = "付呪師の依頼"             -- "Enchanter Writ"
,   [al] = "錬金術師の依頼"          -- "Alchemist Writ"
,   [pr] = "調理師の依頼"             -- "Provisioner Writ"
,   [ww] = "木工師の依頼"             -- "Woodworker Writ"
,   [jw] = "宝飾師のクラフト依頼"    -- "Jewelry Crafting Writ"
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
  ["H1_AXE"         ] = { name="斧"                  , master_name="斧"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "axe"
, ["H1_MACE"        ] = { name="メイス"            , master_name="メイス"                 , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "mace"
, ["H1_SWORD"       ] = { name="剣"                  , master_name="剣"                       , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="両手斧"            , master_name="両手斧"                 , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="大槌"               , master_name="大槌"                    , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="大剣"               , master_name="大剣"                    , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "greatsword"
, ["DAGGER"         ] = { name="短剣"               , master_name="短剣"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap } -- "dagger"
, ["CUIRASS"        ] = { name="胸当て"            , master_name="胸当て"                 , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "cuirass"
, ["SABATONS"       ] = { name="サバトン"         , master_name="サバトン"              , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="篭手"               , master_name="篭手"                    , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "gauntlets"
, ["HELM"           ] = { name="兜"                  , master_name="兜"                       , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "helm"
, ["GREAVES"        ] = { name="グリーヴ"         , master_name="グリーヴ"              , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "greaves"
, ["PAULDRON"       ] = { name="ポールドロン"    , master_name="ポールドロン"         , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "pauldron"
, ["GIRDLE"         ] = { name="ガードル"         , master_name="ガードル"              , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr } -- "girdle"

, ["ROBE"           ] = { name="ローブ"            , master_name="ローブ"                 , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "robe"
, ["JERKIN"         ] = { name="ジャーキン"      , master_name="ジャーキン"           , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "jerkin"
, ["SHOES"          ] = { name="靴"                  , master_name="靴"                       , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "shoes"
, ["GLOVES"         ] = { name="手袋"               , master_name="手袋"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "gloves"
, ["HAT"            ] = { name="帽子"               , master_name="帽子"                    , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "hat"
, ["BREECHES"       ] = { name="パンツ"            , master_name="パンツ"                 , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "breeches"
, ["EPAULETS"       ] = { name="肩当て"            , master_name="肩当て"                 , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "epaulets"
, ["SASH"           ] = { name="サッシュ"         , master_name="サッシュ"              , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr } -- "sash"
, ["JACK"           ] = { name="胴当て"            , master_name="胴当て"                 , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "jack"
, ["BOOTS"          ] = { name="ブーツ"            , master_name="ブーツ"                 , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "boots"
, ["BRACERS"        ] = { name="腕当て"            , master_name="腕当て"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "bracers"
, ["HELMET"         ] = { name="兜"                  , master_name="兜"                       , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "helmet"
, ["GUARDS"         ] = { name="すね当て"         , master_name="すね当て"              , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "guards"
, ["ARM_COPS"       ] = { name="アームカップ"    , master_name="アームカップ"         , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "arm cops"
, ["BELT"           ] = { name="ベルト"            , master_name="ベルト"                 , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr } -- "belt"

, ["BOW"            ] = { name="弓"                  , master_name="弓"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="業火の杖"         , master_name="業火の杖"              , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="氷の杖"            , master_name="氷の杖"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="稲妻の杖"         , master_name="稲妻の杖"              , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="回復の杖"         , master_name="回復の杖"              , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap } -- "restoration staff"
, ["SHIELD"         ] = { name="盾"                  , master_name="盾"                       , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr } -- "shield"

, ["NECKLACE"       ] = { name="ネックレス"      , master_name="ネックレス"           , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "necklace"
, ["RING"           ] = { name="リング"            , master_name="指輪"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=mat_jewl, trait_set_id=trait_jewl } -- "ring"
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
  ["IRON"          ] = { name="鉄"               , crafting_type=bs, mat_set_id=mat_hvy , material_index= 1, master_writ2=  1, level_index= 1  } -- "iron"
, ["STEEL"         ] = { name="鋼鉄"            , crafting_type=bs, mat_set_id=mat_hvy , material_index= 8, master_writ2=  9, level_index= 2  } -- "steel"
, ["ORICHALC"      ] = { name="オリハルコン"    , crafting_type=bs, mat_set_id=mat_hvy , material_index=13, master_writ2=156, level_index= 3  } -- "orichalc"
, ["DWARVEN"       ] = { name="ドワーフ"      , crafting_type=bs, mat_set_id=mat_hvy , material_index=18, master_writ2=160, level_index= 4  } -- "dwarven"
, ["EBON"          ] = { name="黒檀"            , crafting_type=bs, mat_set_id=mat_hvy , material_index=23, master_writ2=164, level_index= 5  } -- "ebon"
, ["CALCINIUM"     ] = { name="カルシニウム"    , crafting_type=bs, mat_set_id=mat_hvy , material_index=26, master_writ2=168, level_index= 6  } -- "calcinium"
, ["GALATITE"      ] = { name="ガラタイト"    , crafting_type=bs, mat_set_id=mat_hvy , material_index=29, master_writ2=172, level_index= 7  } -- "galatite"
, ["QUICKSILVER"   ] = { name="水銀"            , crafting_type=bs, mat_set_id=mat_hvy , material_index=32, master_writ2=176, level_index= 8  } -- "quicksilver"
, ["VOIDSTEEL"     ] = { name="虚無の鉄"      , crafting_type=bs, mat_set_id=mat_hvy , material_index=34, master_writ2=180, level_index= 9  } -- "voidsteel"
, ["RUBEDITE"      ] = { name="ルベダイト"    , crafting_type=bs, mat_set_id=mat_hvy , material_index=40, master_writ2=188, level_index=10  } -- "Rubedite"

, ["HOMESPUN"      ] = { name="手織り布"      , crafting_type=cl, mat_set_id=mat_lgt , material_index= 1, master_writ2=  5, level_index= 1 } -- "homespun"
, ["LINEN"         ] = { name="リネン"         , crafting_type=cl, mat_set_id=mat_lgt , material_index= 8, master_writ2= 45, level_index= 2 } -- "linen"
, ["COTTON"        ] = { name="コットン"      , crafting_type=cl, mat_set_id=mat_lgt , material_index=13, master_writ2= 47, level_index= 3 } -- "cotton"
, ["SPIDERSILK"    ] = { name="スパイダーシルク"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=18, master_writ2= 49, level_index= 4 } -- "spidersilk"
, ["EBONTHREAD"    ] = { name="エボンスレッド"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=23, master_writ2= 51, level_index= 5 } -- "ebonthread"
, ["KRESH"         ] = { name="クレッシュ"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=26, master_writ2=125, level_index= 6 } -- "kresh"
, ["IRONTHREAD"    ] = { name="アイアンスレッド"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=29, master_writ2=126, level_index= 7 } -- "ironthread"
, ["SILVERWEAVE"   ] = { name="シルバーウィーブ"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=32, master_writ2=127, level_index= 8 } -- "silverweave"
, ["SHADOWSPUN"    ] = { name="影の布"         , crafting_type=cl, mat_set_id=mat_lgt , material_index=34, master_writ2=128, level_index= 9 } -- "shadowspun"
, ["ANCESTOR_SILK" ] = { name="先人のシルク"    , crafting_type=cl, mat_set_id=mat_lgt , material_index=40, master_writ2=194, level_index=10 } -- "Ancestor Silk"

, ["RAWHIDE"       ] = { name="生皮"            , crafting_type=cl, mat_set_id=mat_med , material_index= 1, master_writ2=148, level_index= 1 } -- "rawhide"
, ["HIDE"          ] = { name="皮"               , crafting_type=cl, mat_set_id=mat_med , material_index= 8, master_writ2=154, level_index= 2 } -- "hide"
, ["LEATHER"       ] = { name="革"               , crafting_type=cl, mat_set_id=mat_med , material_index=13, master_writ2=158, level_index= 3 } -- "leather"
, ["FULL_LEATHER"  ] = { name="フルレザー"    , crafting_type=cl, mat_set_id=mat_med , material_index=18, master_writ2=162, level_index= 4 } -- "full-leather"
, ["FELL"          ] = { name="フェルハイド"    , crafting_type=cl, mat_set_id=mat_med , material_index=23, master_writ2=166, level_index= 5 } -- "fell"
, ["BRIGANDINE"    ] = { name="ブリガンダイン"    , crafting_type=cl, mat_set_id=mat_med , material_index=26, master_writ2=170, level_index= 6 } -- "brigandine"
, ["IRONHIDE"      ] = { name="アイアンハイド"    , crafting_type=cl, mat_set_id=mat_med , material_index=29, master_writ2=174, level_index= 7 } -- "ironhide"
, ["SUPERB"        ] = { name="最上"            , crafting_type=cl, mat_set_id=mat_med , material_index=32, master_writ2=131, level_index= 8 } -- "superb"
, ["SHADOWHIDE"    ] = { name="シャドウハイド"    , crafting_type=cl, mat_set_id=mat_med , material_index=34, master_writ2=132, level_index= 9 } -- "shadowhide"
, ["RUBEDO_LEATHER"] = { name="ルベドレザー"    , crafting_type=cl, mat_set_id=mat_med , material_index=40, master_writ2=190, level_index=10 } -- "Rubedo Leather"

, ["MAPLE"         ] = { name="カエデ"         , crafting_type=ww, mat_set_id=mat_wood, material_index= 1, master_writ2=  2, level_index= 1  } -- "maple"
, ["OAK"           ] = { name="カシ"            , crafting_type=ww, mat_set_id=mat_wood, material_index= 8, master_writ2= 18, level_index= 2  } -- "oak"
, ["BEECH"         ] = { name="ブナノキ"      , crafting_type=ww, mat_set_id=mat_wood, material_index=13, master_writ2= 20, level_index= 3  } -- "beech"
, ["HICKORY"       ] = { name="ヒッコリー"    , crafting_type=ww, mat_set_id=mat_wood, material_index=18, master_writ2= 22, level_index= 4  } -- "hickory"
, ["YEW"           ] = { name="イチイ"         , crafting_type=ww, mat_set_id=mat_wood, material_index=23, master_writ2= 24, level_index= 5  } -- "yew"
, ["BIRCH"         ] = { name="カバノキ"      , crafting_type=ww, mat_set_id=mat_wood, material_index=26, master_writ2=133, level_index= 6  } -- "birch"
, ["ASH"           ] = { name="アッシュ"      , crafting_type=ww, mat_set_id=mat_wood, material_index=29, master_writ2=134, level_index= 7  } -- "ash"
, ["MAHOGANY"      ] = { name="マホガニー"    , crafting_type=ww, mat_set_id=mat_wood, material_index=32, master_writ2=135, level_index= 8  } -- "mahogany"
, ["NIGHTWOOD"     ] = { name="ナイトウッド"    , crafting_type=ww, mat_set_id=mat_wood, material_index=34, master_writ2=136, level_index= 9  } -- "nightwood"
, ["RUBY_ASH"      ] = { name="ルビーアッシュ"    , crafting_type=ww, mat_set_id=mat_wood, material_index=40, master_writ2=192, level_index=10  } -- "Ruby Ash"

, ["PEWTER"        ] = { name="ピューター"    , crafting_type=jw, mat_set_id=mat_jewl, material_index= 1, master_writ2=  6, level_index= 1  } -- "pewter"
, ["COPPER"        ] = { name="銅"               , crafting_type=jw, mat_set_id=mat_jewl, material_index=13, master_writ2= 56, level_index= 2  } -- "copper"
, ["SILVER"        ] = { name="銀"               , crafting_type=jw, mat_set_id=mat_jewl, material_index=26, master_writ2=137, level_index= 3  } -- "silver"
, ["ELECTRUM"      ] = { name="琥珀金"         , crafting_type=jw, mat_set_id=mat_jewl, material_index=33, master_writ2=139, level_index= 4  } -- "electrum"
, ["PLATINUM"      ] = { name="プラチナ"      , crafting_type=jw, mat_set_id=mat_jewl, material_index=40, master_writ2=255, level_index= 5  } -- "platinum"
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
    [bs] = { "優れた防具"                    -- "A Masterful Plate"
           , "優れた武器"                  } -- "A Masterful Weapon"
,   [cl] = { "優れた服"                       -- "Masterful Tailoring"
           , "優れた革装備"               } -- "Masterful Leatherwear"
,   [en] = { "優れたグリフ"               } -- "A Masterful Glyph"
,   [al] = { "優れた調合薬"               } -- "A Masterful Concoction"
,   [pr] = { "優れた料理"                  } -- "A Masterful Feast"
,   [ww] = { "優れた盾"                       -- "A Masterful Shield"
           , "優れた武器"                  } -- "A Masterful Weapon"
,   [jw] = { "優れた宝飾"                  } -- "Masterful Jewelry"
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

