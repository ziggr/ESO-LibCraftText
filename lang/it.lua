LibCraftText = LibCraftText or {}


-- Table Setup ---------------------------------------------------------------
--
-- Constants and index values we use in later tables

                        -- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   or 1
local cl = CRAFTING_TYPE_CLOTHIER        or 2
local en = CRAFTING_TYPE_ENCHANTING      or 3
local al = CRAFTING_TYPE_ALCHEMY         or 4
local pr = CRAFTING_TYPE_PROVISIONING    or 5
local ww = CRAFTING_TYPE_WOODWORKING     or 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING or 7

                        -- Identify which list of crafting materials.
LibCraftText.MAT_SET_ID = {
    LIGHT           = "mat_lgt"
,   MEDIUM          = "mat_med"
,   HEAVY           = "mat_hvy"
,   WOOD            = "mat_wood"
,   JEWELRY         = "mat_jewl"
}
                        -- For less typing
local mat_lgt       = LibCraftText.MAT_SET_ID.LIGHT
local mat_med       = LibCraftText.MAT_SET_ID.MEDIUM
local mat_hvy       = LibCraftText.MAT_SET_ID.HEAVY
local mat_wood      = LibCraftText.MAT_SET_ID.WOOD
local mat_jewl      = LibCraftText.MAT_SET_ID.JEWELRY

                        -- Identify which list of traits.
LibCraftText.TRAIT_SET_ID = {
    WEAPON          = "trait_weap"
,   ARMOR           = "trait_armr"
,   JEWELRY         = "trait_jewl"
}
                        -- For less typing
local trait_weap    = LibCraftText.TRAIT_SET_ID.WEAPON
local trait_armr    = LibCraftText.TRAIT_SET_ID.ARMOR
local trait_jewl    = LibCraftText.TRAIT_SET_ID.JEWELRY


