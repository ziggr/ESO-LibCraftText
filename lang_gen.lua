
KEY_FILE         = "data/lang_key.lua"
DB_FILE          = "data/lang_db.lua"
DB_FILE_OUT      = "data/lang_db_out.lua"
SAVED_VARS_FILE  = "data/LibCraftText.lua"

dofile(KEY_FILE)
dofile(DB_FILE)
dofile(SAVED_VARS_FILE)

DB = {}                 -- key   = "$DAILY_BS"
                        -- value = table: { ["en"] = "Blacksmithing Writ" }

EN_KEYS = {}            -- key   = "Blacksmithing Writ"
                        -- value = "$DAILY_BS"

LANG_LIST = { "en", "de", "fr", "es", "it", "ru", "ja" }

                        -- For less typing
CRAFTING_TYPE_BLACKSMITHING   = CRAFTING_TYPE_BLACKSMITHING   or 1
CRAFTING_TYPE_CLOTHIER        = CRAFTING_TYPE_CLOTHIER        or 2
CRAFTING_TYPE_ENCHANTING      = CRAFTING_TYPE_ENCHANTING      or 3
CRAFTING_TYPE_ALCHEMY         = CRAFTING_TYPE_ALCHEMY         or 4
CRAFTING_TYPE_PROVISIONING    = CRAFTING_TYPE_PROVISIONING    or 5
CRAFTING_TYPE_WOODWORKING     = CRAFTING_TYPE_WOODWORKING     or 6
CRAFTING_TYPE_JEWELRYCRAFTING = CRAFTING_TYPE_JEWELRYCRAFTING or 7
bs = CRAFTING_TYPE_BLACKSMITHING
cl = CRAFTING_TYPE_CLOTHIER
en = CRAFTING_TYPE_ENCHANTING
al = CRAFTING_TYPE_ALCHEMY
pr = CRAFTING_TYPE_PROVISIONING
ww = CRAFTING_TYPE_WOODWORKING
jw = CRAFTING_TYPE_JEWELRYCRAFTING

CRAFTING_TYPE_ABBREV = {
      [bs] = "BS"
    , [cl] = "CL"
    , [en] = "EN"
    , [al] = "AL"
    , [pr] = "PR"
    , [ww] = "WW"
    , [jw] = "JW"
}

function Warn(msg,...)
    print(string.format(msg,...))
end


-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

-- Import previous database from ordinal LANG_DB into hashtable DB.
function ImportDB()
    for _, vlist in pairs(LANG_DB) do
        local entry = {}
        for k, v in pairs(vlist) do
            if v ~= "" and not(k ~= "en" and v == entry.en) then
                entry[k] = v
            end
        end
        if entry.key then
            DB[entry.key] = entry
        end
    end
end

-- Import hardcoded keys and their EN english values.
function ImportKeys()
    for k, v in pairs(LANG_KEY) do
        DB[k] = DB[k] or {}
        DB[k]["en"] = v
        EN_KEYS[v] = k
    end
end

function Decaret(text)
    return text:gsub("%^.*","")
end

function table_len(t)
    if not t then return nil end
    local ct = 0
    for _,_ in pairs(t) do ct = ct+1 end
    return ct
end

local DAILY_QUEST_TITLE_TO_CRAFTING_TYPE =
{
      ["Blacksmith Writ"        ] = bs
    , ["Clothier Writ"          ] = cl
    , ["Woodworker Writ"        ] = ww
    , ["Enchanter Writ"         ] = en
    , ["Provisioner Writ"       ] = pr
    , ["Alchemist Writ"         ] = al
    , ["Jewelry Crafting Writ"  ] = jw
}

function AllSameCraftingType(crafting_type, quest_titles)
    local abbrev = CRAFTING_TYPE_ABBREV[crafting_type]
    if not abbrev then return false end
    abbrev = abbrev:upper()
    local key    = "$DAILY_"..abbrev
    local db_table = DB[key]
    if not db_table then
        Warn("Missing table for "..key)
        return false
    end

    for _,lang in ipairs(LANG_LIST) do
        local expect = db_table[lang] or ""
        local got    = quest_titles[lang] or ""
        if (lang ~= "it") and (expect ~= got) then
            Warn(string.format("%s  expect:'%s' ~= got:'%s'", lang, expect, got))
            return false
        end
    end
    return true
