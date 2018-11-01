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
    ["en"] = { "Craft Normal (.*): 0 / 1"
             , "Craft a (.*): 0 / 1"
             }
,   ["de"] = { "Stellt normale (.*) her: 0/1"
             , "Stellt ein[en]* (.*) her: 0/1"
             }
,   ["fr"] = { "Fabriquez [uneds]+ (.*) en (.*) norma[lesaux]* : 0/1"
             , "Fabriquez un (.*) en (.*): 0/1"
             }
,   ["ru"] = { "Craft Normal (.*): 0 / 1"
             , "Craft a (.*): 0 / 1"
             }
,   ["es"] = { "Fabrica [unaos]+ (.*) de (.*) normal[es]*: 0/1"
             , "Fabrica un (.*) de (.*): 0/1"
             }
,   ["ja"] = { "(.*)の(.*)%(ノーマル%)を生産する: 0 / 1"
             , "(.*)の(.*)を作る: 0 / 1"
             }
}

-- If the supplied condition requests that we craft a weapon, armor, or jewelry
-- item at a BS/CL/WW/JW station, return the requested item and material rows
-- from LibCraftText.ITEM and LibCraftText.MATERIAL.
--
-- If the supplied condition request something else, such as a consumable
-- glyph, potion, or food, or acquire an alchemy or enchanting material,
-- return nil.
--
function LibCraftText.ParseDailyConditionGear(crafting_type, cond_text)
    local self      = LibCraftText
    local lang      = self.CurrLang()
    local re_list   = self.RE_CONDITION_DAILY[lang]

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
    local matitem = nil
    for _,re in ipairs(re_list) do
        local _,_,g1,g2 = string.find(cond_text, re)
        matitem = g1
        if g2 then matitem = matitem .. "/" .. g2 end
        if matitem then break end
    end
    if not matitem then
        -- print(string.format( "matitem:'%s' cond_text:'%s"
        --                    , tostring(matitem)
        --                    , ,tostring(cond_text)))
        return nil
    end
    matitem = matitem:lower()

    local found    = {}
    found.item     = self.LongestMatch(matitem, self.ITEM,     "name", crafting_type, "master_name")
    found.material = self.LongestMatch(matitem, self.MATERIAL, "name", crafting_type)
    if not (found.item or found.material) then return nil end
    return found
end

                        -- Return the row with the longest matching field.
function LibCraftText.LongestMatch(find_me, rows, field_name, crafting_type, optional_field_name_2)
    local longest_match   = { name=nil, row=nil }
    for _,fieldname in pairs({ field_name, optional_field_name_2 }) do
        if not fieldname then break end
        for _, row in pairs(rows) do
            if row.crafting_type == crafting_type then
                local name = row[fieldname]
                if find_me:find(name:lower()) then
                    if (not longest_match.name) or (longest_match.name:len() < name:len()) then
                        longest_match.name = name
                        longest_match.row  = row
-- print(string.format("yep   find_me:'%s'  row:'%s'", find_me, name:lower()))
                    end
-- else print(string.format("nope  find_me:'%s'  row:'%s'", find_me, name:lower()))
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
      { {
          ["en"] = "Craft Essence of Stamina: 0 / 1"
        , ["de"] = "Stellt Essenzen der Ausdauer her: 0/1"
        , ["fr"] = "Fabriquez une essence de Vigueur : 0/1"
        , ["es"] = "Prepara una esencia de aguante: 0/1"
        , ["ja"] = "スタミナのエキスを生産する: 0 / 1"
        }
      , nil  -- NEEDS TO CHANGE TO potion/poison, level, effect list
      }
    , { {
          ["en"] = "Acquire Mudcrab Chitin: 3 / 3"
        , ["de"] = "Besorgt etwas Schlammkrabbenchitin: 3/3"
        , ["fr"] = "Acquérez une chitine de vasard : 3/3"
        , ["es"] = "Adquiere quitina de cangrejo del barro: 3/3"
        , ["it"] = "TRACKER GOAL TEXT: 3 / 3"
        , ["ru"] = "Раздобыть — Хитин грязевого краба: 3 / 3"
        , ["ja"] = "マッドクラブキチンを手に入れる: 3 / 3"
        }
      , nil
      }
    }
    for _,f in ipairs(fodder) do
        local input  = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = f[2]
        local got    = LibCraftText.ParseDailyConditionGear(al, input)
        luaunit.assertEquals(got, expect)
    end
