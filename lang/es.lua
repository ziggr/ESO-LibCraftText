
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Encargo de herrería"           -- "Blacksmith Writ"
,   [cl] = "Encargo de sastrería"          -- "Clothier Writ"
,   [en] = "Encargo de encantamiento"       -- "Enchanter Writ"
,   [al] = "Encargo de alquimia"            -- "Alchemist Writ"
,   [pr] = "Encargo de provisiones"         -- "Provisioner Writ"
,   [ww] = "Encargo de carpintería"        -- "Woodworker Writ"
,   [jw] = "Encargo de artesanía de joyería"    -- "Jewelry Crafting Writ"
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
    [bs] = { "A Masterful Plate"                  --  "A Masterful Plate"
           , "Un arma magistral"                } --  "A Masterful Weapon"
,   [cl] = { "Masterful Tailoring"                --  "Masterful Tailoring"
           , "Una prenda de cuero magistral"    } --  "Masterful Leatherwear"
,   [en] = { "A Masterful Glyph"                } --  "A Masterful Glyph"
,   [al] = { "A Masterful Concoction"           } --  "A Masterful Concoction"
,   [pr] = { "A Masterful Feast"                } --  "A Masterful Feast"
,   [ww] = { "A Masterful Shield"                 --  "A Masterful Shield"
           , "Un arma magistral"                } --  "A Masterful Weapon"
,   [jw] = { "Masterful Jewelry"                } --  "Masterful Jewelry"
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

