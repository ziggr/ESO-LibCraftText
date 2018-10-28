
KEY_FILE    = "data/lang_key.lua"
DB_FILE     = "data/lang_db.lua"
DB_FILE_OUT = "data/lang_db_out.lua"

dofile(KEY_FILE)
dofile(DB_FILE)

DB = {}                 -- key = "$DAILY_BS"
                        -- value = table: { ["en"] = "Blacksmithing Writ" }

LANG_LIST = { "en", "de", "fr", "es", "it", "ru", "jp" }

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

-- main ----------------------------------------------------------------------
ImportDB()          -- Original database
ImportKeys()        -- Force keys/EN into existence, mostly to catch new strings.

ExportDB()          -- Sequence results into a stable output order.
WriteDB()           -- Write to output file.

