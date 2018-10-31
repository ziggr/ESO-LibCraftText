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
    [bs] = "鍛冶師の依頼"             -- "Blacksmith Writ"
,   [cl] = "仕立師の依頼"             -- "Clothier Writ"
,   [en] = "付呪師の依頼"             -- "Enchanter Writ"
,   [al] = "錬金術師の依頼"          -- "Alchemist Writ"
,   [pr] = "調理師の依頼"             -- "Provisioner Writ"
,   [ww] = "木工師の依頼"             -- "Woodworker Writ"
,   [jw] = "宝飾師のクラフト依頼"    -- "Jewelry Crafting Writ"
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
    [hvy] =   { "鉄"                -- "iron"
              , "鋼鉄"             -- "steel"
              , "オリハルコン"    -- "orichalc"
              , "ドワーフ"       -- "dwarven"
              , "黒檀"             -- "ebon"
              , "カルシニウム"    -- "calcinium"
              , "ガラタイト"    -- "galatite"
              , "水銀"             -- "quicksilver"
              , "虚無の鉄"       -- "voidsteel"
              , "ルベダイト"    -- "Rubedite"
              }
,   [lgt] =   { "手織り布"       -- "homespun"
              , "リネン"          -- "linen"
              , "コットン"       -- "cotton"
              , "スパイダーシルク"    -- "spidersilk"
              , "エボンスレッド"    -- "ebonthread"
              , "クレッシュ"    -- "kresh"
              , "アイアンスレッド"    -- "ironthread"
              , "シルバーウィーブ"    -- "silverweave"
              , "影の布"          -- "shadowspun"
              , "先人のシルク"    -- "Ancestor Silk"
              }
,   [med] =   { "生皮"             -- "rawhide"
              , "皮"                -- "hide"
              , "革"                -- "leather"
              , "フルレザー"    -- "full-leather"
              , "フェルハイド"    -- "fell"
              , "ブリガンダイン"    -- "brigandine"
              , "アイアンハイド"    -- "ironhide"
              , "最上"             -- "superb"
              , "シャドウハイド"    -- "shadowhide"
              , "ルベドレザー"    -- "Rubedo Leather"
              }
,   [ww ] =   { "カエデ"          -- "maple"
              , "カシ"             -- "oak"
              , "ブナノキ"       -- "beech"
              , "ヒッコリー"    -- "hickory"
              , "イチイ"          -- "yew"
              , "カバノキ"       -- "birch"
              , "アッシュ"       -- "ash"
              , "マホガニー"    -- "mahogany"
              , "ナイトウッド"    -- "nightwood"
              , "ルビーアッシュ"    -- "Ruby Ash"
              }
,   [jw ] =   { "ピューター"    -- "pewter"
              , "銅"                -- "copper"
              , "銀"                -- "silver"
              , "琥珀金"          -- "electrum"
              , "プラチナ"       -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "斧"                       -- "Axe"
         , [56] = "メイス"                 -- "Mace"
         , [59] = "剣"                       -- "Sword"
         , [68] = "両手斧"                 -- "Battle Axe"
         , [69] = "大槌"                    -- "Maul"
         , [67] = "大剣"                    -- "Greatsword"
         , [62] = "短剣"                    -- "Dagger"
         , [46] = "胸当て"                 -- "Cuirass"
         , [50] = "サバトン"              -- "Sabatons"
         , [52] = "篭手"                    -- "Gauntlets"
         , [44] = "兜"                       -- "Helm"
         , [49] = "グリーヴ"              -- "Greaves"
         , [47] = "ポールドロン"        -- "Pauldron"
         , [48] = "ガードル"              -- "Girdle"
         }
, [cl] = {
           [28] = "ローブ"                 -- "Robe"
         , [75] = "ジャーキン"           -- "Jerkin"
         , [32] = "靴"                       -- "Shoes"
         , [34] = "手袋"                    -- "Gloves"
         , [26] = "帽子"                    -- "Hat"
         , [31] = "パンツ"                 -- "Breeches"
         , [29] = "肩当て"                 -- "Epaulets"
         , [30] = "サッシュ"              -- "Sash"
         , [37] = "胴当て"                 -- "Jack"
         , [41] = "ブーツ"                 -- "Boots"
         , [43] = "腕当て"                 -- "Bracers"
         , [35] = "兜"                       -- "Helmet"
         , [40] = "すね当て"              -- "Guards"
         , [38] = "アームカップ"        -- "Arm Cops"
         , [39] = "ベルト"                 -- "Belt"
         }