end

function ImportSavedChars()
    for char_name, saved_chars in pairs(LibCraftTextVars.Default["@ziggr"]) do
        ImportSavedChar(char_name, saved_chars)
    end
end


function ImportSavedChar(char_name, saved_chars)
    if char_name == "$AccountWide" then return end

    local quest_ct = table_len(saved_chars.quests)
    local step_ct = table_len(saved_chars.steps)
    local cond_ct = table_len(saved_chars.conditions)
    if (not quest_ct) or (quest_ct ~= step_ct) or (quest_ct ~= cond_ct) then
        Warn(string.format("char:%20s  skipping quests. quest_ct:%s  step_ct:%s  cond_ct:%s"
            , char_name
            , quest_ct
            , step_ct
            , cond_ct
            ))
        return
    end


    for quest_index,_ in pairs(saved_chars.quests) do
        ImportSavedCharQuestConditions(char_name, saved_chars, quest_index)
    end
end

                        -- Skip all the "Travel to X to meed your contact"
                        -- steps that appear 3 times in each master writ quest.
function IsInterestingMasterStep(saved_chars, quest_index, step_i)
    local cond_text_1 = saved_chars
            and saved_chars.conditions
            and saved_chars.conditions[quest_index]
            and saved_chars.conditions[quest_index][step_i]
            and saved_chars.conditions[quest_index][step_i][1]
            and saved_chars.conditions[quest_index][step_i][1].en
    if not cond_text_1 then return false end
    return not cond_text_1:find("Travel to ")
end

function InterestingMasterConditions(saved_chars, quest_index)
    local step_cond_lang_table = {}
    local conditions     = saved_chars.conditions[quest_index]
    for step_i, step_t in pairs(conditions) do
        for cond_i, lang_table in pairs(step_t) do
            -- if not lang_table.en:find("Travel to") then
                local s_c_lt = { step_i, cond_i, lang_table }
                table.insert(step_cond_lang_table, s_c_lt)
            -- end
        end
    end
    -- table.sort(step_cond_lang_table, function(a,b) return a.en < b.en end)
    local i = 0
    function iter()
        i = i + 1
        if i <= #step_cond_lang_table then
            return unpack(step_cond_lang_table[i])
        end
        return nil
    end
    return iter
end


function MasterQuestCondKey(i)
    return string.format("$MASTER_COND_%04d",i)
end

MASTER_COND_MAX_CT = 9999
KNOWN_MASTER_QUEST_COND = nil
function MasterQuestCondAlreadyKnown(lang_table)
    if not KNOWN_MASTER_QUEST_COND then
        KNOWN_MASTER_QUEST_COND = {}
        for i=1,MASTER_COND_MAX_CT do
            local key = MasterQuestCondKey(i)
            if DB[key] then
                KNOWN_MASTER_QUEST_COND[ DB[key].en ] = i
            end
        end
    end
    return KNOWN_MASTER_QUEST_COND[lang_table.en]
end

function ImportMasterQuestCondMaybe(lang_table)
                        -- Already imported? Nothing more to do.
    if MasterQuestCondAlreadyKnown(lang_table) then
        return
    end
                        -- Find an unused keyslot and put this there.
    for i=1,MASTER_COND_MAX_CT do
        local key = MasterQuestCondKey(i)
        if not DB[key] then
            lang_table.key = key
            DB[key] = lang_table
                        -- And remember this lang_table in case it
                        -- recurs within this lang_gen run.
                        -- (The "Travel to X" conditions recur. A lot.)
            KNOWN_MASTER_QUEST_COND[ DB[key].en ] = i
            return
        end
    end
end

local MASTER_QUEST_TITLE_TO_CRAFTING_TYPE_LIST =
{
  ["A Masterful Concoction"] = { al }
, ["A Masterful Feast"     ] = { pr }
, ["A Masterful Glyph"     ] = { en }
, ["A Masterful Plate"     ] = { bs }
, ["A Masterful Shield"    ] = { ww }
, ["A Masterful Weapon"    ] = { bs, ww }
, ["Masterful Jewelry"     ] = { jw }
, ["Masterful Tailoring"   ] = { cl }
, ["Masterful Leatherwear" ] = { cl }
}

