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
  ["H1_AXE"         ] = { name="Hacha"                , master_name="Hacha"                     , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="Espada"               , master_name="Espada"                    , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="hacha de batalla"     , master_name="Hacha de batalla"          , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="Maza"                 , master_name="Maza"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="Mandoble"             , master_name="Mandoble"                  , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="Daga"                 , master_name="Daga"                      , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="Coraza"               , master_name="Coraza"                    , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="escarpes"             , master_name="Escarpes"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="guanteletes"          , master_name="Guanteletes"               , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="yelmo"                , master_name="Casco"                     , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="grebas"               , master_name="Grebas"                    , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="espaldarones"         , master_name="Espaldarones"              , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="Faja"                 , master_name="Faja"                      , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="Túnica"               , master_name="Túnica"                    , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="Jubón"                , master_name="Jubón"                     , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="Zapatos"              , master_name="Zapatos"                   , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="guantes"              , master_name="Guantes"                   , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="Capucha"              , master_name="Capucha"                   , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="calzones"             , master_name="Calzones"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="Cubrehombros"         , master_name="Cubrehombros"              , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="Cubrehombros"}
, ["SASH"           ] = { name="banda"                , master_name="Banda"                     , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="banda"     }
, ["JACK"           ] = { name="pechera"              , master_name="Pechera"                   , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="botas"                , master_name="Botas"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="brazales"             , master_name="Brazales"                  , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="brazaletes"}
, ["HELMET"         ] = { name="Casco"                , master_name="Casco"                     , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="yelmo"     }
, ["GUARDS"         ] = { name="musleras"             , master_name="Musleras"                  , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="Hombreras"            , master_name="Hombreras"                 , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="Cinturón"             , master_name="Cinturón"                  , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="Arco"                 , master_name="Arco"                      , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="Vara infernal"        , master_name="Vara infernal"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="vara glaciar"         , master_name="Vara glaciar"              , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="vara eléctrica"       , master_name="Vara eléctrica"            , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="vara restauradora"    , master_name="Vara restauradora"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="Escudo"               , master_name="Escudo"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="collar"               , master_name="Collar"                    , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="colgantes" }
, ["RING"           ] = { name="anillo"               , master_name="Anillo"                    , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

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
  ["AETHERIAL_TEA"                   ] = { name="té aeterio"                            , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="té aeterio"  }
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="remolachas de Alik'r con queso de cabra", food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="manzanas asadas"                       , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="patata asada"                          , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="plátano sorpresa"                      , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="néctar de cebada"                      , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="Crema de marisco con battaglir"        , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="Té de limón amargo"                    , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="cerveza del Pantano de Hierro"         , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="Salchicha de cerdo bretona"            , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="Sopa de zanahoria"                     , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="pechuga de pollo"                      , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="mazorca de maíz de Chorrol"            , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="Jalea de uva con canela"               , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="vino aclarado de syrah"                , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="vino aclarado de syrah"}
, ["COMELY_WENCH_WHISKEY"            ] = { name="whisky de la doncella encantadora"     , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="pan de maíz cyrodílico"                , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="buñuelos de calabaza de Cyrodill"      , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="antílope asado de Elinhir"             , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="Licor eltérico"                        , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="Licor eltérico"}
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="plato de frutas y queso de Primada"    , food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="Palitos de pescado"                    , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="grog cuatro-ojos"                      , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="Puré de patatas con ajo"               , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="semillas de calabaza con ajo"          , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="Cerveza de trigo y jengibre"           , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="Vino Cegado-Por-Dioses"                , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="Vino Cegado-Por-Dioses"}
, ["GOLDEN_LAGER"                    ] = { name="Cerveza rubia dorada"                  , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="Mazte sedoso"                          , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="tónico de dormir del abuelo"           , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="conserva de uvas"                      , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="tónico de bruja cuervo"                , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="Liebre en salsa de ajo"                , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="Liebre en salsa de ajo"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="caldo espeso de maíz y ajo"            , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="centeno meloso"                        , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="Pastel de zanahoria \"El Paisaje de Jerall\"", food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="Mazte de azahar"                       , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="pez bruja al ajo de Lilmoth"           , food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="pastel de trompa de mamut"             , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="Té maormer"                            , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="aguamiel de Markarth"                  , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="mazte"                                 , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="whisky de sirena"                      , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="lomo de cerdo relleno de mijo"         , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="Vino caliente"                         , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="remordimiento de muthsera"             , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="Vino de nereida"                       , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="zanahorias al ajo a la nibenesa"       , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="cerveza negra con avellanas"           , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="jalea de manzana y ajo de Orcelia"     , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="Arroz con tomate Pellitine"            , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="cerveza roja de centeno"               , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="Melón a la pimienta Redoran"           , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="maíz tostado"                          , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="cente-no en la cara"                   , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="Té de flor marina"                     , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="Curry de pescado y arroz de Senchal"   , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="cerveza \"Lo siento, cariño\""         , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="Malta agria"                           , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="té chai de bayacida"                   , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="mazte especiado"                       , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="plátanos asados de Fuertormenta"       , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="vino de syrah de los Surilie"          , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="Té de menta de Torval"                 , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="té de bayamelaza"                      , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="té de Dos-Céfiros"                     , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="Empanada de venado"                    , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="caldo de maíz del Bosque Occidental"   , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="trucha gratinada de Carrera Blanca"    , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
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
  ["IRON"          ] = { name="hierro"            , level_index= 1, material_index= 1, master_writ2=  1, crafting_type=bs, mat_set_id=mat_hvy  }
, ["STEEL"         ] = { name="acero"             , level_index= 2, material_index= 8, master_writ2=  9, crafting_type=bs, mat_set_id=mat_hvy  }
, ["ORICHALC"      ] = { name="oricalco"          , level_index= 3, material_index=13, master_writ2=156, crafting_type=bs, mat_set_id=mat_hvy  }
, ["DWARVEN"       ] = { name="acero enano"       , level_index= 4, material_index=18, master_writ2=160, crafting_type=bs, mat_set_id=mat_hvy  , name_2="acero enano"    }
, ["EBONY"         ] = { name="ébano"             , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ébano"          }
, ["CALCINIUM"     ] = { name="calcinio"          , level_index= 6, material_index=26, master_writ2=168, crafting_type=bs, mat_set_id=mat_hvy  }
, ["GALATITE"      ] = { name="galatita"          , level_index= 7, material_index=29, master_writ2=172, crafting_type=bs, mat_set_id=mat_hvy  }
, ["QUICKSILVER"   ] = { name="azogue"            , level_index= 8, material_index=32, master_writ2=176, crafting_type=bs, mat_set_id=mat_hvy  }
, ["VOIDSTEEL"     ] = { name="acero del vacío"   , level_index= 9, material_index=34, master_writ2=180, crafting_type=bs, mat_set_id=mat_hvy  }
, ["RUBEDITE"      ] = { name="rubedita"          , level_index=10, material_index=40, master_writ2=188, crafting_type=bs, mat_set_id=mat_hvy  }

, ["JUTE"          ] = { name="tejido artesanal"  , level_index= 1, material_index= 1, master_writ2=  5, crafting_type=cl, mat_set_id=mat_lgt  , name_2="tejido artesanal"}
, ["LINEN"         ] = { name="lino"              , level_index= 2, material_index= 8, master_writ2= 45, crafting_type=cl, mat_set_id=mat_lgt  }
, ["COTTON"        ] = { name="algodón"           , level_index= 3, material_index=13, master_writ2= 47, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SPIDERSILK"    ] = { name="seda de araña"     , level_index= 4, material_index=18, master_writ2= 49, crafting_type=cl, mat_set_id=mat_lgt  }
, ["EBONTHREAD"    ] = { name="hilo de ébano"     , level_index= 5, material_index=23, master_writ2= 51, crafting_type=cl, mat_set_id=mat_lgt  }
, ["KRESH"         ] = { name="kresh"             , level_index= 6, material_index=26, master_writ2=125, crafting_type=cl, mat_set_id=mat_lgt  }
, ["IRONTHREAD"    ] = { name="hilo de hierro"    , level_index= 7, material_index=29, master_writ2=126, crafting_type=cl, mat_set_id=mat_lgt  , name_2="hilo férreo"     }
, ["SILVERWEAVE"   ] = { name="hilo de plata"     , level_index= 8, material_index=32, master_writ2=127, crafting_type=cl, mat_set_id=mat_lgt  }
, ["SHADOWSPUN"    ] = { name="tejido sombrío"    , level_index= 9, material_index=34, master_writ2=128, crafting_type=cl, mat_set_id=mat_lgt  }
, ["ANCESTOR_SILK" ] = { name="seda ancestral"    , level_index=10, material_index=40, master_writ2=194, crafting_type=cl, mat_set_id=mat_lgt  , name_2="seda ancestral"  }

, ["RAWHIDE"       ] = { name="piel cruda"        , level_index= 1, material_index= 1, master_writ2=148, crafting_type=cl, mat_set_id=mat_med  }
, ["HIDE"          ] = { name="piel"              , level_index= 2, material_index= 8, master_writ2=154, crafting_type=cl, mat_set_id=mat_med  }
, ["LEATHER"       ] = { name="cuero"             , level_index= 3, material_index=13, master_writ2=158, crafting_type=cl, mat_set_id=mat_med  }
, ["FULL_LEATHER"  ] = { name="cuero tratado"     , level_index= 4, material_index=18, master_writ2=162, crafting_type=cl, mat_set_id=mat_med  }
, ["FELL_HIDE"     ] = { name="piel impía"        , level_index= 5, material_index=23, master_writ2=166, crafting_type=cl, mat_set_id=mat_med  }
, ["BRIGANDINE"    ] = { name="brigantina"        , level_index= 6, material_index=26, master_writ2=170, crafting_type=cl, mat_set_id=mat_med  , name_2="brigantina"      }
, ["IRONHIDE"      ] = { name="piel férrea"       , level_index= 7, material_index=29, master_writ2=174, crafting_type=cl, mat_set_id=mat_med  }
, ["SUPERB"        ] = { name="soberbio"          , level_index= 8, material_index=32, master_writ2=131, crafting_type=cl, mat_set_id=mat_med  , name_2="soberbia"        }
, ["SHADOWHIDE"    ] = { name="piel sombría"      , level_index= 9, material_index=34, master_writ2=132, crafting_type=cl, mat_set_id=mat_med  }
, ["RUBEDO_LEATHER"] = { name="cuero rubedo"      , level_index=10, material_index=40, master_writ2=190, crafting_type=cl, mat_set_id=mat_med  }

, ["MAPLE"         ] = { name="arce"              , level_index= 1, material_index= 1, master_writ2=  2, crafting_type=ww, mat_set_id=mat_wood }
, ["OAK"           ] = { name="roble"             , level_index= 2, material_index= 8, master_writ2= 18, crafting_type=ww, mat_set_id=mat_wood }
, ["BEECH"         ] = { name="haya"              , level_index= 3, material_index=13, master_writ2= 20, crafting_type=ww, mat_set_id=mat_wood }
, ["HICKORY"       ] = { name="nogal"             , level_index= 4, material_index=18, master_writ2= 22, crafting_type=ww, mat_set_id=mat_wood }
, ["YEW"           ] = { name="tejo"              , level_index= 5, material_index=23, master_writ2= 24, crafting_type=ww, mat_set_id=mat_wood }
, ["BIRCH"         ] = { name="abedul"            , level_index= 6, material_index=26, master_writ2=133, crafting_type=ww, mat_set_id=mat_wood }
, ["ASH"           ] = { name="fresno"            , level_index= 7, material_index=29, master_writ2=134, crafting_type=ww, mat_set_id=mat_wood }
, ["MAHOGANY"      ] = { name="caoba"             , level_index= 8, material_index=32, master_writ2=135, crafting_type=ww, mat_set_id=mat_wood }
, ["NIGHTWOOD"     ] = { name="nocteca"           , level_index= 9, material_index=34, master_writ2=136, crafting_type=ww, mat_set_id=mat_wood }
, ["RUBY_ASH"      ] = { name="fresno rubí"       , level_index=10, material_index=40, master_writ2=192, crafting_type=ww, mat_set_id=mat_wood }

, ["PEWTER"        ] = { name="peltre"            , level_index= 1, material_index= 1, master_writ2=  6, crafting_type=jw, mat_set_id=mat_jewl }
, ["COPPER"        ] = { name="cobre"             , level_index= 2, material_index=13, master_writ2= 56, crafting_type=jw, mat_set_id=mat_jewl }
, ["SILVER"        ] = { name="plata"             , level_index= 3, material_index=26, master_writ2=137, crafting_type=jw, mat_set_id=mat_jewl }
, ["ELECTRUM"      ] = { name="electro"           , level_index= 4, material_index=33, master_writ2=139, crafting_type=jw, mat_set_id=mat_jewl , name_2="electrum"       }
, ["PLATINUM"      ] = { name="platino"           , level_index= 5, material_index=40, master_writ2=255, crafting_type=jw, mat_set_id=mat_jewl }
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
  ["BLESSED_THISTLE"         ] = { name="cardo bendito"                  , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="entoloma azul"                  , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="lengua de buey"                 , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="aguilegia"                      , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="aciano"                         , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="espina de dragón"               , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="rúsula emética"                 , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="seta de diablillo"              , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="cardamina"                      , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="rúsula luminosa"                , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="flor de montaña"                , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="seta de Namira"                 , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="raíz de nirn"                   , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="falacea"                        , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="coprinus violeta"               , crafting_type=al, item_id= 30152 , name_2="coprinus violeta"   }
, ["WATER_HYACINTH"          ] = { name="jacinto de agua"                , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="hongo blanco"                   , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="artemisia"                      , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="baba de escarabajo"             , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="ala de mariposa"                , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="larva de mosca de la carne"     , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="quitina de cangrejo del barro"  , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="belladona"                      , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="jalea de scrib"                 , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="huevo de araña"                 , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="tórax de luciérnaga"            , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="hiel de almeja"                 , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="polvo de nácar"                 , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="agua natural"                   , crafting_type=al, item_id=   883 , name_2="agua natural"       , rank=1, potion_name="sorbo"                   }
, ["CLEAR_WATER"             ] = { name="agua limpia"                    , crafting_type=al, item_id=  1187                               , rank=2, potion_name="tintura"                 }
, ["PRISTINE_WATER"          ] = { name="agua prístina"                  , crafting_type=al, item_id=  4570 , name_2="agua prístina"      , rank=3, potion_name="trago"                   , potion_name2="trago"                    }
, ["CLEANSED_WATER"          ] = { name="agua depurada"                  , crafting_type=al, item_id= 23265 , name_2="agua depurada"      , rank=4, potion_name="poción"                  }
, ["FILTERED_WATER"          ] = { name="agua filtrada"                  , crafting_type=al, item_id= 23266 , name_2="agua filtrada"      , rank=5, potion_name="solución"                }
, ["PURIFIED_WATER"          ] = { name="agua purificada"                , crafting_type=al, item_id= 23267 , name_2="agua purificada"    , rank=6, potion_name="elixir"                  }
, ["CLOUD_MIST"              ] = { name="Bruma"                          , crafting_type=al, item_id= 23268                               , rank=7, potion_name="panacea"                 }
, ["STAR_DEW"                ] = { name="rocío estelar"                  , crafting_type=al, item_id= 64500                               , rank=8, potion_name="destilado"               }
, ["LORKHANS_TEARS"          ] = { name="Lágrimas de Lorkhan"            , crafting_type=al, item_id= 64501                               , rank=9, potion_name="esencia"                 }

, ["GREASE"                  ] = { name="Grasa"                          , crafting_type=al, item_id= 75357                               , rank=1, poison_name="i"                       }
, ["ICHOR"                   ] = { name="icor"                           , crafting_type=al, item_id= 75358                               , rank=2, poison_name="ii"                      }
, ["SLIME"                   ] = { name="limo"                           , crafting_type=al, item_id= 75359                               , rank=3, poison_name="iii"                     }
, ["GALL"                    ] = { name="bilis"                          , crafting_type=al, item_id= 75360                               , rank=4, poison_name="iv"                      }
, ["TEREBINTHINE"            ] = { name="trementina"                     , crafting_type=al, item_id= 75361                               , rank=5, poison_name="v"                       }
, ["PITCH_BILE"              ] = { name="bilis ácido"                    , crafting_type=al, item_id= 75362                               , rank=6, poison_name="vi"                      }
, ["TARBLACK"                ] = { name="betún negro"                    , crafting_type=al, item_id= 75363                               , rank=7, poison_name="vii"                     }
, ["NIGHT_OIL"               ] = { name="aceite noctívago"               , crafting_type=al, item_id= 75364                               , rank=8, poison_name="viii"                    }
, ["ALKAHEST"                ] = { name="alkahest"                       , crafting_type=al, item_id= 75365                               , rank=9, poison_name="ix"                      }

, ["JORA"                    ] = { name="Jora"                           , crafting_type=en, item_id= 45855 , name_2="mediocre"      }
, ["PORADE"                  ] = { name="Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Jera"                           , crafting_type=en, item_id= 45857 , name_2="insignificante"}
, ["JEJORA"                  ] = { name="Jejora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Odra"                           , crafting_type=en, item_id= 45807 , name_2="menor"         }
, ["POJORA"                  ] = { name="Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Edora"                          , crafting_type=en, item_id= 45809 , name_2="moderado"      }
, ["JAERA"                   ] = { name="Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Pora"                           , crafting_type=en, item_id= 45811 , name_2="fuerte"        }
, ["DENARA"                  ] = { name="Denara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Rera"                           , crafting_type=en, item_id= 45813 , name_2="superior"      }
, ["DERADO"                  ] = { name="Derado"                         , crafting_type=en, item_id= 45814 , name_2="grande"       , name_3="grand"          }
, ["REKURA"                  ] = { name="Rekura"                         , crafting_type=en, item_id= 45815 , name_2="espléndido"    }
, ["KURA"                    ] = { name="Kura"                           , crafting_type=en, item_id= 45816 , name_2="monumental"    }
, ["REJERA"                  ] = { name="Rejera"                         , crafting_type=en, item_id= 64509 , name_2="soberbio"      }
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

, ["DEKEIPA"                 ] = { name="Dekeipa"                        , crafting_type=en, item_id= 45839 , name_2="hielo"         }
, ["DENI"                    ] = { name="Deni"                           , crafting_type=en, item_id= 45833 , name_2="aguante"      , name_3="aguante"        }
, ["DENIMA"                  ] = { name="Denima"                         , crafting_type=en, item_id= 45836 , name_2="regeneración de aguante"}
, ["DETERI"                  ] = { name="Deteri"                         , crafting_type=en, item_id= 45842 , name_2="robustez"      }
, ["HAOKO"                   ] = { name="Haoko"                          , crafting_type=en, item_id= 45841 , name_2="podredumbre"   }
, ["HAKEIJO"                 ] = { name="Hakeijo"                        , crafting_type=en, item_id= 68342 , name_2="defensa prismática"}
, ["KADERI"                  ] = { name="Kaderi"                         , crafting_type=en, item_id= 45849 , name_2="percutante"    }
, ["KUOKO"                   ] = { name="Kuoko"                          , crafting_type=en, item_id= 45837 , name_2="veneno"        }
, ["MAKDERI"                 ] = { name="Makderi"                        , crafting_type=en, item_id= 45848 , name_2="aumento de daño mágico"}
, ["MAKKO"                   ] = { name="Makko"                          , crafting_type=en, item_id= 45832 , name_2="magia"        , name_3="magicka"        }
, ["MAKKOMA"                 ] = { name="Makkoma"                        , crafting_type=en, item_id= 45835 , name_2="regeneración de magia"}
, ["MEIP"                    ] = { name="Meip"                           , crafting_type=en, item_id= 45840 , name_2="descarga"      }
, ["OKO"                     ] = { name="Oko"                            , crafting_type=en, item_id= 45831 , name_2="vida"         , name_3="vida"           }
, ["OKOMA"                   ] = { name="Okoma"                          , crafting_type=en, item_id= 45834 , name_2="regeneración de salud"}
, ["OKORI"                   ] = { name="Okori"                          , crafting_type=en, item_id= 45843 , name_2="daño físico"   }
, ["ORU"                     ] = { name="Oru"                            , crafting_type=en, item_id= 45846 , name_2="del alquimista"}
, ["RAKEIPA"                 ] = { name="Rakeipa"                        , crafting_type=en, item_id= 45838 , name_2="fuego"         }
, ["TADERI"                  ] = { name="Taderi"                         , crafting_type=en, item_id= 45847 , name_2="aumento de daño físico"}

, ["TA"                      ] = { name="Ta"                             , crafting_type=en, item_id= 45850 , name_2="Normal"   }
, ["JEJOTA"                  ] = { name="Jejota"                         , crafting_type=en, item_id= 45851 , name_2="Bueno"    }
, ["DENATA"                  ] = { name="Denata"                         , crafting_type=en, item_id= 45852 , name_2="Superior" }
, ["REKUTA"                  ] = { name="Rekuta"                         , crafting_type=en, item_id= 45853 , name_2="Épico"    }
, ["KUTA"                    ] = { name="Kuta"                           , crafting_type=en, item_id= 45854 , name_2="Legendario"}
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
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="Restauración de salud"    , master_potion="esencia de salud"                  , master_poison="veneno de absorción de vida IX"    , daily_potion_name="salud"                        , daily_poison_name="absorción de vida"            }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="Reducción de salud"       , master_potion="esencia de reducción de salud"     , master_poison="Veneno de daño a la salud IX"      , daily_potion_name="reducción de salud"           , daily_poison_name="daño a la salud"              , daily_poison_name2="daño a la salud"              }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="Restauración de magia"    , master_potion="esencia de magia"                  , master_poison="Veneno de absorción de magia IX"   , daily_potion_name="magia"                        , daily_poison_name="absorción de magia"           }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="Reducción de magia"       , master_potion="esencia de reducción de magia"     , master_poison="Veneno de daño a la magia IX"      , daily_potion_name="reducción de magia"           , daily_poison_name="daño a la magia"              , daily_poison_name2="reducción de magia"            }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="Restauración de aguante"  , master_potion="esencia de aguante"                , master_poison="Veneno de absorción de aguante IX" , daily_potion_name="aguante"                      , daily_poison_name="absorción de aguante"         }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="Reducción de aguante"     , master_potion="esencia de reducción de aguante"   , master_poison="Veneno de daño al aguante IX"      , daily_potion_name="reducción de aguante"         , daily_poison_name="daño al aguante"              , daily_poison_name2="daño al aguante"               }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="Aumento de resistencia mágica", master_potion="esencia de's protección mágica"    , master_poison="Veneno de absorción del custodio IX"}
,   ["BREACH"                 ] = { trait_index=08, name="La Grieta"                , master_potion="Estrago de protección mágica esencia de", master_poison="Veneno perforador IX"              }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="Aumento de armadura"      , master_potion="esencia de's armadura"             , master_poison="Veneno de absorción resolutorio IX"}
,   ["FRACTURE"               ] = { trait_index=10, name="Fracture"                 , master_potion="esencia de estrago de armadura"    , master_poison="Veneno fracturador IX"             }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="Aumento de poder mágico"  , master_potion="esencia de potencia de hechizo"    , master_poison="Veneno de absorción del hechicero IX"}
,   ["COWARDICE"              ] = { trait_index=12, name="Cobardía"                 , master_potion="esencia de cobardía"               , master_poison="Veneno de cobardía IX"             }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="Aumento del poder físico" , master_potion="esencia de poder del arma"         , master_poison="Veneno de absorción de brutalidad IX"}
,   ["MAIM"                   ] = { trait_index=14, name="Mutilación"               , master_potion="esencia de mutilación"             , master_poison="Veneno de mutilación IX"           }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="Crítico mágico"           , master_potion="esencia de crítico mágico"         , master_poison="Veneno de absorción profética IX"  }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="Incertidumbre"            , master_potion="esencia de incertidumbre"          , master_poison="Veneno de incertidumbre IX"        }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="Crítico físico"           , master_potion="esencia de crítico físico"         , master_poison="Veneno de absorción de salvajismo IX"}
,   ["ENERVATION"             ] = { trait_index=18, name="Debilitación"             , master_potion="enervación esencia de"             , master_poison="Veneno enervante IX"               }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="Imparable"                , master_potion="esencia de inmovilidad"            , master_poison="Veneno del escapista IX"           }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="Captura"                  , master_potion="esencia de captura"                , master_poison="Veneno enredador IX"               }
,   ["DETECTION"              ] = { trait_index=21, name="Detección"                , master_potion="esencia de detección"              , master_poison="Veneno de absorción de sigilo IX"  }
,   ["INVISIBLE"              ] = { trait_index=22, name="Invisible"                , master_potion="esencia de invisibilidad"          , master_poison="Revealing Poison IX"               }
,   ["SPEED"                  ] = { trait_index=23, name="Velocidad"                , master_potion="esencia de velocidad"              , master_poison="Veneno de absorción de velocidad IX"}
,   ["HINDRANCE"              ] = { trait_index=24, name="Torpeza"                  , master_potion="estorbo esencia de"                , master_poison="Slowing Poison IX"                 }
,   ["PROTECTION"             ] = { trait_index=25, name="Protection"               , master_potion="esencia de Protección"             , master_poison="Veneno anti-protección IX"         }
,   ["VULNERABILITY"          ] = { trait_index=26, name="Vulnerabilidad"           , master_potion="esencia de vulnerabilidad"         , master_poison="Veneno de vulnerabilidad IX"       }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="Salud prolongada"         , master_potion="esencia de Salud prolongada"       , master_poison="Veneno de absorción progresiva de salud IX"}
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="Reducción de salud insidioso", master_potion="Estrago progresivo de salud esencia de", master_poison="Veneno de daño progresivo de salud IX"}
,   ["VITALITY"               ] = { trait_index=29, name="Vitalidad"                , master_potion="esencia de vitalidad"              , master_poison="veneno de absorción de vitalidad^z IX^z"}
,   ["DEFILE"                 ] = { trait_index=30, name="Profanación"              , master_potion="esencia de Profanación"            , master_poison="Veneno marchitador IX"             }
}


