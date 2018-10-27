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
    LibCraftText.saved_var.quests = nil
end

local function find_i(want, list)
    for i,l in ipairs(list) do
        if want == l then return i end
    end
    return nil
end

function LibCraftText.NextLang(want_lang)
    local lang_list = { "en", "de", "fr" }--, "ru", "es", "it", "jp" }
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
        return
    end

    local quest_name = jqi[self.JQI.quest_name]
    return quest_name
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

-- Util ----------------------------------------------------------------------

function LibCraftText.CurrLang()
    return GetCVar("language.2")
end

