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

, ["NATURAL_WATER"           ] = { name="natürliches Wasser"             , crafting_type=al, item_id=   883 }
, ["CLEAR_WATER"             ] = { name="klares Wasser"                  , crafting_type=al, item_id=  1187 }
, ["PRISTINE_WATER"          ] = { name="unberührtes Wasser"             , crafting_type=al, item_id=  4570 , name_2="unberührtes Wasser" }
, ["CLEANSED_WATER"          ] = { name="gesäubertes Wasser"             , crafting_type=al, item_id= 23265 }
, ["FILTERED_WATER"          ] = { name="gefiltertes Wasser"             , crafting_type=al, item_id= 23266 }
, ["PURIFIED_WATER"          ] = { name="gereinigtes Wasser"             , crafting_type=al, item_id= 23267 , name_2="gereinigtes Wasser" }
, ["CLOUD_MIST"              ] = { name="Wolkennebel"                    , crafting_type=al, item_id= 23268 }
, ["STAR_DEW"                ] = { name="Sternentau"                     , crafting_type=al, item_id= 64500 }
, ["LORKHANS_TEARS"          ] = { name="Lorkhans Tränen"                , crafting_type=al, item_id= 64501 }

, ["GREASE"                  ] = { name="Fett"                           , crafting_type=al, item_id= 75357 }
, ["ICHOR"                   ] = { name="Eiter"                          , crafting_type=al, item_id= 75358 }
, ["SLIME"                   ] = { name="Schleim"                        , crafting_type=al, item_id= 75359 }
, ["GALL"                    ] = { name="Galle"                          , crafting_type=al, item_id= 75360 }
, ["TEREBINTHINE"            ] = { name="Terebinthe"                     , crafting_type=al, item_id= 75361 }
, ["PITCH_BILE"              ] = { name="Schwarzgalle"                   , crafting_type=al, item_id= 75362 }
, ["TARBLACK"                ] = { name="Teerschwarz"                    , crafting_type=al, item_id= 75363 }
, ["NIGHT_OIL"               ] = { name="Nachtöl"                        , crafting_type=al, item_id= 75364 }
, ["ALKAHEST"                ] = { name="Alkahest"                       , crafting_type=al, item_id= 75365 }

, ["JORA"                    ] = { name="Jora"                           , crafting_type=en, item_id= 45855 }
, ["PORADE"                  ] = { name="Porade"                         , crafting_type=en, item_id= 45856 }
, ["JERA"                    ] = { name="Jera"                           , crafting_type=en, item_id= 45857 }
, ["JEJORA"                  ] = { name="Jejora"                         , crafting_type=en, item_id= 45806 }
, ["ODRA"                    ] = { name="Odra"                           , crafting_type=en, item_id= 45807 }
, ["POJORA"                  ] = { name="Pojora"                         , crafting_type=en, item_id= 45808 }
, ["EDORA"                   ] = { name="Edora"                          , crafting_type=en, item_id= 45809 }
, ["JAERA"                   ] = { name="Jaera"                          , crafting_type=en, item_id= 45810 }
, ["PORA"                    ] = { name="Pora"                           , crafting_type=en, item_id= 45811 }
, ["DENARA"                  ] = { name="Denara"                         , crafting_type=en, item_id= 45812 }
, ["RERA"                    ] = { name="Rera"                           , crafting_type=en, item_id= 45813 }
, ["DERADO"                  ] = { name="Derado"                         , crafting_type=en, item_id= 45814 }
, ["REKURA"                  ] = { name="Rekura"                         , crafting_type=en, item_id= 45815 }
, ["KURA"                    ] = { name="Kura"                           , crafting_type=en, item_id= 45816 }
, ["REJERA"                  ] = { name="Rejera"                         , crafting_type=en, item_id= 64509 }
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

, ["DEKEIPA"                 ] = { name="Dakeipa"                        , crafting_type=en, item_id= 45839 }
, ["DENI"                    ] = { name="Deni"                           , crafting_type=en, item_id= 45833 }
, ["DENIMA"                  ] = { name="Denima"                         , crafting_type=en, item_id= 45836 }
, ["DETERI"                  ] = { name="Deteri"                         , crafting_type=en, item_id= 45842 }
, ["HAOKO"                   ] = { name="Haoko"                          , crafting_type=en, item_id= 45841 }
, ["HAKEIJO"                 ] = { name="Hakeijo"                        , crafting_type=en, item_id= 68342 }
, ["KADERI"                  ] = { name="Kaderi"                         , crafting_type=en, item_id= 45849 }
, ["KUOKO"                   ] = { name="Kuoko"                          , crafting_type=en, item_id= 45837 }
, ["MAKDERI"                 ] = { name="Makderi"                        , crafting_type=en, item_id= 45848 }
, ["MAKKO"                   ] = { name="Makko"                          , crafting_type=en, item_id= 45832 }
, ["MAKKOMA"                 ] = { name="Makkoma"                        , crafting_type=en, item_id= 45835 }
, ["MEIP"                    ] = { name="Meip"                           , crafting_type=en, item_id= 45840 }
, ["OKO"                     ] = { name="Oko"                            , crafting_type=en, item_id= 45831 }
, ["OKOMA"                   ] = { name="Okoma"                          , crafting_type=en, item_id= 45834 }
, ["OKORI"                   ] = { name="Okori"                          , crafting_type=en, item_id= 45843 }
, ["ORU"                     ] = { name="Oru"                            , crafting_type=en, item_id= 45846 }
, ["RAKEIPA"                 ] = { name="Rakeipa"                        , crafting_type=en, item_id= 45838 }
, ["TADERI"                  ] = { name="Taderi"                         , crafting_type=en, item_id= 45847 }

, ["TA"                      ] = { name="Ta"                             , crafting_type=en, item_id= 45850 }
, ["JEJOTA"                  ] = { name="Jejota"                         , crafting_type=en, item_id= 45851 }
, ["DENATA"                  ] = { name="Denata"                         , crafting_type=en, item_id= 45852 }
, ["REKUTA"                  ] = { name="Rekuta"                         , crafting_type=en, item_id= 45853 }
, ["KUTA"                    ] = { name="Kuta"                           , crafting_type=en, item_id= 45854 }
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

