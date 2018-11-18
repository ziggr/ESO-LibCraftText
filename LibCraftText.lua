LibCraftText = LibCraftText or {}

-- Daily Crafting Writ Quests ------------------------------------------------

-- Return CRAFTING_TYPE_BLACKSMITHING for "Blacksmithing Writ" and so on.
-- Return nil if not a known daily crafting quest name.
--
-- Pass quest name from GetJournalQuestInfo()[1]:
--
--      local quest_name = GetJournalQuestInfo(i)
--      local quest_type = LibCraftText.DailyQuestNameToCraftingType(quest_name)
--
function LibCraftText.DailyQuestNameToCraftingType(quest_name)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.DAILY_QUEST_TITLES[quest_name]
end

-- Return a table that describes what this quest condtion requires.
--
-- Table fields vary depending on crafting type and condition, but field
-- values will be rows from lang/xx.lua tables.
--
--              BS/CL/WW/JW         "Craft Normal Rubedite Sword"
-- item         ITEM                H1_SWORD
-- material     MATERIAL            RUBEDITE
--
--              Enchanting          "Craft Grand Glyph of Health With Ta"
-- potency      MATERIAL            DERADO
-- essence      "                   OKO
-- aspect       "                   TA
--
--              Alchemy             "Craft Essence of Ravage Health"
-- trait        ALCHEMY_TRAIT       RAVAGE_HEALTH
-- solvent      MATERIAL            LORKHANS_TEARS
--
--              Provisioning        "Craft Baked Potato"
-- item         RECIPE              BAKED_POTATO
--
--              Enchanting, Alchemy "Acquire Ta Aspect Rune"
-- material     MATERIAL            TA
--
--              Miscellaneous       "Deliver Goods to Nearest Writ Quartermaster"
-- misc         DAILY_COND          DELIVER_NEAREST_QUARTERMASTER
--
function LibCraftText.ParseDailyCondition(crafting_type, cond_text)

    if not LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER then
        LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER = {
            [CRAFTING_TYPE_BLACKSMITHING  ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_CLOTHIER       ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_ENCHANTING     ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_ALCHEMY        ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_PROVISIONING   ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_WOODWORKING    ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_JEWELRYCRAFTING] = LibCraftText.ParseDailyConditionEquipment
        }
    end

    local func = nil
    if crafting_type then
        func = LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER[crafting_type]
    end
    if not func then
        func = LibCraftText.ParseDailyConditionMisc
    end
    return func(crafting_type, cond_text)
end

-- Master Crafting Writ Quests -----------------------------------------------

-- Return a list of 1 or more crafting types that match the given
-- quest name.
--
-- Both Blacksmithing and Woodworking use "A Masterful Weapon" for one of
-- their possible quest names, which is why you can sometimes get a list
-- of two possible crafting types.
--
function LibCraftText.MasterQuestNameToCraftingTypeList(quest_name)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.MASTER_QUEST_TITLES[quest_name]
end

-- Return a table that describes what this quest condtion requires.
--
-- Table fields vary depending on crafting type and condition, but field
-- values will be rows from lang/xx.lua tables. See ParseDailyCondition()
-- for field explanations.
--
--              Miscellaneous       "Travel to Mournhold to Meet Your Contact"
-- misc         MASTER_COND         TRAVEL_EP
--
function LibCraftText.ParseMasterCondition(crafting_type, cond_text)
    if not LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER then
        LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER = {
            [CRAFTING_TYPE_BLACKSMITHING  ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_CLOTHIER       ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_ENCHANTING     ] = LibCraftText.ParseMasterConditionEnchanting
        ,   [CRAFTING_TYPE_ALCHEMY        ] = LibCraftText.ParseMasterConditionAlchemy
        ,   [CRAFTING_TYPE_PROVISIONING   ] = LibCraftText.ParseMasterConditionProvisioning
        ,   [CRAFTING_TYPE_WOODWORKING    ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_JEWELRYCRAFTING] = LibCraftText.ParseMasterConditionEquipment
        }
    end

    local func = nil
    if crafting_type then
        func = LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER[crafting_type]
    end
    if not func then
        func = LibCraftText.ParseMasterConditionMisc
    end
    return func(crafting_type, cond_text)
end

-- Turning in Master Writs to Rolis Hlaalu -----------------------------------

-- Return the crafting type that matches the given dialog option text.
-- Can return 0 for "<Finish the job.>" when the dialog text is obviously
-- some sort of master writ turn-in, but type is unknown.
--
function LibCraftText.RolisDialogOptionToCraftingType(dialog_text)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.ROLIS_QUEST_TURN_IN[dialog_text]
end
