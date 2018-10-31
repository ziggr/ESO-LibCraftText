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
    [bs] = "Blacksmith Writ"                -- "Blacksmith Writ"
,   [cl] = "Clothier Writ"                  -- "Clothier Writ"
,   [en] = "Enchanter Writ"                 -- "Enchanter Writ"
,   [al] = "Alchemist Writ"                 -- "Alchemist Writ"
,   [pr] = "Provisioner Writ"               -- "Provisioner Writ"
,   [ww] = "Woodworker Writ"                -- "Woodworker Writ"
,   [jw] = "Jewelry Crafting Writ"          -- "Jewelry Crafting Writ"
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
    [bs] = { "A Masterful Plate"                  -- "A Masterful Plate"
           , "A Masterful Weapon"               } -- "A Masterful Weapon"
,   [cl] = { "Masterful Tailoring"                -- "Masterful Tailoring"
           , "Masterful Leatherwear"            } -- "Masterful Leatherwear"
,   [en] = { "A Masterful Glyph"                } -- "A Masterful Glyph"
,   [al] = { "A Masterful Concoction"           } -- "A Masterful Concoction"
,   [pr] = { "A Masterful Feast"                } -- "A Masterful Feast"
,   [ww] = { "A Masterful Shield"                 -- "A Masterful Shield"
           , "A Masterful Weapon"               } -- "A Masterful Weapon"
,   [jw] = { "Masterful Jewelry"                } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualità"                        -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Stile"                           -- "Style"
,   ["trait"  ] =  "Tratti"                          -- "Trait"
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
    [hvy] =   { "iron"               -- "iron"
              , "steel"              -- "steel"
              , "orichalc"           -- "orichalc"
              , "dwarven"            -- "dwarven"
              , "ebon"               -- "ebon"
              , "calcinium"          -- "calcinium"
              , "galatite"           -- "galatite"
              , "quicksilver"        -- "quicksilver"
              , "voidsteel"          -- "voidsteel"
              , "Rubedite"           -- "Rubedite"
              }
,   [lgt] =   { "homespun"           -- "homespun"
              , "linen"              -- "linen"
              , "cotton"             -- "cotton"
              , "spidersilk"         -- "spidersilk"
              , "ebonthread"         -- "ebonthread"
              , "kresh"              -- "kresh"
              , "ironthread"         -- "ironthread"
              , "silverweave"        -- "silverweave"
              , "shadowspun"         -- "shadowspun"
              , "Ancestor Silk"      -- "Ancestor Silk"
              }
,   [med] =   { "rawhide"            -- "rawhide"
              , "hide"               -- "hide"
              , "leather"            -- "leather"
              , "full-leather"       -- "full-leather"
              , "fell"               -- "fell"
              , "brigandine"         -- "brigandine"
              , "ironhide"           -- "ironhide"
              , "superb"             -- "superb"
              , "shadowhide"         -- "shadowhide"
              , "Rubedo Leather"     -- "Rubedo Leather"
              }
,   [ww ] =   { "maple"              -- "maple"
              , "oak"                -- "oak"
              , "beech"              -- "beech"
              , "hickory"            -- "hickory"
              , "yew"                -- "yew"
              , "birch"              -- "birch"
              , "ash"                -- "ash"
              , "mahogany"           -- "mahogany"
              , "nightwood"          -- "nightwood"
              , "Ruby Ash"           -- "Ruby Ash"
              }
,   [jw ] =   { "pewter"             -- "pewter"
              , "copper"             -- "copper"
              , "silver"             -- "silver"
              , "electrum"           -- "electrum"
              , "platinum"           -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "Axe"                       -- "Axe"
         , [56] = "Mace"                      -- "Mace"
         , [59] = "Spada"                     -- "Sword"
         , [68] = "Grande Ascia"              -- "Battle Axe"
         , [69] = "Maul"                      -- "Maul"
         , [67] = "Greatsword"                -- "Greatsword"
         , [62] = "Dagger"                    -- "Dagger"
         , [46] = "Corazza"                   -- "Cuirass"
         , [50] = "Sabatons"                  -- "Sabatons"
         , [52] = "Gauntlets"                 -- "Gauntlets"
         , [44] = "Elmo"                      -- "Helm"
         , [49] = "Gambali"                   -- "Greaves"
         , [47] = "Spallaccio"                -- "Pauldron"
         , [48] = "Girdle"                    -- "Girdle"
         }
, [cl] = {
           [28] = "Veste"                     -- "Robe"
         , [75] = "Giaco"                     -- "Jerkin"
         , [32] = "Scarpe"                    -- "Shoes"
         , [34] = "Guanti"                    -- "Gloves"
         , [26] = "Cappello"                  -- "Hat"
         , [31] = "Calzoni"                   -- "Breeches"
         , [29] = "Coprispalle"               -- "Epaulets"
         , [30] = "Fascia"                    -- "Sash"
         , [37] = "Corpetto"                  -- "Jack"
         , [41] = "Stivali"                   -- "Boots"
         , [43] = "Bracciali"                 -- "Bracers"
         , [35] = "Elmetto"                   -- "Helmet"
         , [40] = "Pantaloni"                 -- "Guards"
         , [38] = "Spalline"                  -- "Arm Cops"
         , [39] = "Cintura"                   -- "Belt"
         }