end

function TestDailyCondition.TestBS()

    local fodder = {
      { {
          ["en"] = "Craft Normal Rubedite Helm: 0 / 1"
        , ["de"] = "Stellt normale Rubedithauben her: 0/1"        -- what about the extra "n" in "hauben" ? Direct object declension?
        , ["fr"] = "Fabriquez un heaume en cuprite normal : 0/1"
        , ["es"] = "Fabrica un yelmo de rubedita normal: 0/1"
        , ["ja"] = "ルベダイトの兜(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDITE
      , LCT.ITEM.HELM
      }
    , { {
          ["en"] = "Craft Normal Rubedite Dagger: 0 / 1"
        , ["de"] = "Stellt normale Rubeditdolche her: 0/1"
        , ["fr"] = "Fabriquez une dague en cuprite normale : 0/1"
        , ["es"] = "Fabrica una daga de rubedita normal: 0/1"
        , ["ja"] = "ルベダイトの短剣(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDITE
      , LCT.ITEM.DAGGER
      }
    , { {
          ["en"] = "Craft Normal Rubedite Pauldron: 0 / 1"
        , ["de"] = "Stellt normale Rubeditschulterschutze her: 0/1"
        , ["fr"] = "Fabriquez des spallières en cuprite normales : 0/1"
        , ["es"] = "Fabrica unos espaldarones de rubedita normales: 0/1"
        , ["ja"] = "ルベダイトのポールドロン(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDITE
      , LCT.ITEM.PAULDRON
      }
    }
    for _,f in ipairs(fodder) do
        local input = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = { material = f[2]
                       , item     = f[3]
                       }
        local got    = LibCraftText.ParseDailyConditionGear(bs, input)
        luaunit.assertEquals(got, expect)
    end
end

function TestDailyCondition.TestCL()
    local fodder = {
      { {
          ["en"] = "Craft Normal Rubedo Leather Helmet: 0 / 1"
        , ["de"] = "Stellt normale Rubedolederhelme her: 0/1"
        , ["fr"] = "Fabriquez un casque en cuir pourpre normal : 0/1"
        , ["ru"] = "Craft Normal Rubedo Leather Helmet: 0 / 1"
        , ["es"] = "Fabrica un casco de cuero rubedo normal: 0/1"
        , ["ja"] = "ルベドレザーの兜(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDO_LEATHER
      , LCT.ITEM.HELMET
      }
      , { {
            ["en"] = "Craft Normal Rubedo Leather Arm Cops: 0 / 1"
          , ["de"] = "Stellt normale Rubedolederschulterkappen her: 0/1"
          , ["fr"] = "Fabriquez des coques d'épaules en cuir pourpre normales : 0/1"
          , ["es"] = "Fabrica unas hombreras de cuero rubedo normales: 0/1"
          , ["ja"] = "ルベドレザーのアームカップ(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDO_LEATHER
      , LCT.ITEM.ARM_COPS
      }
      , { {
            ["en"] = "Craft Normal Rubedo Leather Bracers: 0 / 1"
          , ["de"] = "Stellt normale Rubedolederarmschienen her: 0/1"
          , ["fr"] = "Fabriquez des brassards en cuir pourpre normaux : 0/1"
          , ["es"] = "Fabrica unos brazales de cuero rubedo normales: 0/1"
          , ["ja"] = "ルベドレザーの腕当て(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBEDO_LEATHER
      , LCT.ITEM.BRACERS
      }

    }
    for _,f in ipairs(fodder) do
        local input = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = { material = f[2]
                       , item     = f[3]
                       }
        local got    = LibCraftText.ParseDailyConditionGear(cl, input)
        luaunit.assertEquals(got, expect)
    end
end

function TestDailyCondition.TestEN()
    local fodder = {
      { {
          ["en"] = "Craft Essence of Stamina: 0 / 1"
        , ["de"] = "Stellt Essenzen der Ausdauer her: 0/1"
        , ["fr"] = "Fabriquez une essence de Vigueur : 0/1"
        , ["es"] = "Prepara una esencia de aguante: 0/1"
        , ["ja"] = "スタミナのエキスを生産する: 0 / 1"
        }
      , nil  -- NEEDS TO CHANGE TO potion/poison, level, effect list
      }
    , { {
          ["en"] = "Acquire Mudcrab Chitin: 3 / 3"
        , ["de"] = "Besorgt etwas Schlammkrabbenchitin: 3/3"
        , ["fr"] = "Acquérez une chitine de vasard : 3/3"
        , ["es"] = "Adquiere quitina de cangrejo del barro: 3/3"
        , ["it"] = "TRACKER GOAL TEXT: 3 / 3"
        , ["ru"] = "Раздобыть — Хитин грязевого краба: 3 / 3"
        , ["ja"] = "マッドクラブキチンを手に入れる: 3 / 3"
        }
      , nil  -- NEEDS TO CHANGE TO potion/poison, level, effect list
      }
    , { {
          ["en"]  = "Craft Superb Glyph of Stamina With Ta: 0 / 1"
        , ["de"]  = "Stellt mit einer Ta-Rune eine prächtige Glyphe der Ausdauer her: 0/1"
        , ["fr"]  = "Fabriquez un glyphe de Vigueur superbe avec Ta : 0/1"
        , ["es"]  = "Fabrica un glifo soberbio de aguante con Ta: 0/1"
        , ["ja"]  = "ターの最上のグリフ(スタミナ)を生産する: 0 / 1"
        }
      , nil  -- NEEDS TO CHANGE TO potion/poison, level, effect list
      }
    , { {
          ["en"]  = "Acquire Ta Aspect Rune: 1 / 1"
        , ["de"]  = "Beschafft eine Ta-Aspektrune: 1/1"
        , ["fr"]  = "Acquérez une rune d'aspect Ta : 1/1"
        , ["es"]  = "Adquiere una runa de aspecto Ta: 1/1"
        , ["ru"]  = "Добыть руну аспекта Та: 1 / 1"
        , ["ja"]  = "ターの品質ルーンを手に入れる: 1 / 1"
        }
      , nil  -- NEEDS TO CHANGE TO potion/poison, level, effect list
      }
    }
    for _,f in ipairs(fodder) do
        local input  = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = f[2]
        local got    = LibCraftText.ParseDailyConditionGear(al, input)
        luaunit.assertEquals(got, expect)
    end
end

function TestDailyCondition.TestJW()
    local fodder = {
      { {
          ["en"] = "Craft a Platinum Ring: 0 / 1"
        , ["de"] = "Stellt einen Platinring her: 0/1"
        , ["fr"] = "Fabriquez un anneau en platine : 0/1"
        , ["es"] = "Fabrica un anillo de platino: 0/1"
        , ["ja"] = "プラチナの指輪を作る: 0 / 1"
        }
      , LCT.MATERIAL.PLATINUM
      , LCT.ITEM.RING
      }
    , { {
          ["en"] = "Craft a Platinum Necklace: 0 / 1"
        , ["de"] = "Stellt eine Platinhalskette her: 0/1"
        , ["fr"] = "Fabriquez un collier en platine : 0/1"
        , ["es"] = "Fabrica un collar de platino: 0/1"
        , ["ja"] = "プラチナのネックレスを作る: 0 / 1"
        }
      , LCT.MATERIAL.PLATINUM
      , LCT.ITEM.NECKLACE
      }
    }
    for _,f in ipairs(fodder) do
        local input  = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = { material = f[2]
                       , item     = f[3]
                       }
        local got    = LibCraftText.ParseDailyConditionGear(jw, input)
        luaunit.assertEquals(got, expect)
    end
end





os.exit( luaunit.LuaUnit.run() )
