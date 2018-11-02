
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
local bs = CRAFTING_TYPE_BLACKSMITHING   or 1
local cl = CRAFTING_TYPE_CLOTHIER        or 2
local en = CRAFTING_TYPE_ENCHANTING      or 3
local al = CRAFTING_TYPE_ALCHEMY         or 4
local pr = CRAFTING_TYPE_PROVISIONING    or 5
local ww = CRAFTING_TYPE_WOODWORKING     or 6
local jw = CRAFTING_TYPE_JEWELRYCRAFTING or 7

CRAFTING_TYPE_ABBREV = {
      [bs] = "BS"
    , [cl] = "CL"
    , [en] = "EN"
    , [al] = "AL"
    , [pr] = "PR"
    , [ww] = "WW"
    , [jw] = "JW"
}

function Warn(msg)
    print(msg)
end

CHAR = {
  ["ziggr-alt-one"     ]={ name="ziggr-alt-one"     , faction="DC", rank={ AL=1, BS= 1, CL= 1, EN= 1, JW=1, PR=1, WW= 1 }}
, ["ziggr-alt-two"     ]={ name="ziggr-alt-two"     , faction="AD", rank={ AL=2, BS= 2, CL= 2, EN= 2, JW=2, PR=2, WW= 2 }}
, ["ziggr-alt-three"   ]={ name="ziggr-alt-three"   , faction="EP", rank={ AL=3, BS= 3, CL= 3, EN= 3, JW=3, PR=3, WW= 3 }}
, ["ziggr-alt-four"    ]={ name="ziggr-alt-four"    , faction="DC", rank={ AL=4, BS= 4, CL= 4, EN= 4, JW=4, PR=4, WW= 4 }}
, ["ziggr-alt-five"    ]={ name="ziggr-alt-five"    , faction="AD", rank={ AL=5, BS= 5, CL= 5, EN= 5, JW=5, PR=5, WW= 5 }}
, ["ziggr-alt-six"     ]={ name="ziggr-alt-six"     , faction="EP", rank={ AL=6, BS= 6, CL= 6, EN= 6, JW=5, PR=1, WW= 6 }}
, ["ziggr-alt-seven"   ]={ name="ziggr-alt-seven"   , faction="DC", rank={ AL=7, BS= 7, CL= 7, EN= 7, JW=5, PR=2, WW= 7 }}
, ["ziggr-alt-eight"   ]={ name="ziggr-alt-eight"   , faction="AD", rank={ AL=8, BS= 8, CL= 8, EN= 8, JW=5, PR=1, WW= 8 }}
, ["ziggr-alt-nine"    ]={ name="ziggr-alt-nine"    , faction="EP", rank={ AL=8, BS= 9, CL= 9, EN= 9, JW=5, PR=2, WW= 9 }}
, ["hammer-meets-thumb"]={ name="hammer-meets-thumb", faction="EP", rank={ AL=8, BS=10, CL=10, EN=10, JW=5, PR=6, WW=10 }}
}


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
        ImportSavedCharQuests(char_name, saved_chars, quest_index)
    end
end

