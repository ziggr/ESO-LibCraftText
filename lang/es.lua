
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
    [bs] = { "Una protección magistral"          -- "A Masterful Plate"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [cl] = { "Una prenda de tela magistral"       -- "Masterful Tailoring"
           , "Una prenda de cuero magistral"    } -- "Masterful Leatherwear"
,   [en] = { "Un glifo magistral"               } -- "A Masterful Glyph"
,   [al] = { "Una mezcla magistral"             } -- "A Masterful Concoction"
,   [pr] = { "Un festín magistral"             } -- "A Masterful Feast"
,   [ww] = { "Un escudo magistral"                -- "A Masterful Shield"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [jw] = { "Joyería magistral"               } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Calidad"                         -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Estilo"                          -- "Style"
,   ["trait"  ] =  "Rasgo"                           -- "Trait"
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

LibCraftText.MATERIALS = {
    ["bs" ] = { "hierro"             -- "iron"
              , "acero"              -- "steel"
              , "oricalco"           -- "orichalc"
              , "acero enano"        -- "dwarven"
              , "ébano"             -- "ebon"
              , "calcinio"           -- "calcinium"
              , "galatita"           -- "galatite"
              , "azogue"             -- "quicksilver"
              , "acero del vacío"    -- "voidsteel"
              , "rubedita"           -- "Rubedite"
              }
,   ["lgt"] = { "tejido artesanal"    -- "homespun"
              , "lino"               -- "linen"
              , "algodón"           -- "cotton"
              , "seda de araña"     -- "spidersilk"
              , "hilo de ébano"     -- "ebonthread"
              , "kresh"              -- "kresh"
              , "hilo de hierro"     -- "ironthread"
              , "hilo de plata"      -- "silverweave"
              , "tejido sombrío"    -- "shadowspun"
              , "seda ancestral"     -- "Ancestor Silk"
              }
,   ["med"] = { "piel cruda"         -- "rawhide"
              , "piel"               -- "hide"
              , "cuero"              -- "leather"
              , "cuero tratado"      -- "full-leather"
              , "piel impía"        -- "fell"
              , "brigantina"         -- "brigandine"
              , "piel férrea"       -- "ironhide"
              , "soberbio"           -- "superb"
              , "piel sombría"      -- "shadowhide"
              , "cuero rubedo"       -- "Rubedo Leather"
              }
,   ["ww" ] = { "arce"               -- "maple"
              , "roble"              -- "oak"
              , "haya"               -- "beech"
              , "nogal"              -- "hickory"
              , "tejo"               -- "yew"
              , "abedul"             -- "birch"
              , "fresno"             -- "ash"
              , "caoba"              -- "mahogany"
              , "nocteca"            -- "nightwood"
              , "fresno rubí"       -- "Ruby Ash"
              }
,   ["jw" ] = { "peltre"             -- "pewter"
              , "cobre"              -- "copper"
              , "plata"              -- "silver"
              , "electro"            -- "electrum"
              , "platino"            -- "platinum"
              }

}