, [ww] = {
           [70] = "Bow"                       -- "Bow"
         , [72] = "Bastone del Fuoco"         -- "Inferno Staff"
         , [73] = "Frost Staff"               -- "Ice Staff"
         , [74] = "Lightning Staff"           -- "Lightning Staff"
         , [71] = "Healing Staff"             -- "Restoration Staff"
         , [65] = "Scudo"                     -- "Shield"
         }
, [jw] = {
           [18] = "Necklace"                  -- "Necklace"
         , [24] = "Ring"                      -- "Ring"
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
           [ 1] = "ascia"                     -- "axe"
         , [ 2] = "mazza"                     -- "mace"
         , [ 3] = "spada"                     -- "wword"
         , [ 4] = "ascia da battaglia"        -- "battle Axe"
         , [ 5] = "maglio"                    -- "maul"
         , [ 6] = "spadone"                   -- "greatsword"
         , [ 7] = "pugnale"                   -- "dagger"
         , [ 8] = "corazza"                   -- "cuirass"
         , [ 9] = "schinieri"                 -- "sabatons"
         , [10] = "mittene"                   -- "gauntlets"
         , [11] = "elmo"                      -- "helm"
         , [12] = "gambali"                   -- "greaves"
         , [13] = "spallaccio"                -- "pauldron"
         , [14] = "cinturone"                 -- "girdle"
         }
, [cl] = {
           [ 1] = "veste"                     -- "robe"
         , [ 2] = "giaco"                     -- "jerkin"
         , [ 3] = "scarpe"                    -- "shoes"
         , [ 4] = "guanti"                    -- "gloves"
         , [ 5] = "cappello"                  -- "hat"
         , [ 6] = "calzoni"                   -- "breeches"
         , [ 7] = "coprispalle"               -- "epaulets"
         , [ 8] = "fascia"                    -- "sash"
         , [ 9] = "corpetto"                  -- "jack"
         , [10] = "stivali"                   -- "boots"
         , [11] = "bracciali"                 -- "bracers"
         , [12] = "elmetto"                   -- "helmet"
         , [13] = "pantaloni"                 -- "guards"
         , [14] = "spalline"                  -- "arm cops"
         , [15] = "cintura"                   -- "belt"
         }
, [ww] = {
           [ 1] = "arco"                      -- "bow"
         , [ 3] = "bastone del fuoco"         -- "inferno staff"
         , [ 4] = "bastone del gelo"          -- "ice staff"
         , [ 5] = "bastone del fulmine"       -- "lightning staff"
         , [ 6] = "bastone di cura"           -- "restoration staff"
         , [ 2] = "scudo"                     -- "shield"
         }
, [jw] = {
           [ 2] = "collana"                   -- "necklace"
         , [ 1] = "anello"                    -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normale"                  -- "Normal"
,   [2] = "Buono"                    -- "Fine"
,   [3] = "Superiore"                -- "Superior"
,   [4] = "Epico"                    -- "Epic"
,   [5] = "Leggendario"              -- "Legendary"
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
  ["H1_AXE"         ] = { name="ascia"                , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="mazza"                , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="spada"                , master_name="Spada"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="ascia da battaglia"    , master_name="Grande Ascia"              , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="maglio"               , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="spadone"              , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="pugnale"              , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="corazza"              , master_name="Corazza"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="schinieri"            , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="mittene"              , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="elmo"                 , master_name="Elmo"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="gambali"              , master_name="Gambali"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="spallaccio"           , master_name="Spallaccio"                , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="cinturone"            , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="veste"                , master_name="Veste"                     , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="giaco"                , master_name="Giaco"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="scarpe"               , master_name="Scarpe"                    , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="guanti"               , master_name="Guanti"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="cappello"             , master_name="Cappello"                  , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="calzoni"              , master_name="Calzoni"                   , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="coprispalle"          , master_name="Coprispalle"               , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="fascia"               , master_name="Fascia"                    , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="corpetto"             , master_name="Corpetto"                  , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="stivali"              , master_name="Stivali"                   , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="bracciali"            , master_name="Bracciali"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="elmetto"              , master_name="Elmetto"                   , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="pantaloni"            , master_name="Pantaloni"                 , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="spalline"             , master_name="Spalline"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="cintura"              , master_name="Cintura"                   , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="arco"                 , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="bastone del fuoco"    , master_name="Bastone del Fuoco"         , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="bastone del gelo"     , master_name="Frost Staff"               , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="bastone del fulmine"    , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="bastone di cura"      , master_name="Healing Staff"             , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="scudo"                , master_name="Scudo"                     , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="collana"              , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="anello"               , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