function ImportSavedCharMasterQuestConditions(char_name, saved_chars, quest_index)
    local quest_title = saved_chars.quests[quest_index]
    local crafting_type_list = MASTER_QUEST_TITLE_TO_CRAFTING_TYPE_LIST[quest_title.en]
    if not crafting_type_list then
        print("### Unknown quest title. Skipping. "..quest_title.en)
        return
    end

    for _,_,lang_table in InterestingMasterConditions(saved_chars, quest_index) do
        ImportMasterQuestCondMaybe(lang_table)
    end
end


function ImportSavedCharQuestConditions(char_name, saved_chars, quest_index)
    local quest_title = saved_chars.quests[quest_index]
    local crafting_type = DAILY_QUEST_TITLE_TO_CRAFTING_TYPE[quest_title.en]
    if not crafting_type then
        ImportSavedCharMasterQuestConditions(char_name, saved_chars, quest_index)
        return
    end

    if not AllSameCraftingType(crafting_type, quest_title) then
        Warn(string.format("char:%20s  skipping quest:%d %s %s. Language mismatch."
        , char_name
        , quest_index
        , quest_title.en
        , CRAFTING_TYPE_ABBREV[crafting_type]
        ))
        return
    end

    local ct_abbrev     = CRAFTING_TYPE_ABBREV[crafting_type]:upper()
    local alliance      = saved_chars.alliance
    if (crafting_type == pr) and (not alliance) then
        Warn(string.format("char:%20s  skipping quest:%d %s %s. Missing alliance for Provisioning."
        , char_name
        , quest_index
        , quest_title.en
        , CRAFTING_TYPE_ABBREV[crafting_type]
        ))
        return
    end

    local skill_ranks   = saved_chars.skill_rank or {}
    local skill_rank    = skill_ranks[crafting_type]
    if not skill_rank then
        Warn(string.format("char:%-20s  skipping quest:%d %s %s. Missing skill_rank."
        , char_name
        , quest_index
        , quest_title.en
        , CRAFTING_TYPE_ABBREV[crafting_type]
        ))
        return
    end

    local key_fodder = nil
    if (crafting_type == CRAFTING_TYPE_PROVISIONING and skill_rank <= 3) then
        key_fodder = string.format("$DAILY_COND_%s_%02d_%s_"
                                  , ct_abbrev
                                  , skill_rank
                                  , alliance
                                  )
    else
        key_fodder = string.format("$DAILY_COND_%s_%02d_"
                                  , ct_abbrev
                                  , skill_rank
                                  )
    end

    local conditions = saved_chars.conditions[quest_index]
    for step_i, steps in pairs(conditions) do
        for cond_i,condition in pairs(steps) do
            local key = ImportSavedCharQuestCondition(key_fodder, condition)
            if key then
-- Warn(string.format("%-20s %-22s  %s"
--                   , char_name
--                   , key
--                   , DB[key].en
--                   ))
            end
        end
    end
end

function ImportSavedCharQuestCondition(key_fodder, condition)
    local pree_key = PrexistingCondition(key_fodder, condition)
    if pree_key then
        -- Warn(string.format( "Skipping previously known %s %s"
        --                   , pree_key
        --                   , tostring(condition and colon_strip(condition.en))
        --                   ))
        return nil
    end

    local slot = NextUnusedConditionIndex(key_fodder)
    local key  = ConditionKey(key_fodder, slot)
    local entry = { ["key"] = key }
    for i,lang in ipairs(LANG_LIST) do
        entry[lang] = colon_strip(condition[lang])
    end

    Warn(string.format( "Adding new %s %s"
                      , key
                      , tostring(condition and colon_strip(condition.en))
                      ))

    DB[key] = entry
    return key
end

function ConditionKey(key_fodder, i)
    return string.format("%s%02d", key_fodder, i)
end

