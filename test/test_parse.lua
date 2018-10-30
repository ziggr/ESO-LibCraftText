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


TestSomething = {}

function TestSomething:TestDailyQuestNameEN()
    require("en")
    luaunit.assertEquals(1,2)
end








os.exit( luaunit.LuaUnit.run() )
