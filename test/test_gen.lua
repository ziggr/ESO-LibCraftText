package.path = package.path..";test/?.lua;lang/?.lua"
require("../LibCraftText")

luaunit = require("luaunit")

local LCT = LibCraftText

TestGen = {}

function TestGen

os.exit( luaunit.LuaUnit.run() )