, [ww] = {
           [70] = "弓"                       -- "Bow"
         , [72] = "業火の杖"              -- "Inferno Staff"
         , [73] = "氷の杖"                 -- "Ice Staff"
         , [74] = "稲妻の杖"              -- "Lightning Staff"
         , [71] = "回復の杖"              -- "Restoration Staff"
         , [65] = "盾"                       -- "Shield"
         }
, [jw] = {
           [18] = "ネックレス"           -- "Necklace"
         , [24] = "指輪"                    -- "Ring"
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
           [ 1] = "斧"                       -- "axe"
         , [ 2] = "メイス"                 -- "mace"
         , [ 3] = "剣"                       -- "wword"
         , [ 4] = "両手斧"                 -- "battle Axe"
         , [ 5] = "大槌"                    -- "maul"
         , [ 6] = "大剣"                    -- "greatsword"
         , [ 7] = "短剣"                    -- "dagger"
         , [ 8] = "胸当て"                 -- "cuirass"
         , [ 9] = "サバトン"              -- "sabatons"
         , [10] = "篭手"                    -- "gauntlets"
         , [11] = "兜"                       -- "helm"
         , [12] = "グリーヴ"              -- "greaves"
         , [13] = "ポールドロン"        -- "pauldron"
         , [14] = "ガードル"              -- "girdle"
         }
, [cl] = {
           [ 1] = "ローブ"                 -- "robe"
         , [ 2] = "ジャーキン"           -- "jerkin"
         , [ 3] = "靴"                       -- "shoes"
         , [ 4] = "手袋"                    -- "gloves"
         , [ 5] = "帽子"                    -- "hat"
         , [ 6] = "パンツ"                 -- "breeches"
         , [ 7] = "肩当て"                 -- "epaulets"
         , [ 8] = "サッシュ"              -- "sash"
         , [ 9] = "胴当て"                 -- "jack"
         , [10] = "ブーツ"                 -- "boots"
         , [11] = "腕当て"                 -- "bracers"
         , [12] = "兜"                       -- "helmet"
         , [13] = "すね当て"              -- "guards"
         , [14] = "アームカップ"        -- "arm cops"
         , [15] = "ベルト"                 -- "belt"
         }
, [ww] = {
           [ 1] = "弓"                       -- "bow"
         , [ 3] = "業火の杖"              -- "inferno staff"
         , [ 4] = "氷の杖"                 -- "ice staff"
         , [ 5] = "稲妻の杖"              -- "lightning staff"
         , [ 6] = "回復の杖"              -- "restoration staff"
         , [ 2] = "盾"                       -- "shield"
         }
, [jw] = {
           [ 2] = "ネックレス"           -- "necklace"
         , [ 1] = "リング"                 -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Fine"                     -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Epic"                     -- "Epic"
,   [5] = "Legendary"                -- "Legendary"
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
  ["H1_AXE"         ] = { name="斧"                  , master_name="斧"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="メイス"            , master_name="メイス"                 , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="剣"                  , master_name="剣"                       , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="両手斧"            , master_name="両手斧"                 , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="大槌"               , master_name="大槌"                    , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="大剣"               , master_name="大剣"                    , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="短剣"               , master_name="短剣"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="胸当て"            , master_name="胸当て"                 , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="サバトン"         , master_name="サバトン"              , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="篭手"               , master_name="篭手"                    , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="兜"                  , master_name="兜"                       , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="グリーヴ"         , master_name="グリーヴ"              , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="ポールドロン"    , master_name="ポールドロン"         , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="ガードル"         , master_name="ガードル"              , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="ローブ"            , master_name="ローブ"                 , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="ジャーキン"      , master_name="ジャーキン"           , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="靴"                  , master_name="靴"                       , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="手袋"               , master_name="手袋"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="帽子"               , master_name="帽子"                    , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="パンツ"            , master_name="パンツ"                 , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="肩当て"            , master_name="肩当て"                 , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="サッシュ"         , master_name="サッシュ"              , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="胴当て"            , master_name="胴当て"                 , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="ブーツ"            , master_name="ブーツ"                 , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="腕当て"            , master_name="腕当て"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="兜"                  , master_name="兜"                       , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="すね当て"         , master_name="すね当て"              , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="アームカップ"    , master_name="アームカップ"         , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="ベルト"            , master_name="ベルト"                 , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="弓"                  , master_name="弓"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="業火の杖"         , master_name="業火の杖"              , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="氷の杖"            , master_name="氷の杖"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="稲妻の杖"         , master_name="稲妻の杖"              , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="回復の杖"         , master_name="回復の杖"              , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="盾"                  , master_name="盾"                       , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="ネックレス"      , master_name="ネックレス"           , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="リング"            , master_name="指輪"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
