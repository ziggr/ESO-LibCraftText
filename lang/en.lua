
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING     --  3
local al = CRAFTING_TYPE_ALCHEMY        --  4
local pr = CRAFTING_TYPE_PROVISIONING   --  5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Blacksmith Writ"
,   [cl] = "Clothier Writ"
,   [en] = "Enchanter Writ"
,   [al] = "Alchemist Writ"
,   [pr] = "Provisioner Writ"
,   [ww] = "Woodworker Writ"
,   [jw] = "Jewelry Crafting Writ"
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
    [bs] = {"A Masterful Plate"     , "A Masterful Weapon"    }
,   [cl] = {"Masterful Tailoring"   , "Masterful Leatherwear" }
,   [en] = {"A Masterful Glyph"     }
,   [al] = {"A Masterful Concoction"}
,   [pr] = {"A Masterful Feast"     }
,   [ww] = {"A Masterful Shield"    , "A Masterful Weapon"    }
,   [jw] = {"Masterful Jewelry"     }
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"
,   ["accept"]         = "<Accept the contract.>"
,   ["finish"]         = "<Finish the job.>"
,   ["deliver_substr"] = "Deliver"

,   [bs] = "I've finished the Blacksmithing job."
,   [cl] = "I've finished the Clothier job."
,   [en] = "I've finished the Enchanting job."
,   [al] = "I've finished the Alchemy job."
,   [pr] = "I've finished the Provisioning job."
,   [ww] = "I've finished the Woodworking job."
,   [jw] = "I've finished the Jewelry job."
}

