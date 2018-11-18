local LCT = LCT or LibCraftText

MASTER_FODDER = {

-- Alchemy -------------------------------------------------------------------
  { input  = "Craft an Essence of Ravage Health with the following Traits:"
             .."\n• Breach\n• Increase Spell Power\n• Ravage Health\n• Progress: 0 / 20"
  , expect = { solvent     =   LCT.MATERIAL.LORKHANS_TEARS
             , name_trait  =   LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
             , trait_list  = { LCT.ALCHEMY_TRAIT.BREACH
                             , LCT.ALCHEMY_TRAIT.INCREASE_SPELL_POWER
                             , LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
                             }
             }
  }
, { input = "Craft a Damage Health Poison IX with the following Traits:"
               .."\n• Enervation\n• Fracture\n• Ravage Health\n• Progress: 0 / 20"
  , expect = { solvent     =   LCT.MATERIAL.ALKAHEST
             , name_trait  =   LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
             , trait_list  = { LCT.ALCHEMY_TRAIT.ENERVATION
                             , LCT.ALCHEMY_TRAIT.FRACTURE
                             , LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
                             }
             }
  }

-- Enchanting ----------------------------------------------------------------
, { input = "Craft a Superb Glyph of Reduce Spell Cost"
            .."\n• Quality: Epic\n• Progress: 0 / 1"
  , expect = { potency = LCT.MATERIAL.JEHADE
             , essence = LCT.MATERIAL.MAKKOMA
             , aspect  = LCT.MATERIAL.REKUTA
             }
  }
, { input = "Craft a Superb Glyph of Stamina Recovery"
            .."\n• Quality: Epic\n• Progress: 0 / 1"
  , expect = { potency = LCT.MATERIAL.REJERA
             , essence = LCT.MATERIAL.DENIMA
             , aspect  = LCT.MATERIAL.REKUTA
             }
  }
, { input = "Craft a Superb Glyph of Reduce Feat Cost"
            .."\n• Quality: Epic\n• Progress: 0 / 1"
  , expect = { potency = LCT.MATERIAL.JEHADE
             , essence = LCT.MATERIAL.DENIMA
             , aspect  = LCT.MATERIAL.REKUTA
             }
  }

-- Provisioning --------------------------------------------------------------
, { input = "Craft a Lusty Argonian Maid Mazte"
            .."\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.LUSTY_ARGONIAN_MAID_MAZTE }
  }
, { input = "Craft an Orcrest Agony Pale Ale"
            .."\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.ORCREST_AGONY_PALE_ALE }
  }
, { input = "Craft a Velothi View Vintage Malbec"
            .."\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.VELOTHI_VIEW_VINTAGE_MALBEC }
  }
, { input = "Craft a Longfin Pasty with Melon Sauce\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.LONGFIN_PASTY_WITH_MELON_SAUCE }
  }
, { input = "Craft a Senche-Tiger Single Malt\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.SENCHE_TIGER_SINGLE_MALT }
  }
, { input = "Craft an Orzorga's Blood Price Pie\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.ORZORGAS_BLOOD_PRICE_PIE }
  }
-- Waiting to capture a full lang_table for this quest condition
-- , { input = "Craft an Orzorga's Red Frothgar\n• Progress: 0 / 8"
--   , expect = { item=LCT.RECIPE.ORZORGAS_RED_FROTHGAR }
--   }
, { input = "Craft an Orzorga's Smoked Bear Haunch\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.ORZORGAS_SMOKED_BEAR_HAUNCH }
  }
, { input = "Craft an Orzorga's Tripe Trifle Pocket\n• Progress: 0 / 8"
  , expect = { item=LCT.RECIPE.ORZORGAS_TRIPE_TRIFLE_POCKET }
  }

-- Blacksmithing -------------------------------------------------------------
, { input = "Craft a Rubedite Cuirass with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Sturdy"
            .."\n• Set: Varen's Legacy"
            .."\n• Style: Wood Elf"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.CUIRASS
             , material = LCT.MATERIAL.RUBEDITE
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_STURDY
             , set      = LCT.SET.VARENS_LEGACY
             , motif    = LCT.MOTIF.WOOD_ELF
             }
  }
