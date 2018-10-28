-- Optional file not normally used except by ziggr during l10n work.
--
-- Discover crafting quest text from the current UI language
-- by scanning the quest journal and listening for quest state
-- changes.
--
--
-- To switch languages in-game:
--      /script SetCVar("language.2", "de")

LibCraftText                   = LibCraftText or {}
LibCraftText.name              = "LibCraftText"
LibCraftText.saved_var_version = 1


local function Info(msg)
    d("|c999999LCT: "..msg)
end

local function Error(msg)
    d("|cFF6666LCT: "..msg)
end

function LibCraftText.OnAddOnLoaded(event, addonName)
    local self = LibCraftText
    if addonName == LibCraftText.name then
        LibCraftText.RegisterSlashCommands()
        self.saved_var = ZO_SavedVars:NewAccountWide(
                              "LibCraftTextVars"
                            , self.saved_var_version
                            , nil
                            , self.default
                            )
    end
end

EVENT_MANAGER:RegisterForEvent( LibCraftText.name
                              , EVENT_ADD_ON_LOADED
                              , LibCraftText.OnAddOnLoaded
                              )

function LibCraftText.RegisterSlashCommands()
    local lsc = LibStub and LibStub:GetLibrary("LibSlashCommander", true)
    if lsc then
        local cmd = lsc:Register( "/lct"
                                , function(arg) LibCraftText.SlashCommand(arg) end
                                , "Scan quest journal for craft text")

        local cc = { { "scan"   , "Scan quest journal for crafting quest text" }
                   , { "forget" , "Forget all discovered data"                 }
                   , { "lang"   , "Switch to 'next' language"                  }
                   }
        for _,c in ipairs(cc) do
            local sub = cmd:RegisterSubCommand()
            sub:AddAlias(c[1])
            sub:SetCallback(function() LibCraftText.SlashCommand(c[1]) end)
            sub:SetDescription(c[2])
        end
    else
        SLASH_COMMANDS["/lct"] = LibCraftText.SlashCommand
    end
end

function LibCraftText.SlashCommand(args)
    if (not args) or args:lower() == "scan" then
        Info("Scanning...")
        LibCraftText.ScanQuestJournal()
        LibCraftText.DiscoverMasterValues()
    elseif args:lower() == "forget" then
        LibCraftText.Forget()
        Info("Forgotten.")
    elseif args:sub(1,4):lower() == "lang" then
        local want_lang = args:sub(6,7):lower()
        LibCraftText.NextLang(want_lang)
    else
        Info("Unkonwn command: '"..tostring(args).."'")
    end
end

function LibCraftText.Forget()
    LibCraftText.saved_var.quests          = nil
    LibCraftText.saved_var.steps           = nil
    LibCraftText.saved_var.conditions      = nil
    LibCraftText.saved_var.set             = nil
    LibCraftText.saved_var.item            = nil
    LibCraftText.saved_var.master_template = nil
end

local function find_i(want, list)
    for i,l in ipairs(list) do
        if want == l then return i end
    end
    return nil
end

function LibCraftText.NextLang(want_lang)
    local lang_list = { "en", "de", "fr", "ru", "es", "it", "ja" }
    local curr_lang = LibCraftText.CurrLang()
    local curr_i    = find_i(curr_lang, lang_list)
    local want_i    = find_i(want_lang, lang_list)
    if not curr_i then
        Error("Current language unknown:"..tostring(curr_lang))
        curr_i = 0
    end
    if not want_i then
        want_i = curr_i + 1
        if want_i > #lang_list then want_i = 1 end
    end
    local want_lang2 = lang_list[want_i]

    Info(string.format("Switching languages %s -> %s"
            , tostring(curr_lang)
            , tostring(want_lang2)))

    SetCVar("language.2", want_lang2)
end

-- Quest Journal -------------------------------------------------------------
function LibCraftText.ScanQuestJournal()
    local self         = LibCraftText
    local lang         = self.CurrLang()
    Info("lang: "..tostring(lang))

    self.saved_var.quests = self.saved_var.quests or {}
    for qi = 1, MAX_JOURNAL_QUESTS do
        local qinfo = self.ScanQuest(qi)
        if qinfo then
            self.saved_var.quests[qi] = self.saved_var.quests[qi] or {}
            self.saved_var.quests[qi][lang] = qinfo
            Info("qi:"..tostring(qi).." "..tostring(qinfo))
        end
    end
end

function LibCraftText.ScanQuest(quest_index)
    local self = LibCraftText
                        -- Only daily and master writ CRAFTING quests matter.
    local jqi = { GetJournalQuestInfo(quest_index) }
    if jqi[self.JQI.quest_type] ~= QUEST_TYPE_CRAFTING then
        return nil
    end

    self.ScanQuestSteps(quest_index)

    local quest_name = jqi[self.JQI.quest_name]
    return quest_name
end

function LibCraftText.ScanQuestSteps(quest_index)
    local self = LibCraftText
    local jqi = { GetJournalQuestInfo(quest_index) }
    if jqi[self.JQI.quest_type] ~= QUEST_TYPE_CRAFTING then
        return nil
    end

    local step_ct = GetJournalQuestNumSteps(quest_index)
    for step_i = 1,step_ct do
        local step_info  = { GetJournalQuestStepInfo(quest_index, step_i) }
        local step_text  = step_info[self.JQSI.step_text]
        self.RecordStepText(quest_index,step_i,step_text)

        local condition_ct = step_info[self.JQSI.num_conditions]
        for cond_i = 1,condition_ct do
            local cond_info = { GetJournalQuestConditionInfo(
                                        quest_index, step_i, cond_i) }
            local cond_text = cond_info[self.JQCI.condition_text]
            self.RecordConditionText(quest_index, step_i, cond_i, cond_text)
        end
    end
