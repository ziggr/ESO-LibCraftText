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
    [hvy] =   { "hierro"             -- "iron"
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
,   [lgt] =   { "tejido artesanal"    -- "homespun"
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
,   [med] =   { "piel cruda"         -- "rawhide"
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
,   [ww ] =   { "arce"               -- "maple"
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
,   [jw ] =   { "peltre"             -- "pewter"
              , "cobre"              -- "copper"
              , "plata"              -- "silver"
              , "electro"            -- "electrum"
              , "platino"            -- "platinum"
              }
}

-- These are the item names that appear in master writs.
-- numeric index is the value for "writ1" field of sealed master writs.
LibCraftText.ITEMS_MASTER = {
  [bs] = {
           [53] = "Hacha"                     -- "Axe"
         , [56] = "Maza"                      -- "Mace"
         , [59] = "Espada"                    -- "Sword"
         , [68] = "Hacha de batalla"          -- "Battle Axe"
         , [69] = "Maza"                      -- "Maul"
         , [67] = "Mandoble"                  -- "Greatsword"
         , [62] = "Daga"                      -- "Dagger"
         , [46] = "Coraza"                    -- "Cuirass"
         , [50] = "Escarpes"                  -- "Sabatons"
         , [52] = "Guanteletes"               -- "Gauntlets"
         , [44] = "Casco"                     -- "Helm"
         , [49] = "Grebas"                    -- "Greaves"
         , [47] = "Espaldarones"              -- "Pauldron"
         , [48] = "Faja"                      -- "Girdle"
         }
, [cl] = {
           [28] = "Túnica"                   -- "Robe"
         , [75] = "Jubón"                    -- "Jerkin"
         , [32] = "Zapatos"                   -- "Shoes"
         , [34] = "Guantes"                   -- "Gloves"
         , [26] = "Capucha"                   -- "Hat"
         , [31] = "Calzones"                  -- "Breeches"
         , [29] = "Cubrehombros"              -- "Epaulets"
         , [30] = "Banda"                     -- "Sash"
         , [37] = "Pechera"                   -- "Jack"
         , [41] = "Botas"                     -- "Boots"
         , [43] = "Brazales"                  -- "Bracers"
         , [35] = "Casco"                     -- "Helmet"
         , [40] = "Musleras"                  -- "Guards"
         , [38] = "Hombreras"                 -- "Arm Cops"
         , [39] = "Cinturón"                 -- "Belt"
         }
, [ww] = {
           [70] = "Arco"                      -- "Bow"
         , [72] = "Vara infernal"             -- "Inferno Staff"
         , [73] = "Vara glaciar"              -- "Ice Staff"
         , [74] = "Vara eléctrica"           -- "Lightning Staff"
         , [71] = "Vara restauradora"         -- "Restoration Staff"
         , [65] = "Escudo"                    -- "Shield"
         }
, [jw] = {
           [18] = "Collar"                    -- "Necklace"
         , [24] = "Anillo"                    -- "Ring"
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
           [ 1] = "Hacha"                     -- "axe"
         , [ 2] = "Maza"                      -- "mace"
         , [ 3] = "Espada"                    -- "wword"
         , [ 4] = "hacha de batalla"          -- "battle Axe"
         , [ 5] = "Maza"                      -- "maul"
         , [ 6] = "Mandoble"                  -- "greatsword"
         , [ 7] = "Daga"                      -- "dagger"
         , [ 8] = "Coraza"                    -- "cuirass"
         , [ 9] = "escarpes"                  -- "sabatons"
         , [10] = "guanteletes"               -- "gauntlets"
         , [11] = "yelmo"                     -- "helm"
         , [12] = "grebas"                    -- "greaves"
         , [13] = "espaldarones"              -- "pauldron"
         , [14] = "Faja"                      -- "girdle"
         }
, [cl] = {
           [ 1] = "Túnica"                   -- "robe"
         , [ 2] = "Jubón"                    -- "jerkin"
         , [ 3] = "Zapatos"                   -- "shoes"
         , [ 4] = "guantes"                   -- "gloves"
         , [ 5] = "Capucha"                   -- "hat"
         , [ 6] = "calzones"                  -- "breeches"
         , [ 7] = "Cubrehombros"              -- "epaulets"
         , [ 8] = "banda"                     -- "sash"
         , [ 9] = "pechera"                   -- "jack"
         , [10] = "botas"                     -- "boots"
         , [11] = "brazales"                  -- "bracers"
         , [12] = "Casco"                     -- "helmet"
         , [13] = "musleras"                  -- "guards"
         , [14] = "Hombreras"                 -- "arm cops"
         , [15] = "Cinturón"                 -- "belt"
         }
, [ww] = {
           [ 1] = "Arco"                      -- "bow"
         , [ 3] = "Vara infernal"             -- "inferno staff"
         , [ 4] = "vara glaciar"              -- "ice staff"
         , [ 5] = "vara eléctrica"           -- "lightning staff"
         , [ 6] = "vara restauradora"         -- "restoration staff"
         , [ 2] = "Escudo"                    -- "shield"
         }
, [jw] = {
           [ 2] = "collar"                    -- "necklace"
         , [ 1] = "anillo"                    -- "ring"
         }
}
LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Bueno"                    -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Épico"                   -- "Epic"
,   [5] = "Legendario"               -- "Legendary"
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
  ["H1_AXE"         ] = { name="Hacha"                , master_name="Hacha"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "axe"
, ["H1_MACE"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "mace"
, ["H1_SWORD"       ] = { name="Espada"               , master_name="Espada"                    , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "sword"
, ["H2_BATTLE_AXE"  ] = { name="hacha de batalla"     , master_name="Hacha de batalla"          , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "battle Axe"
, ["H2_MAUL"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "maul"
, ["H2_GREATSWORD"  ] = { name="Mandoble"             , master_name="Mandoble"                  , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "greatsword"
, ["DAGGER"         ] = { name="Daga"                 , master_name="Daga"                      , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=hvy, trait_set_id=weap } -- "dagger"
, ["CUIRASS"        ] = { name="Coraza"               , master_name="Coraza"                    , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "cuirass"
, ["SABATONS"       ] = { name="escarpes"             , master_name="Escarpes"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "sabatons"
, ["GAUNTLETS"      ] = { name="guanteletes"          , master_name="Guanteletes"               , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "gauntlets"
, ["HELM"           ] = { name="yelmo"                , master_name="Casco"                     , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "helm"
, ["GREAVES"        ] = { name="grebas"               , master_name="Grebas"                    , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "greaves"
, ["PAULDRON"       ] = { name="espaldarones"         , master_name="Espaldarones"              , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "pauldron"
, ["GIRDLE"         ] = { name="Faja"                 , master_name="Faja"                      , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=hvy, trait_set_id=armr } -- "girdle"

, ["ROBE"           ] = { name="Túnica"              , master_name="Túnica"                   , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "robe"
, ["JERKIN"         ] = { name="Jubón"               , master_name="Jubón"                    , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "jerkin"
, ["SHOES"          ] = { name="Zapatos"              , master_name="Zapatos"                   , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "shoes"
, ["GLOVES"         ] = { name="guantes"              , master_name="Guantes"                   , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "gloves"
, ["HAT"            ] = { name="Capucha"              , master_name="Capucha"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "hat"
, ["BREECHES"       ] = { name="calzones"             , master_name="Calzones"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "breeches"
, ["EPAULETS"       ] = { name="Cubrehombros"         , master_name="Cubrehombros"              , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "epaulets"
, ["SASH"           ] = { name="banda"                , master_name="Banda"                     , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=lgt, trait_set_id=armr } -- "sash"
, ["JACK"           ] = { name="pechera"              , master_name="Pechera"                   , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "jack"
, ["BOOTS"          ] = { name="botas"                , master_name="Botas"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "boots"
, ["BRACERS"        ] = { name="brazales"             , master_name="Brazales"                  , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "bracers"
, ["HELMET"         ] = { name="Casco"                , master_name="Casco"                     , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "helmet"
, ["GUARDS"         ] = { name="musleras"             , master_name="Musleras"                  , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "guards"
, ["ARM_COPS"       ] = { name="Hombreras"            , master_name="Hombreras"                 , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "arm cops"
, ["BELT"           ] = { name="Cinturón"            , master_name="Cinturón"                 , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=med, trait_set_id=armr } -- "belt"

, ["BOW"            ] = { name="Arco"                 , master_name="Arco"                      , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "bow"
, ["INFERNO_STAFF"  ] = { name="Vara infernal"        , master_name="Vara infernal"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "inferno staff"
, ["ICE_STAFF"      ] = { name="vara glaciar"         , master_name="Vara glaciar"              , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "ice staff"
, ["LIGHTNING_STAFF"] = { name="vara eléctrica"      , master_name="Vara eléctrica"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "lightning staff"
, ["RESTO_STAFF"    ] = { name="vara restauradora"    , master_name="Vara restauradora"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=ww , trait_set_id=weap } -- "restoration staff"
, ["SHIELD"         ] = { name="Escudo"               , master_name="Escudo"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=ww , trait_set_id=armr } -- "shield"

, ["NECKLACE"       ] = { name="collar"               , master_name="Collar"                    , pattern_index= 2, master_writ1=18, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "necklace"
, ["RING"           ] = { name="anillo"               , master_name="Anillo"                    , pattern_index= 1, master_writ1=24, crafting_type=js, mat_set_id=jw , trait_set_id=jewl } -- "ring"
}
