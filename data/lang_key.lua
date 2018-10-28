LANG_KEY = {
    ["$DAILY_BS"       ] = "Blacksmith Writ"
,   ["$DAILY_CL"       ] = "Clothier Writ"
,   ["$DAILY_EN"       ] = "Enchanter Writ"
,   ["$DAILY_AL"       ] = "Alchemist Writ"
,   ["$DAILY_PR"       ] = "Provisioner Writ"
,   ["$DAILY_WW"       ] = "Woodworker Writ"
,   ["$DAILY_JW"       ] = "Jewelry Crafting Writ"

                        -- Collect FULL STRING translations of the many, many,
                        -- daily crafting writ steps and conditions. Then use
                        -- those and their FULL STRING translations to find the
                        -- useful substrings that an add-on developer would use
                        -- to parse a writ into what to craft.
,   ["$DAILY_STEP_BS_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their smiths. They need several Helms, Daggers, and Pauldrons to outfit their warriors."
,   ["$DAILY_STEP_CL_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their leatherworkers. They need several Helmets, Arm Cops, and Bracers to outfit their warriors."
,   ["$DAILY_STEP_EN_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their enchanters. They need a Superb Glyph of Stamina and a Ta Aspect Rune to outfit their warriors."
,   ["$DAILY_STEP_AL_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their alchemists. I've been tasked with creating an Essence of Stamina and acquiring Mudcrab Chitin to complete my contract."
,   ["$DAILY_STEP_PR_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their provisioners. I've been tasked with creating Firsthold Fruit and Cheese Plate and Muthsera's Remorse to complete my contract."
,   ["$DAILY_STEP_PR_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their provisioners. I've been tasked with creating Firsthold Fruit and Cheese Plate and Muthsera's Remorse to complete my contract."
,   ["$DAILY_STEP_WW_A0"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their woodworkers. They need several Bows and Shields to outfit their warriors."
,   ["$DAILY_STEP_JW_A0"] = "This writ is from a group of \"independent merchants\", trading coin for supplies. I've been tasked with creating a Platinum Ring and a Platinum Necklace to complete my contract."

                        -- Then use the above FULL STRING translations to hand-
                        -- craft substring translations.
,   ["$DAILY_STEP_BS_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their smiths."
,   ["$DAILY_STEP_BS_A2"] = "They need several Helms, Daggers, and Pauldrons to outfit their warriors."
,   ["$DAILY_STEP_CL_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their leatherworkers."
,   ["$DAILY_STEP_CL_A2"] = "They need several Helmets, Arm Cops, and Bracers to outfit their warriors."
,   ["$DAILY_STEP_EN_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their enchanters."
,   ["$DAILY_STEP_EN_A2"] = "They need a Superb Glyph of Stamina and a Ta Aspect Rune to outfit their warriors."
,   ["$DAILY_STEP_AL_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their alchemists."
,   ["$DAILY_STEP_AL_A2"] = "I've been tasked with creating an Essence of Stamina and acquiring Mudcrab Chitin to complete my contract."
,   ["$DAILY_STEP_PR_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their provisioners."
,   ["$DAILY_STEP_PR_A2"] = "I've been tasked with creating Firsthold Fruit and Cheese Plate and Muthsera's Remorse to complete my contract."
,   ["$DAILY_STEP_WW_A1"] = "This writ is from the Orsinium Civic Renewal and Vengeance Committee, needing more supplies but wishing to not shame their woodworkers."
,   ["$DAILY_STEP_WW_A2"] = "They need several Bows and Shields to outfit their warriors."
,   ["$DAILY_STEP_JW_A1"] = "This writ is from a group of \"independent merchants\", trading coin for supplies."
,   ["$DAILY_STEP_JW_A2"] = "I've been tasked with creating a Platinum Ring and a Platinum Necklace to complete my contract."

,   ["$DAILY_COND_BS_A_10_1"] = "Craft Normal Rubedite Helm: 0 / 1"
,   ["$DAILY_COND_BS_A_10_2"] = "Craft Normal Rubedite Dagger: 0 / 1"
,   ["$DAILY_COND_BS_A_10_3"] = "Craft Normal Rubedite Pauldron: 0 / 1"
,   ["$DAILY_COND_CL_A_10_1"] = "Craft Normal Rubedo Leather Helmet: 0 / 1"
,   ["$DAILY_COND_CL_A_10_2"] = "Craft Normal Rubedo Leather Arm Cops: 0 / 1"
,   ["$DAILY_COND_CL_A_10_3"] = "Craft Normal Rubedo Leather Bracers: 0 / 1"
,   ["$DAILY_COND_EN_A_10_1"] = "Craft Superb Glyph of Stamina With Ta: 0 / 1"
,   ["$DAILY_COND_EN_A_10_2"] = "Acquire Ta Aspect Rune: 1 / 1"
,   ["$DAILY_COND_AL_A_10_1"] = "Craft Essence of Stamina: 0 / 1"
,   ["$DAILY_COND_AL_A_10_2"] = "Acquire Mudcrab Chitin: 3 / 3"
,   ["$DAILY_COND_PR_A_10_1"] = "Craft Firsthold Fruit and Cheese Plate: 0 / 1"
,   ["$DAILY_COND_PR_A_10_2"] = "Craft Muthsera's Remorse: 0 / 1"
,   ["$DAILY_COND_WW_A_10_1"] = "Craft Normal Ruby Ash Bow: 0 / 2"
,   ["$DAILY_COND_WW_A_10_2"] = "Craft Normal Ruby Ash Shield: 0 / 1"
,   ["$DAILY_COND_JW_A_5_1" ] = "Craft a Platinum Ring: 0 / 1"
,   ["$DAILY_COND_JW_A_5_2" ] = "Craft a Platinum Necklace: 0 / 1"

,   ["$MASTER_PLATE"   ] = "A Masterful Plate"
,   ["$MASTER_WEAPON"  ] = "A Masterful Weapon"
,   ["$MASTER_TAILOR"  ] = "Masterful Tailoring"
,   ["$MASTER_LEATHER" ] = "Masterful Leatherwear"
,   ["$MASTER_GLYPH"   ] = "A Masterful Glyph"
,   ["$MASTER_CONCOCT" ] = "A Masterful Concoction"
,   ["$MASTER_FEAST"   ] = "A Masterful Feast"
,   ["$MASTER_SHIELD"  ] = "A Masterful Shield"
,   ["$MASTER_WEAPON"  ] = "A Masterful Weapon"
,   ["$MASTER_JEWELRY" ] = "Masterful Jewelry"

,   ["$MASTER_LABEL_QUALITY" ] = "Quality"
,   ["$MASTER_LABEL_SET"     ] = "Set"
,   ["$MASTER_LABEL_STYLE"   ] = "Style"
,   ["$MASTER_LABEL_TRAIT"   ] = "Trait"

,   ["$QUALITY_4"] = "Epic"
,   ["$QUALITY_5"] = "Legendary"

                        -- Nice surprise: master writs all have the same
                        -- step text.
,   ["$MASTER_STEP_1"] = "I need to create the item specified by my contract."
,   ["$MASTER_STEP_N"] = "I need to create the items specified by my contract."

,   ["$MASTER_COND_TRAVEL_EP"] = "Travel to Mournhold to Meet Your Contact"
,   ["$MASTER_COND_TRAVEL_AD"] = "Travel to Elden Root to Meet Your Contact"
,   ["$MASTER_COND_TRAVEL_DC"] = "Travel to Wayrest to Meet Your Contact"

                        -- Collect FULL STRING translations of the many, many,
                        -- master writ conditions. Then use
                        -- those and their FULL STRING translations to find the
                        -- useful substrings that an add-on developer would use
                        -- to parse a writ into what to craft.
,   ["$MASTER_COND_EN_1"] = "Craft a Superb Glyph of Reduce Spell Cost\n• Quality: Epic\n• Progress: 0 / 1"
,   ["$MASTER_COND_BS_1"] = "Craft a Rubedite Cuirass with the following Properties:\n• Quality: Epic\n• Trait: Sturdy\n• Set: Varen's Legacy\n• Style: Wood Elf\n• Progress: 0 / 1"
,   ["$MASTER_COND_WW_1"] = "Craft a Ruby Ash Shield with the following Properties:\n• Quality: Epic\n• Trait: Invigorating\n• Set: Orgnum's Scales\n• Style: Psijic Order\n• Progress: 0 / 1"
,   ["$MASTER_COND_PR_1"] = "Craft a Lusty Argonian Maid Mazte\n• Progress: 0 / 8"
,   ["$MASTER_COND_CL_1"] = "Craft an Ancestor Silk Sash with the following Properties:\n• Quality: Epic\n• Trait: Reinforced\n• Set: Varen's Legacy\n• Style: Worm Cult\n• Progress: 0 / 1"
,   ["$MASTER_COND_AL_1"] = "Craft an Essence of Ravage Health with the following Traits:\n• Breach\n• Increase Spell Power\n• Ravage Health\n• Progress: 0 / 20"
,   ["$MASTER_COND_JW_1"] = "Craft a Platinum Ring with the following Properties:\n• Quality: Legendary\n• Trait: Protective\n• Set: Armor Master\n• Progress: 0 / 1"

,   ["$MASTER_COND_SUB_EN_1"] = "Craft a Superb Glyph of Reduce Spell Cost"
,   ["$MASTER_COND_SUB_BS_1"] = "Craft a Rubedite Cuirass with the following Properties:"
,   ["$MASTER_COND_SUB_WW_1"] = "Craft a Ruby Ash Shield with the following Properties:"
,   ["$MASTER_COND_SUB_PR_1"] = "Craft a Lusty Argonian Maid Mazte"
,   ["$MASTER_COND_SUB_CL_1"] = "Craft an Ancestor Silk Sash with the following Properties:"
,   ["$MASTER_COND_SUB_AL_1"] = "Craft an Essence of Ravage Health with the following Traits:"
,   ["$MASTER_COND_SUB_JW_1"] = "Craft a Platinum Ring with the following Properties:"
,   ["$MASTER_COND_SUB_QUAL_4"] = "• Quality: Epic"
,   ["$MASTER_COND_SUB_QUAL_5"] = "• Quality: Legendary"
,   ["$MASTER_COND_SUB_TRAIT_INVIGORATING"] = "• Trait: Invigorating"
,   ["$MASTER_COND_SUB_TRAIT_PROTECTIVE"  ] = "• Trait: Protective"
,   ["$MASTER_COND_SUB_TRAIT_REINFORCED"  ] = "• Trait: Reinforced"
,   ["$MASTER_COND_SUB_TRAIT_STURDY"      ] = "• Trait: Sturdy"
,   ["$MASTER_COND_SUB_SET_ARMOR_MASTER"  ] = "• Set: Armor Master"
,   ["$MASTER_COND_SUB_SET_ORGNUMS_SCALES"] = "• Set: Orgnum's Scales"
,   ["$MASTER_COND_SUB_SET_VARENS_LEGACY" ] = "• Set: Varen's Legacy"
,   ["$MASTER_COND_SUB_MOTIF_PSIJIC_ORDER"] = "• Style: Psijic Order"
,   ["$MASTER_COND_SUB_MOTIF_WOOD_ELF"    ] = "• Style: Wood Elf"
,   ["$MASTER_COND_SUB_MOTIF_WORM_CULT"   ] = "• Style: Worm Cult"
,   ["$MASTER_COND_SUB_ALCH_EFFECT_BREACH"] = "• Breach"
,   ["$MASTER_COND_SUB_ALCH_EFFECT_SPELL_POWER"] = "• Increase Spell Power"
,   ["$MASTER_COND_SUB_ALCH_EFFECT_RAVAGE_HEALTH"] = "• Ravage Health"
,   ["$MASTER_COND_SUB_PROGRESS_0_01"] = "• Progress: 0 / 1"
,   ["$MASTER_COND_SUB_PROGRESS_0_08"] = "• Progress: 0 / 8"
,   ["$MASTER_COND_SUB_PROGRESS_0_20"] = "• Progress: 0 / 20"

,   ["$ROLIS_NAME"           ] = "Rolis Hlaalu"
,   ["$ROLIS_ACCEPT_CONTRACT"] = "<Accept the contract.>"
,   ["$ROLIS_FINISH_JOB"     ] = "<Finish the job.>"
,   ["$ROLIS_DELIVER_SUBSTR" ] = "Deliver"

,   ["$FINISHED_BS"    ] = "I've finished the Blacksmithing job."
,   ["$FINISHED_CL"    ] = "I've finished the Clothier job."
,   ["$FINISHED_EN"    ] = "I've finished the Enchanting job."
,   ["$FINISHED_AL"    ] = "I've finished the Alchemy job."
,   ["$FINISHED_PR"    ] = "I've finished the Provisioning job."
,   ["$FINISHED_WW"    ] = "I've finished the Woodworking job."
,   ["$FINISHED_JW"    ] = "I've finished the Jewelry job."

}