, { input = "Craft a Rubedite Helm with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Divines"
            .."\n• Set: Whitestrake's Retribution"
            .."\n• Style: Imperial"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.HELM
             , material = LCT.MATERIAL.RUBEDITE
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_DIVINES
             , set      = LCT.SET.WHITESTRAKES_RETRIBUTION
             , motif    = LCT.MOTIF.IMPERIAL
             }
  }

, { input = "Craft a Rubedite Maul with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Defending"
            .."\n• Set: Daedric Trickery"
            .."\n• Style: Argonian"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.H2_MAUL
             , material = LCT.MATERIAL.RUBEDITE
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.WEAPON_DEFENDING
             , set      = LCT.SET.DAEDRIC_TRICKERY
             , motif    = LCT.MOTIF.ARGONIAN
             , bug      = { "es" } -- "Maza" overloaded, used for both H1_MACE and H2_MAUL
             }
  }

, { input = "Craft a Rubedite Pauldron with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Nirnhoned"
            .."\n• Set: Eternal Hunt"
            .."\n• Style: Wood Elf"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.PAULDRON
             , material = LCT.MATERIAL.RUBEDITE
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_NIRNHONED
             , set      = LCT.SET.ETERNAL_HUNT
             , motif    = LCT.MOTIF.WOOD_ELF
             }
  }

, { input = "Craft an Ancestor Silk Sash with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Reinforced"
            .."\n• Set: Varen's Legacy"
            .."\n• Style: Worm Cult"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.SASH
             , material = LCT.MATERIAL.ANCESTOR_SILK
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_REINFORCED
             , set      = LCT.SET.VARENS_LEGACY
             , motif    = LCT.MOTIF.WORM_CULT
             }
  }

, { input = "Craft a Rubedo Leather Helmet with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Well-Fitted"
            .."\n• Set: Kagrenac's Hope"
            .."\n• Style: Abah's Watch"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.HELMET
             , material = LCT.MATERIAL.RUBEDO_LEATHER
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_WELL_FITTED
             , set      = LCT.SET.KAGRENACS_HOPE
             , motif    = LCT.MOTIF.ABAHS_WATCH
             }
  }

, { input = "Craft a Ruby Ash Shield with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Invigorating"
            .."\n• Set: Orgnum's Scales"
            .."\n• Style: Psijic Order"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.SHIELD
             , material = LCT.MATERIAL.RUBY_ASH
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_INVIGORATING
             , set      = LCT.SET.ORGNUMS_SCALES
             , motif    = LCT.MOTIF.PSIJIC_ORDER
             }
  }

, { input = "Craft a Ruby Ash Shield with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Nirnhoned"
            .."\n• Set: Noble's Conquest"
            .."\n• Style: Primal"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.SHIELD
             , material = LCT.MATERIAL.RUBY_ASH
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.ARMOR_NIRNHONED
             , set      = LCT.SET.NOBLES_CONQUEST
             , motif    = LCT.MOTIF.PRIMAL
             }
  }

, { input = "Craft a Ruby Ash Restoration Staff with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Nirnhoned"
            .."\n• Set: Oblivion's Foe"
            .."\n• Style: Bloodforge"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.RESTO_STAFF
             , material = LCT.MATERIAL.RUBY_ASH
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.WEAPON_NIRNHONED
             , set      = LCT.SET.OBLIVIONS_FOE
             , motif    = LCT.MOTIF.BLOODFORGE
             }
  }

, { input = "Craft a Platinum Ring with the following Properties:"
            .."\n• Quality: Legendary"
            .."\n• Trait: Protective"
            .."\n• Set: Armor Master"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.RING
             , material = LCT.MATERIAL.PLATINUM
             , quality  = LCT.QUALITY.LEGENDARY
             , trait    = LCT.TRAIT.JEWELRY_PROTECTIVE
             , set      = LCT.SET.ARMOR_MASTER
             }
  }

