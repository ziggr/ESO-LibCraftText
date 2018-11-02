package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")

dofile("data/lang_db.lua")

GENFILE = "test/test_gen.data.lua"

COND_TEXT_FODDER = {}       -- deprecated, favor cond_unique

C = {
    cond_unique = {}        -- [cond_text] = genfile fodder
,   new_cond_ct = 0         -- how many new cond_text inputs did MergeLangDB() add?
}


------------------------------------------------------------------------------

function C.ReadGenData()
                        -- Read current list of condition text and
                        -- expected results.
    COND_TEXT_FODDER = {}
    dofile(GENFILE)
                            -- Retain old condition text keys
    C.cond_unique = {}
    for _,fodder in ipairs(COND_TEXT_FODDER) do
        C.cond_unique[fodder.input] = fodder
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
                C.cond_unique[lang_table.en] = { input = lang_table.en }
            end
        end
    end
end

function C.sorted_keys(t)
    sorted = {}
    for k,_ in pairs(t) do
        table.insert(sorted, k)
    end
    table.sort(sorted)
    -- for _,v in ipairs(sorted) do print(v) end
    return sorted
end

function C.WriteGenData()
                        -- Nothing new to write? Leave file untouched.
    if C.new_cond_ct <= 0 then return end

    local FILE = assert(io.open(GENFILE, "w"))
    FILE:write("COND_TEXT_FODDER = {\n")
    local comma = " "

    for _,cond_text in ipairs(C.sorted_keys(C.cond_unique)) do
        fodder = C.cond_unique[cond_text]
        FILE:write(string.format( "%s { input=%-50s, "
                                , comma
                                , '"'..cond_text..'"'
                                ))
        comma = ","

        for expect_key,value in pairs(fodder or {}) do
            if expect_key ~= "input" then
                FILE:write(string.format("%-20s = %-20s, "
                                        , expect_key
                                        , value
                                        ))
            end
        end
        FILE:write("}\n")
    end
    FILE:write("}\n")
    print(string.format("%d new lines added to %s.", C.new_cond_ct, GENFILE))
end

-- main ----------------------------------------------------------------------

C.ReadGenData()
C.MergeLangDB()
C.WriteGenData()

