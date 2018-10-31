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
    [bs] = "Schmiedeschrieb"                -- "Blacksmith Writ"
,   [cl] = "Schneiderschrieb"               -- "Clothier Writ"
,   [en] = "Verzaubererschrieb"             -- "Enchanter Writ"
,   [al] = "Alchemistenschrieb"             -- "Alchemist Writ"
,   [pr] = "Versorgerschrieb"               -- "Provisioner Writ"
,   [ww] = "Schreinerschrieb"               -- "Woodworker Writ"
,   [jw] = "Schmuckhandwerksschrieb"        -- "Jewelry Crafting Writ"
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
    [bs] = { "Eine meisterhafte Rüstung"         -- "A Masterful Plate"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [cl] = { "Ein meisterhaftes Gewand"           -- "Masterful Tailoring"
           , "Meisterhafte Lederwaren"          } -- "Masterful Leatherwear"
,   [en] = { "Eine meisterhafte Glyphe"         } -- "A Masterful Glyph"
,   [al] = { "Ein meisterhaftes Gebräu"        } -- "A Masterful Concoction"
,   [pr] = { "Ein meisterhaftes Mahl"           } -- "A Masterful Feast"
,   [ww] = { "Ein meisterhafter Schild"           -- "A Masterful Shield"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [jw] = { "Ein meisterhaftes Schmuckstück"  } -- "Masterful Jewelry"
}

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualität"                       -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Stil"                            -- "Style"
,   ["trait"  ] =  "Eigenschaft"                     -- "Trait"
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"              -- "Rolis Hlaalu"
,   ["accept"]         = "<Nehmt den Auftrag an.>"    -- "<Accept the contract.>"
,   ["finish"]         = "<Auftrag abschließen.>"    -- "<Finish the job.>"
,   ["deliver_substr"] = "Beliefert"                 -- "Deliver"

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
    [hvy] =   { "Eisen"              -- "iron"
              , "Stahl"              -- "steel"
              , "Oreichalkos"        -- "orichalc"
              , "Dwemer"             -- "dwarven"
              , "Ebenerz"            -- "ebon"
              , "Kalzinium"          -- "calcinium"
              , "Galatit"            -- "galatite"
              , "Flinksilber"        -- "quicksilver"
              , "Leerenstahl"        -- "voidsteel"
              , "Rubedit"            -- "Rubedite"
              }
,   [lgt] =   { "Jute"               -- "homespun"
              , "Flachs"             -- "linen"
              , "Baumwoll"           -- "cotton"
              , "Spinnenseiden"      -- "spidersilk"
              , "Ebengarn"           -- "ebonthread"
              , "Kresh"              -- "kresh"
              , "Eisenstoff"         -- "ironthread"
              , "Silberstoff"        -- "silverweave"
              , "Leerenstoff"        -- "shadowspun"
              , "Ahnenseiden"        -- "Ancestor Silk"
              }
,   [med] =   { "Rohleder"           -- "rawhide"
              , "Halbleder"          -- "hide"
              , "Leder"              -- "leather"
              , "Hartleder"          -- "full-leather"
              , "Wildleder"          -- "fell"
              , "Rauleder"           -- "brigandine"
              , "Eisenleder"         -- "ironhide"
              , "prächtiges "       -- "superb"
              , "Schattenleder"      -- "shadowhide"
              , "Rubedoleder"        -- "Rubedo Leather"
              }
,   [ww ] =   { "Ahorn"              -- "maple"
              , "Eichen"             -- "oak"
              , "Buchen"             -- "beech"
              , "Hickory"            -- "hickory"
              , "Eiben"              -- "yew"
              , "Birken"             -- "birch"
              , "Eschen"             -- "ash"
              , "Mahagoni"           -- "mahogany"
              , "Nachtholz"          -- "nightwood"
              , "Rubineschen"        -- "Ruby Ash"
              }
,   [jw ] =   { "Zinn"               -- "pewter"
              , "Kupfer"             -- "copper"
              , "Silber"             -- "silver"
              , "Elektrum"           -- "electrum"
              , "Platin"             -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "axt"                       -- "Axe"
         , [56] = "keule"                     -- "Mace"
         , [59] = "schwert"                   -- "Sword"
         , [68] = "streitaxt"                 -- "Battle Axe"
         , [69] = "streitkolben"              -- "Maul"
         , [67] = "bidenhänder"              -- "Greatsword"
         , [62] = "dolch"                     -- "Dagger"
         , [46] = "kürass"                   -- "Cuirass"
         , [50] = "panzerschuhe"              -- "Sabatons"
         , [52] = "hentzen"                   -- "Gauntlets"
         , [44] = "haube"                     -- "Helm"
         , [49] = "beinschienen"              -- "Greaves"
         , [47] = "schulterschutz"            -- "Pauldron"
         , [48] = "gürtel"                   -- "Girdle"
         }
, [cl] = {
           [28] = "robe"                      -- "Robe"
         , [75] = "jacke"                     -- "Jerkin"
         , [32] = "schuhe"                    -- "Shoes"
         , [34] = "handschuhe"                -- "Gloves"
         , [26] = "hut"                       -- "Hat"
         , [31] = "beinkleider"               -- "Breeches"
         , [29] = "schulterpolster"           -- "Epaulets"
         , [30] = "schärpe"                  -- "Sash"
         , [37] = "wams"                      -- "Jack"
         , [41] = "stiefel"                   -- "Boots"
         , [43] = "armschienen"               -- "Bracers"
         , [35] = "helm"                      -- "Helmet"
         , [40] = "schoner"                   -- "Guards"
         , [38] = "schulterkappen"            -- "Arm Cops"
         , [39] = "riemen"                    -- "Belt"
         }
, [ww] = {
           [70] = "bogen"                     -- "Bow"
         , [72] = "flammenstab"               -- "Inferno Staff"
         , [73] = "froststab"                 -- "Ice Staff"
         , [74] = "blitzstab"                 -- "Lightning Staff"
         , [71] = "heilungsstab"              -- "Restoration Staff"
         , [65] = "schild"                    -- "Shield"
         }
, [jw] = {
           [18] = "kette"                     -- "Necklace"
         , [24] = "ring"                      -- "Ring"
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
           [ 1] = "axt"                       -- "axe"
         , [ 2] = "keule"                     -- "mace"
         , [ 3] = "schwert"                   -- "wword"
         , [ 4] = "streitaxt"                 -- "battle Axe"
         , [ 5] = "streitkolben"              -- "maul"
         , [ 6] = "bidenhänder"              -- "greatsword"
         , [ 7] = "dolch"                     -- "dagger"
         , [ 8] = "kürass"                   -- "cuirass"
         , [ 9] = "panzerschuhe"              -- "sabatons"
         , [10] = "hentzen"                   -- "gauntlets"
         , [11] = "haube"                     -- "helm"
         , [12] = "beinschienen"              -- "greaves"
         , [13] = "schulterschutz"            -- "pauldron"
         , [14] = "gürtel"                   -- "girdle"
         }
, [cl] = {
           [ 1] = "robe"                      -- "robe"
         , [ 2] = "jacke"                     -- "jerkin"
         , [ 3] = "schuhe"                    -- "shoes"
         , [ 4] = "handschuhe"                -- "gloves"
         , [ 5] = "hut"                       -- "hat"
         , [ 6] = "beinkleider"               -- "breeches"
         , [ 7] = "schulterpolster"           -- "epaulets"
         , [ 8] = "schärpe"                  -- "sash"
         , [ 9] = "wams"                      -- "jack"
         , [10] = "stiefel"                   -- "boots"
         , [11] = "armschienen"               -- "bracers"
         , [12] = "helm"                      -- "helmet"
         , [13] = "schoner"                   -- "guards"
         , [14] = "schulterkappen"            -- "arm cops"
         , [15] = "riemen"                    -- "belt"
         }
, [ww] = {
           [ 1] = "bogen"                     -- "bow"
         , [ 3] = "flammenstab"               -- "inferno staff"
         , [ 4] = "froststab"                 -- "ice staff"
         , [ 5] = "blitzstab"                 -- "lightning staff"
         , [ 6] = "heilungsstab"              -- "restoration staff"
         , [ 2] = "schild"                    -- "shield"
         }
, [jw] = {
           [ 2] = "halskette"                 -- "necklace"
         , [ 1] = "ring"                      -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Erlesen"                  -- "Fine"
,   [3] = "Überlegen"               -- "Superior"
,   [4] = "Episch"                   -- "Epic"
,   [5] = "Legendär"                -- "Legendary"
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
  ["H1_AXE"         ] = { name="axt"                  , master_name="axt"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="keule"                , master_name="keule"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="schwert"              , master_name="schwert"                   , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="streitaxt"            , master_name="streitaxt"                 , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="streitkolben"         , master_name="streitkolben"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="bidenhänder"         , master_name="bidenhänder"              , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="dolch"                , master_name="dolch"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="kürass"              , master_name="kürass"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="panzerschuhe"         , master_name="panzerschuhe"              , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="hentzen"              , master_name="hentzen"                   , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="haube"                , master_name="haube"                     , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="beinschienen"         , master_name="beinschienen"              , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="schulterschutz"       , master_name="schulterschutz"            , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="gürtel"              , master_name="gürtel"                   , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="jacke"                , master_name="jacke"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="schuhe"               , master_name="schuhe"                    , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="handschuhe"           , master_name="handschuhe"                , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="hut"                  , master_name="hut"                       , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="beinkleider"          , master_name="beinkleider"               , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="schulterpolster"      , master_name="schulterpolster"           , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="schärpe"             , master_name="schärpe"                  , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="wams"                 , master_name="wams"                      , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="stiefel"              , master_name="stiefel"                   , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="armschienen"          , master_name="armschienen"               , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="helm"                 , master_name="helm"                      , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="schoner"              , master_name="schoner"                   , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="schulterkappen"       , master_name="schulterkappen"            , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="riemen"               , master_name="riemen"                    , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="bogen"                , master_name="bogen"                     , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="flammenstab"          , master_name="flammenstab"               , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="froststab"            , master_name="froststab"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="blitzstab"            , master_name="blitzstab"                 , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="heilungsstab"         , master_name="heilungsstab"              , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="schild"               , master_name="schild"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="halskette"            , master_name="kette"                     , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="ring"                 , master_name="ring"                      , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