function PrexistingCondition(key_fodder, condition)
    for i = 1,99 do
        local key   = ConditionKey(key_fodder,i)
        local entry = DB[key]
        if EntriesMatch(condition, entry) then return key end
    end
end

function NextUnusedConditionIndex(key_fodder)
    for i = 1,99 do
        local key   = ConditionKey(key_fodder,i)
        local entry = DB[key]
        if not entry then return i end
    end
    Warn("No unused condition for "..key_fodder)
    return nil
end

-- Do two entries match? All 6 supported languages?
function EntriesMatch(a,b)
                        -- nil vs. nil
    if not (a or b) then return true end
    if (a and not b) or (b and not a) then return false end

    for i, lang in ipairs(LANG_LIST) do
        if lang ~= "it" then
                        -- Strip trailing counts so that
                        -- "Craft Ring: 0/3" and "Craft Ring: 0/1" match.
            local aa = colon_strip(a[lang] or a.en)
            local bb = colon_strip(b[lang] or b.en)
            if aa ~= bb then return false end
        end
    end
    return true
end

NBSP = " " -- C2 A0
-- Remove the ": 0 / 1" stuff at the end of a crafting request.
-- "Craft Normal Dwarven Greaves: 0 / 1" ==> "Craft Normal Dwarven Greaves"
function colon_strip(text)
    if not text then return text end
                        -- This regex is too aggressive, will clear out
                        -- words after colon line "Trait: arcane".
                        -- Do not use on split lines from sealed master writs.
                        -- Apparently safe for daily crafting writs, though:
                        -- no daily crafting writ conditions put anything
                        -- but counts after a colon.
  local r = text:gsub(" ?:.*","")
  r = r:gsub(NBSP.."+$","")
  return r
end

--[[
    assign a quest key for this quest
        -- title ==> crafting type
        -- skill_rank[ctype] ==> rank:  _JW_05_
        -- conditions ==> ordinal _JW_05_12
            look for the set of conditions in existing lang_db
            if exact match, then return that existing lang_db key number
            if not, then increment a a per JW_05 counter

    probably want some preventative shields here:
        use lang_db's quest title entries to check that
        all 7 quest titles are for the same crafting type before continuing.
]]

function ImportQuests(qsc_container)
    local quest_list = qsc_container.quests
    if quest_list then
        for qi, lang_table in pairs(quest_list) do
            ImportSavedVarLangTable(lang_table)
        end
    end

    local steps = qsc_container.steps
    if steps then
        for qi, step_list in pairs(steps) do
            for si, lang_table in pairs(step_list) do
                ImportSavedVarLangTable(lang_table)
            end
        end
    end

    local conditions = qsc_container.conditions
    if conditions then
        for qi, step_list in pairs(conditions) do
            for si, cond_list in pairs(step_list) do
                for ci, lang_table in pairs(cond_list) do
                    ImportSavedVarLangTable(lang_table)
                end
            end
        end
    end
end