, { input = "Craft a Platinum Necklace with the following Properties:"
            .."\n• Quality: Epic"
            .."\n• Trait: Healthy"
            .."\n• Set: Assassin's Guile"
            .."\n• Progress: 0 / 1"
  , expect = { item     = LCT.ITEM.NECKLACE
             , material = LCT.MATERIAL.PLATINUM
             , quality  = LCT.QUALITY.EPIC
             , trait    = LCT.TRAIT.JEWELRY_HEALTHY
             , set      = LCT.SET.ASSASSINS_GUILE
             }
  }

, { input  = "Travel to Elden Root to Meet Your Contact"
  , expect = { misc=LibCraftText.MASTER_COND.TRAVEL_AD }
  }
, { input  = "Travel to Mournhold to Meet Your Contact"
  , expect = { misc=LibCraftText.MASTER_COND.TRAVEL_EP }
  }
, { input  = "Travel to Wayrest to Meet Your Contact"
  , expect = { misc=LibCraftText.MASTER_COND.TRAVEL_DC }
  }


-- ,   en  = "Craft a Superb Glyph of Decrease Spell Harm\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Superb Glyph of Flame Resist\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Superb Glyph of Increase Physical Harm\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Superb Glyph of Poison\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Superb Glyph of Weakening\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Truly Superb Glyph of Reduce Feat Cost\n• Quality: Epic\n• Progress: 0 / 1"
-- ,   en  = "Craft a Truly Superb Glyph of Weakening\n• Quality: Epic\n• Progress: 0 / 1"

-- ,   en  = "Craft a Damage Health Poison IX with the following Traits:\n• Gradual Ravage Health\n• Ravage Health\n• Ravage Stamina\n• Progress: 0 / 20"
-- ,   en  = "Craft a Damage Health Poison IX with the following Traits:\n• Ravage Health\n• Ravage Magicka\n• Ravage Stamina\n• Progress: 0 / 20"
-- ,   en  = "Craft a Sorcery-Draining Poison IX with the following Traits:\n• Breach\n• Increase Spell Power\n• Spell Critical\n• Progress: 0 / 20"
-- ,   en  = "Craft a Stealth-Draining Poison IX with the following Traits:\n• Restore Magicka\n• Increase Spell Power\n• Detection\n• Progress: 0 / 20"
-- ,   en  = "Craft an Escapist's Poison IX with the following Traits:\n• Unstoppable\n• Restore Magicka\n• Spell Critical\n• Progress: 0 / 20"
-- ,   en  = "Craft an Essence of Ravage Health with the following Traits:\n• Enervation\n• Fracture\n• Ravage Health\n• Progress: 0 / 20"

-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Bloodthirsty\n• Set: Alessia's Bulwark\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Bloodthirsty\n• Set: Eyes of Mara\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Bloodthirsty\n• Set: Oblivion's Foe\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Robust\n• Set: Kvatch Gladiator\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Legendary\n• Trait: Protective\n• Set: Noble's Conquest\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Legendary\n• Trait: Swift\n• Set: Varen's Legacy\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Ring with the following Properties:\n• Quality: Epic\n• Trait: Protective\n• Set: Night Mother's Gaze\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Bloodthirsty\n• Set: Hist Bark\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Bloodthirsty\n• Set: Magnus' Gift\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Bloodthirsty\n• Set: Redistributor\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Swift\n• Set: Twilight's Embrace\n• Progress: 0 / 1"