end

function LibCraftText.RecordStepText(quest_index, step_index, step_text)
    local self = LibCraftText
    local lang = self.CurrLang()
    if not (step_text and step_text ~= "") then return end
    self.saved_var.steps = self.saved_var.steps or {}
    self.saved_var.steps[quest_index] = self.saved_var.steps[quest_index] or {}
    self.saved_var.steps[quest_index][step_index]
                          = self.saved_var.steps[quest_index][step_index] or {}
    self.saved_var.steps[quest_index][step_index][lang] = step_text
end

function LibCraftText.RecordConditionText( quest_index, step_index
                                         , condition_index, condition_text)
    local self = LibCraftText
    local lang = self.CurrLang()
    if not (condition_text and condition_text ~= "") then return end
    self.saved_var.conditions = self.saved_var.conditions or {}
    self.saved_var.conditions[quest_index]
            = self.saved_var.conditions[quest_index] or {}
    self.saved_var.conditions[quest_index][step_index]
            = self.saved_var.conditions[quest_index][step_index] or {}
    self.saved_var.conditions[quest_index][step_index][condition_index]
            = self.saved_var.conditions[quest_index][step_index][condition_index] or {}
    self.saved_var.conditions[quest_index][step_index][condition_index][lang]
            = condition_text
end

-- GetJournalQuestInfo() returns:
LibCraftText.JQI = {
  quest_name            =  1 -- string
, background_text       =  2 -- string
, active_step_text      =  3 -- string
, active_step_type      =  4 -- number
, active_step_tracker_override_text =  5 -- string
, completed             =  6 -- boolean
, tracked               =  7 -- boolean
, quest_level           =  8 -- number
, pushed                =  9 -- boolean
, quest_type            = 10 -- number
, instance_display_type = 11 -- number InstanceDisplayType
}

-- GetJournalQuestStepInfo() returns
LibCraftText.JQSI = {
  step_text             = 1 -- string
, visibility            = 2 -- number:nilable
, step_type             = 3 -- number
, tracker_override_text = 4 -- string
, num_conditions        = 5 -- number
}

-- GetJournalQuestConditionInfo() returns
LibCraftText.JQCI = {
  condition_text        = 1 -- string
, current               = 2 -- number
, max                   = 3 -- number
, is_fail_condition     = 4 -- boolean
, is_complete           = 5 -- boolean
, is_credit_shared      = 6 -- boolean
, is_visible            = 7 -- boolean
}

-- -- Master Writ requirements: set, style, alch effect, and so on --------------

function LibCraftText.DiscoverMasterValues()
    local self = LibCraftText
    local lang = self.CurrLang()

                        -- REPLACE WITH A BETTER LINK WITH A MOTIF-CARRYING ITEM

                        -- BS master writ, to gather base text template.
    self.saved_var.master_template    = self.saved_var.master_template or {}
    self.saved_var.master_template.bs = self.saved_var.master_template.bs or {}
    local t = "|H1:item:138798:6:1:0:0:0:59:255:4:%d:23:0:0:0:0:0:0:0:0:0:76000|h|h"
    local item_link = string.format(t, 178) -- 178 = "Armor Master"
    local b = GenerateMasterWritBaseText(item_link)
    self.saved_var.master_template.bs[lang] = b

                        -- Item: Rubedite Axe
    local item_list = {
          18, 24                            -- necklace, ring
        , 26, 28, 29, 30, 31, 32, 34, 75    -- light armor, including jerkin
        , 35, 37, 38, 39, 40, 41, 43        -- medium armor
        , 44, 46, 47, 48, 49, 50, 52        -- heavy armor
        , 52, 56, 59, 67, 68, 69, 62        -- bs weapons
        , 70, 72, 73, 74, 70                -- ww weapons
        , 65                                -- shield
        }

    self.saved_var.item = self.saved_var.item or {}
    local item = self.saved_var.item
    local item_ct = 0
    local t = "|H1:item:138798:6:1:0:0:0:%d:255:4:178:23:0:0:0:0:0:0:0:0:0:76000|h|h"

    local re = self.MASTER_BASE_TEXT_RE.item
    for _, i in ipairs(item_list) do
        local item_link = string.format(t, i)
        local b = GenerateMasterWritBaseText(item_link)
        local _,_,f = string.find(b,re)
        if f then
            item[i] = item[i] or {}
            item[i][lang] = f
            item_ct = item_ct + 1
        end
    end
    Info("discovered item_ct:"..tostring(item_ct))

                        -- Set Bonus: "Armor Master", aka writ4
    self.saved_var.set             = self.saved_var.set or {}
    local set = self.saved_var.set
    local set_ct = 0
    local t = "|H1:item:138798:6:1:0:0:0:59:255:4:%d:23:0:0:0:0:0:0:0:0:0:76000|h|h"

    local re = self.MASTER_BASE_TEXT_RE.set
    for i=1,500 do
        local item_link = string.format(t, i)
        local b = GenerateMasterWritBaseText(item_link)
        local _,_,f = string.find(b,re)
        if f then
            set[i] = set[i] or {}
            set[i][lang] = f
            set_ct = set_ct + 1
        end
    end
    Info("discovered set_ct:"..tostring(set_ct))
end

-- Util ----------------------------------------------------------------------

function LibCraftText.CurrLang()
    return GetCVar("language.2")
end

