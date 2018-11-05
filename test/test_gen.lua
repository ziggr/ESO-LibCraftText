package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")
require("utils_test")
luaunit = require("luaunit")

TestGen            = {}
TestGen.setUpOuter =  Test.setUpOuter
TestGen.setUp      =  Test.setUp

LCT = LibCraftText

                        -- Load the lang_db so that we can roll through all
                        -- supported languages
dofile("data/lang_db.lua")
INPUT_TO_LANG_TABLE = {}
for k,v in pairs(LANG_DB) do
    if v.en then
        INPUT_TO_LANG_TABLE[v.en] = v
    end
end

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
end

local CRAFTING_TYPE_TO_PARSE_FUNC = {
  [bs] = LibCraftText.ParseDailyConditionEquipment
, [cl] = LibCraftText.ParseDailyConditionEquipment
, [en] = LibCraftText.ParseDailyConditionConsumable
, [al] = LibCraftText.ParseDailyConditionConsumable
, [pr] = LibCraftText.ParseDailyConditionConsumable
, [ww] = LibCraftText.ParseDailyConditionEquipment
, [jw] = LibCraftText.ParseDailyConditionEquipment
}
function TestGen.OneTest(input_en, expect)
                        -- Skip lines with bugs in the current language
    if expect.bug then
        local lang = LibCraftText.CurrLang()
        for _,bug_lang in ipairs(expect.bug) do
            if bug_lang == lang then return end
        end
                        -- help assertEquals ignore our "bug" field.
        local expect2 = table.shallow_copy(expect)
        expect2.bug = nil
        expect = expect2
    end

                        -- Skip lines I've not filled in yet.
                        -- We need that crafting_type.
                        --
                        -- Stuffing the crafting_type in "expect" is ugly,
                        -- but it works for now and I've got actual product
                        -- things to do rather than fix ugliness in test
                        -- code.
    local crafting_type = expect.crafting_type
    local crafting_type_carriers = { "material", "item" }
    for _,field_name in ipairs(crafting_type_carriers) do
        if expect[field_name] then
            crafting_type = crafting_type or expect[field_name].crafting_type
            if crafting_type then break end
        end
    end
    if expect.potency then
        crafting_type = en
    end
    if expect.solvent then
        crafting_type = al
    end
    if expect.recipe then
        crafting_type = pr
    end
    if not crafting_type then return end

    local real_expect = table.shallow_copy(expect)
    real_expect.crafting_type = nil

    local lang_table = INPUT_TO_LANG_TABLE[input_en]
    luaunit.assertNotNil(lang_table,input_en)
    local input = lang_table[LibCraftText.CurrLang()] or input_en

    local test_func = CRAFTING_TYPE_TO_PARSE_FUNC[crafting_type]
    if test_func then
        local got = test_func(crafting_type, input)
        luaunit.assertEquals(got, real_expect, input_en.."/"..input)
    end
end

os.exit( luaunit.LuaUnit.run() )
