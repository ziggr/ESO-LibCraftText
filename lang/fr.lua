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
  ["H1_AXE"         ] = { name="hache"                , master_name="hache"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="masse"                , master_name="masse"                     , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="épée"                 , master_name="épée"                      , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="hache de bataille"    , master_name="Hache de bataille"         , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="masse d'arme"         , master_name="masse d'arme"              , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="épée longue"          , master_name="épée longue"               , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="dague"                , master_name="dague"                     , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="cuirasse"             , master_name="cuirasse"                  , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="solerets"             , master_name="Soleret"                   , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="gantelets"            , master_name="Gantelets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="heaume"               , master_name="casque"                    , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="grèves"               , master_name="Grèves"                    , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="spallière"            , master_name="Spallière"                 , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="gaine"                , master_name="gaine"                     , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="robe"                 , master_name="robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="pourpoint"            , master_name="Pourpoint"                 , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="chaussures"           , master_name="Chaussures"                , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="gants"                , master_name="Gants"                     , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="chapeau"              , master_name="chapeau"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="braies"               , master_name="Braies"                    , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="épaulettes"           , master_name="Épaulettes"                , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="épaulettes"}
, ["SASH"           ] = { name="baudrier"             , master_name="Baudrier"                  , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="baudier"   }
, ["JACK"           ] = { name="gilet"                , master_name="gilet"                     , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="bottes"               , master_name="Bottes"                    , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="brassards"            , master_name="Brassards"                 , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="brassards" }
, ["HELMET"         ] = { name="casque"               , master_name="casque"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="casque"    }
, ["GUARDS"         ] = { name="gardes"               , master_name="Gardes"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="coques d'épaules"     , master_name="Coques d'épaules"          , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="ceinture"             , master_name="ceinture"                  , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="arc"                  , master_name="arc"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="bâton infernal"       , master_name="bâton infernal"            , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="bâton de glace"       , master_name="Bâton de glace"            , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="bâton de foudre"      , master_name="Bâton de foudre"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="bâton de rétablissement", master_name="Bâton de rétablissement"   , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="bouclier"             , master_name="bouclier"                  , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="collier"              , master_name="Collier"                   , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="collier"   }
, ["RING"           ] = { name="anneau"               , master_name="Anneau"                    , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

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
  ["AETHERIAL_TEA"                   ] = { name="thé éthérien"                          , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="thé éthérien"}
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="betteraves d'Alik'r au chèvre"         , food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="pommes cuites"                         , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="pomme de terre au four"                , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="banane surprise"                       , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="nectar d'orge"                         , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="bisque de battaglir"                   , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="infusion de citron amer"               , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="bière de Tourbefer"                    , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="saucisse de porc brétonne"             , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="soupe de carottes"                     , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="blanc de poulet"                       , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="maïs grillé de Chorrol"                , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="gelée de raisins à la cannelle"        , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="clairet de Syrah"                      , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="clairet de Syrah"}
, ["COMELY_WENCH_WHISKEY"            ] = { name="whiskey de l'accorte hôtesse"          , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="pain de maïs cyrodiiléen"              , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="beignets de citrouille cyrodiiléens"   , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="antilope rôtie d'Élinhir"              , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="tord-boyau Elthérique"                 , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="tord-boyau Elthérique"}
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="plateau de fruits et de fromage de Prime-Tenure", food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="bâtonnet de poisson"                   , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="grog quilouche"                        , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="purée à l'ail"                         , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="graines de citrouille à l'ail"         , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="bière de froment au gingembre"         , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="Les-Dieux-M'aveuglent"                 , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="Les-Dieux-M'aveuglent"}
, ["GOLDEN_LAGER"                    ] = { name="cervoise dorée"                        , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="mazté soyeux"                          , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="tonique du papi au lit"                , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="confiture de raisin"                   , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="tonique de harfreuse"                  , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="lièvre à l'ail"                        , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="lièvre à l'ail"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="soupe de maïs épaisse à l'ail"         , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="scotch au miel"                        , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="gâteau de carotte de l'auberge de la vue de Jerall", food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="mazté à la fleur de citronnier"        , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="anguille des harfreuses à l'ail de Lilmoth", food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="tourte au groin de mammouth"           , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="thé maormer"                           , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="hydromel de Markarth"                  , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="mazté"                                 , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="whisky des sirènes"                    , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="filet-mignon de porc farci au millet"  , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="vin chaud"                             , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="remords de Muthséra"                   , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="vin de la néréïde"                     , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="carottes à l'ail nibenaises"           , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="bière brune à la noisette"             , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="gelée de pommes à l'ail d'Orcrête"     , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="riz à la tomate de Pellitine"          , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="bière de seigle rousse"                , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="melon poivré de Rédoran"               , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="maïs rôti"                             , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="scotch-dans-ta-face"                   , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="thé à l'anémone"                       , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="curry de poisson de Senchal"           , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="cervoise « Désolé, chérie »"           , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="moût aigre"                            , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="thé d'épiceline"                       , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="mazté épicé"                           , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="bananes cuites de Fort-tempête"        , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="vin de syrah de Surilie"               , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="thé à la menthe de Torval"             , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="thé de mélassine"                      , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="thé des deux zéphyrs"                  , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="friand de gibier"                      , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="bisque au maïs occidental froide"      , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="truite gratinée de Blancherive"        , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
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
  ["IRON"          ] = { name="fer"               , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy  }
, ["STEEL"         ] = { name="acier"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy  }
, ["ORICHALC"      ] = { name="orichalque"        , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy  }
, ["DWARVEN"       ] = { name="dwemère"           , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="dwemer"         }
, ["EBONY"         ] = { name="ébonite"           , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ébonite"        }
, ["CALCINIUM"     ] = { name="calcinium"         , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy  }
, ["GALATITE"      ] = { name="galatite"          , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy  }
, ["QUICKSILVER"   ] = { name="mercure"           , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy  }
, ["VOIDSTEEL"     ] = { name="acier du néant"    , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy  }
, ["RUBEDITE"      ] = { name="cuprite"           , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy  }

, ["JUTE"          ] = { name="artisanales"       , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  , name_2="artisanal"       }
, ["LINEN"         ] = { name="lin"               , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  }
, ["COTTON"        ] = { name="coton"             , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SPIDERSILK"    ] = { name="soie d'araignée"   , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  }
, ["EBONTHREAD"    ] = { name="fil d'ébonite"     , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  }
, ["KRESH"         ] = { name="kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  }
, ["IRONTHREAD"    ] = { name="fil de fer"        , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  , name_2="fil de fer"      }
, ["SILVERWEAVE"   ] = { name="fil d'argent"      , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SHADOWSPUN"    ] = { name="tissombre"         , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  }
, ["ANCESTOR_SILK" ] = { name="soie ancestrales"  , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt  , name_2="soie ancestral"  }

, ["RAWHIDE"       ] = { name="cuir brut"         , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  }
, ["HIDE"          ] = { name="peau"              , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  }
, ["LEATHER"       ] = { name="cuir"              , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  }
, ["FULL_LEATHER"  ] = { name="cuir complet"      , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  }
, ["FELL_HIDE"     ] = { name="déchu"             , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  }
, ["BRIGANDINE"    ] = { name="cuir clouté"       , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  , name_2="brigandine"      }
, ["IRONHIDE"      ] = { name="peau de fer"       , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  }
, ["SUPERB"        ] = { name="superbe"           , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  , name_2="superbe"         }
, ["SHADOWHIDE"    ] = { name="peau d'ombre"      , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  }
, ["RUBEDO_LEATHER"] = { name="cuir pourpre"      , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  }

, ["MAPLE"         ] = { name="érable"            , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood }
, ["OAK"           ] = { name="chêne"             , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood }
, ["BEECH"         ] = { name="hêtre"             , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood }
, ["HICKORY"       ] = { name="noyer"             , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood }
, ["YEW"           ] = { name="if"                , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood }
, ["BIRCH"         ] = { name="bouleau"           , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood }
, ["ASH"           ] = { name="frêne"             , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood }
, ["MAHOGANY"      ] = { name="acajou"            , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood }
, ["NIGHTWOOD"     ] = { name="bois de nuit"      , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood }
, ["RUBY_ASH"      ] = { name="frêne roux"        , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood }

, ["PEWTER"        ] = { name="étain"             , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl }
, ["COPPER"        ] = { name="cuivre"            , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl }
, ["SILVER"        ] = { name="argent"            , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl }
, ["ELECTRUM"      ] = { name="électrum"          , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="électrum"       }
, ["PLATINUM"      ] = { name="platine"           , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl }
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
  ["BLESSED_THISTLE"         ] = { name="chardon béni"                   , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="entoloma bleue"                 , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="noctuelle"                      , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="ancolie"                        , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="bleuet"                         , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="épine-de-dragon"                , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="russule émétique"               , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="pied-de-lutin"                  , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="cardamine des prés"             , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="russule phosphorescente"        , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="lys des cimes"                  , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="truffe de Namira"               , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="nirnrave"                       , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="mutinus elegans"                , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="coprin violet"                  , crafting_type=al, item_id= 30152 , name_2="coprin violet"      }
, ["WATER_HYACINTH"          ] = { name="jacinthe d'eau"                 , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="Chapeau blanc"                  , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="absinthe"                       , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="cloaque de scarabée"            , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="aile de papillon"               , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="larve de mouche à viande"       , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="chitine de vasard"              , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="Belladone"                      , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="gelée de scrib"                 , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="œuf d'araignée"                 , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="thorax de flammouche"           , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="impureté de palourde"           , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="poudre de nacre"                , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="eau naturelle"                  , crafting_type=al, item_id=   883 , name_2="eau naturelle"      }
, ["CLEAR_WATER"             ] = { name="eau claire"                     , crafting_type=al, item_id=  1187 }
, ["PRISTINE_WATER"          ] = { name="eau limpide"                    , crafting_type=al, item_id=  4570 , name_2="eau limpide"        }
, ["CLEANSED_WATER"          ] = { name="eau assainie"                   , crafting_type=al, item_id= 23265 , name_2="eau assainie"       }
, ["FILTERED_WATER"          ] = { name="eau filtrée"                    , crafting_type=al, item_id= 23266 , name_2="eau filtrée"        }
, ["PURIFIED_WATER"          ] = { name="eau purifiée"                   , crafting_type=al, item_id= 23267 , name_2="eau purifiée"       }
, ["CLOUD_MIST"              ] = { name="brume"                          , crafting_type=al, item_id= 23268 }
, ["STAR_DEW"                ] = { name="rosée stellaire"                , crafting_type=al, item_id= 64500 }
, ["LORKHANS_TEARS"          ] = { name="larmes de Lorkhan"              , crafting_type=al, item_id= 64501 }

, ["GREASE"                  ] = { name="graisse"                        , crafting_type=al, item_id= 75357 }
, ["ICHOR"                   ] = { name="sanie"                          , crafting_type=al, item_id= 75358 }
, ["SLIME"                   ] = { name="fluide visqueux"                , crafting_type=al, item_id= 75359 }
, ["GALL"                    ] = { name="bile"                           , crafting_type=al, item_id= 75360 }
, ["TEREBINTHINE"            ] = { name="térébenthine"                   , crafting_type=al, item_id= 75361 }
, ["PITCH_BILE"              ] = { name="bile-poix"                      , crafting_type=al, item_id= 75362 }
, ["TARBLACK"                ] = { name="goudron"                        , crafting_type=al, item_id= 75363 }
, ["NIGHT_OIL"               ] = { name="nocthuile"                      , crafting_type=al, item_id= 75364 }
, ["ALKAHEST"                ] = { name="alcaleste"                      , crafting_type=al, item_id= 75365 }

, ["JORA"                    ] = { name="Jora"                           , crafting_type=en, item_id= 45855 , name_2="insignifiant"  }
, ["PORADE"                  ] = { name="Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Jéra"                           , crafting_type=en, item_id= 45857 , name_2="petit"         }
, ["JEJORA"                  ] = { name="Jéjora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Odra"                           , crafting_type=en, item_id= 45807 , name_2="mineur"        }
, ["POJORA"                  ] = { name="Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Edora"                          , crafting_type=en, item_id= 45809 , name_2="modéré"        }
, ["JAERA"                   ] = { name="Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Pora"                           , crafting_type=en, item_id= 45811 , name_2="fort"          }
, ["DENARA"                  ] = { name="Dénara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Réra"                           , crafting_type=en, item_id= 45813 , name_2="majeur"        }
, ["DERADO"                  ] = { name="Dérado"                         , crafting_type=en, item_id= 45814 , name_2="grandiose"    , name_3="grandiose"      }
, ["REKURA"                  ] = { name="Rekura"                         , crafting_type=en, item_id= 45815 , name_2="splendide"     }
, ["KURA"                    ] = { name="Kura"                           , crafting_type=en, item_id= 45816 , name_2="monumental"    }
, ["REJERA"                  ] = { name="Rejera"                         , crafting_type=en, item_id= 64509 , name_2="superbe"       }
, ["REPORA"                  ] = { name="Repora"                         , crafting_type=en, item_id= 68341 }

, ["JODE"                    ] = { name="Jode"                           , crafting_type=en, item_id= 45817 }
, ["NOTADE"                  ] = { name="Notade"                         , crafting_type=en, item_id= 45818 }
, ["ODE"                     ] = { name="Ode"                            , crafting_type=en, item_id= 45819 }
, ["TADE"                    ] = { name="Tade"                           , crafting_type=en, item_id= 45820 }
, ["JAYDE"                   ] = { name="Jayde"                          , crafting_type=en, item_id= 45821 }
, ["EDODE"                   ] = { name="Edode"                          , crafting_type=en, item_id= 45822 }
, ["POJODE"                  ] = { name="Pojode"                         , crafting_type=en, item_id= 45823 }
, ["REKUDE"                  ] = { name="Rekudé"                         , crafting_type=en, item_id= 45824 }
, ["HADE"                    ] = { name="Hade"                           , crafting_type=en, item_id= 45825 }
, ["IDODE"                   ] = { name="Idode"                          , crafting_type=en, item_id= 45826 }
, ["PODE"                    ] = { name="Pode"                           , crafting_type=en, item_id= 45827 }
, ["KEDEKO"                  ] = { name="Kédéko"                         , crafting_type=en, item_id= 45828 }
, ["REDE"                    ] = { name="Rede"                           , crafting_type=en, item_id= 45829 }
, ["KUDE"                    ] = { name="Kudé"                           , crafting_type=en, item_id= 45830 }
, ["JEHADE"                  ] = { name="Jehade"                         , crafting_type=en, item_id= 64508 }
, ["ITADE"                   ] = { name="Itade"                          , crafting_type=en, item_id= 68340 }

, ["DEKEIPA"                 ] = { name="Dekeïpa"                        , crafting_type=en, item_id= 45839 , name_2="givré"         }
, ["DENI"                    ] = { name="Deni"                           , crafting_type=en, item_id= 45833 , name_2="vigoureux"    , name_3="Vigueur"        }
, ["DENIMA"                  ] = { name="Denima"                         , crafting_type=en, item_id= 45836 , name_2="revigorant"    }
, ["DETERI"                  ] = { name="Deteri"                         , crafting_type=en, item_id= 45842 , name_2="robuste"       }
, ["HAOKO"                   ] = { name="Haoko"                          , crafting_type=en, item_id= 45841 , name_2="odieux"        }
, ["HAKEIJO"                 ] = { name="Hakeijo"                        , crafting_type=en, item_id= 68342 , name_2="de défense prismatique"}
, ["KADERI"                  ] = { name="Kadéri"                         , crafting_type=en, item_id= 45849 , name_2="percutant"     }
, ["KUOKO"                   ] = { name="Kuoko"                          , crafting_type=en, item_id= 45837 , name_2="empoisonné"    }
, ["MAKDERI"                 ] = { name="Makdéri"                        , crafting_type=en, item_id= 45848 , name_2="de puissance magique"}
, ["MAKKO"                   ] = { name="Makko"                          , crafting_type=en, item_id= 45832 , name_2="magique"      , name_3="magie"          }
, ["MAKKOMA"                 ] = { name="Makkoma"                        , crafting_type=en, item_id= 45835 , name_2="régénérant"    }
, ["MEIP"                    ] = { name="Méip"                           , crafting_type=en, item_id= 45840 , name_2="étourdissant"  }
, ["OKO"                     ] = { name="Oko"                            , crafting_type=en, item_id= 45831 , name_2="vital"        , name_3="Santé"          }
, ["OKOMA"                   ] = { name="Okoma"                          , crafting_type=en, item_id= 45834 , name_2="revivifiant"   }
, ["OKORI"                   ] = { name="Okori"                          , crafting_type=en, item_id= 45843 , name_2="de dégâts d'arme"}
, ["ORU"                     ] = { name="Oru"                            , crafting_type=en, item_id= 45846 , name_2="de l'alchimiste"}
, ["RAKEIPA"                 ] = { name="Rakeïpa"                        , crafting_type=en, item_id= 45838 , name_2="ardent"        }
, ["TADERI"                  ] = { name="Taderi"                         , crafting_type=en, item_id= 45847 , name_2="de puissance physique"}

, ["TA"                      ] = { name="Ta"                             , crafting_type=en, item_id= 45850 , name_2="Normal"   }
, ["JEJOTA"                  ] = { name="Jéjota"                         , crafting_type=en, item_id= 45851 , name_2="Raffiné"  }
, ["DENATA"                  ] = { name="Denata"                         , crafting_type=en, item_id= 45852 , name_2="Supérieur"}
, ["REKUTA"                  ] = { name="Rekuta"                         , crafting_type=en, item_id= 45853 , name_2="Épique"   }
, ["KUTA"                    ] = { name="Kuta"                           , crafting_type=en, item_id= 45854 , name_2="Légendaire"}
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
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="Rend de la Santé"     , master_potion="essence de Santé^f"                , master_poison="Poison de drain de Santé IX^m"     }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="Réduit la Santé"      , master_potion="essence de ravage de Santé^f"      , master_poison="Poison de ravage de Santé IX^m"    }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="Rend de la Magie"     , master_potion="essence de Magie^f"                , master_poison="Poison de drain de Magie IX^m"     }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="Réduit la Magie"      , master_potion="essence de ravage de Magie^f"      , master_poison="Poison de ravage de Magie IX^m"    }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="Rend de la Vigueur"   , master_potion="essence de Vigueur^f"              , master_poison="Poison de drain de Vigueur IX^m"   }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="Ravage de Vigueur"    , master_potion="essence de ravage de Vigueur^f"    , master_poison="Poison de ravage de Vigueur IX^m"  }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="Augmente la résistance aux sorts", master_potion="essence de protection contre les sorts^f", master_poison="Poison de drain de Protection IX^m"}
,   ["BREACH"                 ] = { trait_index=08, name="Brèche"               , master_potion="essence de ravage de protection contre les sorts^f", master_poison="Poison de brèche IX^m"             }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="Augmente l'armure"    , master_potion="essence de armure^f"               , master_poison="Poison de drain de Résolution IX^m"}
,   ["FRACTURE"               ] = { trait_index=10, name="Fracture"             , master_potion="essence de ravage d'armure^f"      , master_poison="Poison de fracture IX^m"           }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="Augmente la puissance des sorts", master_potion="essence de puissance de sort^f"    , master_poison="Poison de drain de Sorcellerie IX^m"}
,   ["COWARDICE"              ] = { trait_index=12, name="Couardise"            , master_potion="essence de couardise^f"            , master_poison="Poison de lâcheté IX^m"            }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="Augmente la puissance de l'arme", master_potion="essence de puissance d'arme^f"     , master_poison="Poison de drain de Brutalité IX^m" }
,   ["MAIM"                   ] = { trait_index=14, name="Mutilation"           , master_potion="essence de mutilation^f"           , master_poison="Poison de Mutilation IX^m"         }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="Critique de sorts"    , master_potion="essence de critique des sorts^f"   , master_poison="Poison de drain de Prophécie IX^m" }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="Incertitude"          , master_potion="essence de incertitude^f"          , master_poison="Poison d'Incertitude IX^m"         }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="Critique d'armes"     , master_potion="essence de critique d'arme^f"      , master_poison="Poison de drain de Sauvagerie IX^m"}
,   ["ENERVATION"             ] = { trait_index=18, name="Affaiblissement"      , master_potion="essence de affaiblissement^f"      , master_poison="Poison d'Affaiblissement IX^m"     }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="Implacable"           , master_potion="essence de Immuabilité^f"          , master_poison="Poison du monte-en-l'air IX^m"     }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="Capture"              , master_potion="essence de capture^f"              , master_poison="Poison d'Entrave IX^m"             }
,   ["DETECTION"              ] = { trait_index=21, name="de détection"         , master_potion="essence de détection^f"            , master_poison="Poison de drain de Furtivité IX^m" }
,   ["INVISIBLE"              ] = { trait_index=22, name="invisible"            , master_potion="essence de Invisibilité^f"         , master_poison="Poison révélateur IX^m"            }
,   ["SPEED"                  ] = { trait_index=23, name="Vitesse"              , master_potion="essence de vitesse^f"              , master_poison="Poison de drain de vitesse IX^m"   }
,   ["HINDRANCE"              ] = { trait_index=24, name="Entrave"              , master_potion="essence de entravant^f"            , master_poison="Poison ralentissant IX^m"          }
,   ["PROTECTION"             ] = { trait_index=25, name="Protection"           , master_potion="essence de Protection^f"           , master_poison="Poison inverseur de protection IX^m"}
,   ["VULNERABILITY"          ] = { trait_index=26, name="Vulnérabilité"        , master_potion="essence de vulnérabilité^f"        , master_poison="Poison de vulnérabilité IX^m"      }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="Santé persistante"    , master_potion="essence de Santé pérenne^f"        , master_poison="Poison de drain graduel de Santé IX^m"}
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="Ravage de Santé graduel", master_potion="essence de Ravage de Santé rampante^f", master_poison="Poison de ravage graduel de Santé IX^m"}
,   ["VITALITY"               ] = { trait_index=29, name="Vitalité"             , master_potion="essence de vitalité^f"             , master_poison="Poison de drain de Vitalité IX^m"  }
,   ["DEFILE"                 ] = { trait_index=30, name="Profanation"          , master_potion="essence de Avilissement^f"         , master_poison="Poison profanateur IX^m"           }
}

