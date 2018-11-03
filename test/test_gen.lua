package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")
require("utils_test")
luaunit = require("luaunit")

TestGen            = {}
TestGen.setUpOuter =  Test.setUpOuter
TestGen.setUp      =  Test.setUp
TestGen.test_ct    = 0

LCT = LibCraftText

function table.shallow_copy(t)
    local r = {}
    for k,v in pairs(t) do
        r[k] = v
    end
    return r
end

function TestGen.TestNothing()
    luaunit.assertEquals(1,1)
end

function TestGen.TestAll()
    local LANG_FILE = string.format("lang/%s.lua", LibCraftText.CurrLang())
    dofile(LANG_FILE)
    dofile("test/gen_test.data.lua")

    for _,fodder in pairs(COND_TEXT_FODDER) do
        TestGen.OneTest(fodder.input, fodder.expect)
    end

    print("TestGen ct:"..TestGen.test_ct)
end

function TestGen.OneTest(input, expect)
                        -- Skip lines I've not filled in yet.
                        -- We need that crafting_type.
                        --
                        -- Stuffing the crafting_type in "expect" is ugly,
                        -- but it works for now and I've got actual product
                        -- things to do rather than fix ugliness in test
                        -- code.
    local crafting_type = expect.crafting_type
    if expect.material then
        crafting_type = crafting_type or expect.material.crafting_type
    end

    if not crafting_type then return end
    local real_expect = table.shallow_copy(expect)
    real_expect.crafting_type = nil

    local got = LibCraftText.ParseDailyConditionGear(crafting_type, input)
    luaunit.assertEquals(got, real_expect, input)

    TestGen.test_ct = TestGen.test_ct + 1
    --print(input)
end

os.exit( luaunit.LuaUnit.run() )
