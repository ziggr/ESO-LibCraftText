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

-- , { input = "Craft a Lusty Argonian Maid Mazte\n• Progress: 0 / 8"
-- , { input = "Craft an Orcrest Agony Pale Ale\n• Progress: 0 / 8"
-- , { input = "Craft a Velothi View Vintage Malbec\n• Progress: 0 / 8"

-- , { input = "Craft a Rubedite Cuirass with the following Properties:\n• Quality: Epic\n• Trait: Sturdy\n• Set: Varen's Legacy\n• Style: Wood Elf\n• Progress: 0 / 1"
-- , { input = "Craft a Rubedite Helm with the following Properties:\n• Quality: Epic\n• Trait: Divines\n• Set: Whitestrake's Retribution\n• Style: Imperial\n• Progress: 0 / 1"
-- , { input = "Craft a Rubedite Maul with the following Properties:\n• Quality: Epic\n• Trait: Defending\n• Set: Daedric Trickery\n• Style: Argonian\n• Progress: 0 / 1"
-- , { input = "Craft a Rubedite Pauldron with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Eternal Hunt\n• Style: Wood Elf\n• Progress: 0 / 1"

-- , { input = "Craft an Ancestor Silk Sash with the following Properties:\n• Quality: Epic\n• Trait: Reinforced\n• Set: Varen's Legacy\n• Style: Worm Cult\n• Progress: 0 / 1"
-- , { input = "Craft a Rubedo Leather Helmet with the following Properties:\n• Quality: Epic\n• Trait: Well-Fitted\n• Set: Kagrenac's Hope\n• Style: Abah's Watch\n• Progress: 0 / 1"

-- , { input = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Protective\n• Set: Armor Master\n• Progress: 0 / 1"

-- , { input = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Invigorating\n• Set: Orgnum's Scales\n• Style: Psijic Order\n• Progress: 0 / 1"
-- , { input = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Noble's Conquest\n• Style: Primal\n• Progress: 0 / 1"
-- , { input = "Craft a Ruby Ash Restoration Staff with the following Properties:\n• Quality: Epic\n• Trait: Nirnhoned\n• Set: Oblivion's Foe\n• Style: Bloodforge\n• Progress: 0 / 1"

-- , { input = "Craft a Platinum Necklace with the following Properties:\n• Quality: Epic\n• Trait: Healthy\n• Set: Assassin's Guile\n• Progress: 0 / 1"

-- , { input = "Travel to Elden Root to Meet Your Contact"
-- , { input = "Travel to Mournhold to Meet Your Contact"
-- , { input = "Travel to Wayrest to Meet Your Contact"
}
