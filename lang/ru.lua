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
  ["H1_AXE"         ] = { name="axe"                  , master_name="Axe"                       , pattern_index= 1, master_writ1=53, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_MACE"        ] = { name="mace"                 , master_name="Mace"                      , pattern_index= 2, master_writ1=56, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H1_SWORD"       ] = { name="sword"                , master_name="Sword"                     , pattern_index= 3, master_writ1=59, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_BATTLE_AXE"  ] = { name="battle axe"           , master_name="Battle Axe"                , pattern_index= 4, master_writ1=68, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_MAUL"        ] = { name="maul"                 , master_name="Maul"                      , pattern_index= 5, master_writ1=69, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["H2_GREATSWORD"  ] = { name="greatsword"           , master_name="Greatsword"                , pattern_index= 6, master_writ1=67, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["DAGGER"         ] = { name="dagger"               , master_name="Dagger"                    , pattern_index= 7, master_writ1=62, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_weap }
, ["CUIRASS"        ] = { name="cuirass"              , master_name="Cuirass"                   , pattern_index= 8, master_writ1=46, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["SABATONS"       ] = { name="sabatons"             , master_name="Sabatons"                  , pattern_index= 9, master_writ1=50, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GAUNTLETS"      ] = { name="gauntlets"            , master_name="Gauntlets"                 , pattern_index=10, master_writ1=52, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["HELM"           ] = { name="helm"                 , master_name="Helm"                      , pattern_index=11, master_writ1=44, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GREAVES"        ] = { name="greaves"              , master_name="Greaves"                   , pattern_index=12, master_writ1=49, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["PAULDRON"       ] = { name="pauldron"             , master_name="Pauldron"                  , pattern_index=13, master_writ1=47, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }
, ["GIRDLE"         ] = { name="girdle"               , master_name="Girdle"                    , pattern_index=14, master_writ1=48, crafting_type=bs, mat_set_id=mat_hvy , trait_set_id=trait_armr }

, ["ROBE"           ] = { name="robe"                 , master_name="Robe"                      , pattern_index= 1, master_writ1=28, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["JERKIN"         ] = { name="jerkin"               , master_name="Jerkin"                    , pattern_index= 2, master_writ1=75, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["SHOES"          ] = { name="shoes"                , master_name="Shoes"                     , pattern_index= 3, master_writ1=32, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["GLOVES"         ] = { name="gloves"               , master_name="Gloves"                    , pattern_index= 4, master_writ1=34, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["HAT"            ] = { name="hat"                  , master_name="Hat"                       , pattern_index= 5, master_writ1=26, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["BREECHES"       ] = { name="breeches"             , master_name="Breeches"                  , pattern_index= 6, master_writ1=31, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr }
, ["EPAULETS"       ] = { name="epaulets"             , master_name="Epaulets"                  , pattern_index= 7, master_writ1=29, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="epaulet"   }
, ["SASH"           ] = { name="sash"                 , master_name="Sash"                      , pattern_index= 8, master_writ1=30, crafting_type=cl, mat_set_id=mat_lgt , trait_set_id=trait_armr , name_2="sash"      }
, ["JACK"           ] = { name="jack"                 , master_name="Jack"                      , pattern_index= 9, master_writ1=37, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BOOTS"          ] = { name="boots"                , master_name="Boots"                     , pattern_index=10, master_writ1=41, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BRACERS"        ] = { name="bracers"              , master_name="Bracers"                   , pattern_index=11, master_writ1=43, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="bracers"   }
, ["HELMET"         ] = { name="helmet"               , master_name="Helmet"                    , pattern_index=12, master_writ1=35, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr , name_2="helmet"    }
, ["GUARDS"         ] = { name="guards"               , master_name="Guards"                    , pattern_index=13, master_writ1=40, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["ARM_COPS"       ] = { name="arm cops"             , master_name="Arm Cops"                  , pattern_index=14, master_writ1=38, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }
, ["BELT"           ] = { name="belt"                 , master_name="Belt"                      , pattern_index=15, master_writ1=39, crafting_type=cl, mat_set_id=mat_med , trait_set_id=trait_armr }

, ["BOW"            ] = { name="bow"                  , master_name="Bow"                       , pattern_index= 1, master_writ1=70, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["INFERNO_STAFF"  ] = { name="inferno staff"        , master_name="Inferno Staff"             , pattern_index= 3, master_writ1=72, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["ICE_STAFF"      ] = { name="ice staff"            , master_name="Ice Staff"                 , pattern_index= 4, master_writ1=73, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["LIGHTNING_STAFF"] = { name="lightning staff"      , master_name="Lightning Staff"           , pattern_index= 5, master_writ1=74, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["RESTO_STAFF"    ] = { name="restoration staff"    , master_name="Restoration Staff"         , pattern_index= 6, master_writ1=71, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_weap }
, ["SHIELD"         ] = { name="shield"               , master_name="Shield"                    , pattern_index= 2, master_writ1=65, crafting_type=ww, mat_set_id=mat_wood, trait_set_id=trait_armr }

, ["NECKLACE"       ] = { name="necklace"             , master_name="Necklace"                  , pattern_index= 2, master_writ1=18, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl , name_2="necklace"  }
, ["RING"           ] = { name="ring"                 , master_name="Ring"                      , pattern_index= 1, master_writ1=24, crafting_type=jw, mat_set_id=mat_jewl, trait_set_id=trait_jewl }

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
  ["AETHERIAL_TEA"                   ] = { name="этерический чай"                       , food_item_id=033602, recipe_list_index=  9, recipe_index= 31, name_2="этерический чай"}
, ["ALIKR_BEETS_WITH_GOAT_CHEESE"    ] = { name="алик'рская свекла с козьим сыром"      , food_item_id=028338, recipe_list_index=  3, recipe_index= 13}
, ["BAKED_APPLES"                    ] = { name="печеные яблоки"                        , food_item_id=033837, recipe_list_index=  2, recipe_index=  1}
, ["BAKED_POTATO"                    ] = { name="печеный картофель"                     , food_item_id=028354, recipe_list_index=  3, recipe_index=  2}
, ["BANANA_SURPRISE"                 ] = { name="банановый сюрприз"                     , food_item_id=028281, recipe_list_index=  2, recipe_index=  2}
, ["BARLEY_NECTAR"                   ] = { name="ячменный нектар"                       , food_item_id=033624, recipe_list_index=  8, recipe_index= 14}
, ["BATTAGLIR_CHOWDER"               ] = { name="чаудер из баттаглира"                  , food_item_id=028394, recipe_list_index=  3, recipe_index= 15}
, ["BITTERLEMON_TEA"                 ] = { name="горький чай с лимоном"                 , food_item_id=028457, recipe_list_index=  9, recipe_index= 13}
, ["BOG_IRON_ALE"                    ] = { name="болотнорудный эль"                     , food_item_id=028405, recipe_list_index=  8, recipe_index=  4}
, ["BRETON_PORK_SAUSAGE"             ] = { name="бретонская свиная колбаса"             , food_item_id=028342, recipe_list_index=  1, recipe_index= 13}
, ["CARROT_SOUP"                     ] = { name="морковный суп"                         , food_item_id=028321, recipe_list_index=  3, recipe_index=  1}
, ["CHICKEN_BREAST"                  ] = { name="куриная грудка"                        , food_item_id=033819, recipe_list_index=  1, recipe_index=  3}
, ["CHORROL_CORN_ON_THE_COB"         ] = { name="корролский початок кукурузы"           , food_item_id=033514, recipe_list_index=  3, recipe_index= 20}
, ["CINNAMON_GRAPE_JELLY"            ] = { name="виноградное желе с корицей"            , food_item_id=042790, recipe_list_index=  2, recipe_index= 19}
, ["CLARIFIED_SYRAH_WINE"            ] = { name="очищенное вино сорта шираз"            , food_item_id=028409, recipe_list_index=  8, recipe_index=  7, name_2="очищенное вино сорта шираз"}
, ["COMELY_WENCH_WHISKEY"            ] = { name="виски «Смазливая девка»"               , food_item_id=028402, recipe_list_index=  8, recipe_index= 31}
, ["CYRODILIC_CORNBREAD"             ] = { name="сиродильский кукурузный хлеб"          , food_item_id=033897, recipe_list_index=  3, recipe_index= 25}
, ["CYRODILIC_PUMPKIN_FRITTERS"      ] = { name="тыква во фритюре по-сиродильски"       , food_item_id=033789, recipe_list_index=  2, recipe_index= 20}
, ["ELENHIR_ROAST_ANTELOPE"          ] = { name="жареная оленина по-элинирски"          , food_item_id=033520, recipe_list_index=  1, recipe_index= 20}
, ["ELTHERIC_HOOCH"                  ] = { name="самогон «Элтерический»"                , food_item_id=028417, recipe_list_index=  8, recipe_index= 13, name_2="самогон «Элтерический»"}
, ["FIRSTHOLD_FRUIT_AND_CHEESE_PLATE"] = { name="сырная тарелка с фруктами по-фестхолдски", food_item_id=068236, recipe_list_index=  2, recipe_index= 40}
, ["FISHY_STICK"                     ] = { name="рыбные палочки"                        , food_item_id=033526, recipe_list_index=  1, recipe_index=  1}
, ["FOUR_EYE_GROG"                   ] = { name="грог «Четыре глаза»"                   , food_item_id=033612, recipe_list_index=  8, recipe_index=  8}
, ["GARLIC_MASHED_POTATOES"          ] = { name="картофельное пюре с чесноком"          , food_item_id=028346, recipe_list_index=  3, recipe_index= 19}
, ["GARLIC_PUMPKIN_SEEDS"            ] = { name="тыквенные семена с чесноком"           , food_item_id=033490, recipe_list_index=  2, recipe_index= 14}
, ["GINGER_WHEAT_BEER"               ] = { name="пшенично-имбирное пиво"                , food_item_id=033963, recipe_list_index=  8, recipe_index= 18}
, ["GODS_BLIND_ME"                   ] = { name="«Боги, ослепите меня»"                 , food_item_id=028433, recipe_list_index=  8, recipe_index= 25, name_2="«Боги, ослепите меня»"}
, ["GOLDEN_LAGER"                    ] = { name="золотой лагер"                         , food_item_id=033933, recipe_list_index=  8, recipe_index=  3}
, ["GOSSAMER_MAZTE"                  ] = { name="мацт «Паутинка»"                       , food_item_id=033957, recipe_list_index=  8, recipe_index= 15}
, ["GRANDPAS_BEDTIME_TONIC"          ] = { name="тоник «Дедушкин сонный час»"           , food_item_id=028444, recipe_list_index= 10, recipe_index= 31}
, ["GRAPE_PRESERVES"                 ] = { name="виноградное варенье"                   , food_item_id=033825, recipe_list_index=  2, recipe_index=  3}
, ["HAGRAVENS_TONIC"                 ] = { name="тоник ворожеи"                         , food_item_id=068263, recipe_list_index= 10, recipe_index= 42}
, ["HARE_IN_GARLIC_SAUCE"            ] = { name="заяц в чесночном соусе"                , food_item_id=033581, recipe_list_index=  1, recipe_index= 21, name_2="заяц в чесночном соусе"}
, ["HEARTY_GARLIC_CORN_CHOWDER"      ] = { name="наваристый зерновой чаудер с чесноком" , food_item_id=068239, recipe_list_index=  3, recipe_index= 40}
, ["HONEY_RYE"                       ] = { name="медово-ржаной виски"                   , food_item_id=028421, recipe_list_index=  8, recipe_index= 16}
, ["JERALL_VIEW_INN_CARROT_CAKE"     ] = { name="морковный торт таверны «Радушие Джерола»", food_item_id=033575, recipe_list_index=  3, recipe_index= 21}
, ["LEMON_FLOWER_MAZTE"              ] = { name="лимонный мацт"                         , food_item_id=033945, recipe_list_index=  8, recipe_index=  9}
, ["LILMOTH_GARLIC_HAGFISH"          ] = { name="пиявкорот с чесноком по-лилмотски"     , food_item_id=068235, recipe_list_index=  1, recipe_index= 42}
, ["MAMMOTH_SNOUT_PIE"               ] = { name="пирог с хоботом мамонта"               , food_item_id=033903, recipe_list_index=  1, recipe_index= 25}
, ["MAORMER_TEA"                     ] = { name="маормерский чай"                       , food_item_id=028465, recipe_list_index=  9, recipe_index= 19}
, ["MARKARTH_MEAD"                   ] = { name="маркартский мед"                       , food_item_id=068257, recipe_list_index=  8, recipe_index= 42}
, ["MAZTE"                           ] = { name="мацт"                                  , food_item_id=033606, recipe_list_index=  8, recipe_index=  5}
, ["MERMAID_WHISKEY"                 ] = { name="виски «Русалка»"                       , food_item_id=033630, recipe_list_index=  8, recipe_index= 17}
, ["MILLET_STUFFED_PORK_LOIN"        ] = { name="свиная вырезка с начинкой из пшена"    , food_item_id=043088, recipe_list_index=  1, recipe_index= 31}
, ["MULLED_WINE"                     ] = { name="пряное вино"                           , food_item_id=033969, recipe_list_index=  8, recipe_index= 21}
, ["MUTHSERAS_REMORSE"               ] = { name="«Раскаяние мутсэры»"                   , food_item_id=068260, recipe_list_index=  9, recipe_index= 42}
, ["NEREID_WINE"                     ] = { name="вино нереиды"                          , food_item_id=033975, recipe_list_index=  8, recipe_index= 24}
, ["NIBENESE_GARLIC_CARROTS"         ] = { name="нибенейская морковь с чесноком"        , food_item_id=033478, recipe_list_index=  3, recipe_index= 14}
, ["NUT_BROWN_ALE"                   ] = { name="темный ореховый эль"                   , food_item_id=028401, recipe_list_index=  8, recipe_index=  1}
, ["ORCREST_GARLIC_APPLE_JELLY"      ] = { name="чесночно-яблочное желе из Оркреста"    , food_item_id=043094, recipe_list_index=  2, recipe_index= 31}
, ["PELLITINE_TOMATO_RICE"           ] = { name="пеллитинский рис с томатом"            , food_item_id=042814, recipe_list_index=  2, recipe_index= 13}
, ["RED_RYE_BEER"                    ] = { name="красное ржаное пиво"                   , food_item_id=033600, recipe_list_index=  8, recipe_index=  2}
, ["REDORAN_PEPPERED_MELON"          ] = { name="редоранская перченая дыня"             , food_item_id=033552, recipe_list_index=  2, recipe_index= 15}
, ["ROAST_CORN"                      ] = { name="жареная кукуруза"                      , food_item_id=033813, recipe_list_index=  3, recipe_index=  3}
, ["RYE_IN_YOUR_EYE"                 ] = { name="«Рожь-в-глазах»"                       , food_item_id=028429, recipe_list_index=  8, recipe_index= 22}
, ["SEAFLOWER_TEA"                   ] = { name="чай «Морской цветок»"                  , food_item_id=034005, recipe_list_index=  9, recipe_index= 15}
, ["SENCHAL_CURRY_FISH_AND_RICE"     ] = { name="сенчальское рыбное карри с рисом"      , food_item_id=028350, recipe_list_index=  1, recipe_index= 19}
, ["SORRY_HONEY_LAGER"               ] = { name="лагер «Извини, дорогая»"               , food_item_id=033642, recipe_list_index=  8, recipe_index= 23}
, ["SOUR_MASH"                       ] = { name="кислый затор"                          , food_item_id=028425, recipe_list_index=  8, recipe_index= 19}
, ["SPICEBERRY_CHAI"                 ] = { name="пряный ягодный чай"                    , food_item_id=033684, recipe_list_index=  9, recipe_index= 20}
, ["SPICED_MAZTE"                    ] = { name="пряный мацт"                           , food_item_id=033636, recipe_list_index=  8, recipe_index= 20}
, ["STORMHOLD_BAKED_BANANAS"         ] = { name="печеные бананы по-стормхолдски"        , food_item_id=033587, recipe_list_index=  2, recipe_index= 21}
, ["SURILIE_SYRAH_WINE"              ] = { name="вино Сурили сорта шираз"               , food_item_id=033939, recipe_list_index=  8, recipe_index=  6}
, ["TORVAL_MINT_TEA"                 ] = { name="торвальский мятный чай"                , food_item_id=034017, recipe_list_index=  9, recipe_index= 21}
, ["TREACLEBERRY_TEA"                ] = { name="ягодный чай с патокой"                 , food_item_id=033672, recipe_list_index=  9, recipe_index= 14}
, ["TWO_ZEPHYR_TEA"                  ] = { name="чай «Два зефира»"                      , food_item_id=028473, recipe_list_index=  9, recipe_index= 25}
, ["VENISON_PASTY"                   ] = { name="корзиночка с олениной"                 , food_item_id=028398, recipe_list_index=  1, recipe_index= 15}
, ["WEST_WEALD_CORN_CHOWDER"         ] = { name="зерновой чаудер Западного Вельда"      , food_item_id=032160, recipe_list_index=  3, recipe_index= 31}
, ["WHITERUN_CHEESE_BAKED_TROUT"     ] = { name="запеченная с сыром вайтранская форель" , food_item_id=033484, recipe_list_index=  1, recipe_index= 14}
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
, ["EBONY"         ] = { name="ebon"              , level_index= 5, material_index=23, master_writ2=164, crafting_type=bs, mat_set_id=mat_hvy  , name_2="ebon"           }
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
  ["BLESSED_THISTLE"         ] = { name="благословенный чертополох"      , crafting_type=al, item_id= 30157 }
, ["BLUE_ENTOLOMA"           ] = { name="голубая энтолома"               , crafting_type=al, item_id= 30148 }
, ["BUGLOSS"                 ] = { name="воловик"                        , crafting_type=al, item_id= 30160 }
, ["COLUMBINE"               ] = { name="водосбор"                       , crafting_type=al, item_id= 30164 }
, ["CORN_FLOWER"             ] = { name="василек"                        , crafting_type=al, item_id= 30161 }
, ["DRAGONTHORN"             ] = { name="драконий шип"                   , crafting_type=al, item_id= 30162 }
, ["EMETIC_RUSSULA"          ] = { name="жгучеедкая сыроежка"            , crafting_type=al, item_id= 30151 }
, ["IMP_STOOL"               ] = { name="бесовский гриб"                 , crafting_type=al, item_id= 30156 }
, ["LADYS_SMOCK"             ] = { name="луговой сердечник"              , crafting_type=al, item_id= 30158 }
, ["LUMINOUS_RUSSULA"        ] = { name="светящаяся сыроежка"            , crafting_type=al, item_id= 30155 }
, ["MOUNTAIN_FLOWER"         ] = { name="горноцвет"                      , crafting_type=al, item_id= 30163 }
, ["NAMIRAS_ROT"             ] = { name="гниль Намиры"                   , crafting_type=al, item_id= 30153 }
, ["NIRNROOT"                ] = { name="корень Нирна"                   , crafting_type=al, item_id= 30165 }
, ["STINKHORN"               ] = { name="цветохвостник веретеновидный"   , crafting_type=al, item_id= 30149 }
, ["VIOLET_COPRINUS"         ] = { name="лиловый копринус"               , crafting_type=al, item_id= 30152 , name_2="лиловый копринус"   }
, ["WATER_HYACINTH"          ] = { name="водный гиацинт"                 , crafting_type=al, item_id= 30166 }
, ["WHITE_CAP"               ] = { name="белянка"                        , crafting_type=al, item_id= 30154 }
, ["WORMWOOD"                ] = { name="полынь"                         , crafting_type=al, item_id= 30159 }
, ["BEETLE_SCUTTLE"          ] = { name="Жучиный скатл"                  , crafting_type=al, item_id= 77583 }
, ["BUTTERFLY_WING"          ] = { name="Крыло бабочки"                  , crafting_type=al, item_id= 77585 }
, ["FLESHFLY_LARVA"          ] = { name="Личинка мясной мухи"            , crafting_type=al, item_id= 77587 }
, ["MUDCRAB_CHITIN"          ] = { name="Хитин грязевого краба"          , crafting_type=al, item_id= 77591 }
, ["NIGHTSHADE"              ] = { name="Паслен"                         , crafting_type=al, item_id= 77590 }
, ["SCRIB_JELLY"             ] = { name="Скрибовое желе"                 , crafting_type=al, item_id= 77589 }
, ["SPIDER_EGG"              ] = { name="Паучье яйцо"                    , crafting_type=al, item_id= 77584 }
, ["TORCHBUG_THORAX"         ] = { name="Торакс светлячка"               , crafting_type=al, item_id= 77581 }
, ["CLAM_GALL"               ] = { name="желчь моллюска"                 , crafting_type=al, item_id=139020 }
, ["POWDERED_MOTHER_OF_PEARL"] = { name="измельченный перламутр"         , crafting_type=al, item_id=139019 }

, ["NATURAL_WATER"           ] = { name="природная вода"                 , crafting_type=al, item_id=   883 , name_2="природную воду"     }
, ["CLEAR_WATER"             ] = { name="чистая вода"                    , crafting_type=al, item_id=  1187 }
, ["PRISTINE_WATER"          ] = { name="нетронутая вода"                , crafting_type=al, item_id=  4570 , name_2="нетронутую воду"    }
, ["CLEANSED_WATER"          ] = { name="очищенная вода"                 , crafting_type=al, item_id= 23265 , name_2="очищенную воду"     }
, ["FILTERED_WATER"          ] = { name="фильтрованная вода"             , crafting_type=al, item_id= 23266 , name_2="фильтрованную воду" }
, ["PURIFIED_WATER"          ] = { name="дистиллированная вода"          , crafting_type=al, item_id= 23267 , name_2="дистиллированную воду"}
, ["CLOUD_MIST"              ] = { name="облачный пар"                   , crafting_type=al, item_id= 23268 }
, ["STAR_DEW"                ] = { name="звездная роса"                  , crafting_type=al, item_id= 64500 }
, ["LORKHANS_TEARS"          ] = { name="Слезы Лорхана"                  , crafting_type=al, item_id= 64501 }

, ["GREASE"                  ] = { name="Топленое сало"                  , crafting_type=al, item_id= 75357 }
, ["ICHOR"                   ] = { name="Сукровица"                      , crafting_type=al, item_id= 75358 }
, ["SLIME"                   ] = { name="Слизь"                          , crafting_type=al, item_id= 75359 }
, ["GALL"                    ] = { name="Желчь"                          , crafting_type=al, item_id= 75360 }
, ["TEREBINTHINE"            ] = { name="Терпентинное масло"             , crafting_type=al, item_id= 75361 }
, ["PITCH_BILE"              ] = { name="Смоляная желчь"                 , crafting_type=al, item_id= 75362 }
, ["TARBLACK"                ] = { name="Дегтярное масло"                , crafting_type=al, item_id= 75363 }
, ["NIGHT_OIL"               ] = { name="Ночное масло"                   , crafting_type=al, item_id= 75364 }
, ["ALKAHEST"                ] = { name="Алкагест"                       , crafting_type=al, item_id= 75365 }

, ["JORA"                    ] = { name="Джора"                          , crafting_type=en, item_id= 45855 , name_2="trifling"      }
, ["PORADE"                  ] = { name="Пораде"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Джера"                          , crafting_type=en, item_id= 45857 , name_2="petty"         }
, ["JEJORA"                  ] = { name="Джеджора"                       , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Одра"                           , crafting_type=en, item_id= 45807 , name_2="minor"         }
, ["POJORA"                  ] = { name="Поджора"                        , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Эдора"                          , crafting_type=en, item_id= 45809 , name_2="moderate"      }
, ["JAERA"                   ] = { name="Джейра"                         , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Пора"                           , crafting_type=en, item_id= 45811 , name_2="strong"        }
, ["DENARA"                  ] = { name="Денара"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Рера"                           , crafting_type=en, item_id= 45813 , name_2="greater"       }
, ["DERADO"                  ] = { name="Дерадо"                         , crafting_type=en, item_id= 45814 , name_2="grand"        , name_3="grand"          }
, ["REKURA"                  ] = { name="Рекура"                         , crafting_type=en, item_id= 45815 , name_2="splendid"      }
, ["KURA"                    ] = { name="Кура"                           , crafting_type=en, item_id= 45816 , name_2="monumental"    }
, ["REJERA"                  ] = { name="Реджера"                        , crafting_type=en, item_id= 64509 , name_2="superb"        }
, ["REPORA"                  ] = { name="Репора"                         , crafting_type=en, item_id= 68341 }

, ["JODE"                    ] = { name="Джоде"                          , crafting_type=en, item_id= 45817 }
, ["NOTADE"                  ] = { name="Нотаде"                         , crafting_type=en, item_id= 45818 }
, ["ODE"                     ] = { name="Оде"                            , crafting_type=en, item_id= 45819 }
, ["TADE"                    ] = { name="Таде"                           , crafting_type=en, item_id= 45820 }
, ["JAYDE"                   ] = { name="Джайде"                         , crafting_type=en, item_id= 45821 }
, ["EDODE"                   ] = { name="Эдоде"                          , crafting_type=en, item_id= 45822 }
, ["POJODE"                  ] = { name="Поджоде"                        , crafting_type=en, item_id= 45823 }
, ["REKUDE"                  ] = { name="Рекуде"                         , crafting_type=en, item_id= 45824 }
, ["HADE"                    ] = { name="Хаде"                           , crafting_type=en, item_id= 45825 }
, ["IDODE"                   ] = { name="Идоде"                          , crafting_type=en, item_id= 45826 }
, ["PODE"                    ] = { name="Поде"                           , crafting_type=en, item_id= 45827 }
, ["KEDEKO"                  ] = { name="Кедеко"                         , crafting_type=en, item_id= 45828 }
, ["REDE"                    ] = { name="Реде"                           , crafting_type=en, item_id= 45829 }
, ["KUDE"                    ] = { name="Куде"                           , crafting_type=en, item_id= 45830 }
, ["JEHADE"                  ] = { name="Джехаде"                        , crafting_type=en, item_id= 64508 }
, ["ITADE"                   ] = { name="Итаде"                          , crafting_type=en, item_id= 68340 }

, ["DEKEIPA"                 ] = { name="Декейпа"                        , crafting_type=en, item_id= 45839 , name_2="frost"         }
, ["DENI"                    ] = { name="Дени"                           , crafting_type=en, item_id= 45833 , name_2="stamina"      , name_3="stamina"        }
, ["DENIMA"                  ] = { name="Денима"                         , crafting_type=en, item_id= 45836 , name_2="stamina recovery"}
, ["DETERI"                  ] = { name="Детери"                         , crafting_type=en, item_id= 45842 , name_2="hardening"     }
, ["HAOKO"                   ] = { name="Хаоко"                          , crafting_type=en, item_id= 45841 , name_2="foulness"      }
, ["HAKEIJO"                 ] = { name="Хакейджо"                       , crafting_type=en, item_id= 68342 , name_2="prismatic defense"}
, ["KADERI"                  ] = { name="Кадери"                         , crafting_type=en, item_id= 45849 , name_2="bashing"       }
, ["KUOKO"                   ] = { name="Куоко"                          , crafting_type=en, item_id= 45837 , name_2="poison"        }
, ["MAKDERI"                 ] = { name="Макдери"                        , crafting_type=en, item_id= 45848 , name_2="increase magical harm"}
, ["MAKKO"                   ] = { name="Макко"                          , crafting_type=en, item_id= 45832 , name_2="magicka"      , name_3="magicka"        }
, ["MAKKOMA"                 ] = { name="Маккома"                        , crafting_type=en, item_id= 45835 , name_2="magicka recovery"}
, ["MEIP"                    ] = { name="Мейп"                           , crafting_type=en, item_id= 45840 , name_2="shock"         }
, ["OKO"                     ] = { name="Око"                            , crafting_type=en, item_id= 45831 , name_2="health"       , name_3="health"         }
, ["OKOMA"                   ] = { name="Окома"                          , crafting_type=en, item_id= 45834 , name_2="health recovery"}
, ["OKORI"                   ] = { name="Окори"                          , crafting_type=en, item_id= 45843 , name_2="weapon damage" }
, ["ORU"                     ] = { name="Ору"                            , crafting_type=en, item_id= 45846 , name_2="potion boost"  }
, ["RAKEIPA"                 ] = { name="Ракейпа"                        , crafting_type=en, item_id= 45838 , name_2="flame"         }
, ["TADERI"                  ] = { name="Тадери"                         , crafting_type=en, item_id= 45847 , name_2="increase physical harm"}

, ["TA"                      ] = { name="Та"                             , crafting_type=en, item_id= 45850 , name_2="Обычное"  }
, ["JEJOTA"                  ] = { name="Джеджота"                       , crafting_type=en, item_id= 45851 , name_2="Хорошее"  }
, ["DENATA"                  ] = { name="Дената"                         , crafting_type=en, item_id= 45852 , name_2="Превосходное"}
, ["REKUTA"                  ] = { name="Рекута"                         , crafting_type=en, item_id= 45853 , name_2="Эпическое"}
, ["KUTA"                    ] = { name="Кута"                           , crafting_type=en, item_id= 45854 , name_2="Легендарное"}
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
LibCraftText.ALCHEMY_TRAITS = {
    ["RESTORE_HEALTH"         ] = { trait_index=01, name="Восстановление здоровья", master_potion="Essence of health"                 , master_poison="Drain Health Poison IX"            }
,   ["RAVAGE_HEALTH"          ] = { trait_index=02, name="Опустошение здоровья" , master_potion="Essence of Ravage Health"          , master_poison="Damage Health Poison IX"           }
,   ["RESTORE_MAGICKA"        ] = { trait_index=03, name="Восстановление магии" , master_potion="Essence of Magicka"                , master_poison="Drain Magicka Poison IX"           }
,   ["RAVAGE_MAGICKA"         ] = { trait_index=04, name="Опустошение магии"    , master_potion="Essence of Ravage Magicka"         , master_poison="Damage Magicka Poison IX"          }
,   ["RESTORE_STAMINA"        ] = { trait_index=05, name="Восстановление запаса сил", master_potion="Essence of stamina"                , master_poison="Drain Stamina Poison IX"           }
,   ["RAVAGE_STAMINA"         ] = { trait_index=06, name="Опустошение запаса сил", master_potion="Essence of Ravage Stamina"         , master_poison="Damage Stamina Poison IX"          }
,   ["SPELL_RESISTANCE"       ] = { trait_index=07, name="Увеличение защиты от магии", master_potion="Essence of Spell Protection"       , master_poison="Яд ослабления защиты IX"           }
,   ["BREACH"                 ] = { trait_index=08, name="Разрыв"               , master_potion="Essence of Ravage Spell Protection", master_poison="Breaching Poison IX"               }
,   ["INCREASE_ARMOR"         ] = { trait_index=09, name="Увеличение брони"     , master_potion="Essence of Armor"                  , master_poison="Resolve-Draining Poison IX"        }
,   ["FRACTURE"               ] = { trait_index=10, name="Перелом"              , master_potion="Essence of Ravage Armor"           , master_poison="Fracturing Poison IX"              }
,   ["INCREASE_SPELL_POWER"   ] = { trait_index=11, name="Увеличение силы заклинаний", master_potion="Essence of Spell Power"            , master_poison="Sorcery-Draining Poison IX"        }
,   ["COWARDICE"              ] = { trait_index=12, name="Трусость"             , master_potion="Essence of Cowardice"              , master_poison="Cowardice Poison IX"               }
,   ["INCREASE_WEAPON_POWER"  ] = { trait_index=13, name="Увеличение силы оружия", master_potion="Essence of Weapon Power"           , master_poison="Brutality-Draining Poison IX"      }
,   ["MAIM"                   ] = { trait_index=14, name="Травма"               , master_potion="Essence of Maim"                   , master_poison="Maiming Poison IX"                 }
,   ["SPELL_CRITICAL"         ] = { trait_index=15, name="Критический урон заклинаниями", master_potion="Essence of Spell Critical"         , master_poison="Prophecy-Draining Poison IX"       }
,   ["UNCERTAINTY"            ] = { trait_index=16, name="Неуверенность"        , master_potion="Essence of Uncertainty"            , master_poison="Uncertainty Poison IX"             }
,   ["WEAPON_CRITICAL"        ] = { trait_index=17, name="Критический урон оружием", master_potion="Essence of Weapon Crit"            , master_poison="Savagery-Draining Poison IX"       }
,   ["ENERVATION"             ] = { trait_index=18, name="Слабость"             , master_potion="Essence of Enervation"             , master_poison="Enervating Poison IX"              }
,   ["UNSTOPPABLE"            ] = { trait_index=19, name="Неудержимость"        , master_potion="Essence of Immovability"           , master_poison="Escapist's Poison IX"              }
,   ["ENTRAPMENT"             ] = { trait_index=20, name="Защемление"           , master_potion="Essence of Entrapment"             , master_poison="Entrapping Poison IX"              }
,   ["DETECTION"              ] = { trait_index=21, name="Обнаружение"          , master_potion="Essence of Detection"              , master_poison="Stealth-Draining Poison IX"        }
,   ["INVISIBLE"              ] = { trait_index=22, name="Невидимость"          , master_potion="Essence of Invisibility"           , master_poison="Conspicuous Poison IX"             }
,   ["SPEED"                  ] = { trait_index=23, name="Скорость"             , master_potion="Essence of Speed"                  , master_poison="Speed-Draining Poison IX"          }
,   ["HINDRANCE"              ] = { trait_index=24, name="Помеха"               , master_potion="Essence of Hindering"              , master_poison="Hindering Poison IX"               }
,   ["PROTECTION"             ] = { trait_index=25, name="Защита"               , master_potion="Essence of Protection"             , master_poison="Protection-Reversing Poison IX"    }
,   ["VULNERABILITY"          ] = { trait_index=26, name="Уязвимость"           , master_potion="Essence of Vulnerability"          , master_poison="Vulnerability Poison IX"           }
,   ["LINGERING_HEALTH"       ] = { trait_index=27, name="Длительное исцеление" , master_potion="Essence of Lingering Health"       , master_poison="Gradual Health Drain Poison IX"    }
,   ["GRADUAL_RAVAGE_HEALTH"  ] = { trait_index=28, name="Постепенное опустош. здоровья", master_potion="Essence of Creeping Ravage Health" , master_poison="Gradual Ravage Health Poison IX"   }
,   ["VITALITY"               ] = { trait_index=29, name="Живучесть"            , master_potion="Essence of Vitality"               , master_poison="Vitality-Draining Poison IX"       }
,   ["DEFILE"                 ] = { trait_index=30, name="Осквернение"          , master_potion="Essence of Defile"                 , master_poison="Defiling Poison IX"                }
}

-- The 6 possible potions and poisons that a daily crafting writ can request.
--
-- trait        reference into ALCHEMY_TRAITS so you know which potion/poison to make
-- potion_name  Appears in potion name such a "Elixir of Health"
-- poison name  Appears in poison name such as "Drain Health Poison III"
--
local at = LibCraftText.ALCHEMY_TRAITS -- for less typing
LibCraftText.ALCHEMY_ITEMS = {
  ["HEALTH"           ] = { trait=at.RESTORE_HEALTH , potion_name="health"                       , poison_name="drain health"                 }
, ["MAGICKA"          ] = { trait=at.RESTORE_MAGICKA, potion_name="magicka"                      , poison_name="drain magicka"                }
, ["STAMINA"          ] = { trait=at.RESTORE_STAMINA, potion_name="stamina"                      , poison_name="drain stamina"                }
, ["RAVAGE_HEALTH"    ] = { trait=at.RAVAGE_HEALTH  , potion_name="ravage health"                , poison_name="damage health"                }
, ["RAVAGE_MAGICKA"   ] = { trait=at.RAVAGE_MAGICKA , potion_name="ravage magicka"               , poison_name="damage magicka"               }
, ["RAVAGE_STAMINA"   ] = { trait=at.RAVAGE_STAMINA , potion_name="ravage stamina"               , poison_name="damage stamina"               }
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
LibCraftText.ALCHEMY_SOLVENTS = {
  { rank=1, potion_name="sip"                    , poison_name="i"                      , potion_mat=cm.NATURAL_WATER  , poison_mat=cm.GREASE       }
, { rank=2, potion_name="tincture"               , poison_name="ii"                     , potion_mat=cm.CLEAR_WATER    , poison_mat=cm.ICHOR        }
, { rank=3, potion_name="dram"                   , poison_name="iii"                    , potion_mat=cm.PRISTINE_WATER , poison_mat=cm.SLIME        }
, { rank=4, potion_name="potion"                 , poison_name="iv"                     , potion_mat=cm.CLEANSED_WATER , poison_mat=cm.GALL         }
, { rank=5, potion_name="solution"               , poison_name="v"                      , potion_mat=cm.FILTERED_WATER , poison_mat=cm.TEREBINTHINE }
, { rank=6, potion_name="elixir"                 , poison_name="vi"                     , potion_mat=cm.PURIFIED_WATER , poison_mat=cm.PITCH_BILE   }
, { rank=7, potion_name="panacea"                , poison_name="vii"                    , potion_mat=cm.CLOUD_MIST     , poison_mat=cm.TARBLACK     }
, { rank=8, potion_name="distillate"             , poison_name="viii"                   , potion_mat=cm.STAR_DEW       , poison_mat=cm.NIGHT_OIL    }
, { rank=9, potion_name="essence"                , poison_name="ix"                     , potion_mat=cm.LORKHANS_TEARS , poison_mat=cm.ALKAHEST     }
}
cm = nil

-- Quest Titles --------------------------------------------------------------

LibCraftText.DAILY_QUEST_TITLES = {
    [bs] = "Заказ кузнецу"                  -- "Blacksmith Writ"
,   [cl] = "Заказ портному"                 -- "Clothier Writ"
,   [en] = "Заказ зачарователю"             -- "Enchanter Writ"
,   [al] = "Заказ алхимику"                 -- "Alchemist Writ"
,   [pr] = "Заказ снабженцу"                -- "Provisioner Writ"
,   [ww] = "Заказ столяру"                  -- "Woodworker Writ"
,   [jw] = "Заказ ювелиру"                  -- "Jewelry Crafting Writ"
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
    [bs] = { "Искусные латы"                      -- "A Masterful Plate"
           , "Искусное оружие"                  } -- "A Masterful Weapon"
,   [cl] = { "Искусные тканевые доспехи"          -- "Masterful Tailoring"
           , "Искусные кожаные доспехи"         } -- "Masterful Leatherwear"
,   [en] = { "Искусный глиф"                    } -- "A Masterful Glyph"
,   [al] = { "Искусное варево"                  } -- "A Masterful Concoction"
,   [pr] = { "Искусный пир"                     } -- "A Masterful Feast"
,   [ww] = { "Искусный щит"                       -- "A Masterful Shield"
           , "Искусное оружие"                  } -- "A Masterful Weapon"
,   [jw] = { "Искусные ювелирные изделия"       } -- "Masterful Jewelry"
}


-- Random Unsorted Stuff -----------------------------------------------------

LibCraftText.MASTER_LABELS = {
    ["quality"] =  "Качество"                        -- "Quality"
,   ["set"    ] =  "Комплект"                        -- "Set"
,   ["style"  ] =  "Стиль"                           -- "Style"
,   ["trait"  ] =  "Особенность"                     -- "Trait"
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
    [1] = "Обычное"                  -- "Normal"
,   [2] = "Хорошее"                  -- "Fine"
,   [3] = "Превосходное"             -- "Superior"
,   [4] = "Эпическое"                -- "Epic"
,   [5] = "Легендарное"              -- "Legendary"
}

