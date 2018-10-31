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

-- for less typing
local bs = CRAFTING_TYPE_BLACKSMITHING
local cl = CRAFTING_TYPE_CLOTHIER
local en = CRAFTING_TYPE_ENCHANTING
local al = CRAFTING_TYPE_ALCHEMY
local pr = CRAFTING_TYPE_PROVISIONING
local ww = CRAFTING_TYPE_WOODWORKING
local jw = CRAFTING_TYPE_JEWELRYCRAFTING

local LCT = LibCraftText

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

-- DAILY crafting conditions

LibCraftText.RE_CONDITION_DAILY = {
    ["en"] = "Craft Normal (.*): 0 / 1"
,   ["de"] = "Stellt normale (.*) her: 0/1"
,   ["fr"] = "Fabriquez une? (.*) en (.*) normal : 0/1"
,   ["ru"] = "Craft Normal (.*): 0 / 1"
,   ["es"] = "Fabrica une? (.*) de (.*) normal: 0/1"
,   ["it"] = "Craft (.*): 0 / 1"
,   ["ja"] = "(.*)の(.*)%(ノーマル%)を生産する: 0 / 1"
}

-- If the supplied condition requests that we craft a weapon, armor, or jewelry
-- item at a BS/CL/WW/JW station, return the requested item and material rows
-- from LibCraftText.ITEM and LibCraftText.MATERIAL.
--
-- If the supplied condition request something else, such as a consumable
-- glyph, potion, or food, or acquire an alchemy or enchanting material,
-- return nil.
--
function LibCraftText.ParseDailyConditionGear(crafting_type, cond_text, re)
    local self  = LibCraftText
    local lang  = self.CurrLang()
    local re    = self.RE_CONDITION_DAILY[lang]

                        -- Some languages put material (adjective) before
                        -- item (noun). Others put the material after.
                        --
                        -- It is nigh impossible to use a regex to detect the
                        -- boundary between "Rubedoleder" and "helme" in
                        -- "Rubedolederhelme", especially for all combinations
                        -- of material, item, and language. So instead, we loop
                        -- through known materials and items looking for
                        -- matches.
                        --
                        -- Smush g1 and g2 into a single string that we can
                        -- search.
    local _,_,g1,g2 = string.find(cond_text, re)
    local matitem = g1
    if g2 then matitem = matitem .. "/" .. g2 end
    if not matitem then return nil end
    matitem = matitem:lower()

    local found    = {}
    found.item     = self.LongestMatch(matitem, self.ITEM,     "name", crafting_type)
    found.material = self.LongestMatch(matitem, self.MATERIAL, "name", crafting_type)
    return found
end

                        -- Return the row with the longest matching field.
function LibCraftText.LongestMatch(find_me, rows, field_name, crafting_type)
    local longest_match   = { name=nil, row=nil }
    local field_name      = "name"
    for _, row in pairs(rows) do
        if row.crafting_type == crafting_type then
            local name = row[field_name]
            if find_me:find(name:lower()) then
                if (not longest_match.name) or (longest_match.name:len() < name:len()) then
                    longest_match.name = name
                    longest_match.row  = row
                end
            end
        end
    end
    return longest_match.row
end

-- End Belonga LCT -----------------------------------------------------------

                        -- The 6 supported languages. Italian is not yet
                        -- supported because its translation is partial:
                        -- instead of "Craft a Platinum Ring: 0 / 1", Italian
                        -- displays information-free "TRACKER GOAL TEXT: 0 / 1"
                        --
LANG_ORDER = { "en", "de", "fr", "ru", "es", "ja" }

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

function TestDailyCondition.TestAL()
    local fodder = {
      ["en"] = { "Craft Essence of Stamina: 0 / 1"         , nil }
    , ["de"] = { "Stellt Essenzen der Ausdauer her: 0/1"   , nil }
    , ["fr"] = { "Fabriquez une essence de Vigueur : 0/1"  , nil }
    , ["es"] = { "Prepara una esencia de aguante: 0/1"     , nil }
    , ["it"] = { "TRACKER GOAL TEXT: 0 / 1"                , nil }
    , ["ja"] = { "スタミナのエキスを生産する: 0 / 1"           , nil }
    }
    local f = fodder[LibCraftText.CurrLang()]
    if not f then return end

    local expect = nil
    local got    = LibCraftText.ParseDailyConditionGear(al, f[1])
    luaunit.assertEquals(got, expect)
end

function TestDailyCondition.TestBS()
    local fodder = {
      ["en"] = { "Craft Normal Rubedite Helm: 0 / 1"           , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM }
    , ["de"] = { "Stellt normale Rubedithauben her: 0/1"       , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM } -- what about the extra "n" in "hauben" ? Direct object declension?
    , ["fr"] = { "Fabriquez un heaume en cuprite normal : 0/1" , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM }
    , ["es"] = { "Fabrica un yelmo de rubedita normal: 0/1"    , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM }
    --["it"] = { "Craft Rubedite Helm: 0 / 1"                  , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM }
    , ["ja"] = { "ルベダイトの兜(ノーマル)を生産する: 0 / 1"        , LCT.MATERIAL.RUBEDITE, LCT.ITEM.HELM }
    }
    local f = fodder[LibCraftText.CurrLang()]
    if not f then return end

    local expect = { material = f[2]
                   , item     = f[3]
                   }
    local got    = LibCraftText.ParseDailyConditionGear(bs, f[1])
    luaunit.assertEquals(got, expect)
end

function TestDailyCondition.TestCL()
    local fodder = {
      ["en"] = { "Craft Normal Rubedo Leather Helmet: 0 / 1"       , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    , ["de"] = { "Stellt normale Rubedolederhelme her: 0/1"        , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET } -- what about that trailing "e" on "helme"?
    , ["fr"] = { "Fabriquez un casque en cuir pourpre normal : 0/1", LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    , ["ru"] = { "Craft Normal Rubedo Leather Helmet: 0 / 1"       , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    , ["es"] = { "Fabrica un casco de cuero rubedo normal: 0/1"    , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    --["it"] = { "Craft Rubedo Leather Helmet: 0 / 1"              , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    , ["ja"] = { "ルベドレザーの兜(ノーマル)を生産する: 0 / 1"           , LCT.MATERIAL.RUBEDO_LEATHER, LCT.ITEM.HELMET }
    }
    local f = fodder[LibCraftText.CurrLang()]
    if not f then return end

    local expect = { material = f[2]
                   , item     = f[3]
                   }
    local got    = LibCraftText.ParseDailyConditionGear(cl, f[1])
    luaunit.assertEquals(got, expect)
end


function TestDailyCondition.TestNothing()
end





os.exit( luaunit.LuaUnit.run() )
