
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
    [bs] = { "優れた防具"                    --  "A Masterful Plate"
           , "優れた武器"                  } --  "A Masterful Weapon"
,   [cl] = { "優れた服"                       --  "Masterful Tailoring"
           , "優れた革装備"               } --  "Masterful Leatherwear"
,   [en] = { "優れたグリフ"               } --  "A Masterful Glyph"
,   [al] = { "優れた調合薬"               } --  "A Masterful Concoction"
,   [pr] = { "優れた料理"                  } --  "A Masterful Feast"
,   [ww] = { "優れた盾"                       --  "A Masterful Shield"
           , "優れた武器"                  } --  "A Masterful Weapon"
,   [jw] = { "優れた宝飾"                  } --  "Masterful Jewelry"
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

