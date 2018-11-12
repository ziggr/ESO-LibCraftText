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
  ["H1_AXE"         ] = { name="axt"                  , master_name="axt"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="keule"                , master_name="keule"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="schwert"              , master_name="schwert"                   , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="streitaxt"            , master_name="streitaxt"                 , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="streitkolben"         , master_name="streitkolben"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="bidenhänder"          , master_name="bidenhänder"               , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="dolch"                , master_name="dolch"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="kürass"               , master_name="kürass"                    , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="panzerschuhe"         , master_name="panzerschuhe"              , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="hentzen"              , master_name="hentzen"                   , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="haube"                , master_name="haube"                     , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="beinschienen"         , master_name="beinschienen"              , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="schulterschutz"       , master_name="schulterschutz"            , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="gürtel"               , master_name="gürtel"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="jacke"                , master_name="jacke"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="schuhe"               , master_name="schuhe"                    , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="handschuhe"           , master_name="handschuhe"                , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="hut"                  , master_name="hut"                       , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="beinkleider"          , master_name="beinkleider"               , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="schulterpolster"      , master_name="schulterpolster"           , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="schulterpolster"}
, ["SASH"           ] = { name="schärpe"              , master_name="schärpe"                   , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="schärpe"   }
, ["JACK"           ] = { name="wams"                 , master_name="wams"                      , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="stiefel"              , master_name="stiefel"                   , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="armschienen"          , master_name="armschienen"               , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="armschienen"}
, ["HELMET"         ] = { name="helm"                 , master_name="helm"                      , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="helm"      }
, ["GUARDS"         ] = { name="schoner"              , master_name="schoner"                   , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="schulterkappen"       , master_name="schulterkappen"            , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="riemen"               , master_name="riemen"                    , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="bogen"                , master_name="bogen"                     , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="flammenstab"          , master_name="flammenstab"               , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="froststab"            , master_name="froststab"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="blitzstab"            , master_name="blitzstab"                 , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="heilungsstab"         , master_name="heilungsstab"              , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="schild"               , master_name="schild"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="halskette"            , master_name="kette"                     , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="halskette" }
, ["RING"           ] = { name="ring"                 , master_name="ring"                      , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

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
  ["AETHERIAL_TEA"                   ] = { name="Ätherischer Tee"                       , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="Ätherischen Tee"}
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="Alik'r-Gemüse mit Ziegenkäse"          , food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="Bratäpfel"                             , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="Ofenkartoffel"                         , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="Bananenüberraschung"                   , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="Gerstennektar"                         , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="Battaglirsuppe"                        , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="Bitterzitrustee"                       , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="Sumpfeisen-Ale"                        , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="bretonische Fleischwurst"              , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="Karottensuppe"                         , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="Hühnerbrust"                           , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="Chorrol-Maiskolben am Stück"           , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="Zimttraubengelee"                      , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="klarer Syrahwein"                      , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="klaren Syrahwein"}
, ["COMELY_WENCH_WHISKEY"            ] = { name="Hübschmaidwhiskey"                     , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="cyrodiilisches Maisbrot"               , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="cyrodiilisches Kürbisfrittiertes"      , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="Elinhir-Grillantilope"                 , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="eltherischer Fusel"                    , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="eltherischen Fusel"}
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="Ersthalt-Käseplatte mit Früchten"      , food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="Fischstäbchen"                         , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="Vieraugengrog"                         , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="Kartoffelpüree mit Knoblauch"          , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="Kürbissamen mit Knoblauch"             , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="Ingwerbier"                            , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="Heiliger Strohsack"                    , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="Heiligen Strohsack"}
, ["GOLDEN_LAGER"                    ] = { name="Goldlager"                             , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="Gespinstmazte"                         , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="Großvaters Nachttonikum"               , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="Traubeneingemachtes"                   , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="Rabenvetteltonikum"                    , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="Hase in Knoblauchsoße"                 , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="Hasen in Knoblauchsoße"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="herzhafte Maissuppe mit Knoblauch"     , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="Honigwhiskey"                          , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="Jerallblick-Karottenkuchen"            , food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="Zitrusblütenmazte"                     , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="Lilmoth-Vettelfisch mit Knoblauch"     , food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="Mammutrüsselpastete"                   , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="Maormertee"                            , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="Markarth-Met"                          , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="Mazte"                                 , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="Wassernixenwhiskey"                    , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="gefüllte Schweinelende mit Hirse"      , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="Glühwein"                              , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="Muthseras Reue"                        , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="Nereïdenwein"                          , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="nibenesische Knoblauchkarotten"        , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="Nussbraunale"                          , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="Orkruh-Apfelgelee mit Knoblauch"       , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="Pellitine-Tomatenreis"                 , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="Rotweizenbier"                         , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="Redoran-Pfeffermelone"                 , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="Grillmais"                             , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="Durchschlagwhiskey"                    , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="Seeblumentee"                          , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="Senchal-Curryfisch mit Reis"           , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="Tutmirleidlager"                       , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="Sauermaische"                          , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="Würzbeerenchai"                        , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="Würzmazte"                             , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="Sturmfeste-Backbananen"                , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="Surilie-Syrahwein"                     , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="Torval-Minztee"                        , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="Sirupbeerentee"                        , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="Doppelsturmtee"                        , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="Wildfleischpastete"                    , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="Westauen-Maissuppe"                    , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="Weißlauf-Käseforelle"                  , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
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
  ["IRON"          ] = { name="Eisen"             , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy  }
, ["STEEL"         ] = { name="Stahl"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy  }
, ["ORICHALC"      ] = { name="Oreichalkos"       , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy  }
, ["DWARVEN"       ] = { name="Dwemer"            , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="Dwemer"         }
, ["EBONY"         ] = { name="Ebenerz"           , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="Ebenerz"        }
, ["CALCINIUM"     ] = { name="Kalzinium"         , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy  }
, ["GALATITE"      ] = { name="Galatit"           , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy  }
, ["QUICKSILVER"   ] = { name="Flinksilber"       , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy  }
, ["VOIDSTEEL"     ] = { name="Leerenstahl"       , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy  }
, ["RUBEDITE"      ] = { name="Rubedit"           , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy  }

, ["JUTE"          ] = { name="Jute"              , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  , name_2="Jute"            }
, ["LINEN"         ] = { name="Flachs"            , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  }
, ["COTTON"        ] = { name="Baumwoll"          , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SPIDERSILK"    ] = { name="Spinnenseiden"     , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  }
, ["EBONTHREAD"    ] = { name="Ebengarn"          , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  }
, ["KRESH"         ] = { name="Kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  }
, ["IRONTHREAD"    ] = { name="Eisenstoff"        , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  , name_2="Eisenstoff"      }
, ["SILVERWEAVE"   ] = { name="Silberstoff"       , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SHADOWSPUN"    ] = { name="Leerenstoff"       , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  }
, ["ANCESTOR_SILK" ] = { name="Ahnenseiden"       , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt  , name_2="Ahnenseiden"     }

, ["RAWHIDE"       ] = { name="Rohleder"          , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  }
, ["HIDE"          ] = { name="Halbleder"         , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  }
, ["LEATHER"       ] = { name="Leder"             , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  }
, ["FULL_LEATHER"  ] = { name="Hartleder"         , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  }
, ["FELL_HIDE"     ] = { name="Wildleder"         , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  }
, ["BRIGANDINE"    ] = { name="Rauleder"          , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  , name_2="Rauleder"        }
, ["IRONHIDE"      ] = { name="Eisenleder"        , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  }
, ["SUPERB"        ] = { name="prächtiges "       , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  , name_2="Prachtleder"     }
, ["SHADOWHIDE"    ] = { name="Schattenleder"     , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  }
, ["RUBEDO_LEATHER"] = { name="Rubedoleder"       , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  }

, ["MAPLE"         ] = { name="Ahorn"             , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood }
, ["OAK"           ] = { name="Eichen"            , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood }
, ["BEECH"         ] = { name="Buchen"            , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood }
, ["HICKORY"       ] = { name="Hickory"           , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood }
, ["YEW"           ] = { name="Eiben"             , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood }
, ["BIRCH"         ] = { name="Birken"            , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood }
, ["ASH"           ] = { name="Eschen"            , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood }
, ["MAHOGANY"      ] = { name="Mahagoni"          , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood }
, ["NIGHTWOOD"     ] = { name="Nachtholz"         , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood }
, ["RUBY_ASH"      ] = { name="Rubineschen"       , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood }

, ["PEWTER"        ] = { name="Zinn"              , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl }
, ["COPPER"        ] = { name="Kupfer"            , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl }
, ["SILVER"        ] = { name="Silber"            , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl }
, ["ELECTRUM"      ] = { name="Elektrum"          , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="Elektrum"       }
, ["PLATINUM"      ] = { name="Platin"            , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl }
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
  ["BLESSED_THISTLE"         ] = { name="Benediktenkraut"                , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="blauer Glöckling"               , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="Wolfsauge"                      , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="Akelei"                         , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="Kornblume"                      , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="Drachendorn"                    , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="Brechtäubling"                  , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="Koboldschemel"                  , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="Wiesenschaumkraut"              , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="Leuchttäubling"                 , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="Bergblume"                      , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="Namiras Fäulnis"                , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="Nirnwurz"                       , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="Stinkmorchel"                   , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="violetter Tintling"             , crafting_type=al, item_id= 30152 , name_2="violetten Tintling" }
, ["WATER_HYACINTH"          ] = { name="Wasserhyazinthe"                , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="Weißkappe"                      , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="Wermut"                         , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="Käferbeine"                     , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="Schmetterlingsflügel"           , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="Fleischfliegenlarve"            , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="Schlammkrabbenchitin"           , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="Nachtschatten"                  , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="Skribgelee"                     , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="Spinnenei"                      , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="Fackelkäferpanzer"              , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="Muschelgalle"                   , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="pulverisiertes Perlmutt"        , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="natürliches Wasser"             , crafting_type=al, item_id=   883 , name_2="natürliches Wasser" , rank=1, potion_name="schlückchen"             }
, ["CLEAR_WATER"             ] = { name="klares Wasser"                  , crafting_type=al, item_id=  1187                               , rank=2, potion_name="tinktur"                 }
, ["PRISTINE_WATER"          ] = { name="unberührtes Wasser"             , crafting_type=al, item_id=  4570 , name_2="unberührtes Wasser" , rank=3, potion_name="schluck"                 , potion_name2="Schlücke"                 }
, ["CLEANSED_WATER"          ] = { name="gesäubertes Wasser"             , crafting_type=al, item_id= 23265 , name_2="gesäubertes Wasser" , rank=4, potion_name="trank"                   }
, ["FILTERED_WATER"          ] = { name="gefiltertes Wasser"             , crafting_type=al, item_id= 23266 , name_2="gefiltertes Wasser" , rank=5, potion_name="lösung"                  }
, ["PURIFIED_WATER"          ] = { name="gereinigtes Wasser"             , crafting_type=al, item_id= 23267 , name_2="gereinigtes Wasser" , rank=6, potion_name="elixier"                 }
, ["CLOUD_MIST"              ] = { name="Wolkennebel"                    , crafting_type=al, item_id= 23268                               , rank=7, potion_name="panazee"                 }
, ["STAR_DEW"                ] = { name="Sternentau"                     , crafting_type=al, item_id= 64500                               , rank=8, potion_name="destillat"               }
, ["LORKHANS_TEARS"          ] = { name="Lorkhans Tränen"                , crafting_type=al, item_id= 64501                               , rank=9, potion_name="essenz"                  }

, ["GREASE"                  ] = { name="Fett"                           , crafting_type=al, item_id= 75357                               , rank=1, poison_name="i"                       }
, ["ICHOR"                   ] = { name="Eiter"                          , crafting_type=al, item_id= 75358                               , rank=2, poison_name="ii"                      }
, ["SLIME"                   ] = { name="Schleim"                        , crafting_type=al, item_id= 75359                               , rank=3, poison_name="iii"                     }
, ["GALL"                    ] = { name="Galle"                          , crafting_type=al, item_id= 75360                               , rank=4, poison_name="iv"                      }
, ["TEREBINTHINE"            ] = { name="Terebinthe"                     , crafting_type=al, item_id= 75361                               , rank=5, poison_name="v"                       }
, ["PITCH_BILE"              ] = { name="Schwarzgalle"                   , crafting_type=al, item_id= 75362                               , rank=6, poison_name="vi"                      }
, ["TARBLACK"                ] = { name="Teerschwarz"                    , crafting_type=al, item_id= 75363                               , rank=7, poison_name="vii"                     }
, ["NIGHT_OIL"               ] = { name="Nachtöl"                        , crafting_type=al, item_id= 75364                               , rank=8, poison_name="viii"                    }
, ["ALKAHEST"                ] = { name="Alkahest"                       , crafting_type=al, item_id= 75365                               , rank=9, poison_name="ix"                      }

, ["JORA"                    ] = { name="Jora"                           , crafting_type=en, item_id= 45855 , name_2="unbedeutende"  }
, ["PORADE"                  ] = { name="Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Jera"                           , crafting_type=en, item_id= 45857 , name_2="winzige"       }
, ["JEJORA"                  ] = { name="Jejora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Odra"                           , crafting_type=en, item_id= 45807 , name_2="niedere"       }
, ["POJORA"                  ] = { name="Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Edora"                          , crafting_type=en, item_id= 45809 , name_2="moderate"      }
, ["JAERA"                   ] = { name="Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Pora"                           , crafting_type=en, item_id= 45811 , name_2="starke"        }
, ["DENARA"                  ] = { name="Denara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Rera"                           , crafting_type=en, item_id= 45813 , name_2="hervorragende" }
, ["DERADO"                  ] = { name="Derado"                         , crafting_type=en, item_id= 45814 , name_2="gewaltige"    , name_3="gewaltige"      }
, ["REKURA"                  ] = { name="Rekura"                         , crafting_type=en, item_id= 45815 , name_2="vortreffliche" }
, ["KURA"                    ] = { name="Kura"                           , crafting_type=en, item_id= 45816 , name_2="monumentale"   }
, ["REJERA"                  ] = { name="Rejera"                         , crafting_type=en, item_id= 64509 , name_2="prächtige"     }
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

, ["DEKEIPA"                 ] = { name="Dakeipa"                        , crafting_type=en, item_id= 45839 , name_2="frosts"        }
, ["DENI"                    ] = { name="Deni"                           , crafting_type=en, item_id= 45833 , name_2="ausdauer"     , name_3="ausdauer"       }
, ["DENIMA"                  ] = { name="Denima"                         , crafting_type=en, item_id= 45836 , name_2="ausdauerregeneration"}
, ["DETERI"                  ] = { name="Deteri"                         , crafting_type=en, item_id= 45842 , name_2="abhärtung"     }
, ["HAOKO"                   ] = { name="Haoko"                          , crafting_type=en, item_id= 45841 , name_2="fäulnis"       }
, ["HAKEIJO"                 ] = { name="Hakeijo"                        , crafting_type=en, item_id= 68342 , name_2="prismatischen verteidigung"}
, ["KADERI"                  ] = { name="Kaderi"                         , crafting_type=en, item_id= 45849 , name_2="einschlagens"  }
, ["KUOKO"                   ] = { name="Kuoko"                          , crafting_type=en, item_id= 45837 , name_2="gifts"         }
, ["MAKDERI"                 ] = { name="Makderi"                        , crafting_type=en, item_id= 45848 , name_2="erhöhten magischen schadens"}
, ["MAKKO"                   ] = { name="Makko"                          , crafting_type=en, item_id= 45832 , name_2="magicka"      , name_3="magicka"        }
, ["MAKKOMA"                 ] = { name="Makkoma"                        , crafting_type=en, item_id= 45835 , name_2="magickaregeneration"}
, ["MEIP"                    ] = { name="Meip"                           , crafting_type=en, item_id= 45840 , name_2="schocks"       }
, ["OKO"                     ] = { name="Oko"                            , crafting_type=en, item_id= 45831 , name_2="lebens"       , name_3="lebens"         }
, ["OKOMA"                   ] = { name="Okoma"                          , crafting_type=en, item_id= 45834 , name_2="lebensregeneration"}
, ["OKORI"                   ] = { name="Okori"                          , crafting_type=en, item_id= 45843 , name_2="waffenkraft"   }
, ["ORU"                     ] = { name="Oru"                            , crafting_type=en, item_id= 45846 , name_2="trankverbesserung"}
, ["RAKEIPA"                 ] = { name="Rakeipa"                        , crafting_type=en, item_id= 45838 , name_2="flamme"        }
, ["TADERI"                  ] = { name="Taderi"                         , crafting_type=en, item_id= 45847 , name_2="erhöhten physischen schadens"}

, ["TA"                      ] = { name="Ta"                             , crafting_type=en, item_id= 45850 , name_2="Normal"   }
, ["JEJOTA"                  ] = { name="Jejota"                         , crafting_type=en, item_id= 45851 , name_2="Erlesen"  }
, ["DENATA"                  ] = { name="Denata"                         , crafting_type=en, item_id= 45852 , name_2="Überlegen"}
, ["REKUTA"                  ] = { name="Rekuta"                         , crafting_type=en, item_id= 45853 , name_2="Episch"   }
, ["KUTA"                    ] = { name="Kuta"                           , crafting_type=en, item_id= 45854 , name_2="Legendär" }
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
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="Leben wiederherstellen"   , master_potion="Essenz des Lebens"                 , master_poison="Gift des Lebensentzugs IX"         , daily_potion_name="lebens"                       , daily_poison_name="lebensentzugs"                }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="Lebensverwüstung"         , master_potion="Essenz der Lebensverwüstung"       , master_poison="Gift der Lebensschändung IX"       , daily_potion_name="lebensverwüstung"             , daily_poison_name="lebensschändung"              , daily_poison_name2="lebensschändung"              }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="Magicka wiederherstellen" , master_potion="Essenz der Magicka"                , master_poison="Gift des Magickaentzugs IX"        , daily_potion_name="magicka"                      , daily_poison_name="magickaentzugs"               }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="Magickaverwüstung"        , master_potion="Essenz der Magickaverwüstung"      , master_poison="Gift der Magickaschändung IX"      , daily_potion_name="magickaverwüstung"            , daily_poison_name="magickaschändung"             , daily_poison_name2="magickaverwüstung"             }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="Ausdauer wiederherstellen", master_potion="Essenz der Ausdauer"               , master_poison="Gift des Ausdauerentzugs IX"       , daily_potion_name="ausdauer"                     , daily_poison_name="ausdauerentzugs"              }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="Ausdauerverwüstung"       , master_potion="Essenz der Ausdauerverwüstung"     , master_poison="Gift der Ausdauerschändung IX"     , daily_potion_name="ausdauerverwüstung"           , daily_poison_name="ausdauerschändung"            , daily_poison_name2="ausdauerschändung"             }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="Erhöht Magieresistenz"    , master_potion="Essenz des Zauberschutzes"         , master_poison="Gift des Schutzentzugs IX"         }
,   ["BREACH"                 ] = { trait_index=08, name="Bruch"                    , master_potion="Essenz der Zauberschutzverwüstung" , master_poison="Gift des Durchdringens IX"         }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="Erhöht Rüstung"           , master_potion="Essenz der Rüstung"                , master_poison="Gift des Entschlossenheitsentzugs IX"}
,   ["FRACTURE"               ] = { trait_index=10, name="Fraktur"                  , master_potion="Essenz der Rüstungsverwüstung"     , master_poison="Gift des Zertrümmerns IX"          }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="Erhöht Magiekraft"        , master_potion="Essenz der Magiekraft"             , master_poison="Gift des Zaubereientzugs IX"       }
,   ["COWARDICE"              ] = { trait_index=12, name="Feigheit"                 , master_potion="Essenz der Feigheit"               , master_poison="Gift der Feigheit IX"              }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="Erhöht Waffenkraft"       , master_potion="Essenz der Waffenkraft"            , master_poison="Gift des Brutalitätsentzugs IX"    }
,   ["MAIM"                   ] = { trait_index=14, name="Verkrüppeln"              , master_potion="Essenz des Verkrüppelns"           , master_poison="Gift der Verstümmelung IX"         }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="Kritische Magietreffer"   , master_potion="Essenz der kritischen Magietreffer", master_poison="Gift des Prophetieentzugs IX"      }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="Ungewissheit"             , master_potion="Essenz der Ungewissheit"           , master_poison="Gift der Ungewissheit IX"          }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="Kritische Waffentreffer"  , master_potion="Essenz der kritischen Waffentreffer", master_poison="Gift des Wildheitentzugs IX"       }
,   ["ENERVATION"             ] = { trait_index=18, name="Schwäche"                 , master_potion="Essenz der Schwäche"               , master_poison="Gift der Enervierung IX"           }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="Sicherer Stand"           , master_potion="Essenz der Unbeweglichkeit"        , master_poison="Gift des Fliehenden IX"            }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="Einfangen"                , master_potion="Essenz des Einfangens"             , master_poison="Gift des Festsetzens IX"           }
,   ["DETECTION"              ] = { trait_index=21, name="Detektion"                , master_potion="Essenz der Detektion"              , master_poison="Gift des Schleichentzugs IX"       }
,   ["INVISIBLE"              ] = { trait_index=22, name="Unsichtbarkeit"           , master_potion="Essenz der Unsichtbarkeit"         , master_poison="Gift des Auffallens IX"            }
,   ["SPEED"                  ] = { trait_index=23, name="Tempo"                    , master_potion="Essenz des Tempos"                 , master_poison="Gift des Tempoentzugs IX"          }
,   ["HINDRANCE"              ] = { trait_index=24, name="Einschränken"             , master_potion="Essenz des Einschränkens"          , master_poison="Gift der Hinderung IX"             }
,   ["PROTECTION"             ] = { trait_index=25, name="Schutz"                   , master_potion="Essenz des Schutzes"               , master_poison="Gift der Schutzumkehrung IX"       }
,   ["VULNERABILITY"          ] = { trait_index=26, name="Verwundbarkeit"           , master_potion="Essenz der Verwundbarkeit"         , master_poison="Gift der Verwundbarkeit IX"        }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="Beständige Heilung"       , master_potion="Essenz des beständigen Lebens"     , master_poison="langsam wirkendes Gift des Lebensentzugs IX"}
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="Langsame Lebensverwüstung", master_potion="Essenz der schleichenden Lebensverwüstung", master_poison="langsam wirkendes Gift der Lebensverwüstung IX"}
,   ["VITALITY"               ] = { trait_index=29, name="Vitalität"                , master_potion="Essenz der Vitalität"              , master_poison="Gift des Vitalitätsentzugs IX"     }
,   ["DEFILE"                 ] = { trait_index=30, name="Schänden"                 , master_potion="Essenz der Schändung"              , master_poison="Gift der Schändung IX"             }
}


