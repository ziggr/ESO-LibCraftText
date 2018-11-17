local LCT = LCT or LibCraftText

MASTER_FODDER = {

  { input  = "Craft an Essence of Ravage Health with the following Traits:\n• Breach\n• Increase Spell Power\n• Ravage Health\n• Progress: 0 / 20"
  , expect = { solvent     =   LCT.MATERIAL.LORKHANS_TEARS
             , name_trait  =   LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
             , trait_list  = { LCT.ALCHEMY_TRAIT.BREACH
                             , LCT.ALCHEMY_TRAIT.INCREASE_SPELL_POWER
                             , LCT.ALCHEMY_TRAIT.RAVAGE_HEALTH
                             }
             }
   }



}
