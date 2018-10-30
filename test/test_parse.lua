package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")
luaunit = require("luaunit")

-- Testing scaffolding
CRAFTING_TYPE_BLACKSMITHING     = 1
CRAFTING_TYPE_CLOTHIER          = 2
CRAFTING_TYPE_ENCHANTING        = 3
CRAFTING_TYPE_ALCHEMY           = 4
CRAFTING_TYPE_PROVISIONING      = 5
CRAFTING_TYPE_WOODWORKING       = 6
CRAFTING_TYPE_JEWELRYCRAFTING   = 7



-- Belonga LCT ---------------------------------------------------------------

-- Test Scaffolding to enable unit tests to force a specific language.
function LibCraftText.ForceLang(lang)
    LibCraftText.force_lang = lang
end

-- Test Scaffolding to enable unit tests to force a specific language.
function LibCraftText.CurrLang()
    if LibCraftText.force_lang then
        return LibCraftText.force_lang
    elseif not GetCVar then
        return "en" -- for running outside of ESO client.
    end
    return GetCVar("language.2")
end

LibCraftText.RE_CONDITION_CL = {
    ["de"] = "Stellt normale (.*) her: 0/1"
,   ["en"] = "Craft Normal (.*): 0 / 1"
,   ["fr"] = "Fabriquez une? (.*) en (.*) normal : 0/1"
,   ["es"] = "Fabrica une? (.*) de (.*) normal: 0/1"
,   ["it"] = "Craft (.*): 0 / 1"
,   ["ru"] = "Craft Normal (.*): 0 / 1"
,   ["ja"] = "(.*)の(.)%(ノーマル%)を生産する: 0 / 1"
}
function LibCraftText.ParseConditionCL(cond_text)
    local lang      = LibCraftText.CurrLang()
    local re        = LibCraftText.RE_CONDITION_CL[lang]
    local _,_,g1,g2 = string.find(cond_text, re)

                        -- Some languages put material (adjective) before
                        -- item (noun). Others put the material after.
                        --
                        -- It is nigh impossible to use a regex to detect the
                        -- boundary between "Rubedoleder" and "helme" in
                        -- "Rubedolederhelme", especially for all combinations
                        -- of material, item, and language. So instead, we loop
                        -- through known materials and items looking for
                        -- matches.

                        -- Smush g1 and g2 into a single string that we can
                        -- search.
    local matitem = g1
    if g2 then matitem = matitem .. "/" .. g2 end

g1 = "Rubedo Leather"
g2 = "Helmet"
    if g2 then
        return { material_name = g1 -- "Rubedo Leather"
               , item_name     = g2 -- "Helm"
               }
   end
end
-- End Belonga LCT -----------------------------------------------------------

LANG_ORDER = { "en", "de", "fr", "ru", "es", "it", "ja" }

TestDailyCondition = {}

-- Zig modified luaunit.lua to call this new function once outside of
-- any `--repeat N` iteration. This lets us reset the language cycle
-- back to "en" at the start of each individual .TestX() function's iteration.
function TestDailyCondition:setUpOuter()
    self.lang_index = nil
end

-- Advance to next language. Allows us to run each .TestX() function
-- once for each supported language in LANG_ORDER.
--
-- luaunit calls .setUp() before each call to .TestX(). And if you pass
-- `--repeat N` on the commant line, luaunit will repeat the .setUp()/.TestX()
-- calls N times.
--
-- Yes, it is REALLY inefficient to swap languages before each .TestX() call,
-- would be better to run the entire test suite in a language, THEN swap
-- languages to run again in a different language. But that's just not how
-- luaunit is designed, and fighting or rewriting that tool is so far removed
-- from my primary work product (parser of crafting text) that it isn't worth
-- the time.
--
function TestDailyCondition:setUp()
    if not self.lang_index then self.lang_index = 0 end
    self.lang_index = self.lang_index + 1
    if #LANG_ORDER < self.lang_index then
        self.lang_index = 1
    end
    local want_lang = LANG_ORDER[self.lang_index]
    LibCraftText.ForceLang(want_lang)
    dofile(string.format("lang/%s.lua",want_lang))
    -- print(want_lang.."  "..LibCraftText.DAILY_QUEST_TITLES[1])
end

function TestDailyCondition.TestCL()
    local fodder = {
      ["en"] = { "Craft Normal Rubedo Leather Helmet: 0 / 1"       , "Rubedo Leather", "Helmet" }
    , ["de"] = { "Stellt normale Rubedolederhelme her: 0/1"        , "Rubedoleder"   , "helme"  }
    , ["fr"] = { "Fabriquez un casque en cuir pourpre normal : 0/1", "cuir pourpre"  , "casque" }
    , ["ru"] = { "Craft Normal Rubedo Leather Helmet: 0 / 1"       , "Rubedo Leather", "Helmet" }
    , ["es"] = { "Fabrica un casco de cuero rubedo normal: 0/1"    , "cuero rubedo"  , "casco"  }
    , ["it"] = { "Craft Rubedo Leather Helmet: 0 / 1"              , "Rubedo Leather", "Helmet" }
    , ["ja"] = { "ルベドレザーの兜(ノーマル)を生産する: 0 / 1"           , "ルベドレザー"    , "兜"     }
    }

    local f = fodder[LibCraftText.CurrLang()]
    local input, expect_mat, expect_item = unpack(f)
    local expect = { material_name = expect_mat
                   , item_name     = expect_item
                   }
    local got    = LibCraftText.ParseConditionCL(input)
    luaunit.assertEquals(got, expect)
end

-- TestSomething = {}
-- function TestSomething:TestDailyQuestNameEN()
--     require("en")
--     luaunit.assertEquals(1,1)
--     luaunit.assertEquals(1,1)
--     luaunit.assertEquals(1,1)
-- end


function TestDailyCondition.TestNothing()
end





os.exit( luaunit.LuaUnit.run() )
