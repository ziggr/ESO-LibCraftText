LibCraftText = LibCraftText or {}


-- Quest Names ---------------------------------
--
-- Pass quest name from GetJournalQuestInfo()[1]:
--      local quest_name = GetJournalQuestInfo(i)
--      local quest_type = LibCraftText.DailyQuestNameToCraftingType(quest_name)
--

-- Return CRAFTING_TYPE_BLACKSMITHING for "Blacksmithing Writ" and so on.
-- Return nil if not a known daily crafting quest name.
--
function LibCraftText.DailyQuestNameToCraftingType(quest_name)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.DAILY_QUEST_TITLES[quest_name]
end

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


-- Quest Conditions ----------------------------------------------------------
--
-- Return a table that describes what this quest condtion requires.
--
-- Table fields vary depending on crafting type and condition, but field
-- values will be rows from lang/xx.lua tables.
--
--              BS/CL/WW/JW
-- item         ITEM                H1_SWORD            "Craft Normal
-- material     MATERIAL            RUBEDITE              Rubedite Sword"
-- quality      QUALITY             EPIC                "Quality: Epic"
-- trait        TRAIT               WEAPON_SHARPENED    "Trait: Sharpened"
-- set          SET                 MORKULDIN           "Set: Morkuldin"
-- motif        MOTIF               WOOD_ELF            "Style: Wood Elf"
--
--              Enchanting          "Craft Grand Glyph of Health With Ta"
-- potency      MATERIAL            DERADO
-- essence      "                   OKO
-- aspect       "                   TA
--
--              Alchemy             "Craft Essence of Ravage Health"
-- trait        ALCHEMY_TRAIT       RAVAGE_HEALTH
-- solvent      MATERIAL            LORKHANS_TEARS
-- trait_list   { BREACH            "with the following traits:"
--              , FRACTURE
--              , RAVAGE_HEALTH }
--
--              Provisioning        "Craft Baked Potato"
-- item         RECIPE              BAKED_POTATO
--
--              Enchanting, Alchemy "Acquire Ta Aspect Rune"
-- material     MATERIAL            TA
--
--              Miscellaneous       "Deliver Goods to Nearest Writ Quartermaster"
-- misc         DAILY_COND          DELIVER_NEAREST_QUARTERMASTER
--                                  "Travel to Mournhold to Meet Your Contact"
--              MASTER_COND         TRAVEL_EP
--
function LibCraftText.ParseDailyCondition(crafting_type, cond_text)
    return LibCraftText.Daily.ParseConditionInternal(crafting_type, cond_text)
end

function LibCraftText.ParseMasterCondition(crafting_type, cond_text)
    return LibCraftText.Master.ParseConditionInternal(crafting_type, cond_text)
end


-- Quest Dialogs -------------------------------------------------------------
--
-- Convert dialog titles or options to their corresponding crafting_type
-- and other data.
--
-- Returns one of LibCraftText.DIALOG.DAILY.ROW:
--
--  option_examine   "<Examine the Blacksmith Writs.>"
--  title_turn_in    "-Blacksmith Delivery Crate-"
--  crafting_type    CRAFTING_TYPE_BLACKSMITHING
--
function LibCraftText.DailyDialogTitleToRow(dialog_title)
    for _,row in ipairs(LibCraftText.DIALOG.DAILY.ROW) do
        if row.title_turn_in == dialog_title then return row end
    end
    return nil
end

function LibCraftText.DailyDialogOptionToRow(option_text)
    for _,row in ipairs(LibCraftText.DIALOG.DAILY.ROW) do
        if row.option_examine == option_text then return row end
    end
    return nil
end
                        -- Is this one of the two daily crafting writ boards?
function LibCraftText.DailyDialogTitleIsWritBoard(dialog_title)
    for _,t in pairs(LibCraftText.DIALOG.DAILY.TITLE_OFFER) do
        if t == dialog_title then return true end
    end
    return nil
end


-- Turning in Master Writs to Rolis Hlaalu -----------------------------------

-- Convert Rolis dialog option "I've finished the Blacksmithing job."
-- into CRAFTING_TYPE_BLACKSMITHING.
--
function LibCraftText.RolisDialogOptionToCraftingType(dialog_text)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.MASTER_OPTION_FINISH[dialog_text]
end