-- Import ESO SavedVars file
function ImportSavedVars()
    local qsc_container = LibCraftTextVars.Default["@ziggr"]["$AccountWide"]
    ImportQuests(qsc_container)

    local materials = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].materials
    for weight, lang_list in pairs(materials) do
        for lang, level_list in pairs(lang_list) do
            for level, text in pairs(level_list) do
                        -- Special case to omit Italian material strings
                        -- which are the entire master writ base text innstead
                        -- of a material name
                if lang ~= "it" then
                    local key = string.format("$MATERIAL_%s_%02d", weight:upper(), level)
                    local entry = DB[key]
                    entry[lang] = text
                end
            end
        end
    end

    local items = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].items
                        -- BEGIN COPYPASTA FROM LibCraftText.DiscoverItems()
    local writ1 = {
      ["bs" ] = { 53, 56, 59, 68, 69, 67, 62        -- bs weapons
                , 46, 50, 52, 44, 49, 47, 48 }      -- heavy armor
    , ["lgt"] = { 28, 75, 32, 34, 26, 31, 29, 30 }  -- light armor, including jerkin
    , ["med"] = { 37, 41, 43, 35, 40, 38, 39 }      -- medium armor
    , ["ww" ] = { 70, 72, 73, 74, 71                -- ww weapons
                , 65 }                              -- shield
    , ["jw" ] = { 18, 24 }                          -- necklace, ring
    }
                        -- END COPYPASTA FROM LibCraftText.DiscoverItems()
    for weight, lang_list in pairs(items) do
        local item_num_list = writ1[weight]
        for lang, item_list in pairs(lang_list) do
            for i, text in pairs(item_list) do
                local item_num = item_num_list[i]
                local key = string.format("$MASTER_ITEM_%02d", item_num)
                local entry = DB[key]
                entry[lang] = text
            end
        end
    end

    local trait_materials = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].trait_materials
    for item_id, lang_table in pairs(trait_materials) do
        local key = string.format("$TRAIT_MATERIAL_%06d", item_id)
        ImportSavedVarLangTable(lang_table, key)
    end

    local qualities = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].qualities
    for lang, qual_list in pairs(qualities) do
        for i, text in pairs(qual_list) do
            local key = string.format("$QUALITY_%d", i)
            local entry = DB[key]
            entry[lang] = text
        end
    end

    local trait_keys = {
        [ 1] = "$TRAIT_WEAPON_POWERED"
    ,   [ 2] = "$TRAIT_WEAPON_CHARGED"
    ,   [ 3] = "$TRAIT_WEAPON_PRECISE"
    ,   [ 4] = "$TRAIT_WEAPON_INFUSED"
    ,   [ 5] = "$TRAIT_WEAPON_DEFENDING"
    ,   [ 6] = "$TRAIT_WEAPON_TRAINING"
    ,   [ 7] = "$TRAIT_WEAPON_SHARPENED"
    ,   [ 8] = "$TRAIT_WEAPON_DECISIVE"
    ,   [25] = "$TRAIT_WEAPON_NIRNHONED"    -- ZZ CHECK THIS vs ARMOR
    ,   [11] = "$TRAIT_ARMOR_STURDY"
    ,   [12] = "$TRAIT_ARMOR_IMPENETRABLE"
    ,   [13] = "$TRAIT_ARMOR_REINFORCED"
    ,   [14] = "$TRAIT_ARMOR_WELL_FITTED"
    ,   [15] = "$TRAIT_ARMOR_TRAINING"
    ,   [16] = "$TRAIT_ARMOR_INFUSED"
    ,   [17] = "$TRAIT_ARMOR_PROSPEROUS"
    ,   [18] = "$TRAIT_ARMOR_DIVINES"
    ,   [26] = "$TRAIT_ARMOR_NIRNHONED"
    ,   [22] = "$TRAIT_JEWELRY_ARCANE"
    ,   [21] = "$TRAIT_JEWELRY_HEALTHY"
    ,   [23] = "$TRAIT_JEWELRY_ROBUST"
    ,   [30] = "$TRAIT_JEWELRY_TRIUNE"
    ,   [33] = "$TRAIT_JEWELRY_INFUSED"
    ,   [32] = "$TRAIT_JEWELRY_PROTECTIVE"
    ,   [28] = "$TRAIT_JEWELRY_SWIFT"
    ,   [29] = "$TRAIT_JEWELRY_HARMONY"
    ,   [31] = "$TRAIT_JEWELRY_BLOODTHIRSTY"
    }
    local traits = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].traits
    for trait_num, lang_table in pairs(traits) do
        if 0 ~= trait_num then
            local key = trait_keys[trait_num]
            ImportSavedVarLangTable(lang_table, key)
        end
    end

    local sets = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].sets
    for set_num, lang_table in pairs(sets) do
        if 0 ~= set_num then
            local key = string.format("$SET_%03d", set_num)
            ImportSavedVarLangTable(lang_table, key)
        end
    end

    local motifs = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].motifs
    for motif_num, lang_table in pairs(motifs) do
        if 0 ~= motif_num then
            local key = string.format("$MOTIF_%03d", motif_num)
            ImportSavedVarLangTable(lang_table, key)
        end
    end

    local items = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].items_from_stations
    if items then
        for crafting_type, pattern_list in pairs(items) do
            for pattern_index, lang_table in pairs(pattern_list) do
                local key = string.format( "$ITEM_%s_%02d"
                                         , CRAFTING_TYPE_ABBREV[crafting_type]
                                         , pattern_index
                                         )
                ImportSavedVarLangTable(lang_table, key)
            end
        end
    end

    local mats = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].consumable_materials
    if mats then
        for crafting_type, item_list in pairs(mats) do
            for item_id, lang_table in pairs(item_list) do
                local key = string.format( "$MATERIAL_%s_%06d"
                                         , CRAFTING_TYPE_ABBREV[crafting_type]
                                         , item_id
                                         )
                ImportSavedVarLangTable(lang_table, key)
            end
        end
    end

                        -- Enchanting potency names
    local table_names = { ["potencies"] = "$POTENCY_%06d"
                        }
    for table_name, key_pattern in pairs(table_names) do
        local table = LibCraftTextVars.Default["@ziggr"]["$AccountWide"][table_name]
        if table then
            for item_id, lang_table in pairs(table) do
                local key = string.format(key_pattern, item_id)
                ImportSavedVarLangTable(lang_table, key)
            end
        end
    end
                        -- Enchanting essence names
    local key_pattern_add = "$ESSENCE_%06d_ADD"
    local key_pattern_sub = "$ESSENCE_%06d_SUB"
    local essences = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].essences
    for item_id, add_sub in pairs(essences) do
        local key_add = string.format(key_pattern_add, item_id)
        local key_sub = string.format(key_pattern_sub, item_id)
        ImportSavedVarLangTable(add_sub.add, key_add)
        ImportSavedVarLangTable(add_sub.sub, key_sub)
    end

                        -- Recipes. Include recipe index numbers, as numbers.
    local recipes = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].recipes
    if recipes then
        for food_item_id, recipe in pairs(recipes) do
            local key = string.format( "$FOOD_%06d"
                                     , food_item_id
                                     )
            local lang_table          = recipe.name
            ImportSavedVarLangTable(lang_table, key)
            DB[key].recipe_list_index = recipe.recipe_list_index
            DB[key].recipe_index      = recipe.recipe_index
            DB[key].recipe_item_id    = recipe.recipe_item_id
        end
    end

                        -- Alchemy potion rank adjectives: "Essence", "IX"
    local alchemy = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].alchemy
    local solvent = alchemy.solvent
    for rank = 1,9 do
        local solvent_potion_key = string.format("$ALCHEMY_SOLVENT_POTION_%d", rank)
        local solvent_poison_key = string.format("$ALCHEMY_SOLVENT_POISON_%d", rank)
        ImportSavedVarLangTable(solvent.potion[rank], solvent_potion_key)
        ImportSavedVarLangTable(solvent.poison[rank], solvent_poison_key)
    end
                        -- Alchemy potion names: "Health", "Drain Magicka"
    local potion_names = {
                           ["HEALTH"           ] = "Health"
                         , ["MAGICKA"          ] = "Magicka"
                         , ["STAMINA"          ] = "Stamina"
                         , ["RAVAGE_HEALTH"    ] = "Ravage Health"
                         , ["RAVAGE_MAGICKA"   ] = "Ravage Magicka"
                         , ["RAVAGE_STAMINA"   ] = "Ravage Stamina"
                         }
    for key_part, saved_var_name in pairs(potion_names) do
        local solvent_potion_key = string.format("$ALCHEMY_POTION_%s", key_part)
        local solvent_poison_key = string.format("$ALCHEMY_POISON_%s", key_part)
        ImportSavedVarLangTable(alchemy.potion[saved_var_name], solvent_potion_key)
        ImportSavedVarLangTable(alchemy.poison[saved_var_name], solvent_poison_key)
    end

                        -- Alchemy traits, and master potions/poisons that
                        -- reference that trait in the potion/poison item name.
    for i,lang_table in ipairs(alchemy.trait) do
        local key = string.format("$ALCHEMY_TRAIT_%02d",i)
        ImportSavedVarLangTable(lang_table, key)
    end
    for i,lang_table in ipairs(alchemy.link.master_poison) do
        local key = string.format("$ALCHEMY_MASTER_POISON_%02d",i)
        ImportSavedVarLangTable(lang_table, key)
    end
    for i,lang_table in ipairs(alchemy.link.master_potion) do
        local key = string.format("$ALCHEMY_MASTER_POTION_%02d",i)
        ImportSavedVarLangTable(lang_table, key)
    end
