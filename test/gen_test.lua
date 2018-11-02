package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")

dofile("data/lang_db.lua")

GENFILE = "test/gen_test.data.lua"

C = {
    cond_unique = {}

                            -- [cond_text] = "{ key=CONST, key2=OTHERCONST }"
                            -- key is the EN condition text and value is a
                            -- text/string representation of the Lua table of
                            -- expected key/value pairs.

,   new_cond_ct = 0         -- how many new cond_text inputs did MergeLangDB()
                            -- add?

,   preamble_lines = {}     -- Any data lines before "COND_TEXT_FODDER = {"
}


------------------------------------------------------------------------------

function C.ReadGenData()
                        -- Read current list of condition text and
                        -- expected results.
    local FILE = io.open(GENFILE,"r")
    local re_input   = 'input="([^"]*)"'
    local re_expect  = 'expect=({.*}) *}$'
    local in_cond_fodder = false
    for line in FILE:lines() do
        in_cond_fodder = in_cond_fodder or line:find("^COND_TEXT_FODDER")
        if not in_cond_fodder then
            table.insert(C.preamble_lines, line)
        else
            local _,_,input          = line:find(re_input)
            local _,_,expect_as_text = line:find(re_expect)
            if input then
                expect_as_text = expect_as_text or "{}"
                -- print("in:"..input.." expect_as_text:"..tostring(expect_as_text))
                C.cond_unique[input] = expect_as_text
            end
        end
    end
end

function C.MergeLangDB()
                        -- Insert any new condition text.
    C.new_cond_ct = 0
    for k,lang_table in pairs(LANG_DB) do
        local key   = lang_table.key
        if key:find("$DAILY_COND_") and lang_table.en then
            if not C.cond_unique[lang_table.en] then
                C.new_cond_ct = C.new_cond_ct + 1
                C.cond_unique[lang_table.en] = "{}"
            end
        end
    end
end

function C.sorted_keys(t)
    local sorted = {}
    for k,_ in pairs(t) do
        table.insert(sorted, k)
    end
    table.sort(sorted)
    -- for _,v in ipairs(sorted) do print(v) end
    return sorted
end

function C.WriteGenData()
    local FILE = assert(io.open(GENFILE, "w"))
    FILE:write("COND_TEXT_FODDER = {\n")
    local comma = " "
    for _,line in ipairs(C.preamble_lines) do
        FILE:write(line)
        FILE:write("\n")
    end
    for _,cond_text in ipairs(C.sorted_keys(C.cond_unique)) do
        local expect_as_text = C.cond_unique[cond_text]
        FILE:write(string.format( "%s { input=%-50s, expect=%-50s }\n"
                                , comma
                                , '"'..cond_text..'"'
                                , expect_as_text
                                ))
        comma = ","
    end
    FILE:write("}\n")
    print(string.format("%d new lines added to %s.", C.new_cond_ct, GENFILE))
end

-- main ----------------------------------------------------------------------

C.ReadGenData()
C.MergeLangDB()
C.WriteGenData()