function ImportSavedCharQuests(char_name, saved_chars, quest_index)
    local quest_title = saved_chars.quests[quest_index]
    local crafting_type = DAILY_QUEST_TITLE_TO_CRAFTING_TYPE[quest_title.en]
    if not crafting_type then
        -- Warn(string.format("char:%20s  skipping quest:%d %s %s. Non-daily. ## WRITE ME."
        -- , char_name
        -- , quest_index
        -- , quest_title.en
        -- , CRAFTING_TYPE_ABBREV[crafting_type]
        -- ))
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

    local key_fodder    = nil
    local ct_abbrev     = CRAFTING_TYPE_ABBREV[crafting_type]:upper()
    local alliance      = saved_chars.alliance
    if not alliance then
        Warn(string.format("char:%20s  skipping quest:%d %s %s. Missing alliance."
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
        key_fodder = string.format("DAILY_COND_%s_%02d_%s_"
                                  , ct_abbrev
                                  , skill_rank
                                  , alliance
                                  )
print("food")
    else
        key_fodder = string.format("DAILY_COND_%s_%02d_"
                                  , ct_abbrev
                                  , skill_rank
                                  , alliance
                                  )
    end

    Warn(string.format("Hiya! %-20s %s  %s"
                      , char_name
                      , key_fodder
                      , quest_title.en
                      ))
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
            DB[key] = DB[key] or {}
            local entry = DB[key]
            entry.key = key
            for lang,text in pairs(lang_table) do
                entry[lang] = text
            end
        end
    end

    local sets = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].sets
    for set_num, lang_table in pairs(sets) do
        if 0 ~= set_num then
            local key = string.format("$SET_%03d", set_num)
            DB[key] = DB[key] or {}
            local entry = DB[key]
            entry.key = key
            for lang,text in pairs(lang_table) do
                entry[lang] = text
            end
        end
    end

    local motifs = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].motifs
    for motif_num, lang_table in pairs(motifs) do
        if 0 ~= motif_num then
            local key = string.format("$MOTIF_%03d", motif_num)
            DB[key] = DB[key] or {}
            local entry = DB[key]
            entry.key = key
            for lang,text in pairs(lang_table) do
                entry[lang] = text
            end
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
                DB[key] = DB[key] or {}
                local entry = DB[key]
                entry.key = key
                for lang,text in pairs(lang_table) do
                    entry[lang] = Decaret(text)
                end
            end
        end
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

function ImportSavedVarLangTable(lang_table)
    if not lang_table and lang_table.en then return end

    local key = lang_table.key or EN_KEYS[lang_table.en]
    if not key then
        Warn("SavedVars: unknown string '"..tostring(lang_table.en).."'")
        return
    end

    local entry = DB[key]
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
            local key = '"'..kv[1]..'"'
            FILE:write(string.format('          %s   %-3s = "%s"\n'
                                    , comma(lang_i)
                                    , kv[1]
                                    , escape_quote(kv[2])
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

-- Replace all $XXX with their
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
    for k, entry_hash in pairs(DB) do

                        -- fallback to en if no translation yet
        local val = entry_hash[lang] or entry_hash.en
        val = escape_quote(val)
        val = escape_re(val)    -- Some lang strings are REs with % escapes. Retain them.
        local key = k
        local key_padded = string.format("%-"..tostring(repl_len).."s", key)
        local val_padded = pad(repl_len, '"'..val..'"')
        out_line, ct = out_line:gsub(key_padded, val_padded)

                        -- SURPRISE! Lua strings are BYTES not CHARS! This
                        -- matters when val is a string with umlauts or other
                        -- non-ASCII code points. The difference will cause all
                        -- this careful alignment work to be off by the number
                        -- of extra bytes of utf-8 wide chars. Oh well.
                        --
                        -- Lua 5.3 adds _some_ UTF-8 handling, but I don't care
                        -- enough upgrade from 5.2 and recode to fix this
                        -- today.

        if (0 < ct) and (repl_len < (val:len() + 2)) then
            Warn(string.format("Replacement exceeds space:%d < %d:\"%s\""
                              , repl_len
                              , val:len() + 2
                              , val))
        end

-- if k == "$ROLIS_NAME" and template_line:find(k) then
-- print("k:'"..k.."'\n")
-- print("key_padded:'"..key_padded.."'\n")
-- print("val_padded:'"..val_padded.."'\n")
-- print("line:'"..out_line.."'\n")
-- print("pos_delim  :"..tostring(pos_delim))
-- print("pos_comment:"..tostring(pos_comment))
-- print("pos_end    :"..tostring(pos_end))
-- print("repl_len   :"..tostring(repl_len))
--end

    end
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
