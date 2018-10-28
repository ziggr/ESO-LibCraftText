
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

LANG_LIST = { "en", "de", "fr", "es", "it", "ru", "jp" }

function Warn(msg)
    print(msg.."\n")
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
    for _, vlist in ipairs(LANG_DB) do
        local entry = {}
        for k, v in pairs(vlist) do
            entry[k] = v
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

-- Import ESO SavedVars file
function ImportSavedVars()
    local quest_list = LibCraftTextVars.Default["@ziggr"]["$AccountWide"].quests
    for qi, lang_table in pairs(quest_list) do
        if lang_table.en then
            local key = EN_KEYS[lang_table.en]
            if not key then
                Warn("SavedVars: unknown string '"..tostring(lang_table.en).."'")
            else
                local entry = DB[key]
                for lang, value in pairs(lang_table) do
                    entry[lang] = value
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

function WriteDB()
    local FILE = assert(io.open(DB_FILE_OUT, "w"))
    FILE:write("LANG_DB = {\n")
    for i,entry_list in ipairs(LANG_DB) do
        FILE:write(string.format("%s [%2d] = {\n", comma(i), i))
        for lang_i, kv in ipairs(entry_list) do
            local key = '"'..kv[1]..'"'
            FILE:write(string.format('         %s   %-3s = "%s"\n'
                                    , comma(lang_i), kv[1], kv[2]))
        end
        FILE:write("         }\n")
    end
    FILE:write("}\n")
end

function WriteLangs()
    for _,lang in ipairs(LANG_LIST) do
        WriteLang(lang)
    end
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
    local pos_end     = pos_delim + 10
    if pos_comment then pos_end = pos_comment end
    local repl_len = pos_end - pos_delim - 4
-- print(tostring(pos_delim)
-- ..".."..tostring(pos_comment)
-- .."  "..template_line)

    local out_line = template_line
    for k, entry_hash in pairs(DB) do
                        -- fallback to en if no translation yet
        local val = entry_hash[lang] or entry_hash.en
        local key = k
        local key_padded = string.format("%-"..tostring(repl_len).."s", key)
        local val_padded = string.format("%-"..tostring(repl_len).."s", '"'..val..'"')
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
ExportDB()          -- Sequence results into a stable output order.
WriteDB()           -- Write to output file.

WriteLang("en")
WriteLang("de")
WriteLang("fr")
