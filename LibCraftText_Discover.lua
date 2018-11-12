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

-- For less typing
local bs = CRAFTING_TYPE_BLACKSMITHING   -- 1
local cl = CRAFTING_TYPE_CLOTHIER        -- 2
local en = CRAFTING_TYPE_ENCHANTING      -- 3
local al = CRAFTING_TYPE_ALCHEMY         -- 4
local pr = CRAFTING_TYPE_PROVISIONING    -- 5
local ww = CRAFTING_TYPE_WOODWORKING     -- 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING -- 7

local function Info(msg)
    d("|c999999LibCraftText: "..msg)
end

local function Error(msg)
    d("|cFF6666LibCraftText: "..msg)
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
        self.saved_char = ZO_SavedVars:New(
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

        local cc = { { "scan"       , "Scan quest journal for crafting quest text" }
                   , { "forget"     , "Forget all discovered data"                 }
                   , { "lang"       , "Switch to 'next' language"                  }
                   , { "scanlang"   , "Scan, then switch languages"                }
                   , { "en"         , "Switch to English language. (other lang codes work, too)"}
                   , { "discover"   , "Extract material and item names"            }
                   , { "abandon"    , "Abandon all daily crafting quests"          }
                   , { "alchemist"  , "Craft 26 potions to learn all traits"       }
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
        LibCraftText.Scan()
    elseif args:lower() == "discover" then
        Info("Discovering...")
        LibCraftText.Discover()
        Info("Ready for you to interact with 6 equipment crafting stations.")
    elseif args:lower() == "forget" then
        LibCraftText.Forget()
        Info("Forgotten.")
    elseif args:lower() == "abandon" then
        LibCraftText.Abandon()
        LibCraftText.Forget()
        Info("Abandoned and forgotten.")
    elseif args:lower() == "lang" then
        LibCraftText.NextLang()
    elseif args:lower() == "scanlang" then
        LibCraftText.Scan()
        LibCraftText.NextLang()
    elseif args:lower() == "en" then
        SetCVar("language.2", "en")
    elseif LibCraftText.IsLang(args) then
        local lang = LibCraftText.IsLang(args)
        SetCVar("language.2", lang)
    elseif args:lower() == "alchemist" then
        LibCraftText.LearnAllAlchemy()
    else
        Info("Unknown command: '"..tostring(args).."'")
    end
end

function LibCraftText.Scan()
    LibCraftText.ScanQuestJournal()
    LibCraftText.ScanSkillRanks()
    LibCraftText.ReportScannedLang()
end

function LibCraftText.Discover()
    -- LibCraftText.DiscoverEquipmentMaterials()
    -- LibCraftText.DiscoverConsumableMaterials()
    -- LibCraftText.DiscoverItems()
    -- LibCraftText.DiscoverQualities()
    -- LibCraftText.DiscoverTraits()
    -- LibCraftText.DiscoverSets()
    -- LibCraftText.DiscoverMotifs()
    LibCraftText.DiscoverRecipes()
    LibCraftText.RegisterCraftingStationListener()
end

function LibCraftText.Forget()
    local fields = {
                     "quests"
                   , "steps"
                   , "conditions"
                   , "materials"
                   , "items"
                   , "qualities"
                   , "traits"
                   , "sets"
                   , "motifs"
                   , "items_from_stations"
                   , "skill_rank"
                   , "alliance"
                   , "consumable_materials"
                   , "scanned_lang"
                   , "recipes"
                   , "alchemy"
                   }
    for _,field in ipairs(fields) do
        -- LibCraftText.saved_var [field] = nil  Uncomment only when you really need to.
        LibCraftText.saved_char[field] = nil
    end
end

function LibCraftText.Abandon()
    LibCraftText.AbandonSomeDailies()
end

                        -- Abandon all the daily crafting quests we can find.
                        -- Return the count of quests that we abandoned.
function LibCraftText.AbandonSomeDailies()
    local self = LibCraftText
                        -- Iterate backwards to avoid problems with quest
                        -- indexes changing each time we delete a quest.
    local abandon_ct = 0
    for quest_index = MAX_JOURNAL_QUESTS,1,-1  do
        local jqi = { GetJournalQuestInfo(quest_index) }
        local repeat_type = GetJournalQuestRepeatType(quest_index)
-- Info(string.format("qi:%d  qtype:%d ?= %d  rtype:%d ?= %d   name:%s"
--     , quest_index
--     , jqi[self.JQI.quest_type]  , QUEST_TYPE_CRAFTING
--     , repeat_type               , QUEST_REPEAT_DAILY
--     , jqi[self.JQI.quest_name]
--     ))
        if jqi[self.JQI.quest_type] == QUEST_TYPE_CRAFTING
            and repeat_type == QUEST_REPEAT_DAILY then
            local name = jqi[self.JQI.quest_name]
            Info(string.format("abandoned %d:%s", quest_index, tostring(name)))
            AbandonQuest(quest_index)
            abandon_ct = abandon_ct + 1
        end
    end
    return abandon_ct
end

LibCraftText.LANG_LIST = { "en", "de", "fr", "ru", "es", "it", "ja" }

function LibCraftText.IsLang(text)
    if not text then return nil end
    for _,lang in ipairs(LibCraftText.LANG_LIST) do
        if lang == text:lower() then
            return lang
        end
    end
    return nil
end

function LibCraftText.ReportScannedLang()
    local self      = LibCraftText
    local curr_lang = self.CurrLang()
    self.saved_char.scanned_lang = self.saved_char.scanned_lang or {}
    self.saved_char.scanned_lang[curr_lang] = true

                        -- Are we in a language that comes "before" the
                        -- current language in LANG_LIST? If so, and if
                        -- you forgot to scan it, then light it up red.
    local in_before = true
    local report_table = {}
    for _,lang in ipairs(self.LANG_LIST) do
        local color = "|c666666"
        if self.saved_char.scanned_lang[lang] then
            color = "|c669966"  -- Done. All is good.
        elseif in_before then
            color = "|cFF6666"  -- You missed one! Turn back! Turn back!
        else
            color = "|c666666"  -- Todo, dim grey.
        end

        if lang == curr_lang then
            in_before = false
            lang      = lang:upper()  -- Show current lang in uppercase.
        end

        local msg = color..lang.."|r"
        table.insert(report_table, msg)
    end
    Info("Scanned: "..table.concat(report_table, " "))
end

local function find_i(want, list)
    for i,l in ipairs(list) do
        if want == l then return i end
    end
    return nil
end

function LibCraftText.NextLang(want_lang)
    local lang_list = LibCraftText.LANG_LIST
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

function LibCraftText.ToQuestIndexOverride(quest_index)
    local self       = LibCraftText
    local jqi        = { GetJournalQuestInfo(quest_index) }
    if jqi[self.JQI.quest_type] ~= QUEST_TYPE_CRAFTING then
        return nil
    end
    local quest_name = jqi[self.JQI.quest_name]
    local ctype      = self.DailyQuestNameToCraftingType(quest_name)
    if (not ctype)
                        -- Hack for broken IT Italian translation
            and quest_name == ""
            and GetCVar("language.2") == "it" then
        ctype = CRAFTING_TYPE_JEWELRYCRAFTING
    end
    local quest_index_key_override = self.CRAFTING_TYPE_ABBREV[ctype]
    local qi         = quest_index_key_override or quest_index
    return qi
end

-- The above hack in LibCraftText.ToQuestIndexOverride() fixes some IT Italian
-- problems, but does introduce this one strange second condition in Italian
-- that none of the other languages have:
--    ["jw"] =
--    {
--        [1] =
--        {                                               <-- becomes $DAILY_COND_JW_05_08
--            [2] =                                       <-- HERE
--            {                                           <--
--                ["it"] = "TRACKER GOAL TEXT: 3 / 3",    <--
--            },                                          <--
--            [1] =
--            {
--                ["es"] = "Fabrica dos colgantes de platino: 0/2",
--                ["fr"] = "Fabriquez deux colliers en platine : 0/2",
--                ["it"] = "TRACKER GOAL TEXT: 0 / 2",
--                ["ja"] = "プラチナのネックレスを2個作る: 0 / 2",
--                ["en"] = "Craft Two Platinum Necklaces: 0 / 2",
--                ["de"] = "Stellt zwei Platinhalsketten her: 0/2",
--                ["ru"] = "Craft two Platinum Necklaces: 0 / 2",
--            },
--        },
--    },
--
-- Which in turn causes lang_gen.lua to stumble when it encounters a lang_table
-- with no "en" value, thus unable render that key when generating en, de, or
-- any language other than "it". So I'll hand-strip this lang_table from
-- saved variables for now, but I suspect I'll need to be smarter in either
-- LibCraftText.RecordConditionText() ("don't insert a non-EN language if
-- there's not already EN english value"?) or lang_gen. Not sure yet.

-- Quest Journal -------------------------------------------------------------
function LibCraftText.ScanQuestJournal()
    local self         = LibCraftText
    local lang         = self.CurrLang()
    Info("lang: "..tostring(lang))

    self.saved_char.quests = self.saved_char.quests or {}
    for quest_index = 1, MAX_JOURNAL_QUESTS do
        local quest_name = self.ScanQuest(quest_index)
        if quest_name then
            local qi_override = self.ToQuestIndexOverride(quest_index)
            self.saved_char.quests[qi_override] = self.saved_char.quests[qi_override] or {}
            self.saved_char.quests[qi_override][lang] = quest_name
            Info("qi:"..tostring(qi_override).." "..tostring(quest_name))
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

LibCraftText.CRAFTING_TYPE_ABBREV = {
    [bs] = "bs"
,   [cl] = "cl"
,   [en] = "en"
,   [al] = "al"
,   [pr] = "pr"
,   [ww] = "ww"
,   [jw] = "jw"
}

function LibCraftText.ScanQuestSteps(quest_index)
    local self = LibCraftText
    local jqi = { GetJournalQuestInfo(quest_index) }
    if jqi[self.JQI.quest_type] ~= QUEST_TYPE_CRAFTING then
        return nil
    end

    local qi_override   = self.ToQuestIndexOverride(quest_index)

    local step_ct = GetJournalQuestNumSteps(quest_index)
    for step_i = 1,step_ct do
        local step_info  = { GetJournalQuestStepInfo(quest_index, step_i) }
        local step_text  = step_info[self.JQSI.step_text]
        self.RecordStepText( quest_index, step_i, step_text
                           , qi_override )

        local condition_ct = step_info[self.JQSI.num_conditions]
        for cond_i = 1,condition_ct do
            local cond_info = { GetJournalQuestConditionInfo(
                                        quest_index, step_i, cond_i) }
            local cond_text = cond_info[self.JQCI.condition_text]
            self.RecordConditionText( quest_index, step_i, cond_i, cond_text
                                    , qi_override)
        end
    end
end

function LibCraftText.RecordStepText(quest_index, step_index, step_text, quest_index_key_override)
    local self = LibCraftText
    local lang = self.CurrLang()
    if not (step_text and step_text ~= "") then return end
    local qi = quest_index_key_override or quest_index
    self.saved_char.steps = self.saved_char.steps or {}
    self.saved_char.steps[qi] = self.saved_char.steps[qi] or {}
    self.saved_char.steps[qi][step_index]
                          = self.saved_char.steps[qi][step_index] or {}
    self.saved_char.steps[qi][step_index][lang] = step_text
end

function LibCraftText.RecordConditionText( quest_index, step_index
                                         , condition_index, condition_text
                                         , quest_index_key_override )
    local self = LibCraftText
    local lang = self.CurrLang()
    local qi = quest_index_key_override or quest_index
    if not (condition_text and condition_text ~= "") then return end
    self.saved_char.conditions = self.saved_char.conditions or {}
    self.saved_char.conditions[qi]
            = self.saved_char.conditions[qi] or {}
    self.saved_char.conditions[qi][step_index]
            = self.saved_char.conditions[qi][step_index] or {}
    self.saved_char.conditions[qi][step_index][condition_index]
            = self.saved_char.conditions[qi][step_index][condition_index] or {}
    self.saved_char.conditions[qi][step_index][condition_index][lang]
            = condition_text
end

local SKILL_ID = {
      [bs] =  70041    -- Metalworking
    , [cl] =  70044    -- Tailoring
    , [en] =  70045    -- Potency Improvement
    , [al] =  70043    -- Solvent Expertise
    , [pr] =  44650    -- Recipe Improvement
    , [ww] =  70046    -- Woodworking
    , [jw] = 103636    -- Engraver
}
function LibCraftText.SkillRank(crafting_type)
    local ability_skill_id = SKILL_ID[crafting_type]
    local keys = { GetSpecificSkillAbilityKeysByAbilityId(ability_skill_id) }
    local skill_rank = GetSkillAbilityUpgradeInfo(unpack(keys))
    return skill_rank
end

function LibCraftText.ScanSkillRanks()
    local self = LibCraftText
    for crafting_type,_ in ipairs(SKILL_ID) do
        local skill_rank = self.SkillRank(crafting_type)
        self.saved_char.skill_rank = self.saved_char.skill_rank or {}
        self.saved_char.skill_rank[crafting_type] = skill_rank
    end

    local ALLIANCE = {
          [ALLIANCE_ALDMERI_DOMINION]       = "AD"
        , [ALLIANCE_EBONHEART_PACT  ]       = "EP"
        , [ALLIANCE_DAGGERFALL_COVENANT]    = "DC"
        }
    local alliance_id = GetUnitAlliance("player")
    self.saved_char.alliance = ALLIANCE[alliance_id]
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

--[[

    HOW TO PARSE DAILY CRAFTING CONDITIONS?

    German squishes words together.
    French, Spanish reorders adjectival materials AFTER item name
    Japanese puts the adj+item BEFORE the "craft wo suru" verb

    The verbs change depending on crafting type:
    "prepara" potion, "fabrica" dagger, "adquiere" mudcrab chitin

    10 mats, can probably find names by scanning
    37 or so gear items, can probably scan those names, too, even if


function LibCraftText.DiscoverDaily(quest_index, step_index
        , condition_index, cond_text)
    local self = LibCraftText
    local quest_name = GetJournalQuestInfo(quest_index)
    local crafting_type = LibCraftText.DailyQuestNameToCraftingType(quest_name)

                        -- Bootstrap: eventually these need to live in lang_db.
                        -- But after a full 3-day cycle of  rank 10
                        -- Rubedite/Ruby Ash/Ancestor Silk/Platinum daily
                        -- writs, you will have extracted all possible daily
                        -- write items.
                        --
                        -- So use lang_db MATS table if you got one, but fall
                        -- back to these if you don't.
    local MATS = {
        [bs] = {
               ,   en  = { "Rubedite" }
               ,   de  = { "Rubedit" }
               ,   fr  = { "cuprite" }
               ,   es  = { "rubedita" }
               ,   ja  = { "ルベダイト" }
               }
    }


    local RE = {
        [bs] = {   en  = "Craft Normal $MAT $ITEM: 0 / 1"
               ,   de  = "Stellt normale $MAT$ITEM her: 0/1"
               ,   fr  = "Fabriquez une? $ITEM en $MAT normal : 0/1"
               ,   es  = "Fabrica une $ITEM de $MAT normal: 0/1"
               ,   it  = "Craft $MAT $ITEM: 0 / 1"
               ,   ja  = "$MATの$ITEM(ノーマル)を生産する: 0 / 1"
               }
    ,   [cl]   {   en  = "Craft Normal $MAT $ITEM: 0 / 1"
               ,   de  = "Stellt normale Rubedolederschulterkappen her: 0/1"
               ,   fr  = "Fabriquez des coques d'épaules en cuir pourpre normales : 0/1"
               ,   es  = "Fabrica unas hombreras de cuero rubedo normales: 0/1"
               ,   it  = "Craft Rubedo Leather Arm Cops: 0 / 1"
               ,   ja  = "ルベドレザーのアームカップ(ノーマル)を生産する: 0 / 1"
               }
    }
end

]]

-- Get all BS LGT MED WW JW base crafting materials,
-- fill saved_vars.mats with table.
--
-- If this can be gleaned at runtime, then there's no reason to include it
-- in lang_template.lua files. But I'll include it for now.

function LibCraftText.DiscoverEquipmentMaterials()
    local self = LibCraftText
    self.saved_var.materials = self.saved_var.materials or {}
    local materials = self.saved_var.materials
    local lang  = self.CurrLang()

                        -- As of 2018-10-29, Italian translation lacks any
                        -- material substring in its master writ base text.
                        -- Since the Italian translation leaves its daily
                        -- crafting writ steps in EN english anyway, I'm okay
                        -- with skipping material substring extraction for
                        -- Italian.
    if lang == "it" then return end

    local writ2 = {
       ["bs" ] = {   1,   9, 156, 160, 164, 168, 172, 176, 180, 188  }
    ,  ["lgt"] = {   5,  45,  47,  49,  51, 125, 126, 127, 128, 194  }
    ,  ["med"] = { 148, 154, 158, 162, 166, 170, 174, 131, 132, 190  }
    ,  ["ww" ] = {   2,  18,  20,  22,  24, 133, 134, 135, 136, 192  }
    ,  ["jw" ] = {   6,  56, 137, 139, 255                           }
    }
    local template = {
       ["bs" ] = "|H1:item:119563:6:1:0:0:0:69:%d:4:74:8:35:0:0:0:0:0:0:0:0:66000|h|h"
    ,  ["lgt"] = "|H1:item:119694:6:1:0:0:0:32:%d:4:79:14:65:0:0:0:0:0:0:0:0:63000|h|h"
    ,  ["med"] = "|H1:item:119695:6:1:0:0:0:37:%d:4:81:11:62:0:0:0:0:0:0:0:0:61500|h|h"
    ,  ["ww" ] = "|H1:item:119681:6:1:0:0:0:74:%d:4:95:26:34:0:0:0:0:0:0:0:0:529000|h|h"
    ,  ["jw" ] = "|H1:item:138798:6:1:0:0:0:18:%d:4:176:30:0:0:0:0:0:0:0:0:0:656000|h|h"
    }
    local RE = {
       ["bs" ] = { en = "Craft an? (.*) Maul;"
                 , de = "Stellt einen (.*)streitkolben mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez une masse d'arme [en ]*([^;]*);"
                 , ru = "Создать предмет %((.*) Maul%);"
                 , es = "Fabricar: Maza de ([^;]*);"
                 , it = nil -- base_text lacks ANY material substring!
                 , ja = "Craft a (.*)の大槌;"
                 }
    ,  ["lgt"] = { en = "Craft an? (.*) Shoes;"
                 , de = "Stellt einige (.*)schuhe mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez des Chaussures [en ]*([^;]*);"
                 , ru = "Создать предмет %((.*) Shoes%);"
                 , es = "Fabricar: Zapatos de ([^;]*);"
                 , it = nil -- base_text lacks ANY material substring!
                 , ja = "Craft a (.*)の靴;"
                 }
    ,  ["med"] = { en = "Craft an? (.*) Jack"
                 , de = "Stellt ein (.*) ?.ams mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez un gilet [en ]*([^;]*);"
                 , ru = "Создать предмет %((.*) Jack%);"
                 , es = "Fabricar: Pechera [de ]*([^;]*);"
                 , it = nil -- base_text lacks ANY material substring!
                 , ja = "Craft a (.*)の胴当て;"
                 }
    ,  ["ww" ] = { en = "Craft an? (.*) Lightning Staff;"
                 , de = "Stellt einen (.*)blitzstab mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez un Bâton de foudre en ([^;]*);"
                 , ru = "Создать предмет %((.*) Lightning Staff%);"
                 , es = "Fabricar: Vara eléctrica de \t?([^;]*);"
                 , it = nil -- base_text lacks ANY material substring!
                 , ja = "Craft a (.*)の稲妻の杖;"
                 }
    ,  ["jw" ] = { en = "Craft an? (.*) Necklace;"
                 , de = "Stellt einen (.*)kette mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez un Collier en ([^;]*);"
                 , ru = "Создать предмет %((.*) Necklace%);"
                 , es = "Fabricar: Collar de ([^;]*);"
                 , it = nil -- base_text lacks ANY material substring!
                 , ja = "Craft a (.*)のネックレス;"
                 }
    }

    for weight, list in pairs(writ2)  do
        materials[weight] = materials[weight] or {}
        materials[weight][lang] = {}
        for i,mat_num in ipairs(writ2[weight]) do
            local item_link = template[weight]:format(mat_num)
            local b = GenerateMasterWritBaseText(item_link)
            local re = RE[weight][lang] or RE[weight].en
            local _,_,f = string.find(b,re)
            table.insert(materials[weight][lang], f or b)
        end
    end
end

-- Get names of all AL EN materials
function LibCraftText.DiscoverConsumableMaterials()
    local MAT_ROWS = {
                       {  30157 , al } -- "Blessed Thistle"
                     , {  30148 , al } -- "Blue Entoloma"
                     , {  30160 , al } -- "Bugloss"
                     , {  30164 , al } -- "Columbine"
                     , {  30161 , al } -- "Corn Flower"
                     , {  30162 , al } -- "Dragonthorn"
                     , {  30151 , al } -- "Emetic Russula"
                     , {  30156 , al } -- "Imp Stool"
                     , {  30158 , al } -- "Lady's Smock"
                     , {  30155 , al } -- "Luminous Russula"
                     , {  30163 , al } -- "Mountain flower"
                     , {  30153 , al } -- "Namira's Rot"
                     , {  30165 , al } -- "Nirnroot"
                     , {  30149 , al } -- "Stinkhorn"
                     , {  30152 , al } -- "Violet Coprinus"
                     , {  30166 , al } -- "Water Hyacinth"
                     , {  30154 , al } -- "White Cap"
                     , {  30159 , al } -- "Wormwood"
                     , {  77583 , al } -- "Beetle Scuttle"
                     , {  77585 , al } -- "Butterfly Wing"
                     , {  77587 , al } -- "Fleshfly Larva"
                     , {  77591 , al } -- "Mudcrab Chitin"
                     , {  77590 , al } -- "Nightshade"
                     , {  77589 , al } -- "Scrib Jelly"
                     , {  77584 , al } -- "Spider Egg"
                     , {  77581 , al } -- "Torchbug Thorax"
                     , { 139020 , al } -- "Clam Gall"
                     , { 139019 , al } -- "Powdered Mother of Pearl"

                     , {    883 , al } -- "Natural Water"
                     , {   1187 , al } -- "Clear Water"
                     , {   4570 , al } -- "Pristine Water"
                     , {  23265 , al } -- "Cleansed Water"
                     , {  23266 , al } -- "Filtered Water"
                     , {  23267 , al } -- "Purified Water"
                     , {  23268 , al } -- "Cloud Mist"
                     , {  64500 , al } -- "Star Dew"
                     , {  64501 , al } -- "Lorkhan's Tears"

                     , {  75357 , al } -- "Grease"
                     , {  75358 , al } -- "Ichor"
                     , {  75359 , al } -- "Slime"
                     , {  75360 , al } -- "Gall"
                     , {  75361 , al } -- "Terebinthine"
                     , {  75362 , al } -- "Pitch-Bile"
                     , {  75363 , al } -- "Tarblack"
                     , {  75364 , al } -- "Night-Oil"
                     , {  75365 , al } -- "Alkahest"

                     , {  45855 , en } -- "Jora"
                     , {  45856 , en } -- "Porade"
                     , {  45857 , en } -- "Jera"
                     , {  45806 , en } -- "Jejora"
                     , {  45807 , en } -- "Odra"
                     , {  45808 , en } -- "Pojora"
                     , {  45809 , en } -- "Edora"
                     , {  45810 , en } -- "Jaera"
                     , {  45811 , en } -- "Pora"
                     , {  45812 , en } -- "Denara"
                     , {  45813 , en } -- "Rera"
                     , {  45814 , en } -- "Derado"
                     , {  45815 , en } -- "Rekura"
                     , {  45816 , en } -- "Kura"
                     , {  64509 , en } -- "Rejera"
                     , {  68341 , en } -- "Repora"

                     , {  45817 , en } -- "Jode"
                     , {  45818 , en } -- "Notade"
                     , {  45819 , en } -- "Ode"
                     , {  45820 , en } -- "Tade"
                     , {  45821 , en } -- "Jayde"
                     , {  45822 , en } -- "Edode"
                     , {  45823 , en } -- "Pojode"
                     , {  45824 , en } -- "Rekude"
                     , {  45825 , en } -- "Hade"
                     , {  45826 , en } -- "Idode"
                     , {  45827 , en } -- "Pode"
                     , {  45828 , en } -- "Kedeko"
                     , {  45829 , en } -- "Rede"
                     , {  45830 , en } -- "Kude"
                     , {  64508 , en } -- "Jehade"
                     , {  68340 , en } -- "Itade"

                     , {  45839 , en } -- "Dekeipa"
                     , {  45833 , en } -- "Deni"
                     , {  45836 , en } -- "Denima"
                     , {  45842 , en } -- "Deteri"
                     , {  45841 , en } -- "Haoko"
                     , {  68342 , en } -- "Hakeijo"
                     , {  45849 , en } -- "Kaderi"
                     , {  45837 , en } -- "Kuoko"
                     , {  45848 , en } -- "Makderi"
                     , {  45832 , en } -- "Makko"
                     , {  45835 , en } -- "Makkoma"
                     , {  45840 , en } -- "Meip"
                     , {  45831 , en } -- "Oko"
                     , {  45834 , en } -- "Okoma"
                     , {  45843 , en } -- "Okori"
                     , {  45846 , en } -- "Oru"
                     , {  45838 , en } -- "Rakeipa"
                     , {  45847 , en } -- "Taderi"

                     , {  45850 , en } -- "Ta"
                     , {  45851 , en } -- "Jejota"
                     , {  45852 , en } -- "Denata"
                     , {  45853 , en } -- "Rekuta"
                     , {  45854 , en } -- "Kuta"
                     }


    local self = LibCraftText
    self.saved_var.consumable_materials = self.saved_var.consumable_materials or {}
    local materials = self.saved_var.consumable_materials -- for less typing
    local lang      = self.CurrLang()
    for _,row in ipairs(MAT_ROWS) do
        -- local key               = row[1]
        local item_id           = row[1]
        local crafting_type     = row[2]
        local item_link         = self.ItemIDToItemLink(item_id)
        local item_name_carety  = GetItemLinkName(item_link)
        local item_name         = Decaret(item_name_carety)
        materials[crafting_type] = materials[crafting_type] or {}
        materials[crafting_type][item_id] = materials[crafting_type][item_id] or {}
        materials[crafting_type][item_id][lang] = item_name
        -- break
    end
end

-- copied from Dolgubon's LibLazyCrafting functions.lua.
-- Isn't there an official ZOS copy of this now?
function LibCraftText.ItemLinkToItemID(itemLink)
    return tonumber(string.match(itemLink,"|H%d:item:(%d+)"))
end

function LibCraftText.ItemIDToItemLink(item_id)
                        -- I have no idea what the non-zero numbers here
                        -- mean, not sure they even matter.
    local template = "|H0:item:%d:24:50:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    return string.format(template, item_id)
end

function LibCraftText.DiscoverItems()
    local self = LibCraftText
    self.saved_var.items = self.saved_var.items or {}
    local items = self.saved_var.items
    local lang  = self.CurrLang()

    local writ1 = {
      ["bs" ] = { 53, 56, 59, 68, 69, 67, 62        -- bs weapons
                , 46, 50, 52, 44, 49, 47, 48 }      -- heavy armor
    , ["lgt"] = { 28, 75, 32, 34, 26, 31, 29, 30 }  -- light armor, including jerkin
    , ["med"] = { 37, 41, 43, 35, 40, 38, 39 }      -- medium armor
    , ["ww" ] = { 70, 72, 73, 74, 71                -- ww weapons
                , 65 }                              -- shield
    , ["jw" ] = { 18, 24 }                          -- necklace, ring
    }
    local template = {
       ["bs" ] = "|H1:item:119563:6:1:0:0:0:%d:188:4:74:8:35:0:0:0:0:0:0:0:0:66000|h|h"
    ,  ["lgt"] = "|H1:item:119694:6:1:0:0:0:%d:194:4:79:14:65:0:0:0:0:0:0:0:0:63000|h|h"
    ,  ["med"] = "|H1:item:119695:6:1:0:0:0:%d:190:4:81:11:62:0:0:0:0:0:0:0:0:61500|h|h"
    ,  ["ww" ] = "|H1:item:119681:6:1:0:0:0:%d:192:4:95:26:34:0:0:0:0:0:0:0:0:529000|h|h"
    ,  ["jw" ] = "|H1:item:138798:6:1:0:0:0:%d:255:4:176:30:0:0:0:0:0:0:0:0:0:656000|h|h"
    }
    local RE = {
       ["bs" ] = { en = "Craft a Rubedite ([^;]*);"
                 , de = "Stellt ein[eniga]* Rubedit(.*) mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez [unedes]* (.*) en cuprite;"
                 , ru = "Создать предмет %(Rubedite ([^;]*)%);"
                 , es = "Fabricar: (.*) de rubedita;"
                 , it = "Crea un ([^;]*);"
                 , ja = "Craft a ルベダイトの([^;]*);"
                 }
    ,  ["lgt"] = { en = "Craft an Ancestor Silk ([^;]*);"
                 , de = "Stellt ein[eniga]* Ahnenseiden(.*) mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez [unedes]* (.*) en soie ancestrales?;"
                 , ru = "Создать предмет %(Ancestor Silk ([^;]*)%);"
                 , es = "Fabricar: (.*) de seda ancestral;"
                 , it = "Crea un ([^;]*);"
                 , ja = "Craft a 先人のシルクの([^;]*);"
                 }
    ,  ["med"] = { en = "Craft a Rubedo Leather ([^;]*);"
                 , de = "Stellt ein[eniga]* Rubedoleder(.*) mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez [unedes]* (.*) en cuir pourpres?;"
                 , ru = "Создать предмет %(Rubedo Leather ([^;]*)%);"
                 , es = "Fabricar: (.*) de cuero rubedo;"
                 , it = "Crea un ([^;]*);"
                 , ja = "Craft a ルベドレザーの([^;]*);"
                 }
    ,  ["ww" ] = { en = "Craft a Ruby Ash ([^;]*);"
                 , de = "Stellt ein[eniga]* Rubineschen(.*) mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez [unedes]* (.*) en frêne roux;"
                 , ru = "Создать предмет %(Ruby Ash ([^;]*)%);"
                 , es = "Fabricar: (.*) de \t?fresno rubí;"
                 , it = "Crea un ([^;]*);"
                 , ja = "Craft a ルビーアッシュの([^;]*);"
                 }
    ,  ["jw" ] = { en = "Craft a platinum ([^;]*);"
                 , de = "Stellt ein[eniga]* Platin(.*) mit bestimmten Eigenschaften her."
                 , fr = "Fabriquez [unedes]* (.*) en platine;"
                 , ru = "Создать предмет %(platinum ([^;]*)%);"
                 , es = "Fabricar: (.*) de platino;"
                 , it = "Crea un ([^;]*);"
                 , ja = "Craft a プラチナの([^;]*);"
                 }
    }

    for weight, list in pairs(writ1)  do
        items[weight] = items[weight] or {}
        items[weight][lang] = {}
        for i,item_num in ipairs(writ1[weight]) do
            local item_link = template[weight]:format(item_num)
            local b = GenerateMasterWritBaseText(item_link)
            local re = RE[weight][lang] or RE[weight].en
            local f = nil
            if re then
                _,_,f = string.find(b,re)
            end
            table.insert(items[weight][lang], f or b)
        end
    end
end

function LibCraftText.DiscoverQualities()
    local self = LibCraftText
    self.saved_var.qualities = self.saved_var.qualities or {}
    local qualities = self.saved_var.qualities
    local lang  = self.CurrLang()

    local template = "|H1:item:138798:6:1:0:0:0:24:255:%d:176:30:0:0:0:0:0:0:0:0:0:656000|h|h"

    local RE = { en = "Quality: ([^;]*);"
               , de = "Qualität: ([^;]*)"
               , fr = "Qualité : ([^;]*)"
               , ru = "качество: ([^;]*);"
               , es = "Calidad: ([^;]*);"
               , it = "Qualità: ([^;]*);"
               , ja = "Quality: ([^;]*);"
               }

    qualities[lang] = {}
    for quality_num = 1,5 do
        local item_link = template:format(quality_num)
        local b = GenerateMasterWritBaseText(item_link)
        local re = RE[lang] or RE.en
        local f = nil
        if re then
            _,_,f = string.find(b,re)
        end
        table.insert(qualities[lang], f or b)
    end
end

function LibCraftText.DiscoverTraits()
    local self = LibCraftText
    self.saved_var.traits = self.saved_var.traits or {}
    local traits = self.saved_var.traits
    local lang  = self.CurrLang()

    local writ5 = {
      weapon  = {   1,  2,  3,  4,  5,  6,  7,  8, 26 }
    , armor   = {  11, 12, 13, 14, 15, 16, 17, 18, 25 }
    , jewelry = {  22, 21, 23, 30, 33, 32, 28, 29, 31 }
    }
    local template = {
        weapon  = "|H1:item:119563:6:1:0:0:0:53:188:4:74:%d:35:0:0:0:0:0:0:0:0:66000|h|h"
    ,   armor   = "|H1:item:119694:6:1:0:0:0:28:194:4:79:%d:65:0:0:0:0:0:0:0:0:63000|h|h"
    ,   jewelry = "|H1:item:138798:6:1:0:0:0:24:255:4:176:%d:0:0:0:0:0:0:0:0:0:656000|h|h"
    }

    local RE = { en = "Trait: ([^;]*);"
               , de = "Eigenschaft: ([^;\n]*)\n"
               , fr = "Trait : ([^;]*);"
               , ru = "особенность: ([^;]*);"
               , es = "Rasgo: ([^;]*);"
               , it = "Tratti: ([^;]*);"
               , ja = "Trait: ([^;]*);"
               }

    for ttype, trait_list in pairs(writ5)  do
        for i,trait_num in ipairs(trait_list) do
            local item_link = template[ttype]:format(trait_num)
            local b = GenerateMasterWritBaseText(item_link)
            local re = RE[lang] or RE.en
            local _,_,f = string.find(b,re)
            if f then
                traits[trait_num] = traits[trait_num] or {}
                traits[trait_num][lang] = f
            else
                traits[0] = traits[0] or {}
                traits[0][lang] = b
            end
        end
    end
end

function LibCraftText.DiscoverSets()
    local self = LibCraftText
    self.saved_var.sets = self.saved_var.sets or {}
    local sets = self.saved_var.sets
    local lang  = self.CurrLang()

                        -- writ4
    local template = "|H1:item:119563:6:1:0:0:0:53:188:4:%d:8:35:0:0:0:0:0:0:0:0:66000|h|h"

    local RE = { en = "Set: ([^;]*);"
               , de = "Set: ([^;\n]*)\n"
               , fr = "Ensemble : ([^;]*);"
               , ru = "комплект: ([^;]*);"
               , es = "Conjunto: ([^;]*);"
               , it = "Set: ([^;]*)"
               , ja = "Set: ([^;]*);"
               }

    for set_num = 1,500 do
        local item_link = template:format(set_num)
        local b = GenerateMasterWritBaseText(item_link)
        local re = RE[lang] or RE.en
        local _,_,f = string.find(b,re)
        if f then
            sets[set_num] = sets[set_num] or {}
            sets[set_num][lang] = f
        else
            sets[0] = sets[0] or {}
            sets[0][lang] = b
        end
    end

end

function LibCraftText.DiscoverMotifs()
    local self = LibCraftText
    self.saved_var.motifs = self.saved_var.motifs or {}
    local motifs = self.saved_var.motifs
    local lang   = self.CurrLang()

                        -- writ6
    local template = "|H1:item:119563:6:1:0:0:0:53:188:4:178:8:%d:0:0:0:0:0:0:0:0:66000|h|h"

    local RE = { en = "Style: ([^;]*)"
               , de = "Stil: ([^;\n]*)\n"
               , fr = "Style : ([^;]*)"
               , ru = "стиль: ([^;]*)"
               , es = "Estilo: ([^;]*)"
               , it = "Stile: ([^;\n]*)"  -- Italian master writ base text lacks VALUES after the "Stile" label. Grr.
               , ja = "Style: ([^;]*)"
               }

    for motif_num = 1,100 do
        local item_link = template:format(motif_num)
        local b = GenerateMasterWritBaseText(item_link)
        local re = RE[lang] or RE.en
        local _,_,f = string.find(b,re)
        if f then
            motifs[motif_num] = motifs[motif_num] or {}
            motifs[motif_num][lang] = f
        else
            motifs[0] = motifs[0] or {}
            motifs[0][lang] = b
        end
    end
end

                        -- I don't want to store 2339 (!) recipe names, in 7
                        -- different languagess. That will make SavedVariables
                        -- huge, probably megabytes huge. Just store the few
                        -- dozen recipe names that we actually want.

local RECIPE_NAMES_EN = {
  "Aetherial Tea"                   -- 9 31
, "Alik'r Beets with Goat Cheese"   -- 3 13
, "Baked Apples"
, "Baked Potato"
, "Banana Surprise"
, "Barley Nectar"
, "Battaglir Chowder"
, "Bitterlemon Tea"
, "Bog-Iron Ale"
, "Breton Pork Sausage"
, "Carrot Soup"
, "Chicken Breast"
, "Chorrol Corn on the Cob"
, "Cinnamon Grape Jelly"
, "Clarified Syrah Wine"
, "Comely Wench Whiskey"
, "Cyrodilic Cornbread"
, "Cyrodilic Pumpkin Fritters"
, "Elinhir Roast Antelope"
, "Eltheric Hooch"
, "Firsthold Fruit and Cheese Plate"
, "Fishy Stick"
, "Four-Eye Grog"
, "Garlic Mashed Potatoes"
, "Garlic Pumpkin Seeds"
, "Ginger Wheat Beer"
, "Gods-Blind-Me"
, "Golden Lager"
, "Gossamer Mazte"
, "Grandpa's Bedtime Tonic"
, "Grape Preserves"
, "Hagraven's Tonic"
, "Hare in Garlic Sauce"
, "Hearty Garlic Corn Chowder"
, "Honey Rye"
, "Jerall View Inn Carrot Cake"
, "Lemon Flower Mazte"
, "Lilmoth Garlic Hagfish"
, "Mammoth Snout Pie"
, "Maormer Tea"
, "Markarth Mead"
, "Mazte"
, "Mermaid Whiskey"
, "Millet-Stuffed Pork Loin"
, "Mulled Wine"
, "Muthsera's Remorse"
, "Nereid Wine"
, "Nibenese Garlic Carrots"
, "Nut Brown Ale"
, "Orcrest Garlic Apple Jelly"
, "Pellitine Tomato Rice"
, "Red Rye Beer"
, "Redoran Peppered Melon"
, "Roast Corn"
, "Rye-in-Your-Eye"
, "Seaflower Tea"
, "Senchal Curry Fish and Rice"
, "Sorry, Honey Lager"
, "Sour Mash"
, "Spiceberry Chai"
, "Spiced Mazte"
, "Stormhold Baked Bananas"
, "Surilie Syrah Wine"
, "Torval Mint Tea"
, "Treacleberry Tea"
, "Two-Zephyr Tea"
, "Venison Pasty"
, "West Weald Corn Chowder"
, "Whiterun Cheese-Baked Trout"


}
function LibCraftText.DiscoverRecipes()
    local self   = LibCraftText
    local lang   = self.CurrLang()

    self.saved_var.recipes = self.saved_var.recipes or {}
    local recipes = self.saved_var.recipes

                        -- Running in EN English?  Now would be the time to
                        -- take that long list of EN English food names and
                        -- look up their recipe and food item_id, record to
                        -- SavedVariables so that other languages can use those
                        -- indexes.
    if lang == "en" then
        -- self.saved_var.recipes = {}
        -- recipes = self.saved_var.recipes
                        -- Build an index of EN names for fast lookup
        local name_to_recipe = {}
        local want_recipe_ct = 0
        for _,name in ipairs(RECIPE_NAMES_EN) do
            name_to_recipe[name:lower()] = {}
            want_recipe_ct = want_recipe_ct + 1
        end

                        -- Scan every single recipe from every single
                        -- recipe book. This goes surprisingly fast.
        local found_recipe_ct = 0
        local seen_recipe_ct  = 0
        local recipe_list_ct = GetNumRecipeLists()
        for rl_index = 1,recipe_list_ct do
            local rl_info   = {GetRecipeListInfo(rl_index)}
            local rl_name   = rl_info[1]
            local recipe_ct = rl_info[2]
            for recipe_i = 1,recipe_ct do
                local food_info = {GetRecipeResultItemInfo(rl_index, recipe_i)}
                local food_name = Decaret(food_info[1])
                if food_name then
                    seen_recipe_ct = seen_recipe_ct + 1
                end
                local r         = name_to_recipe[food_name:lower()]
                if r then
                    r.recipe_list_index = rl_index
                    r.recipe_index      = recipe_i
                    r.name              = r.name or {}
                    r.name.en           = food_name

                    local link          = GetRecipeResultItemLink(rl_index, recipe_i )
                    local item_id       = self.ItemLinkToItemID(link)
                    recipes[item_id]    = r
                    found_recipe_ct     = found_recipe_ct + 1
                end
            end
        end

        Info(string.format( "EN recipes  want:%d  found:%d  seen:%d"
                          , want_recipe_ct
                          , found_recipe_ct
                          , seen_recipe_ct
                          ))
        if found_recipe_ct < want_recipe_ct then
            Error("Missing some recipes!")
            for _,name in ipairs(RECIPE_NAMES_EN) do
                local r = name_to_recipe[name]
                if not (r and r.name) then
                    Error(name)
                end
            end
        end
    end
                        -- For ALL languages, collect food names.
                        -- Assumes that you
    local recorded_ct = 0
    self.saved_var.recipes = self.saved_var.recipes or {}
    for food_item_id,recipe in pairs(self.saved_var.recipes) do
        local food_info = {GetRecipeResultItemInfo( recipe.recipe_list_index
                                                  , recipe.recipe_index
                                                  )}
        local food_name     = food_info[1]
        recipe.name[lang]   = Decaret(food_name)
        recorded_ct         = recorded_ct + 1
    end
    if recorded_ct <= 0 then
        Error("Cannot scan recipes. Start in EN English.")
    end
end

function LibCraftText.RegisterCraftingStationListener()
    EVENT_MANAGER:RegisterForEvent(
              LibCraftText.name
            , EVENT_CRAFTING_STATION_INTERACT
            , LibCraftText.OnCraftingStationInteract
            )
end
                        -- This table must come AFTER any function it lists.
function LibCraftText.OnCraftingStationInteract(event_code, crafting_type, same_station)
    local self = LibCraftText

    local OCSI_Func = {
        [bs] = LibCraftText.DiscoverCraftingStationGear
    ,   [cl] = LibCraftText.DiscoverCraftingStationGear
    ,   [en] = LibCraftText.DiscoverCraftingStationEnchanting
    ,   [ww] = LibCraftText.DiscoverCraftingStationGear
    ,   [jw] = LibCraftText.DiscoverCraftingStationGear
    ,   [al] = LibCraftText.DiscoverCraftingStationAlchemy
    }

    local func = OCSI_Func[crafting_type]
    if func then
        func(crafting_type)

    end
end

function Decaret(str)
    return zo_strformat("<<1>>", str)
end

                        -- material count for a level 1 version of each of the
                        -- 14 or so patterns at each equipment crafting
                        -- station.
LibCraftText.STATION_API_INPUT = {
    [bs] = { 3, 3, 3, 5, 5, 5, 2,      7, 5, 5, 5, 6, 5, 5 }
,   [cl] = { 7, 7, 5, 5, 5, 6, 5, 5,   7, 5, 5, 5, 6, 5, 5 }
,   [ww] = { 3, 6, 3, 3, 3, 3 }
,   [jw] = { 2, 3 }
}
function LibCraftText.DiscoverCraftingStationGear(crafting_type)
    local self = LibCraftText
    local mat_ct_list = self.STATION_API_INPUT[crafting_type]
    if not mat_ct_list then return end

    self.saved_var.items_from_stations = self.saved_var.items_from_stations or {}
    local sv = self.saved_var.items_from_stations
    sv[crafting_type] = sv[crafting_type] or {}
    local lang = self.CurrLang()

    local RE = {
        [bs] = {   en = { "iron (.*)" }
               ,   de = { "Eisen(.*)" }
               ,   fr = { "(.*) en fer" }
               ,   es = { "(.*) de hierro" }
               ,   it = { "(.*)" }
               ,   ru = { "iron (.*)" }
               ,   ja = { "鉄の(.*)" }
               }
      , [cl] = {   en = { "homespun (.*)"       , "rawhide (.*)"        }
               ,   de = { "Jute(.*)"            , "Rohleder(.*)"        }
               ,   fr = { "(.*) artisana"       , "(.*) en cuir"        }
               ,   es = { "(.*) de tejido "     , "(.*) de piel cruda"  }
               ,   it = { "(.*)"                                        }
               ,   ru = { "homespun (.*)"       , "rawhide (.*)"        }
               ,   ja = { "手織り布の(.*)"       , "生皮の(.*)"           }
               }
      , [ww] = {   en = { "maple (.*)" }
               ,   de = { "Ahorn(.*)" }
               ,   fr = { "(.*) en érable" }
               ,   es = { "(.*) de arce" }
               ,   it = { "(.*)" }
               ,   ru = { "maple (.*)" }
               ,   ja = { "カエデの(.*)" }
               }
      , [jw] = {   en = { "pewter (.*)" }
               ,   de = { "Zinn(.*)" }
               ,   fr = { "(.*) en étain" }
               ,   es = { "(.*) de peltre" }
               ,   it = { "(.*)" }
               ,   ru = { "pewter (.*)" }
               ,   ja = { "ピューターの(.*)" }
               }
    }
    local re_list   = RE[crafting_type][lang]

    for pattern_index, mat_ct in ipairs(mat_ct_list) do
        local item_link = GetSmithingPatternResultLink( pattern_index
                                                      , 1
                                                      , mat_ct
                                                      , 1
                                                      )
        local item_name = GetItemLinkName(item_link)
        item_name       = Decaret(item_name)
        local f = nil
        for _,re in ipairs(re_list) do
            _,_,f = string.find(item_name,re)
            if f then break end
        end
        sv[crafting_type][pattern_index] = sv[crafting_type][pattern_index] or {}
        sv[crafting_type][pattern_index][lang] = f or ("!!! "..item_name)
if f then
    Info(tostring(f))
else
    Error("!!! '"..tostring(item_name).."'' no match re:"..table.concat(re_list,", "))
end

    end
end



function LibCraftText.DiscoverCraftingStationAlchemy(crafting_type)
    local self = LibCraftText
    local cm = LibCraftText.CONSUMABLE_MATERIAL -- for less typing

    local POISON = "poison"
    local POTION = "potion"

    local SOLVENT = {
                      [POTION] = cm.NATURAL_WATER
                    , [POISON] = cm.GREASE
                    }
    local REAGENT = {
          ["Health"        ] = { cm.BLUE_ENTOLOMA    , cm.BUTTERFLY_WING }
        , ["Magicka"       ] = { cm.BUGLOSS          , cm.CORN_FLOWER    }
        , ["Stamina"       ] = { cm.BLESSED_THISTLE  , cm.COLUMBINE      }
        , ["Ravage Health" ] = { cm.BLESSED_THISTLE  , cm.CORN_FLOWER    }
        , ["Ravage Magicka"] = { cm.BLUE_ENTOLOMA    , cm.SCRIB_JELLY    }
        , ["Ravage Stamina"] = { cm.EMETIC_RUSSULA   , cm.FLESHFLY_LARVA }
        }
    local lang = self.CurrLang()
    self.IndexBags()
    self.saved_var.alchemy = self.saved_var.alchemy or {}
    for solvent_key,solvent in pairs(SOLVENT) do
        self.saved_var.alchemy[solvent_key] = self.saved_var.alchemy[solvent_key] or {}
        local sol_mat_bag = self.ToMatBag(solvent)
        for reagent_key, reagent_list in pairs(REAGENT) do
            local r1_mat_bag = self.ToMatBag(reagent_list[1])
            local r2_mat_bag = self.ToMatBag(reagent_list[2])
            local args = { sol_mat_bag.bag_id, sol_mat_bag.slot_id
                         , r1_mat_bag.bag_id , r1_mat_bag.slot_id
                         , r2_mat_bag.bag_id , r2_mat_bag.slot_id
                         }
            local potion_name = GetAlchemyResultingItemInfo(unpack(args))
            potion_name = Decaret(potion_name)

                        -- Potion/Poison name
            local RE_POTION  = {
                                   en = { "sip of (.*)"
                                        , "(.*) poison i" }
                               ,   de = { "schlückchen [ders]+ (.*)"
                                        , "gift [ders]+ (.*) i" }
                               ,   fr = { "gorgée de (.*)"
                                        , "poison de (.*) i" }
                               ,   es = { "sorbo de (.*)"
                                        , "veneno de (.*) i" }
                               ,   it = { "(.*)"
                                        , "(.*) poison" }
                               ,   ru = { "sip of (.*)"
                                        , "(.*) poison i" }
                               ,   ja = { "(.*) の雫"
                                        , "(.*)の毒 1" }
                               }


            local name = potion_name
            local found = nil
            for _,re in ipairs(RE_POTION[lang]) do
                local _,_,f = string.find(potion_name:lower(), re)
                if f then
                    found = f
                end
            end
            if found then
                name = found
            else
                Error(string.format("potion name '%s'",name))
            end
            self.saved_var.alchemy[solvent_key][reagent_key]
                = self.saved_var.alchemy[solvent_key][reagent_key] or {}
            self.saved_var.alchemy[solvent_key][reagent_key][lang] = name
        end
    end

        -- local solvent_name = nil
    local RANK_SOLVENT = {
                           { cm.NATURAL_WATER  , cm.GREASE        }
                         , { cm.CLEAR_WATER    , cm.ICHOR         }
                         , { cm.PRISTINE_WATER , cm.SLIME         }
                         , { cm.CLEANSED_WATER , cm.GALL          }
                         , { cm.FILTERED_WATER , cm.TEREBINTHINE  }
                         , { cm.PURIFIED_WATER , cm.PITCH_BILE    }
                         , { cm.CLOUD_MIST     , cm.TARBLACK      }
                         , { cm.STAR_DEW       , cm.NIGHT_OIL     }
                         , { cm.LORKHANS_TEARS , cm.ALKAHEST      }
                         }
    local key_sol = {"potion", "poison"}
    local r1_mat_bag = self.ToMatBag(cm.BLUE_ENTOLOMA)
    local r2_mat_bag = self.ToMatBag(cm.BUTTERFLY_WING)
    for i,sol_pair in pairs(RANK_SOLVENT) do
        for potion_poison_i, solvent in ipairs(sol_pair) do
            key = key_sol[potion_poison_i]
            sol_mat_bag = self.ToMatBag(solvent)

            local args = { sol_mat_bag.bag_id, sol_mat_bag.slot_id
                         , r1_mat_bag.bag_id , r1_mat_bag.slot_id
                         , r2_mat_bag.bag_id , r2_mat_bag.slot_id
                         }
            local potion_name = GetAlchemyResultingItemInfo(unpack(args))
            potion_name = Decaret(potion_name)

                        -- Essence/Poison IX
            local RE_SOLVENT = {
                                   en = { "(.*) of health"
                                        , "drain health poison (.*)" }
                               ,   de = { "(.*) des lebens"
                                        , "gift des lebensentzugs (.*)" }
                               ,   fr = { "(.*) de santé"
                                        , "poison de drain de santé (.*)" }
                               ,   es = { "(.*) de salud"
                                        , "veneno de absorción de vida (.*)" }
                                        -- Italian lacks "Essence" or "IX" rank
                                        -- words. Potion name is just "Health".
                               ,   it = { "(.*) of health"
                                        , "drain health poison (.*)" }
                               ,   ru = { "(.*) of health"
                                        , "drain health poison (.*)" }
                               ,   ja = { "体力 の(.*)"
                                        , "(.*):体力"
                                        , "体力吸収の毒 (.*)" }
                               }

            local name = potion_name
            local found = nil
            for _,re in ipairs(RE_SOLVENT[lang]) do
                local _,_,f = string.find(potion_name:lower(), re)
                if f then
                    found = f
                end
            end
            if found then
                name = found
            else
                Error(string.format("solvent name '%s'",name))
            end
            self.saved_var.alchemy.solvent = self.saved_var.alchemy.solvent or {}
            self.saved_var.alchemy.solvent[key]
                = self.saved_var.alchemy.solvent[key] or {}
            self.saved_var.alchemy.solvent[key][i]
                = self.saved_var.alchemy.solvent[key][i] or {}
            self.saved_var.alchemy.solvent[key][i][lang] = name
        end
    end

                        -- Dump all 4 traits of all 28 reagents.
                        -- Not used for lang_db, but helpful to know when
                        -- adding new traits or reagents to the db.
                        --
                        -- Useful only in english, so not bothering to
                        -- break out into [lang] sub tables.
    local ALL_REAGENTS = {
                 cm.BLESSED_THISTLE
               , cm.BLUE_ENTOLOMA
               , cm.BUGLOSS
               , cm.COLUMBINE
               , cm.CORN_FLOWER
               , cm.DRAGONTHORN
               , cm.EMETIC_RUSSULA
               , cm.IMP_STOOL
               , cm.LADYS_SMOCK
               , cm.LUMINOUS_RUSSULA
               , cm.MOUNTAIN_FLOWER
               , cm.NAMIRAS_ROT
               , cm.NIRNROOT
               , cm.STINKHORN
               , cm.VIOLET_COPRINUS
               , cm.WATER_HYACINTH
               , cm.WHITE_CAP
               , cm.WORMWOOD
               , cm.BEETLE_SCUTTLE
               , cm.BUTTERFLY_WING
               , cm.FLESHFLY_LARVA
               , cm.MUDCRAB_CHITIN
               , cm.NIGHTSHADE
               , cm.SCRIB_JELLY
               , cm.SPIDER_EGG
               , cm.TORCHBUG_THORAX
               , cm.CLAM_GALL
               , cm.POWDERED_MOTHER_OF_PEARL
               }
    self.saved_var.alchemy.reagent_traits = self.saved_var.alchemy.reagent_traits or {}
    local template = "|H1:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    for i,t in ipairs(ALL_REAGENTS) do
        self.saved_var.alchemy.reagent_traits[i] = self.saved_var.alchemy.reagent_traits[i] or {}
        self.saved_var.alchemy.reagent_traits[i].name = t.name
        for ti = 1,4 do
            local link = template:format(t.item_id)
            _,name = GetItemLinkReagentTraitInfo(link, ti)
            self.saved_var.alchemy.reagent_traits[i][ti] = name
        end
    end

                        -- Discover trait names in all languages.
                        --
                        -- I assume/hope that traits don't move around within
                        -- their 4 slots of a reagent.
    local TRAITS_K = {
              [ 1] = { index= 1, reagent=cm.BLUE_ENTOLOMA    , trait_index=3 } -- Restore Health
            , [ 2] = { index= 2, reagent=cm.BLESSED_THISTLE  , trait_index=3 } -- Ravage Health
            , [ 3] = { index= 3, reagent=cm.BUGLOSS          , trait_index=4 } -- Restore Magicka
            , [ 4] = { index= 4, reagent=cm.BLUE_ENTOLOMA    , trait_index=1 } -- Ravage Magicka
            , [ 5] = { index= 5, reagent=cm.BLESSED_THISTLE  , trait_index=1 } -- Restore Stamina
            , [ 6] = { index= 6, reagent=cm.EMETIC_RUSSULA   , trait_index=3 } -- Ravage Stamina
            , [ 7] = { index= 7, reagent=cm.BUGLOSS          , trait_index=1 } -- Increase Spell Resist
            , [ 8] = { index= 8, reagent=cm.LADYS_SMOCK      , trait_index=3 } -- Breach
            , [ 9] = { index= 9, reagent=cm.IMP_STOOL        , trait_index=3 } -- Increase Armor
            , [10] = { index=10, reagent=cm.DRAGONTHORN      , trait_index=3 } -- Fracture
            , [11] = { index=11, reagent=cm.CORN_FLOWER      , trait_index=2 } -- Increase Spell Power
            , [12] = { index=12, reagent=cm.BLUE_ENTOLOMA    , trait_index=2 } -- Cowardice
            , [13] = { index=13, reagent=cm.BLESSED_THISTLE  , trait_index=2 } -- Increase Weapon Power
            , [14] = { index=14, reagent=cm.IMP_STOOL        , trait_index=1 } -- Maim
            , [15] = { index=15, reagent=cm.LADYS_SMOCK      , trait_index=4 } -- Spell Critical
            , [16] = { index=16, reagent=cm.NIRNROOT         , trait_index=2 } -- Uncertainty
            , [17] = { index=17, reagent=cm.DRAGONTHORN      , trait_index=4 } -- Weapon Critical
            , [18] = { index=18, reagent=cm.IMP_STOOL        , trait_index=4 } -- Enervation
            , [19] = { index=19, reagent=cm.COLUMBINE        , trait_index=4 } -- Unstoppable
            , [20] = { index=20, reagent=cm.EMETIC_RUSSULA   , trait_index=4 } -- Entrapment
            , [21] = { index=21, reagent=cm.CORN_FLOWER      , trait_index=4 } -- Detection
            , [22] = { index=22, reagent=cm.BLUE_ENTOLOMA    , trait_index=4 } -- Invisible
            , [23] = { index=23, reagent=cm.BLESSED_THISTLE  , trait_index=4 } -- Speed
            , [24] = { index=24, reagent=cm.LUMINOUS_RUSSULA , trait_index=4 } -- Hindrance
            , [25] = { index=25, reagent=cm.BEETLE_SCUTTLE   , trait_index=3 } -- Protection
            , [26] = { index=26, reagent=cm.FLESHFLY_LARVA   , trait_index=2 } -- Vulnerability
            , [27] = { index=27, reagent=cm.BUTTERFLY_WING   , trait_index=3 } -- Lingering Health
            , [28] = { index=28, reagent=cm.FLESHFLY_LARVA   , trait_index=3 } -- Gradual Ravage Health
            , [29] = { index=29, reagent=cm.BEETLE_SCUTTLE   , trait_index=4 } -- Vitality
            , [30] = { index=30, reagent=cm.NIGHTSHADE       , trait_index=4 } -- Defile
            }
    self.saved_var.alchemy.trait = self.saved_var.alchemy.trait or {}
    local template = "|H1:item:%d:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    for i,t in ipairs(TRAITS_K) do
        local link = template:format(t.reagent.item_id)
        _,name = GetItemLinkReagentTraitInfo(link, t.trait_index)
        self.saved_var.alchemy.trait[i] = self.saved_var.alchemy.trait[i] or {}
        self.saved_var.alchemy.trait[i][lang] = name
    end

                        -- Discover item names and links for single-trait potions and poisons.
                        -- Their item NAMES will match master writ "Damage Health Poison IX"
                        --
                        -- So this same iteration might be useful

    -- potion: "|H0:item:54339:30:3:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:65536|h|h",
    -- poison: "|H0:item:76826:30:3:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:65536|h|h",
    --                    ^ varies by effect                           ^ identifies potion traits
    --
    local TRAITS = {
              [ 1] = { index= 1, reagent_list={cm.WATER_HYACINTH    , cm.BLUE_ENTOLOMA                          }} -- Restore Health
            , [ 2] = { index= 2, reagent_list={cm.VIOLET_COPRINUS   , cm.NIRNROOT                               }} -- Ravage Health
            , [ 3] = { index= 3, reagent_list={cm.LADYS_SMOCK       , cm.BUGLOSS                                }} -- Restore Magicka
            , [ 4] = { index= 4, reagent_list={cm.VIOLET_COPRINUS   , cm.WHITE_CAP                              }} -- Ravage Magicka
            , [ 5] = { index= 5, reagent_list={cm.DRAGONTHORN       , cm.MOUNTAIN_FLOWER                        }} -- Restore Stamina
            , [ 6] = { index= 6, reagent_list={cm.FLESHFLY_LARVA    , cm.IMP_STOOL                              }} -- Ravage Stamina
            , [ 7] = { index= 7, reagent_list={cm.WHITE_CAP         , cm.CLAM_GALL                              }} -- Spell Resistance
            , [ 8] = { index= 8, reagent_list={cm.BEETLE_SCUTTLE    , cm.VIOLET_COPRINUS                        }} -- Breach
            , [ 9] = { index= 9, reagent_list={cm.MUDCRAB_CHITIN    , cm.IMP_STOOL                              }} -- Increase Armor
            , [10] = { index=10, reagent_list={cm.TORCHBUG_THORAX   , cm.DRAGONTHORN                            }} -- Fracture
            , [11] = { index=11, reagent_list={cm.VIOLET_COPRINUS   , cm.LADYS_SMOCK        , cm.MUDCRAB_CHITIN }} -- Increase Spell Power
            , [12] = { index=12, reagent_list={cm.BLUE_ENTOLOMA     , cm.BLESSED_THISTLE    , cm.BUGLOSS        }} -- Cowardice
            , [13] = { index=13, reagent_list={cm.DRAGONTHORN       , cm.STINKHORN          , cm.BEETLE_SCUTTLE }} -- Increase Weapon Power
            , [14] = { index=14, reagent_list={cm.MOUNTAIN_FLOWER   , cm.LUMINOUS_RUSSULA   , cm.NIRNROOT       }} -- Maim
            , [15] = { index=15, reagent_list={cm.NAMIRAS_ROT       , cm.WATER_HYACINTH                         }} -- Spell Critical
            , [16] = { index=16, reagent_list={cm.BUTTERFLY_WING    , cm.NIRNROOT                               }} -- Uncertainty
            , [17] = { index=17, reagent_list={cm.DRAGONTHORN       , cm.WATER_HYACINTH                         }} -- Weapon Critical
            , [18] = { index=18, reagent_list={cm.IMP_STOOL         , cm.NIRNROOT                               }} -- Enervation
            , [19] = { index=19, reagent_list={cm.NAMIRAS_ROT       , cm.COLUMBINE                              }} -- Unstoppable
            , [20] = { index=20, reagent_list={cm.EMETIC_RUSSULA    , cm.WATER_HYACINTH                         }} -- Entrapment
            , [21] = { index=21, reagent_list={cm.CORN_FLOWER       , cm.WHITE_CAP                              }} -- Detection
            , [22] = { index=22, reagent_list={cm.BLUE_ENTOLOMA     , cm.NIRNROOT                               }} -- Invisible
            , [23] = { index=23, reagent_list={cm.BLESSED_THISTLE   , cm.NAMIRAS_ROT                            }} -- Speed
            , [24] = { index=24, reagent_list={cm.CLAM_GALL         , cm.LUMINOUS_RUSSULA                       }} -- Hindrance
            , [25] = { index=25, reagent_list={cm.NIGHTSHADE        , cm.BEETLE_SCUTTLE                         }} -- Protection
            , [26] = { index=26, reagent_list={cm.SCRIB_JELLY       , cm.FLESHFLY_LARVA                         }} -- Vulnerability
            , [27] = { index=27, reagent_list={cm.BUTTERFLY_WING    , cm.SPIDER_EGG                             }} -- Lingering Health
            , [28] = { index=28, reagent_list={cm.NIGHTSHADE        , cm.FLESHFLY_LARVA                         }} -- Gradual Ravage Health
            , [29] = { index=29, reagent_list={cm.BUTTERFLY_WING    , cm.TORCHBUG_THORAX                        }} -- Vitality
            , [30] = { index=30, reagent_list={cm.CLAM_GALL         , cm.NIGHTSHADE                             }} -- Defile
            }
    local potion_mat_bag = self.ToMatBag(cm.LORKHANS_TEARS)
    local poison_mat_bag = self.ToMatBag(cm.ALKAHEST      )

    self.saved_var.alchemy.link  = self.saved_var.alchemy.link or {}
    local saved_var_link         = self.saved_var.alchemy.link -- for less typing
    saved_var_link.potion        = saved_var_link.potion or {}
    saved_var_link.poison        = saved_var_link.poison or {}
    saved_var_link.master_potion = saved_var_link.master_potion or {}
    saved_var_link.master_poison = saved_var_link.master_poison or {}
    for i,trait in ipairs(TRAITS) do
        local r1_mat_bag = self.ToMatBag(trait.reagent_list[1])
        local r2_mat_bag = self.ToMatBag(trait.reagent_list[2])
        local r3_mat_bag = self.ToMatBag(trait.reagent_list[3]) or {}
        local args = { potion_mat_bag.bag_id, potion_mat_bag.slot_id
                     , r1_mat_bag.bag_id    , r1_mat_bag.slot_id
                     , r2_mat_bag.bag_id    , r2_mat_bag.slot_id
                     , r3_mat_bag.bag_id    , r3_mat_bag.slot_id
                     }
        local potion_link = GetAlchemyResultingItemLink(unpack(args))
        local potion_name = GetAlchemyResultingItemInfo(unpack(args))

        args       = { poison_mat_bag.bag_id, poison_mat_bag.slot_id
                     , r1_mat_bag.bag_id    , r1_mat_bag.slot_id
                     , r2_mat_bag.bag_id    , r2_mat_bag.slot_id
                     , r3_mat_bag.bag_id    , r3_mat_bag.slot_id
                     }
        local poison_link = GetAlchemyResultingItemLink(unpack(args))
        local poison_name = GetAlchemyResultingItemInfo(unpack(args))
        saved_var_link.master_potion[i] = saved_var_link.master_potion[i] or {}
        saved_var_link.master_poison[i] = saved_var_link.master_poison[i] or {}
        saved_var_link.master_potion[i][lang] = potion_name
        saved_var_link.master_poison[i][lang] = poison_name
        saved_var_link.potion[i] = potion_link
        saved_var_link.poison[i] = poison_link

    end
end

function LibCraftText.DiscoverCraftingStationEnchanting(crafting_type)
    local self = LibCraftText
    local lang = self.CurrLang()
                        -- Scan bags EVERY time we interact, just in case
                        -- inventory changed between interactions.
    self.IndexBags()

    local m = self.CONSUMABLE_MATERIAL -- for less typing
    local potency_list = {
        --  rank   add            subtract      level   adjective   writ
            [ 1] = m.JORA    -- , m.JODE            1   trifling    EN_01
            --   , m.PORADE  -- , m.NOTADE          5   inferior
        ,   [ 2] = m.JERA    -- , m.ODE            10   petty       EN_02
            --   , m.JEJORA  -- , m.TADE           15   slight
        ,   [ 3] = m.ODRA    -- , m.JAYDE          20   minor       EN_03
            --   , m.POJORA  -- , m.EDODE          25   lesser
        ,   [ 4] = m.EDORA   -- , m.POJODE         30   moderate    EN_04
            --   , m.JAERA   -- , m.REKUDE         35   average
        ,   [ 5] = m.PORA    -- , m.HADE           40   strong      EN_05
            --   , m.DENARA  -- , m.IDODE        CP10   major
        ,   [ 6] = m.RERA    -- , m.PODE         CP30   greater     EN_06
        ,   [ 7] = m.DERADO  -- , m.KEDEKO       CP50   grand       EN_07
        ,   [ 8] = m.REKURA  -- , m.REDE         CP70   splendid    EN_08
        ,   [ 9] = m.KURA    -- , m.KUDE        CP100   monumental  EN_09
        ,   [10] = m.REJERA  -- , m.JEHADE      CP150   superb      EN_10
            --   , m.REPORA  -- , m.ITADE       CP160   truly superb
        }
    local aspect_list  = { m.TA }


                        -- For extracting "Major" from "Major Glyph of Health"
    local RE_POTENCY = {
        en = { "(.*) glyph of"}
    ,   de = { "(.*) glyphe des"}
    ,   fr = { "glyphe (.*) vital"
             , "(petit) glyphe "}
    ,   es = { "glifo (.*) de vida"}
    ,   it = { "(.*) glyph of"}  -- "glifo of health" for all 10 potencies. Broken.
    ,   ru = { "(.*) glyph of"}
    ,   ja = { "(.*)のグリフ"
             , "(.*)なグリフ"}
    }
                        -- Roll through all 10 Enchanting rank potencies
                        -- that daily crafting writs ask for.
    local essence         = m.OKO
    local essence_mat_bag = self.ToMatBag(essence)
    for _,aspect in ipairs(aspect_list) do
        local aspect_mat_bag  = self.ToMatBag(aspect)
        for _,potency in pairs(potency_list) do
            local potency_name = nil
            local en_info      = self.GetEnchantingInfo(potency, essence, aspect)
            if not en_info then
                Error("Giving up.")
                return
            end
            local name         = en_info.name
            for _,re in ipairs(RE_POTENCY[lang]) do
                local _,_,f = string.find(name:lower(), re)
                if f then
                    potency_name = f
                    break
                end
            end
            if not potency_name then
                potency_name = name:lower()
            end

            local i = potency.item_id
            self.saved_var.potencies = self.saved_var.potencies or {}
            self.saved_var.potencies[i] = self.saved_var.potencies[i] or {}
            self.saved_var.potencies[i][lang] = potency_name
            Info(string.format("potency %2d: %s", i, potency_name))
        end
    end

    local essence_list = { m.DEKEIPA
                         , m.DENI
                         , m.DENIMA
                         , m.DETERI
                         , m.HAOKO
                         , m.HAKEIJO
                         , m.KADERI
                         , m.KUOKO
                         , m.MAKDERI
                         , m.MAKKO
                         , m.MAKKOMA
                         , m.MEIP
                         , m.OKO
                         , m.OKOMA
                         , m.OKORI
                         , m.ORU
                         , m.RAKEIPA
                         , m.TADERI
                         }
                        -- For extracting "Health" from "Trifling Glyph of Health"
    local RE_ESSENCE = {
        en = { "glyph of (.*)"}
    ,   de = { "glyphe de[sr] (.*)"}
    ,   fr = { "glyphe insignifiant (.*)"}
    ,   es = { "glifo mediocre de (.*)"
             ,  "glifo mediocre (.*)" } -- must come AFTER " de " line
    ,   it = { "glifo of (.*)"
             , "glyph of (.*)" }
    ,   ru = { "glyph of (.*)"}
    ,   ja = { "グリフ %((.*)%)"}
    }
    local potency = m.JORA
    local aspect  = m.TA
    for _,essence in ipairs(essence_list) do
        local essence_name = nil
        local en_info      = self.GetEnchantingInfo(potency, essence, aspect)
        if not en_info then
            Error("Giving up.")
            return
        end
        local name         = en_info.name
        for _,re in ipairs(RE_ESSENCE[lang]) do
            local _,_,f = string.find(name:lower(), re)
            if f then
                essence_name = f
                break
            end
        end
        if not essence_name then
            essence_name = name:lower()
        end
        essence_name = Decaret(essence_name)

        local i = essence.item_id
        self.saved_var.essences = self.saved_var.essences or {}
        self.saved_var.essences[i] = self.saved_var.essences[i] or {}
        self.saved_var.essences[i][lang] = essence_name
        Info(string.format("essence %2d: %s", i, essence_name))
    end
end

function LibCraftText.GetEnchantingInfo(mat_potency, mat_essence, mat_aspect)
    local self = LibCraftText
    local essence_mat_bag = self.ToMatBag(mat_essence)
    local aspect_mat_bag  = self.ToMatBag(mat_aspect)
    local potency_mat_bag = self.ToMatBag(mat_potency)

                        -- Must actually have items in inventory
    if not (essence_mat_bag and aspect_mat_bag and potency_mat_bag) then
        Error("Giving up.")
        return
    end
                        -- Get Glyph Link, Name
    local args = { potency_mat_bag.bag_id
                 , potency_mat_bag.slot_id
                 , essence_mat_bag.bag_id
                 , essence_mat_bag.slot_id
                 , aspect_mat_bag.bag_id
                 , aspect_mat_bag.slot_id
             }
    local name = GetEnchantingResultingItemInfo(unpack(args))
    local link = GetEnchantingResultingItemLink(unpack(args))
    if name == "" then
        Error(string.format(
              "Enchanting: character lacks rune knowlege."
              .." Go make some glyphs then try again. %s %s %s"
              , tostring(mat_potency.name)
              , tostring(mat_essence.name)
              , tostring(mat_aspect.name)
              ))
        return nil
    end
    local item_id = self.ItemLinkToItemID(link)
    return { ["item_link"] = link
           , ["name"     ] = name
           , ["item_id"  ] = item_id
           }
end


function LibCraftText.ToMatBag(mat_row)
    if not mat_row then return nil end
    local item_id = mat_row.item_id
    local mat_bag = LibCraftText.item_id_to_mat_bag[item_id]
    if not mat_bag then
        Error("Inventory missing:"..tostring(mat_row.name).."   item_id:"..tostring(mat_row.item_id))
        return nil
    -- else
    --     Info(string.format( "bag_id:%d slot_id:%d item_id:%d %s"
    --                       , mat_bag.bag_id
    --                       , mat_bag.slot_id
    --                       , mat_row.item_id
    --                       , mat_row.name
    --                       ))
    end
    return mat_bag
end

function LibCraftText.IndexBags()
    local self = LibCraftText
    local bag_id_list = { BAG_BACKPACK
                        , BAG_BANK
                        , BAG_SUBSCRIBER_BANK
                        , BAG_VIRTUAL
                        }
    local item_id_to_mat_bag = {}
    for _,bag_id in ipairs(bag_id_list) do
    -- for bag_id = BAG_MIN_VALUE,BAG_MAX_VALUE do
        local slot_id = ZO_GetNextBagSlotIndex(bag_id, nil)
        while slot_id do
            local item_id = GetItemId(bag_id, slot_id, LINK_STYLE_DEFAULT)
            if item_id and 0 < item_id then
                -- local name = GetItemName(bag_id, slot_id)
                -- Info(string.format("%d %d %d %s", bag_id, slot_id, item_id, name))
                item_id_to_mat_bag[item_id] = item_id_to_mat_bag[item_id] or {}
                item_id_to_mat_bag[item_id].bag_id     = bag_id
                item_id_to_mat_bag[item_id].slot_id = slot_id
            end
            slot_id = ZO_GetNextBagSlotIndex(bag_id, slot_id)
        end
    end

    self.item_id_to_mat_bag = item_id_to_mat_bag
end

local m = LibCraftText.CONSUMABLE_MATERIAL -- for less typing
LibCraftText.LEARN_ALCHEMY = {
  { m.BEETLE_SCUTTLE  , m.CORN_FLOWER     , m.LADYS_SMOCK              }
, { m.BEETLE_SCUTTLE  , m.BUTTERFLY_WING  , m.POWDERED_MOTHER_OF_PEARL }
, { m.BEETLE_SCUTTLE  , m.IMP_STOOL       , m.LUMINOUS_RUSSULA         }
, { m.BLESSED_THISTLE , m.DRAGONTHORN     , m.STINKHORN                }
, { m.BLESSED_THISTLE , m.COLUMBINE       , m.NAMIRAS_ROT              }
, { m.BLUE_ENTOLOMA   , m.BUGLOSS         , m.WHITE_CAP                }
, { m.BLUE_ENTOLOMA   , m.CLAM_GALL       , m.SPIDER_EGG               }
, { m.BUGLOSS         , m.COLUMBINE       , m.MOUNTAIN_FLOWER          }
, { m.BLUE_ENTOLOMA   , m.BUTTERFLY_WING  , m.SCRIB_JELLY              }
, { m.BUTTERFLY_WING  , m.NIRNROOT        , m.TORCHBUG_THORAX          }
, { m.CLAM_GALL       , m.MOUNTAIN_FLOWER , m.MUDCRAB_CHITIN           }
, { m.CLAM_GALL       , m.EMETIC_RUSSULA  , m.FLESHFLY_LARVA           }
, { m.CORN_FLOWER     , m.MUDCRAB_CHITIN  , m.NIGHTSHADE               }
, { m.CORN_FLOWER     , m.TORCHBUG_THORAX , m.VIOLET_COPRINUS          }
, { m.COLUMBINE       , m.DRAGONTHORN     , m.WATER_HYACINTH           }
, { m.EMETIC_RUSSULA  , m.NAMIRAS_ROT     , m.NIRNROOT                 }
, { m.EMETIC_RUSSULA  , m.VIOLET_COPRINUS , m.WATER_HYACINTH           }
, { m.FLESHFLY_LARVA  , m.NIGHTSHADE      , m.STINKHORN                }
, { m.FLESHFLY_LARVA  , m.SCRIB_JELLY     , m.POWDERED_MOTHER_OF_PEARL }
, { m.IMP_STOOL       , m.MOUNTAIN_FLOWER , m.NIRNROOT                 }
, { m.LADYS_SMOCK     , m.NAMIRAS_ROT     , m.VIOLET_COPRINUS          }
, { m.COLUMBINE       , m.WORMWOOD        , m.LUMINOUS_RUSSULA         }
, { m.CLAM_GALL       , m.SCRIB_JELLY     , m.SPIDER_EGG               }
, { m.DRAGONTHORN     , m.TORCHBUG_THORAX , m.WHITE_CAP                }
, { m.LADYS_SMOCK     , m.WATER_HYACINTH  , m.WORMWOOD                 }
, { m.EMETIC_RUSSULA  , m.WHITE_CAP       , m.WORMWOOD                 }
}
m = nil

                        -- Mix 26 potions to learn all 30 traits across 28
                        -- reagents. You only need to do this once after
                        -- a PTS reset.
                        --
                        -- I assume you already have Alchemy skill
                        -- "Laboratory Use" to permit 3-reagent potions.
                        -- Unknown results if not.
function LibCraftText.LearnAllAlchemy()
    local self = LibCraftText
    if GetCraftingInteractionType() ~= CRAFTING_TYPE_ALCHEMY then
        Error("Learn alchemy while interacting at an alchemy station.")
        return
    end
    self.IndexBags()
                        -- Crafting 26 potions in a tight loop with no time
                        -- for the UI to breathe does not work. Second-and-
                        -- later crafting attempts do nothing. So turn this
                        -- for-loop into a zo_callLater() chain.
    LibCraftText.oneFunc = function(index, func)
                if #LibCraftText.LEARN_ALCHEMY < index then
                    Info("Done.")
                    return
                end
                Info(string.format( "Learning %2d/%2d"
                                  , index
                                  , #LibCraftText.LEARN_ALCHEMY
                                  ))
                local reagent_list = LibCraftText.LEARN_ALCHEMY[index]
                if not reagent_list then return false end
                LibCraftText.LearnOneAlchemy(reagent_list)
                zo_callLater(function() LibCraftText.oneFunc(index + 1, func) end, 1500)
                return true
            end
    LibCraftText.oneFunc(1, oneFunc)
end

function LibCraftText.LearnOneAlchemy(reagent_list)
    local self = LibCraftText
    local sol_mat_bag = self.ToMatBag(self.CONSUMABLE_MATERIAL.NATURAL_WATER)
    local r1_mat_bag = self.ToMatBag(reagent_list[1])
    local r2_mat_bag = self.ToMatBag(reagent_list[2])
    local r3_mat_bag = self.ToMatBag(reagent_list[3]) or {}
    local args = { sol_mat_bag.bag_id, sol_mat_bag.slot_id
                 , r1_mat_bag.bag_id , r1_mat_bag.slot_id
                 , r2_mat_bag.bag_id , r2_mat_bag.slot_id
                 , r3_mat_bag.bag_id , r3_mat_bag.slot_id
                 }
    CraftAlchemyItem(unpack(args))
end


-- Util ----------------------------------------------------------------------

function LibCraftText.CurrLang()
    return GetCVar("language.2")
end


-- bs  |H1:item:119563:6:1:0:0:0:69:188:4:74:8:35:0:0:0:0:0:0:0:0:66000|h|h
-- lgt |H1:item:119694:6:1:0:0:0:32:194:4:79:14:65:0:0:0:0:0:0:0:0:63000|h|h
-- med |H1:item:119695:6:1:0:0:0:37:190:4:81:11:62:0:0:0:0:0:0:0:0:61500|h|h
-- ww  |H1:item:119681:6:1:0:0:0:74:192:4:95:26:34:0:0:0:0:0:0:0:0:529000|h|h
-- jw  |H1:item:138798:6:1:0:0:0:18:255:4:176:30:0:0:0:0:0:0:0:0:0:656000|h|h

-- al  |H1:item:119705:6:1:0:0:0:199:19:3:1:0:0:0:0:0:0:0:0:0:0:50000|h|h
-- en  |H1:item:119564:6:1:0:0:0:26587:225:4:0:0:0:0:0:0:0:0:0:0:0:22000|h|h
-- pr  |H1:item:119693:6:1:0:0:0:68253:0:0:0:0:0:0:0:0:0:0:0:0:0:20000|h|h
