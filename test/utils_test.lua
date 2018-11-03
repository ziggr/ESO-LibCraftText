-- Code common to multiple test suites.

local function Warn(msg)
    print(msg)
end

-- Testing scaffolding
CRAFTING_TYPE_BLACKSMITHING     = 1
CRAFTING_TYPE_CLOTHIER          = 2
CRAFTING_TYPE_ENCHANTING        = 3
CRAFTING_TYPE_ALCHEMY           = 4
CRAFTING_TYPE_PROVISIONING      = 5
CRAFTING_TYPE_WOODWORKING       = 6
CRAFTING_TYPE_JEWELRYCRAFTING   = 7

-- for less typing
bs = CRAFTING_TYPE_BLACKSMITHING
cl = CRAFTING_TYPE_CLOTHIER
en = CRAFTING_TYPE_ENCHANTING
al = CRAFTING_TYPE_ALCHEMY
pr = CRAFTING_TYPE_PROVISIONING
ww = CRAFTING_TYPE_WOODWORKING
jw = CRAFTING_TYPE_JEWELRYCRAFTING

LCT = LibCraftText

Test = {}

                        -- The 6 supported languages. Italian is not yet
                        -- supported because its translation is partial:
                        -- instead of "Craft a Platinum Ring: 0 / 1", Italian
                        -- displays information-free "TRACKER GOAL TEXT: 0 / 1"
                        --
LANG_ORDER = { "en", "de", "fr", "ru", "es", "ja" }

Test = {}

-- Zig modified luaunit.lua to call this new function once outside of
-- any `--repeat N` iteration. This lets us reset the language cycle
-- back to "en" at the start of each individual .TestX() function's iteration.
function Test:setUpOuter()
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
function Test:setUp()
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
