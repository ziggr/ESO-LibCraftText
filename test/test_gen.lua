package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")
require("utils_test")
luaunit = require("luaunit")

TestGen            = {}
TestGen.setUpOuter =  Test.setUpOuter
TestGen.setUp      =  Test.setUp

function TestGen.TestNothing()
    luaunit.assertEquals(1,1)
end

os.exit( luaunit.LuaUnit.run() )