-- Craftable Equipment -------------------------------------------------------
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
--                  throughout different languages. Or the particularly evil
--                  JP Japanese ring, which uses "リング" (phonetic "ringu")
--                  at the crafting station, but kanji "指輪" (yubi-wa, aka
--                  finger-ring) within daily crafting request condition text.
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
-- name_2           FR French has a typo for Sash: "baudier" when it should
--                  be "baudrier". An extra name column helps match these
--                  surprises.
--
LibCraftText.ITEM = {
  ["H1_AXE"         ] = { name="ascia"                , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="mazza"                , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="spada"                , master_name="Spada"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="ascia da battaglia"   , master_name="Grande Ascia"              , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="maglio"               , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="spadone"              , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="pugnale"              , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="corazza"              , master_name="Corazza"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="schinieri"            , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="mittene"              , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="elmo"                 , master_name="Elmo"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="gambali"              , master_name="Gambali"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="spallaccio"           , master_name="Spallaccio"                , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="cinturone"            , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="veste"                , master_name="Veste"                     , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="giaco"                , master_name="Giaco"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="scarpe"               , master_name="Scarpe"                    , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="guanti"               , master_name="Guanti"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="cappello"             , master_name="Cappello"                  , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="calzoni"              , master_name="Calzoni"                   , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="coprispalle"          , master_name="Coprispalle"               , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="coprispalle"}
, ["SASH"           ] = { name="fascia"               , master_name="Fascia"                    , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="fascia"    }
, ["JACK"           ] = { name="corpetto"             , master_name="Corpetto"                  , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="stivali"              , master_name="Stivali"                   , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="bracciali"            , master_name="Bracciali"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="bracciali" }
, ["HELMET"         ] = { name="elmetto"              , master_name="Elmetto"                   , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="elmetto"   }
, ["GUARDS"         ] = { name="pantaloni"            , master_name="Pantaloni"                 , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="spalline"             , master_name="Spalline"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="cintura"              , master_name="Cintura"                   , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="arco"                 , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="bastone del fuoco"    , master_name="Bastone del Fuoco"         , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="bastone del gelo"     , master_name="Frost Staff"               , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="bastone del fulmine"  , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="bastone di cura"      , master_name="Healing Staff"             , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="scudo"                , master_name="Scudo"                     , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="collana"              , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="collana"   }
, ["RING"           ] = { name="anello"               , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

, ["AETHERIAL_TEA"  ] = { name="Aetherial Tea"        ,                                                                              crafting_type=pr,                                              }
}

-- Craftable Food and Drink --------------------------------------------------
--
-- name             string that appears in "Craft Banana Surprise"
--
-- recipe_list_index    API value for GetRecipeResultItemInfo() and others
--
-- recipe_index     API value for GetRecipeResultItemInfo() and others
--
LibCraftText.RECIPE = {
  ["AETHERIAL_TEA"                   ] = { name="Aetherial Tea"                         , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="Aetherial Tea"}
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="Alik'r Beets with Goat Cheese"         , food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="Baked Apples"                          , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="Baked Potato"                          , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="Banana Surprise"                       , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="Barley Nectar"                         , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="Battaglir Chowder"                     , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="Bitterlemon Tea"                       , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="Bog-Iron Ale"                          , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="Breton Pork Sausage"                   , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="Carrot Soup"                           , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="Chicken Breast"                        , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="Chorrol Corn on the Cob"               , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="Cinnamon Grape Jelly"                  , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="Clarified Syrah Wine"                  , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="Clarified Syrah Wine"}
, ["COMELY_WENCH_WHISKEY"            ] = { name="Comely Wench Whiskey"                  , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="Cyrodilic Cornbread"                   , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="Cyrodilic Pumpkin Fritters"            , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="Elinhir Roast Antelope"                , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="Eltheric Hooch"                        , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="Eltheric Hooch"}
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="Firsthold Fruit and Cheese Plate"      , food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="Fishy Stick"                           , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="Four-Eye Grog"                         , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="Garlic Mashed Potatoes"                , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="Garlic Pumpkin Seeds"                  , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="Ginger Wheat Beer"                     , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="Gods-Blind-Me"                         , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="Gods-Blind-Me"}
, ["GOLDEN_LAGER"                    ] = { name="Golden Lager"                          , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="Gossamer Mazte"                        , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="Grandpa's Bedtime Tonic"               , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="Grape Preserves"                       , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="Hagraven's Tonic"                      , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="Hare in Garlic Sauce"                  , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="Hare in Garlic Sauce"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="Hearty Garlic Corn Chowder"            , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="Honey Rye"                             , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="Jerall View Inn Carrot Cake"           , food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="Lemon Flower Mazte"                    , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="Lilmoth Garlic Hagfish"                , food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="Mammoth Snout Pie"                     , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="Maormer Tea"                           , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="Markarth Mead"                         , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="Mazte"                                 , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="Mermaid Whiskey"                       , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="Millet-Stuffed Pork Loin"              , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="Mulled Wine"                           , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="Muthsera's Remorse"                    , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="Nereid Wine"                           , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="Nibenese Garlic Carrots"               , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="Nut Brown Ale"                         , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="Orcrest Garlic Apple Jelly"            , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="Pellitine Tomato Rice"                 , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="Red Rye Beer"                          , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="Redoran Peppered Melon"                , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="Roast Corn"                            , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="Rye-in-your-Eye"                       , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="Seaflower Tea"                         , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="Senchal Curry Fish and Rice"           , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="Sorry, Honey Lager"                    , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="Sour Mash"                             , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="Spiceberry Chai"                       , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="Spiced Mazte"                          , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="Stormhold Baked Bananas"               , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="Surilie Syrah Wine"                    , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="Torval Mint Tea"                       , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="Treacleberry Tea"                      , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="Two-Zephyr Tea"                        , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="Venison Pasty"                         , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="West Weald Corn Chowder"               , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="Whiterun Cheese-Baked Trout"           , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
}


-- Materials for Craftable Equipment -----------------------------------------
--
-- Answer the question "what material does this crafting quest require?"
-- Rubetite? Jute? Maple?
--
-- name             string that appears in material requested in daily
--                  crafting quests and master writ conditions.
--
-- level_index      ordinal 1..10 (or 1..5) to sort materials by level.
--
-- material_index   crafting index passed as an argument to ZOS API functions
--                  like GetSmithingPatternResultLink() and others
--
-- master_writ2     value for `writ2` field in sealed master writ item links.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- mat_set_id       What set of crafting materials is this material in?
--
-- name_2           A second name to search for when parsing materials from
--                  writ text. FR French uses "soie ancestrales" for the main
--                  name of Ancestor Silk, but strips the plural "s" when
--                  used as an adjective for a singular crafting item.
--