end

-- From http://lua-users.org/wiki/SplitJoin
function split(str,sep)
    local ret={}
    local n=1
    for w in str:gmatch("([^"..sep.."]*)") do
        ret[n] = ret[n] or w -- only set once (so the blank after a string is ignored)
        if w=="" then
            n = n + 1
        end -- step forwards on a blank but not a string
    end
    return ret
end

function ImportSavedVarLangTable(lang_table, key_override)
    if not (lang_table and lang_table.en) then return end

    local key = key_override or lang_table.key or EN_KEYS[lang_table.en]
    if not key then
        Warn("SavedVars: unknown string '"..tostring(lang_table.en).."'")
        return
    end

    DB[key] = DB[key] or {}
    local entry = DB[key]
                        -- Copy EN now, so that we don't have to worry about in
                        -- the "skip NOP translations that match en" if-
                        -- statement later.
    entry.en = lang_table.en
    for lang, value in pairs(lang_table) do
                        -- Skip NOP translations
        if value ~= "" and not (key ~= "en" and value == lang_table.en) then
            entry[lang] = value
        end
    end


                        -- Attempt to extract substrings.
    local delim = "\n"
    local en_sub = split(lang_table.en, delim)
    if #en_sub <= 1 then return end
    for lang, value in pairs(lang_table) do
        if value then
            local tr_sub = split(value, delim)
            if #tr_sub == #en_sub then
                for i, en in ipairs(en_sub) do
                    local tr = tr_sub[i]
                    key = EN_KEYS[en]
                    if not key then
                        Warn("SavedVars: unknown string '"..tostring(en).."'")
                    elseif tr and tr ~= en then
                        entry = DB[key]
                        entry[lang] = tr
                    end
                end
            end
        end
    end
