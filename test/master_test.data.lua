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

-- , { input = "Craft a Rubedite Greatsword with the following Properties:\n• Quality: Epic\n• Trait: Defending\n• Set: Kvatch Gladiator\n• Style: Daggerfall Covenant\n• Progress: 0 / 1"
-- , { input = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Bloodthirsty\n• Set: Alessia's Bulwark\n• Progress: 0 / 1"
-- , { input = "Craft a Ruby Ash Bow with the following Properties:\n• Quality: Epic\n• Trait: Powered\n• Set: Hist Bark\n• Style: Hlaalu\n• Progress: 0 / 1"

-- ,   en  = "Craft a Rubedite Pauldron with the following Properties:\n• Quality: Epic\n• Trait: Impenetrable\n• Set: Kvatch Gladiator\n• Style: Pyandonean\n• Progress: 0 / 1"
-- ,   en  = "Craft a Platinum Necklace with the following Properties:\n• Quality: Legendary\n• Trait: Swift\n• Set: Varen's Legacy\n• Progress: 0 / 1"
-- ,   en  = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Kagrenac's Hope\n• Style: Trinimac\n• Progress: 0 / 1"
-- ,   en  = "Craft an Ancestor Silk Breeches with the following Properties:\n• Quality: Epic\n• Trait: Infused\n• Set: Law of Julianos\n• Style: Morag Tong\n• Progress: 0 / 1"
-- ,   en  = "Craft a Rubedo Leather Bracers with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Noble's Conquest\n• Style: Mercenary\n• Progress: 0 / 1"

}