-- The 6 possible potions and poisons that a daily crafting writ can request.
--
-- trait        reference into ALCHEMY_TRAITS so you know which potion/poison to make
-- potion_name  Appears in potion name such a "Elixir of Health"
-- poison name  Appears in poison name such as "Drain Health Poison III"
--
local at = LibCraftText.ALCHEMY_TRAIT -- for less typing
LibCraftText.ALCHEMY_ITEM = {
  ["HEALTH"           ] = { trait=at.RESTORE_HEALTH , potion_name="santé"                        , poison_name="drain de santé"               }
, ["MAGICKA"          ] = { trait=at.RESTORE_MAGICKA, potion_name="magie"                        , poison_name="drain de magie"               }
, ["STAMINA"          ] = { trait=at.RESTORE_STAMINA, potion_name="vigueur"                      , poison_name="drain de vigueur"             }
, ["RAVAGE_HEALTH"    ] = { trait=at.RAVAGE_HEALTH  , potion_name="ravage de santé"              , poison_name="ravage de santé"              }
, ["RAVAGE_MAGICKA"   ] = { trait=at.RAVAGE_MAGICKA , potion_name="ravage de magie"              , poison_name="ravage de magie"              }
, ["RAVAGE_STAMINA"   ] = { trait=at.RAVAGE_STAMINA , potion_name="ravage de vigueur"            , poison_name="ravage de vigueur"            }
}
at = nil