end

-- Export database
function ExportDB()
                        -- To help hold output stable for more helpful diffs,
                        -- sort toplevel by $XXX key, and then used a fixed
                        -- order for key/en/de/fr/... sequence under that.
    local keys = {}
    for k,v in pairs(DB) do table.insert(keys,k) end
    table.sort(keys)


    local lang_db = {}
    for key_i, key in ipairs(keys) do
        local entry_hash = DB[key]
        local entry_list = {}
        entry_list[1] = { "key", key }
        for _, lang in ipairs(LANG_LIST) do
            if entry_hash[lang] then
                table.insert(entry_list, { lang, entry_hash[lang] })
            end
        end
                        -- Include numeric recipe indexes after all the text.
        local field_list = { "recipe_list_index", "recipe_index", "recipe_item_id" }
        for k,v in ipairs(field_list) do
            if entry_hash[v] then
                table.insert(entry_list, { v, entry_hash[v] })
            end
        end

        table.insert(lang_db, entry_list)
    end
    LANG_DB = lang_db
end

local function comma(i)
    if i == 1 then return " " else return "," end
end

local function escape_quote(t)
    local tt = t
    tt = string.gsub(tt,'\\','\\\\')
    tt = string.gsub(tt,'"','\\"')
    tt = string.gsub(tt,'\n','\\n')
    return tt
end

function WriteDB()
    local FILE = assert(io.open(DB_FILE_OUT, "w"))
    FILE:write("LANG_DB = {\n")
    for i,entry_list in ipairs(LANG_DB) do
        FILE:write(string.format("%s [%3d] = {\n", comma(i), i))
        for lang_i, kv in ipairs(entry_list) do
                        -- Most values are strings, but we do have numeric
                        -- values for recipe indexes because Zig really
                        -- does not want to maitain all those numbers by hand.
            local value = '"'..escape_quote(kv[2])..'"'
            if type(kv[2]) == "number" then
                value = tostring(kv[2])
            end

            local key = '"'..kv[1]..'"'
            FILE:write(string.format('          %s   %-3s = %s\n'
                                    , comma(lang_i)
                                    , kv[1]
                                    , value
                                    ))
        end
        FILE:write("          }\n")
    end
    FILE:write("}\n")
