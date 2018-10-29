
-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

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
           , "Un vêtement de cuir magistral"   } -- "Masterful Leatherwear"
,   [en] = { "Un glyphe magistral"              } -- "A Masterful Glyph"
,   [al] = { "Une concoction magistrale"        } -- "A Masterful Concoction"
,   [pr] = { "Un festin magistral"              } -- "A Masterful Feast"
,   [ww] = { "Un bouclier magistral"              -- "A Masterful Shield"
           , "Une arme magistrale"              } -- "A Masterful Weapon"
,   [jw] = { "Joaillerie magistrale"            } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualité"                        -- "Quality"
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

LibCraftText.MATERIALS = {
    ["bs" ] = { "fer"                -- "iron"
              , "acier"              -- "steel"
              , "orichalque"         -- "orichalc"
              , "dwemère"           -- "dwarven"
              , "ébonite"           -- "ebon"
              , "calcinium"          -- "calcinium"
              , "galatite"           -- "galatite"
              , "mercure"            -- "quicksilver"
              , "acier du néant"    -- "voidsteel"
              , "cuprite"            -- "Rubedite"
              }
,   ["lgt"] = { "artisanales"        -- "homespun"
              , "lin"                -- "linen"
              , "coton"              -- "cotton"
              , "soie d'araignée"    -- "spidersilk"
              , "fil d'ébonite"     -- "ebonthread"
              , "kresh"              -- "kresh"
              , "fil de fer"         -- "ironthread"
              , "fil d'argent"       -- "silverweave"
              , "tissombre"          -- "shadowspun"
              , "soie ancestrales"    -- "Ancestor Silk"
              }
,   ["med"] = { "cuir brut"          -- "rawhide"
              , "peau"               -- "hide"
              , "cuir"               -- "leather"
              , "cuir complet"       -- "full-leather"
              , "déchu"             -- "fell"
              , "cuir clouté"       -- "brigandine"
              , "peau de fer"        -- "ironhide"
              , "superbe"            -- "superb"
              , "peau d'ombre"       -- "shadowhide"
              , "cuir pourpre"       -- "Rubedo Leather"
              }
,   ["ww" ] = { "érable"            -- "maple"
              , "chêne"             -- "oak"
              , "hêtre"             -- "beech"
              , "noyer"              -- "hickory"
              , "if"                 -- "yew"
              , "bouleau"            -- "birch"
              , "frêne"             -- "ash"
              , "acajou"             -- "mahogany"
              , "bois de nuit"       -- "nightwood"
              , "frêne roux"        -- "Ruby Ash"
              }
,   ["jw" ] = { "étain"             -- "pewter"
              , "cuivre"             -- "copper"
              , "argent"             -- "silver"
              , "électrum"          -- "electrum"
              , "platine"            -- "platinum"
              }

}
