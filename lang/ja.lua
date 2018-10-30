
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

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
    ["bs" ] = { "鉄"                -- "iron"
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
,   ["lgt"] = { "手織り布"       -- "homespun"
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
,   ["med"] = { "生皮"             -- "rawhide"
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
,   ["ww" ] = { "カエデ"          -- "maple"
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
,   ["jw" ] = { "ピューター"    -- "pewter"
              , "銅"                -- "copper"
              , "銀"                -- "silver"
              , "琥珀金"          -- "electrum"
              , "プラチナ"       -- "platinum"
              }
}

LibCraftText.ITEMS = {
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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Fine"                     -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Epic"                     -- "Epic"
,   [5] = "Legendary"                -- "Legendary"
}