LibCraftText.MATERIAL = {
  ["IRON"          ] = { name="iron"              , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy  }
, ["STEEL"         ] = { name="steel"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy  }
, ["ORICHALC"      ] = { name="orichalc"          , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy  }
, ["DWARVEN"       ] = { name="dwarven"           , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="dwarven"        }
, ["EBONY"         ] = { name="ebon"              , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ebony"          }
, ["CALCINIUM"     ] = { name="calcinium"         , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy  }
, ["GALATITE"      ] = { name="galatite"          , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy  }
, ["QUICKSILVER"   ] = { name="quicksilver"       , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy  }
, ["VOIDSTEEL"     ] = { name="voidsteel"         , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy  }
, ["RUBEDITE"      ] = { name="Rubedite"          , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy  }

, ["JUTE"          ] = { name="homespun"          , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  , name_2="homespun"        }
, ["LINEN"         ] = { name="linen"             , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  }
, ["COTTON"        ] = { name="cotton"            , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SPIDERSILK"    ] = { name="spidersilk"        , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  }
, ["EBONTHREAD"    ] = { name="ebonthread"        , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  }
, ["KRESH"         ] = { name="kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  }
, ["IRONTHREAD"    ] = { name="ironthread"        , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  , name_2="ironthread"      }
, ["SILVERWEAVE"   ] = { name="silverweave"       , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SHADOWSPUN"    ] = { name="shadowspun"        , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  }
, ["ANCESTOR_SILK" ] = { name="Ancestor Silk"     , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt  , name_2="Ancestor Silk"   }

, ["RAWHIDE"       ] = { name="rawhide"           , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  }
, ["HIDE"          ] = { name="hide"              , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  }
, ["LEATHER"       ] = { name="leather"           , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  }
, ["FULL_LEATHER"  ] = { name="full-leather"      , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  }
, ["FELL_HIDE"     ] = { name="fell"              , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  }
, ["BRIGANDINE"    ] = { name="brigandine"        , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  , name_2="brigandine"      }
, ["IRONHIDE"      ] = { name="ironhide"          , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  }
, ["SUPERB"        ] = { name="superb"            , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  , name_2="superb"          }
, ["SHADOWHIDE"    ] = { name="shadowhide"        , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  }
, ["RUBEDO_LEATHER"] = { name="Rubedo Leather"    , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  }

, ["MAPLE"         ] = { name="maple"             , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood }
, ["OAK"           ] = { name="oak"               , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood }
, ["BEECH"         ] = { name="beech"             , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood }
, ["HICKORY"       ] = { name="hickory"           , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood }
, ["YEW"           ] = { name="yew"               , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood }
, ["BIRCH"         ] = { name="birch"             , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood }
, ["ASH"           ] = { name="ash"               , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood }
, ["MAHOGANY"      ] = { name="mahogany"          , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood }
, ["NIGHTWOOD"     ] = { name="nightwood"         , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood }
, ["RUBY_ASH"      ] = { name="Ruby Ash"          , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood }

, ["PEWTER"        ] = { name="pewter"            , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl }
, ["COPPER"        ] = { name="copper"            , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl }
, ["SILVER"        ] = { name="silver"            , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl }
, ["ELECTRUM"      ] = { name="electrum"          , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="electrum"       }
, ["PLATINUM"      ] = { name="platinum"          , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl }
}

-- Alchemy and Enchanting Materials
--
-- For "Acquire Mudcrab Chitin"
--
--
-- name             string that appears in material requested in daily
--                  crafting quests and master writ conditions.
--
-- crafting_type    Blacksmithing, Clothier, Woodworking, or Jewelry Crafting?
--
-- item_id          ZOS itemId for use in itemLinks and other APIness.
--
-- name_2           German and Russian alternate spellings.
--
LibCraftText.CONSUMABLE_MATERIAL = {
  ["BLESSED_THISTLE"         ] = { name="blessed thistle"                , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="blue entoloma"                  , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="bugloss"                        , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="columbine"                      , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="corn flower"                    , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="dragonthorn"                    , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="emetic russula"                 , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="imp stool"                      , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="lady's smock"                   , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="luminous russula"               , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="mountain flower"                , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="namira's rot"                   , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="nirnroot"                       , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="stinkhorn"                      , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="violet coprinus"                , crafting_type=al, item_id= 30152 , name_2="violet coprinus"    }
, ["WATER_HYACINTH"          ] = { name="water hyacinth"                 , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="white cap"                      , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="wormwood"                       , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="Beetle Scuttle"                 , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="Butterfly Wing"                 , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="Fleshfly Larva"                 , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="Mudcrab Chitin"                 , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="Nightshade"                     , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="Scrib Jelly"                    , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="Spider Egg"                     , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="Torchbug Thorax"                , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="Reagent"                        , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="Reagent"                        , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="natural water"                  , crafting_type=al, item_id=   883 , name_2="natural water"      , rank=1, potion_name="health"                  }
, ["CLEAR_WATER"             ] = { name="clear water"                    , crafting_type=al, item_id=  1187                               , rank=2, potion_name="health"                  }
, ["PRISTINE_WATER"          ] = { name="pristine water"                 , crafting_type=al, item_id=  4570 , name_2="pristine water"     , rank=3, potion_name="health"                  }
, ["CLEANSED_WATER"          ] = { name="cleansed water"                 , crafting_type=al, item_id= 23265 , name_2="cleansed water"     , rank=4, potion_name="health"                  }
, ["FILTERED_WATER"          ] = { name="filtered water"                 , crafting_type=al, item_id= 23266 , name_2="filtered water"     , rank=5, potion_name="health"                  }
, ["PURIFIED_WATER"          ] = { name="purified water"                 , crafting_type=al, item_id= 23267 , name_2="purified water"     , rank=6, potion_name="health"                  }
, ["CLOUD_MIST"              ] = { name="cloud mist"                     , crafting_type=al, item_id= 23268                               , rank=7, potion_name="health"                  }
, ["STAR_DEW"                ] = { name="Star Dew"                       , crafting_type=al, item_id= 64500                               , rank=8, potion_name="health"                  }
, ["LORKHANS_TEARS"          ] = { name="Lorkhan's Tears"                , crafting_type=al, item_id= 64501                               , rank=9, potion_name="health"                  }

, ["GREASE"                  ] = { name="Grease"                         , crafting_type=al, item_id= 75357                               , rank=1, poison_name="Drain Health Poison"     }
, ["ICHOR"                   ] = { name="Ichor"                          , crafting_type=al, item_id= 75358                               , rank=2, poison_name="Drain Health Poison"     }
, ["SLIME"                   ] = { name="Slime"                          , crafting_type=al, item_id= 75359                               , rank=3, poison_name="Drain Health Poison"     }
, ["GALL"                    ] = { name="Gall"                           , crafting_type=al, item_id= 75360                               , rank=4, poison_name="Drain Health Poison"     }
, ["TEREBINTHINE"            ] = { name="Terebinthine"                   , crafting_type=al, item_id= 75361                               , rank=5, poison_name="Drain Health Poison"     }
, ["PITCH_BILE"              ] = { name="Pitch-Bile"                     , crafting_type=al, item_id= 75362                               , rank=6, poison_name="Drain Health Poison"     }
, ["TARBLACK"                ] = { name="Tarblack"                       , crafting_type=al, item_id= 75363                               , rank=7, poison_name="Drain Health Poison"     }
, ["NIGHT_OIL"               ] = { name="Night-Oil"                      , crafting_type=al, item_id= 75364                               , rank=8, poison_name="Drain Health Poison"     }
, ["ALKAHEST"                ] = { name="Alkahest"                       , crafting_type=al, item_id= 75365                               , rank=9, poison_name="Drain Health Poison"     }

, ["JORA"                    ] = { name="Jora"                           , crafting_type=en, item_id= 45855 , name_2="glifo of health"}
, ["PORADE"                  ] = { name="Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Jera"                           , crafting_type=en, item_id= 45857 , name_2="glifo of health"}
, ["JEJORA"                  ] = { name="Jejora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Odra"                           , crafting_type=en, item_id= 45807 , name_2="glifo of health"}
, ["POJORA"                  ] = { name="Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Edora"                          , crafting_type=en, item_id= 45809 , name_2="glifo of health"}
, ["JAERA"                   ] = { name="Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Pora"                           , crafting_type=en, item_id= 45811 , name_2="glifo of health"}
, ["DENARA"                  ] = { name="Denara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Rera"                           , crafting_type=en, item_id= 45813 , name_2="glifo of health"}
, ["DERADO"                  ] = { name="Derado"                         , crafting_type=en, item_id= 45814 , name_2="glifo of health", name_3="glifo of health"}
, ["REKURA"                  ] = { name="Rekura"                         , crafting_type=en, item_id= 45815 , name_2="glifo of health"}
, ["KURA"                    ] = { name="Kura"                           , crafting_type=en, item_id= 45816 , name_2="glifo of health"}
, ["REJERA"                  ] = { name="Rejera"                         , crafting_type=en, item_id= 64509 , name_2="glifo of health"}
, ["REPORA"                  ] = { name="Repora"                         , crafting_type=en, item_id= 68341 }

, ["JODE"                    ] = { name="Jode"                           , crafting_type=en, item_id= 45817 }
, ["NOTADE"                  ] = { name="Notade"                         , crafting_type=en, item_id= 45818 }
, ["ODE"                     ] = { name="Ode"                            , crafting_type=en, item_id= 45819 }
, ["TADE"                    ] = { name="Tade"                           , crafting_type=en, item_id= 45820 }
, ["JAYDE"                   ] = { name="Jayde"                          , crafting_type=en, item_id= 45821 }
, ["EDODE"                   ] = { name="Edode"                          , crafting_type=en, item_id= 45822 }
, ["POJODE"                  ] = { name="Pojode"                         , crafting_type=en, item_id= 45823 }
, ["REKUDE"                  ] = { name="Rekude"                         , crafting_type=en, item_id= 45824 }
, ["HADE"                    ] = { name="Hade"                           , crafting_type=en, item_id= 45825 }
, ["IDODE"                   ] = { name="Idode"                          , crafting_type=en, item_id= 45826 }
, ["PODE"                    ] = { name="Pode"                           , crafting_type=en, item_id= 45827 }
, ["KEDEKO"                  ] = { name="Kedeko"                         , crafting_type=en, item_id= 45828 }
, ["REDE"                    ] = { name="Rede"                           , crafting_type=en, item_id= 45829 }
, ["KUDE"                    ] = { name="Kude"                           , crafting_type=en, item_id= 45830 }
, ["JEHADE"                  ] = { name="Jehade"                         , crafting_type=en, item_id= 64508 }
, ["ITADE"                   ] = { name="Itade"                          , crafting_type=en, item_id= 68340 }

, ["DEKEIPA"                 ] = { name="Dekeipa"                        , crafting_type=en, item_id= 45839 , name_2="frost"         }
, ["DENI"                    ] = { name="Deni"                           , crafting_type=en, item_id= 45833 , name_2="stamina"      , name_3="stamina"        }
, ["DENIMA"                  ] = { name="Denima"                         , crafting_type=en, item_id= 45836 , name_2="stamina recovery"}
, ["DETERI"                  ] = { name="Deteri"                         , crafting_type=en, item_id= 45842 , name_2="hardening"     }
, ["HAOKO"                   ] = { name="Haoko"                          , crafting_type=en, item_id= 45841 , name_2="foulness"      }
, ["HAKEIJO"                 ] = { name="Hakeijo"                        , crafting_type=en, item_id= 68342 , name_2="prismatic defense"}
, ["KADERI"                  ] = { name="Kaderi"                         , crafting_type=en, item_id= 45849 , name_2="bashing"       }
, ["KUOKO"                   ] = { name="Kuoko"                          , crafting_type=en, item_id= 45837 , name_2="poison"        }
, ["MAKDERI"                 ] = { name="Makderi"                        , crafting_type=en, item_id= 45848 , name_2="increase magical harm"}
, ["MAKKO"                   ] = { name="Makko"                          , crafting_type=en, item_id= 45832 , name_2="magicka"      , name_3="magicka"        }
, ["MAKKOMA"                 ] = { name="Makkoma"                        , crafting_type=en, item_id= 45835 , name_2="magicka recovery"}
, ["MEIP"                    ] = { name="Meip"                           , crafting_type=en, item_id= 45840 , name_2="shock"         }
, ["OKO"                     ] = { name="Oko"                            , crafting_type=en, item_id= 45831 , name_2="health"       , name_3="health"         }
, ["OKOMA"                   ] = { name="Okoma"                          , crafting_type=en, item_id= 45834 , name_2="health recovery"}
, ["OKORI"                   ] = { name="Okori"                          , crafting_type=en, item_id= 45843 , name_2="weapon damage" }
, ["ORU"                     ] = { name="Oru"                            , crafting_type=en, item_id= 45846 , name_2="potion boost"  }
, ["RAKEIPA"                 ] = { name="Rakeipa"                        , crafting_type=en, item_id= 45838 , name_2="flame"         }
, ["TADERI"                  ] = { name="Taderi"                         , crafting_type=en, item_id= 45847 , name_2="increase physical harm"}

, ["TA"                      ] = { name="Ta"                             , crafting_type=en, item_id= 45850 , name_2="Normale"  }
, ["JEJOTA"                  ] = { name="Jejota"                         , crafting_type=en, item_id= 45851 , name_2="Buono"    }
, ["DENATA"                  ] = { name="Denata"                         , crafting_type=en, item_id= 45852 , name_2="Superiore"}
, ["REKUTA"                  ] = { name="Rekuta"                         , crafting_type=en, item_id= 45853 , name_2="Epico"    }
, ["KUTA"                    ] = { name="Kuta"                           , crafting_type=en, item_id= 45854 , name_2="Leggendario"}
}


-- Alchemy Traits ------------------------------------------------------------

-- Answering "which trait?" for "Craft a potion/poison with the following traits".
--
-- trait_index      integer 1 through 30. Appears in one of the 4 bytes of
--                  itemLink for potions/poisons with this trait.
--
-- name             user-visible name of this trait. Often appears as part of
--                  potion name. Sometimes appears as part of poison name.
--
-- master_potion    name of a rank 9 potion with this trait. Appears as part
--                  of master writ requests.
--
-- master_poison    name of a rank 9 poison with this trait. Appears as part
--                  of master writ requests.
--
LibCraftText.ALCHEMY_TRAIT = {
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="Restore Health"       , master_potion="health"                            , master_poison="Drain Health Poison"               }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="Ravage Health"        , master_potion="Ravage Health"                     , master_poison="Damage Health Poison"              }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="Restore Magicka"      , master_potion="Magicka"                           , master_poison="Drain Magicka Poison"              }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="Ravage Magicka"       , master_potion="Ravage Magicka"                    , master_poison="Damage Magicka Poison"             }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="Restore Stamina"      , master_potion="stamina"                           , master_poison="Drain Stamina Poison"              }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="Ravage Stamina"       , master_potion="Ravage Stamina"                    , master_poison="Damage Stamina Poison"             }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="Increase Spell Resist", master_potion="Spell Protection"                  , master_poison="Ward-Draining Poison"              }
,   ["BREACH"                 ] = { trait_index=08, name="Breach"               , master_potion="Ravage Spell Protection"           , master_poison="Breaching Poison"                  }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="Increase Armor"       , master_potion="Armor"                             , master_poison="Resolve-Draining Poison"           }
,   ["FRACTURE"               ] = { trait_index=10, name="Fracture"             , master_potion="Ravage Armor"                      , master_poison="Fracturing Poison"                 }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="Increase Spell Power" , master_potion="Spell Power"                       , master_poison="Sorcery-Draining Poison"           }
,   ["COWARDICE"              ] = { trait_index=12, name="Cowardice"            , master_potion="Cowardice"                         , master_poison="Cowardice Poison"                  }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="Increase Weapon Power", master_potion="Weapon Power"                      , master_poison="Brutality-Draining Poison"         }
,   ["MAIM"                   ] = { trait_index=14, name="Maim"                 , master_potion="Maim"                              , master_poison="Maiming Poison"                    }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="Spell Critical"       , master_potion="Spell Critical"                    , master_poison="Prophecy-Draining Poison"          }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="Uncertainty"          , master_potion="Uncertainty"                       , master_poison="Uncertainty Poison"                }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="Weapon Critical"      , master_potion="Weapon Crit"                       , master_poison="Savagery-Draining Poison"          }
,   ["ENERVATION"             ] = { trait_index=18, name="Enervation"           , master_potion="Enervation"                        , master_poison="Enervating Poison"                 }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="Unstoppable"          , master_potion="Immovability"                      , master_poison="Escapist's Poison"                 }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="Entrapment"           , master_potion="Entrapment"                        , master_poison="Entrapping Poison"                 }
,   ["DETECTION"              ] = { trait_index=21, name="Detection"            , master_potion="Detection"                         , master_poison="Stealth-Draining Poison"           }
,   ["INVISIBLE"              ] = { trait_index=22, name="Invisible"            , master_potion="Invisibility"                      , master_poison="Conspicuous Poison"                }
,   ["SPEED"                  ] = { trait_index=23, name="Speed"                , master_potion="Speed"                             , master_poison="Speed-Draining Poison"             }
,   ["HINDRANCE"              ] = { trait_index=24, name="Hindrance"            , master_potion="Hindering"                         , master_poison="Hindering Poison"                  }
,   ["PROTECTION"             ] = { trait_index=25, name="Protection"           , master_potion="Protection"                        , master_poison="Protection-Reversing Poison"       }
,   ["VULNERABILITY"          ] = { trait_index=26, name="Vulnerability"        , master_potion="Vulnerability"                     , master_poison="Vulnerability Poison"              }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="Lingering Health"     , master_potion="Lingering Health"                  , master_poison="Gradual Health Drain Poison"       }
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="Gradual Ravage Health", master_potion="Creeping Ravage Health"            , master_poison="Gradual Ravage Health Poison"      }
,   ["VITALITY"               ] = { trait_index=29, name="Vitality"             , master_potion="Vitality"                          , master_poison="Vitality-Draining Poison"          }
,   ["DEFILE"                 ] = { trait_index=30, name="Defile"               , master_potion="Defile"                            , master_poison="Defiling Poison"                   }
}

