package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")
require("utils_test")
luaunit = require("luaunit")

TestDailyCondition = {}
TestDailyCondition.setUpOuter =  Test.setUpOuter
TestDailyCondition.setUp      =  Test.setUp


-- Belonga LCT ---------------------------------------------------------------



-- End Belonga LCT -----------------------------------------------------------


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

function TestDailyCondition.TestPR()
    local fodder = {
      { {
          ["en"] = "Craft Firsthold Fruit and Cheese Plate: 0 / 1"
        , ["de"] = "Stellt eine Ersthalt-Käseplatte mit Früchten her: 0/1"
        , ["fr"] = "Préparez un plateau de fruits et de fromage de Prime-Tenure : 0/1"
        , ["es"] = "Preparæ plato de frutas y queso de Primada: 0/1"
        , ["ru"] = "Создать — сырная тарелка с фруктами по-фестхолдски: 0 / 1"
        , ["ja"] = "ファーストホールドの果実とチーズのプレートを生産する: 0 / 1"
        }
      , nil
      }
    , { {
          ["en"] = "Craft Muthsera's Remorse: 0 / 1"
        , ["de"] = "Stellt Muthseras Reue her: 0/1"
        , ["fr"] = "Préparez un remords de Muthséra : 0/1"
        , ["es"] = "Preparæ remordimiento de muthsera: 0/1"
        , ["ru"] = "Создать — «Раскаяние мутсэры»: 0 / 1"
        , ["ja"] = "ムスセラの良心の呵責を生産する: 0 / 1"
        }
      , nil
      }
    }
    for _,f in ipairs(fodder) do
        local input  = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = f[2]
        local got    = LibCraftText.ParseDailyConditionGear(jw, input)
        luaunit.assertEquals(got, expect)
    end
end

function TestDailyCondition.TestWW()
    local fodder = {
      { {
          ["en"] = "Craft Normal Ruby Ash Bow: 0 / 2"
        , ["de"] = "Stellt normale Rubineschenbögen her: 0/2"
        , ["fr"] = "Fabriquez un arc en frêne roux normal : 0/2"
        , ["es"] = "Fabrica un arco de fresno rubí normal: 0/2"
        , ["it"] = "Craft Ruby Ash Bow: 0 / 2"
        , ["ja"] = "ルビーアッシュの弓(ノーマル)を生産する: 0 / 2"
        }
      , LCT.MATERIAL.RUBY_ASH
      , LCT.ITEM.BOW
      }
    , { {
          ["en"] = "Craft Normal Ruby Ash Shield: 0 / 1"
        , ["de"] = "Stellt normale Rubineschenschilde her: 0/1"
        , ["fr"] = "Fabriquez un bouclier en frêne roux normal : 0/1"
        , ["es"] = "Fabrica un escudo de fresno rubí normal: 0/1"
        , ["it"] = "Craft Ruby Ash Shield: 0 / 1"
        , ["ja"] = "ルビーアッシュの盾(ノーマル)を生産する: 0 / 1"
        }
      , LCT.MATERIAL.RUBY_ASH
      , LCT.ITEM.SHIELD
      }
    }
    for _,f in ipairs(fodder) do
        local input  = f[1][LibCraftText.CurrLang()]
        if not input then return end
        local expect = { material = f[2]
                       , item     = f[3]
                       }
        local got    = LibCraftText.ParseDailyConditionGear(ww, input)
        luaunit.assertEquals(got, expect)
    end
end

local COND_TEXT_EN = {}

function TestDailyCondition.TestLangDBConditions()
                        -- Scan through all condition text to make sure
                        -- that it doesn't crash the parser.
                        --
                        -- Does NOT check for correct result.
                        -- Do that elsewhere.
    dofile("data/lang_db.lua")
    for k,lang_table in pairs(LANG_DB) do
        local key   = lang_table.key
        if key:find("$DAILY_COND_") then
            TestDailyCondition.OneLangDBCondition(lang_table)
        end
    end

    --                     -- NOT part of this text, just tinkering around
    -- if (LibCraftText.CurrLang() == "en") then
    --     local cond_text_list = {}
    --     for cond_text,_ in pairs(COND_TEXT_EN) do
    --         table.insert(cond_text_list,cond_text)
    --     end
    --     table.sort(cond_text_list)
    --     for _,cond_text in ipairs(cond_text_list) do
    --         print(string.format(", { %-50s, }", '"'..cond_text..'"'))
    --     end
    -- end
end

local ABBREV_R = {
    ["bs"] = bs
,   ["cl"] = cl
,   ["en"] = en
,   ["al"] = al
,   ["pr"] = pr
,   ["ww"] = ww
,   ["jw"] = jw
}
function TestDailyCondition.OneLangDBCondition(lang_table)
    local key       = lang_table.key
    local _,_,ctxt = key:find("$DAILY_COND_(..)_")
    if not ctxt then return end
    local crafting_type = ABBREV_R[ctxt:lower()]

    local cond_text = lang_table[LibCraftText.CurrLang()]
    if not cond_text then return end
    local result = LibCraftText.ParseDailyConditionGear(crafting_text, cond_text)


    --                     -- NOT part of this test, just tinkering around.
    -- if (LibCraftText.CurrLang() == "en") then
    --     COND_TEXT_EN[cond_text] = crafting_type
    -- end
end


os.exit( luaunit.LuaUnit.run() )