-- Quest Titles --------------------------------------------------------------

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
    [bs] = { "Eine meisterhafte Rüstung"          -- "A Masterful Plate"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [cl] = { "Ein meisterhaftes Gewand"           -- "Masterful Tailoring"
           , "Meisterhafte Lederwaren"          } -- "Masterful Leatherwear"
,   [en] = { "Eine meisterhafte Glyphe"         } -- "A Masterful Glyph"
,   [al] = { "Ein meisterhaftes Gebräu"         } -- "A Masterful Concoction"
,   [pr] = { "Ein meisterhaftes Mahl"           } -- "A Masterful Feast"
,   [ww] = { "Ein meisterhafter Schild"           -- "A Masterful Shield"
           , "Eine meisterhafte Waffe"          } -- "A Masterful Weapon"
,   [jw] = { "Ein meisterhaftes Schmuckstück"   } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualität"                        -- "Quality"
,   ["set"    ] =  "Set"                             -- "Set"
,   ["style"  ] =  "Stil"                            -- "Style"
,   ["trait"  ] =  "Eigenschaft"                     -- "Trait"
}

LibCraftText.ROLIS_QUEST_TURN_IN = {

    ["rolis"]          = "Rolis Hlaalu"              -- "Rolis Hlaalu"
,   ["accept"]         = "<Nehmt den Auftrag an.>"   -- "<Accept the contract.>"
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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Erlesen"                  -- "Fine"
,   [3] = "Überlegen"                -- "Superior"
,   [4] = "Episch"                   -- "Epic"
,   [5] = "Legendär"                 -- "Legendary"
}