end

function WriteLangs()
    for _,lang in ipairs(LANG_LIST) do
        WriteLang(lang)
    end
end

local function escape_re(t)
    return t:gsub("%%","%%%%")
end

-- unicode strlen(). Sort of. Works well enough for our UTF-8 encoded text.
local function ustrlen(str)
    local _, count = str:gsub( "[^\128-\193]", "")
    return count
end

local function pad(want_len, str)
    local str_len = ustrlen(str)
    local pad_len = math.max(0,want_len - str_len)
    local pad = string.format("%"..pad_len.."s","")
    return str .. pad
end

-- Replace all $XXX with their language-specific string literal.
function ReplaceKeys(template_line, lang)
    local pos_delim = template_line:find("%$")
    if not (pos_delim and pos_delim < template_line:len())
        then return template_line
    end

                        -- How many characters of room do we have before
                        -- our replacement text bumps into a comment or bracket?
    local pos_comment = template_line:find("%-%-")
    local pos_comma   = template_line:find(",", pos_delim)

    local pos_end     = pos_delim + 10
    if pos_comment then pos_end = pos_comment end
    if pos_comma   then pos_end = math.min(pos_end, pos_comma) end
    local repl_len = pos_end - pos_delim - 4
-- print(tostring(pos_delim)
-- ..".."..tostring(pos_comment)
-- .."  "..template_line)

    local out_line = template_line

    local function lookup(key_padded)
        local _,_,key,padding = key_padded:find("(%$[A-Z0-9_%.]+)(%s*)")
        local repl_len = key:len()
        if padding then
            repl_len = repl_len + padding:len()
        end

                        -- Programmatic keys for numeric recipe indexes.
                        -- Yeah, cramming recipe numbers into a text-processor
                        -- lang_db is a gross hack. Blech.
                        --      suffix, field name         , fmt
        local programmatic = { {"_RLI", "recipe_list_index", "%3d"}
                             , {"_RID", "recipe_item_id"   ,"%06d"}
                             , { "_RI", "recipe_index"     , "%3d"}
                             }
        for _,p in ipairs(programmatic) do
            if key:find(p[1].."$") then
                key = key:sub(1,key:len()-p[1]:len())
                local lang_table = DB[key]
                if not lang_table then return key end
                local value = lang_table[p[2]]
                if not value then
                    Warn(string.format("lang_db value for key:%s field:%s", key, p[2]))
                    return "0"
                end
                return string.format(p[3],value)
            end
        end

        local lang_table = DB[key]
        if not lang_table then return key end
        local val = lang_table[lang] or lang_table.en
        val = escape_quote(val)
        val = escape_re(val)    -- Some lang strings are REs with % escapes. Retain them.
        local val_padded = pad(repl_len, '"'..val..'"')

        return val_padded
    end

    out_line = out_line:gsub("(%$[A-Z0-9_]+%s*)",lookup)
    return out_line
end

function WriteLang(lang)
    local IN_FILE        = "lang_template.txt"
    local template_lines = io.lines(IN_FILE)

    -- local LANG_OUT_FILE = string.format("lang/%s_out.lua", lang)
    local LANG_OUT_FILE = string.format("lang/%s.lua", lang)
    local FILE = assert(io.open(LANG_OUT_FILE, "w"))
    for template_line in template_lines do
        local out_line = ReplaceKeys(template_line, lang)
        FILE:write(out_line)
        FILE:write("\n")
    end
    FILE:close()
end

-- main ----------------------------------------------------------------------
ImportDB()          -- Original database
ImportKeys()        -- Force keys/EN into existence, mostly to catch new strings.
ImportSavedVars()   -- Read anything recently scraped from ESO via `/lct scan`.
ImportSavedChars()  -- Read per-char quests
ExportDB()          -- Sequence results into a stable output order.
WriteDB()           -- Write to output file.
WriteLangs()        -- Write lang/nn.lua translation files.
