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
        LibCraftText.Scan()
    elseif args:lower() == "forget" then
        LibCraftText.Forget()
        Info("Forgotten.")
    elseif args:sub(1,4):lower() == "lang" then
        local want_lang = args:sub(6,7):lower()
        LibCraftText.NextLang(want_lang)
    else
        Info("Unknown command: '"..tostring(args).."'")
    end
end

function LibCraftText.Scan()
    LibCraftText.ScanQuestJournal()
    LibCraftText.DiscoverMaterials()
    LibCraftText.DiscoverItems()
    LibCraftText.DiscoverQualities()
    LibCraftText.DiscoverTraits()
    LibCraftText.DiscoverSets()
    LibCraftText.DiscoverMotifs()
end

function LibCraftText.Forget()
    LibCraftText.saved_var.quests          = nil
    LibCraftText.saved_var.steps           = nil
    LibCraftText.saved_var.conditions      = nil
    LibCraftText.saved_var.materials       = nil
    LibCraftText.saved_var.items           = nil
    LibCraftText.saved_var.qualities       = nil
    LibCraftText.saved_var.traits          = nil
    LibCraftText.saved_var.sets            = nil
    LibCraftText.saved_var.motifs          = nil
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

function LibCraftText.DiscoverMaterials()
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
