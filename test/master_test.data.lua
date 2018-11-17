local LCT = LCT or LibCraftText

MASTER_FODDER = {

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

, { input = "Craft a Lusty Argonian Maid Mazte\n• Progress: 0 / 8"
  , expect = { item=LCT.LUSTY_ARGONIAN_MAID_MAZTE }
  }

-- , { input = "Craft a Rubedite Cuirass with the following Properties:\n• Quality: Epic\n• Trait: Sturdy\n• Set: Varen's Legacy\n• Style: Wood Elf\n• Progress: 0 / 1"
-- , { input = "Craft a Rubedite Helm with the following Properties:\n• Quality: Epic\n• Trait: Divines\n• Set: Whitestrake's Retribution\n• Style: Imperial\n• Progress: 0 / 1"
-- , { input = "Craft an Ancestor Silk Sash with the following Properties:\n• Quality: Epic\n• Trait: Reinforced\n• Set: Varen's Legacy\n• Style: Worm Cult\n• Progress: 0 / 1"
-- , { input = "Craft a Superb Glyph of Reduce Spell Cost\n• Quality: Epic\n• Progress: 0 / 1"
-- , { input = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Protective\n• Set: Armor Master\n• Progress: 0 / 1"
-- , { input = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Invigorating\n• Set: Orgnum's Scales\n• Style: Psijic Order\n• Progress: 0 / 1"
-- , { input = "Travel to Elden Root to Meet Your Contact"
-- , { input = "Travel to Wayrest to Meet Your Contact"
-- , { input = "Travel to Mournhold to Meet Your Contact"

}