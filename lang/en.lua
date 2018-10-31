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
         , [59] = "Sword"                     -- "Sword"
         , [68] = "Battle Axe"                -- "Battle Axe"
         , [69] = "Maul"                      -- "Maul"
         , [67] = "Greatsword"                -- "Greatsword"
         , [62] = "Dagger"                    -- "Dagger"
         , [46] = "Cuirass"                   -- "Cuirass"
         , [50] = "Sabatons"                  -- "Sabatons"
         , [52] = "Gauntlets"                 -- "Gauntlets"
         , [44] = "Helm"                      -- "Helm"
         , [49] = "Greaves"                   -- "Greaves"
         , [47] = "Pauldron"                  -- "Pauldron"
         , [48] = "Girdle"                    -- "Girdle"
         }
, [cl] = {
           [28] = "Robe"                      -- "Robe"
         , [75] = "Jerkin"                    -- "Jerkin"
         , [32] = "Shoes"                     -- "Shoes"
         , [34] = "Gloves"                    -- "Gloves"
         , [26] = "Hat"                       -- "Hat"
         , [31] = "Breeches"                  -- "Breeches"
         , [29] = "Epaulets"                  -- "Epaulets"
         , [30] = "Sash"                      -- "Sash"
         , [37] = "Jack"                      -- "Jack"
         , [41] = "Boots"                     -- "Boots"
         , [43] = "Bracers"                   -- "Bracers"
         , [35] = "Helmet"                    -- "Helmet"
         , [40] = "Guards"                    -- "Guards"
         , [38] = "Arm Cops"                  -- "Arm Cops"
         , [39] = "Belt"                      -- "Belt"
         }
, [ww] = {
           [70] = "Bow"                       -- "Bow"
         , [72] = "Inferno Staff"             -- "Inferno Staff"
         , [73] = "Ice Staff"                 -- "Ice Staff"
         , [74] = "Lightning Staff"           -- "Lightning Staff"
         , [71] = "Restoration Staff"         -- "Restoration Staff"
         , [65] = "Shield"                    -- "Shield"
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
           [ 1] = "axe"                       -- "axe"
         , [ 2] = "mace"                      -- "mace"
         , [ 3] = "sword"                     -- "wword"
         , [ 4] = "battle axe"                -- "battle Axe"
         , [ 5] = "maul"                      -- "maul"
         , [ 6] = "greatsword"                -- "greatsword"
         , [ 7] = "dagger"                    -- "dagger"
         , [ 8] = "cuirass"                   -- "cuirass"
         , [ 9] = "sabatons"                  -- "sabatons"
         , [10] = "gauntlets"                 -- "gauntlets"
         , [11] = "helm"                      -- "helm"
         , [12] = "greaves"                   -- "greaves"
         , [13] = "pauldron"                  -- "pauldron"
         , [14] = "girdle"                    -- "girdle"
         }
, [cl] = {
           [ 1] = "robe"                      -- "robe"
         , [ 2] = "jerkin"                    -- "jerkin"
         , [ 3] = "shoes"                     -- "shoes"
         , [ 4] = "gloves"                    -- "gloves"
         , [ 5] = "hat"                       -- "hat"
         , [ 6] = "breeches"                  -- "breeches"
         , [ 7] = "epaulets"                  -- "epaulets"
         , [ 8] = "sash"                      -- "sash"
         , [ 9] = "jack"                      -- "jack"
         , [10] = "boots"                     -- "boots"
         , [11] = "bracers"                   -- "bracers"
         , [12] = "helmet"                    -- "helmet"
         , [13] = "guards"                    -- "guards"
         , [14] = "arm cops"                  -- "arm cops"
         , [15] = "belt"                      -- "belt"
         }
, [ww] = {
           [ 1] = "bow"                       -- "bow"
         , [ 3] = "inferno staff"             -- "inferno staff"
         , [ 4] = "ice staff"                 -- "ice staff"
         , [ 5] = "lightning staff"           -- "lightning staff"
         , [ 6] = "restoration staff"         -- "restoration staff"
         , [ 2] = "shield"                    -- "shield"
         }
, [jw] = {
           [ 2] = "necklace"                  -- "necklace"
         , [ 1] = "ring"                      -- "ring"
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
  ["H1_AXE"         ] = { name="axe"                  , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="mace"                 , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="sword"                , master_name="Sword"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="battle axe"           , master_name="Battle Axe"                , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="maul"                 , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="greatsword"           , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="dagger"               , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="cuirass"              , master_name="Cuirass"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="sabatons"             , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="gauntlets"            , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="helm"                 , master_name="Helm"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="greaves"              , master_name="Greaves"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="pauldron"             , master_name="Pauldron"                  , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="girdle"               , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="Robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="jerkin"               , master_name="Jerkin"                    , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="shoes"                , master_name="Shoes"                     , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="gloves"               , master_name="Gloves"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="hat"                  , master_name="Hat"                       , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="breeches"             , master_name="Breeches"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="epaulets"             , master_name="Epaulets"                  , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="sash"                 , master_name="Sash"                      , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="jack"                 , master_name="Jack"                      , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="boots"                , master_name="Boots"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="bracers"              , master_name="Bracers"                   , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="helmet"               , master_name="Helmet"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="guards"               , master_name="Guards"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="arm cops"             , master_name="Arm Cops"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="belt"                 , master_name="Belt"                      , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="bow"                  , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="inferno staff"        , master_name="Inferno Staff"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="ice staff"            , master_name="Ice Staff"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="lightning staff"      , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="restoration staff"    , master_name="Restoration Staff"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="shield"               , master_name="Shield"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="necklace"             , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="ring"                 , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