-- Potion/Poison leveled names
--
-- "Dram of Health" vs. "Potion of Health" vs. "Essence of Health"
--
-- Poison levels are just the numeric suffix "III" or "IX" or whatever.
--
-- rank             alchemy rank 1..9
-- potion_name      string that appears in names of potions at this rank
-- poison_name         "                            poisons  "
-- potion_mat       material to use to craft a potion of this rank
-- poison_mat          "                       poison  "
--
local cm = LibCraftText.CONSUMABLE_MATERIAL -- for less typing
LibCraftText.ALCHEMY_SOLVENT = {
  { rank=1, name="gorgée"                 , mat=cm.NATURAL_WATER  }
, { rank=2, name="teinture"               , mat=cm.CLEAR_WATER    }
, { rank=3, name="goutte"                 , mat=cm.PRISTINE_WATER }
, { rank=4, name="potion"                 , mat=cm.CLEANSED_WATER }
, { rank=5, name="solution"               , mat=cm.FILTERED_WATER }
, { rank=6, name="élixir"                 , mat=cm.PURIFIED_WATER }
, { rank=7, name="panacée"                , mat=cm.CLOUD_MIST     }
, { rank=8, name="distillat"              , mat=cm.STAR_DEW       }
, { rank=9, name="essence"                , mat=cm.LORKHANS_TEARS }

, { rank=1, name="i"                      , mat=cm.GREASE         }
, { rank=2, name="ii"                     , mat=cm.ICHOR          }
, { rank=3, name="iii"                    , mat=cm.SLIME          }
, { rank=4, name="iv"                     , mat=cm.GALL           }
, { rank=5, name="v"                      , mat=cm.TEREBINTHINE   }
, { rank=6, name="vi"                     , mat=cm.PITCH_BILE     }
, { rank=7, name="vii"                    , mat=cm.TARBLACK       }
, { rank=8, name="viii"                   , mat=cm.NIGHT_OIL      }
, { rank=9, name="ix"                     , mat=cm.ALKAHEST       }
}
cm = nil

-- Quest Titles --------------------------------------------------------------

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
           , "Un vêtement de cuir magistral"    } -- "Masterful Leatherwear"
,   [en] = { "Un glyphe magistral"              } -- "A Masterful Glyph"
,   [al] = { "Une concoction magistrale"        } -- "A Masterful Concoction"
,   [pr] = { "Un festin magistral"              } -- "A Masterful Feast"
,   [ww] = { "Un bouclier magistral"              -- "A Masterful Shield"
           , "Une arme magistrale"              } -- "A Masterful Weapon"
,   [jw] = { "Joaillerie magistrale"            } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Qualité"                         -- "Quality"
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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Raffiné"                  -- "Fine"
,   [3] = "Supérieur"                -- "Superior"
,   [4] = "Épique"                   -- "Epic"
,   [5] = "Légendaire"               -- "Legendary"
}