-- ,   en  = "Craft a Rubedite Axe with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Shalidor's Curse\n• Style: Silken Ring\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Axe with the following Properties:\n• Quality: Epic\n• Trait: Sharpened\n• Set: Daedric Trickery\n• Style: Akaviri\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Dagger with the following Properties:\n• Quality: Epic\n• Trait: Sharpened\n• Set: Assassin's Guile\n• Style: Dwemer\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Gauntlets with the following Properties:\n• Quality: Epic\n• Trait: Sturdy\n• Set: Armor of the Seducer\n• Style: Draugr\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Greatsword with the following Properties:\n• Quality: Epic\n• Trait: Defending\n• Set: Kvatch Gladiator\n• Style: Daggerfall Covenant\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Greaves with the following Properties:\n• Quality: Epic\n• Trait: Divines\n• Set: Kagrenac's Hope\n• Style: Redoran\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Helm with the following Properties:\n• Quality: Epic\n• Trait: Training\n• Set: Death's Wind\n• Style: Worm Cult\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Mace with the following Properties:\n• Quality: Epic\n• Trait: Charged\n• Set: Kagrenac's Hope\n• Style: Dark Elf\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Mace with the following Properties:\n• Quality: Epic\n• Trait: Sharpened\n• Set: Ashen Grip\n• Style: Ancient Elf\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Pauldron with the following Properties:\n• Quality: Epic\n• Trait: Impenetrable\n• Set: Kvatch Gladiator\n• Style: Pyandonean\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedite Sabatons with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Daedric Trickery\n• Style: Buoyant Armiger\n• Progress: 0 / 1"

-- ,   en  = "Craft an Ancestor Silk Breeches with the following Properties:\n• Quality: Epic\n• Trait: Infused\n• Set: Law of Julianos\n• Style: Morag Tong\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Breeches with the following Properties:\n• Quality: Epic\n• Trait: Training\n• Set: Magnus' Gift\n• Style: Dark Brotherhood\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Breeches with the following Properties:\n• Quality: Epic\n• Trait: Well-Fitted\n• Set: Kagrenac's Hope\n• Style: Ancient Orc\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Epaulets with the following Properties:\n• Quality: Epic\n• Trait: Impenetrable\n• Set: Tava's Favor\n• Style: Sapiarch\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Epaulets with the following Properties:\n• Quality: Epic\n• Trait: Infused\n• Set: Spectre's Eye\n• Style: Ebonshadow\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Sash with the following Properties:\n• Quality: Epic\n• Trait: Well-Fitted\n• Set: Alessia's Bulwark\n• Style: Ancient Elf\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Arm Cops with the following Properties:\n• Quality: Epic\n• Trait: Training\n• Set: Oblivion's Foe\n• Style: Ancient Elf\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Boots with the following Properties:\n• Quality: Epic\n• Trait: Training\n• Set: Song of Lamae\n• Style: Ebonheart Pact\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Bracers with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Noble's Conquest\n• Style: Mercenary\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Guards with the following Properties:\n• Quality: Epic\n• Trait: Divines\n• Set: Oblivion's Foe\n• Style: Primal\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Helmet with the following Properties:\n• Quality: Epic\n• Trait: Training\n• Set: Hunding's Rage\n• Style: Hlaalu\n• Progress: 0 / 1"

-- ,   en  = "Craft a Ruby Ash Bow with the following Properties:\n• Quality: Epic\n• Trait: Powered\n• Set: Hist Bark\n• Style: Hlaalu\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Inferno Staff with the following Properties:\n• Quality: Epic\n• Trait: Precise\n• Set: Hist Bark\n• Style: Malacath\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Lightning Staff with the following Properties:\n• Quality: Epic\n• Trait: Defending\n• Set: Hist Bark\n• Style: Order of the Hour\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Lightning Staff with the following Properties:\n• Quality: Epic\n• Trait: Powered\n• Set: Eternal Hunt\n• Style: Thieves Guild\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Lightning Staff with the following Properties:\n• Quality: Epic\n• Trait: Precise\n• Set: Tava's Favor\n• Style: Sapiarch\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Infused\n• Set: Armor of the Seducer\n• Style: Dark Brotherhood\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Infused\n• Set: Song of Lamae\n• Style: Nord\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Invigorating\n• Set: Oblivion's Foe\n• Style: Redoran\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Invigorating\n• Set: Shacklebreaker\n• Style: Aldmeri Dominion\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Kagrenac's Hope\n• Style: Trinimac\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Sturdy\n• Set: Eyes of Mara\n• Style: Daedric\n• Progress: 0 / 1"



}