-- The 6 possible potions and poisons that a daily crafting writ can request.
--
-- trait        reference into ALCHEMY_TRAITS so you know which potion/poison to make
-- potion_name  Appears in potion name such a "Elixir of Health"
-- poison name  Appears in poison name such as "Drain Health Poison III"
--
local at = LibCraftText.ALCHEMY_TRAIT -- for less typing
LibCraftText.ALCHEMY_ITEM = {
  ["HEALTH"           ] = { trait=at.RESTORE_HEALTH , potion_name="health"                       , poison_name="drain health"                 }
, ["MAGICKA"          ] = { trait=at.RESTORE_MAGICKA, potion_name="magicka"                      , poison_name="drain magicka"                }
, ["STAMINA"          ] = { trait=at.RESTORE_STAMINA, potion_name="stamina"                      , poison_name="drain stamina"                }
, ["RAVAGE_HEALTH"    ] = { trait=at.RAVAGE_HEALTH  , potion_name="ravage health"                , poison_name="damage health"                }
, ["RAVAGE_MAGICKA"   ] = { trait=at.RAVAGE_MAGICKA , potion_name="ravage magicka"               , poison_name="damage magicka"               }
, ["RAVAGE_STAMINA"   ] = { trait=at.RAVAGE_STAMINA , potion_name="ravage stamina"               , poison_name="damage stamina"               }
}
at = nil

-- Quest Titles --------------------------------------------------------------

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


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualità"                         -- "Quality"
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

LibCraftText.QUALITIES = {
    [1] = "Normale"                  -- "Normal"
,   [2] = "Buono"                    -- "Fine"
,   [3] = "Superiore"                -- "Superior"
,   [4] = "Epico"                    -- "Epic"
,   [5] = "Leggendario"              -- "Legendary"
}