-- Quest Titles --------------------------------------------------------------

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Encargo de herrería"            -- "Blacksmith Writ"
,   [cl] = "Encargo de sastrería"           -- "Clothier Writ"
,   [en] = "Encargo de encantamiento"       -- "Enchanter Writ"
,   [al] = "Encargo de alquimia"            -- "Alchemist Writ"
,   [pr] = "Encargo de provisiones"         -- "Provisioner Writ"
,   [ww] = "Encargo de carpintería"         -- "Woodworker Writ"
,   [jw] = "Encargo de artesanía de joyería"-- "Jewelry Crafting Writ"
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
    [bs] = { "Una protección magistral"           -- "A Masterful Plate"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [cl] = { "Una prenda de tela magistral"       -- "Masterful Tailoring"
           , "Una prenda de cuero magistral"    } -- "Masterful Leatherwear"
,   [en] = { "Un glifo magistral"               } -- "A Masterful Glyph"
,   [al] = { "Una mezcla magistral"             } -- "A Masterful Concoction"
,   [pr] = { "Un festín magistral"              } -- "A Masterful Feast"
,   [ww] = { "Un escudo magistral"                -- "A Masterful Shield"
           , "Un arma magistral"                } -- "A Masterful Weapon"
,   [jw] = { "Joyería magistral"                } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

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

LibCraftText.QUALITIES = {
    [1] = "Normal"                   -- "Normal"
,   [2] = "Bueno"                    -- "Fine"
,   [3] = "Superior"                 -- "Superior"
,   [4] = "Épico"                    -- "Epic"
,   [5] = "Legendario"               -- "Legendary"
}

