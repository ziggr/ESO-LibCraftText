LibCraftText = {}

-- Daily Crafting Writ Quests ------------------------------------------------

-- Return CRAFTING_TYPE_BLACKSMITHING for "Blacksmithing Writ" and so on.
-- Return nil if not a known daily crafting quest name.
--
-- Pass quest name from GetJournalQuestInfo()[1]:
--
--      local quest_name = GetJournalQuestInfo(i)
--      local quest_type = LibCraftText.DailyQuestNameToCraftingType(quest_name)
--
function LibCraftText.DailyQuestNameToCraftingType(quest_name)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.DAILY_QUEST_TITLES[quest_name]
end


-- Master Crafting Writ Quests -----------------------------------------------

-- Return a list of 1 or more crafting types that match the given
-- quest name.
--
-- Both Blacksmithing and Woodworking use "A Masterful Weapon" for one of
-- their possible quest names, which is why you can sometimes get a list
-- of two possible crafting types.
--
function LibCraftText.MasterQuestNameToCraftingTypeList(quest_name)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.MASTER_QUEST_TITLES[quest_name]
end

-- Turning in Master Writs to Rolis Hlaalu -----------------------------------

-- Return the crafting type that matches the given dialog option text.
-- Can return 0 for "<Finish the job.>" when the dialog text is obviously
-- some sort of master writ turn-in, but type is unknown.
--
function LibCraftText.RolisDialogOptionToCraftingType(dialog_text)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.ROLIS_QUEST_TURN_IN[dialog_text]
end


-- Daily Crafting Conditions Parser ------------------------------------------
--
-- Turn condition text into "what do I need to make/acquire?" constants.
--

-- If the supplied condition requests that we craft a weapon, armor, or jewelry
-- item at a BS/CL/WW/JW station, return the requested item and material rows
-- from LibCraftText.ITEM and LibCraftText.MATERIAL.
--
-- If the supplied condition request something else, such as a consumable
-- glyph, potion, or food, or acquire an alchemy or enchanting material,
-- return nil.
--
function LibCraftText.ParseDailyConditionEquipment(crafting_type, cond_text)
    local self      = LibCraftText
    local lang      = self.CurrLang()
    local re_list   = self.RE_CONDITION_DAILY_EQUIPMENT[lang]

                        -- Rare special case: fix buggy FR translation.
    local bugfix = self.BUGFIX[lang] and self.BUGFIX[lang][cond_text]
    if bugfix then
        cond_text = bugfix
    end
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
    local g1,g2
    for _,re in ipairs(re_list) do
        _,_,g1,g2 = string.find(cond_text, re)
        matitem = g1
        if g2 then matitem = matitem .. "/" .. g2 end
        if matitem then break end
    end
    if not matitem then
        -- print(string.format( "matitem:'%s' cond_text:'%s'"
        --                    , tostring(matitem)
        --                    , tostring(cond_text)))
        return nil
    end
    matitem = matitem:lower()

                        -- All the various lang fields that we search for
                        -- item and material names
    local item_fields = { "name", "master_name", "name_plural", "name_2" }
    local mat_fields  = { "name",                               "name_2" }

                        -- First, search for an exact match of the left(g1)
                        -- and/or right(g2) substrings. This allows us to match
                        -- short FR "lin" (a complete word for linen) instead
                        -- of erroneously matching longer, but partial, "peau"
                        -- (hide) from "chapeau"
    local exact_item  = self.ExactMatch(g1, self.ITEM, crafting_type
                            , unpack(item_fields))
                      or self.ExactMatch(g2, self.ITEM, crafting_type
                            , unpack(item_fields))

    local exact_material = self.ExactMatch(g1, self.MATERIAL , crafting_type
                            , unpack(mat_fields))
                        or self.ExactMatch(g2, self.MATERIAL , crafting_type
                            , unpack(mat_fields))

    local found    = {}
    found.item     = exact_item
                   or self.LongestMatch(matitem, self.ITEM     , crafting_type
                            , unpack(item_fields))
    found.material = exact_material
                   or self.LongestMatch(matitem, self.MATERIAL , crafting_type
                            , unpack(mat_fields))
-- VERY helpful when testing 'make gentest' for showing what matched what.
-- print(string.format( "g1:%s g2:%s e_it:%s e_mat:%s f.it:%s f.mat:%s"
--                    , tostring(g1)
--                    , tostring(g2)
--                    , tostring(exact_item     and exact_item.name    )
--                    , tostring(exact_material and exact_material.name)
--                    , tostring(found.item     and found.item.name    )
--                    , tostring(found.material and found.material.name)
--                    ))

    if not (found.item or found.material) then return nil end
    return found
end

                        -- Regexes that can extract all gear crafting
                        -- materials and items.
LibCraftText.RE_CONDITION_DAILY_EQUIPMENT = {
    ["en"] = { "Craft Normal ([^:]*)"
             , "Craft a ([^:]*)"
             , "Craft Two ([^:]*)"
             , "Craft Three ([^:]*)"
             }
,   ["de"] = { "Stellt normale (.*) her"
             , "Stellt ein[en]* (.*) her"
             , "Stellt zwei (.*) her"
             , "Stellt drei (.*) her"
             }
,   ["fr"] = { "Fabriquez [uneds]+ (.*) en (.*) norm"
             , "Fabriquez un (.*) en ([^:]*)"
             , "Fabriquez des (.*) en (.*) norm"
             , "Fabriquez deux (.*) en ([^:]*)"
             , "Fabriquez trois (.*) en ([^:]*)"
             , "Fabriquez [uneds]+ (.*) norm" -- MUST be after all "X en Y"
                                              -- regexes to keep preposition
                                              -- "en" out of matitem.
             , "Fabriquez un (.*) d'([^:]*)"
             }
,   ["ru"] = { "Craft Normal ([^:]*)"
             , "Craft a ([^:]*)"
             , "Craft two ([^:]*)"
             , "Craft three ([^:]*)"
             }
,   ["es"] = { "Fabrica [unaos]+ (.*) norm"
             , "Fabrica [unaos]+ (.*) de (.*) norm"
             , "Fabrica un (.*) de ([^:]*)"
             , "Fabrica dos (.*) de ([^:]*)"
             , "Fabrica tres (.*) de ([^:]*)"
             }
,   ["ja"] = { "(.*)%(ノーマル%)を生産する"
             , "(.*)の(.*)%(ノーマル%)を生産する"
             , "(.*)の(.*)を作る"
             , "(.*)を2個作る"
             , "(.*)を3個作る"
             }
}

                        -- The official FR French translation has a couple
                        -- condition strings that completely omit the  material
                        -- required (EN Oak FR chêne). Replace broken lines
                        -- with ones that will actually work.
LibCraftText.BUGFIX = {
    ["fr"] = {
                ["Fabriquez un bouclier normal"               ] = "Fabriquez un bouclier en chêne normal"
             ,  ["Fabriquez un bâton de rétablissement normal"] = "Fabriquez un bâton de rétablissement en chêne normal"
             }
}

LibCraftText.RE_CONDITION_ACQUIRE = {
    ["en"] = { "Acquire ([^:]*)"
             }
,   ["de"] = { "Besorgt ([^:]*)"
             , "Beschafft ([^:]*)"
             }
,   ["fr"] = { "Acquérez ([^:]*)"
             , "Acquérir ([^:]*)"
             }
,   ["ru"] = { "Раздобыть — ([^:]*)"
             , "Добыть ([^:]*)"
             , "Достать ([^:]*)"
             }
,   ["es"] = { "Adquiere ([^:]*)"
             }
,   ["ja"] = { "(.*)を手に入れる" }
}

-- If the supplied condition requests that we craft a potion or poison at
-- an AL station, return the requested item and level.
--
-- If the supplied condition requests something else, such as gear,
-- or acquire some alchemy or enchanting material, return nil.
--
function LibCraftText.ParseDailyConditionConsumable(crafting_type, cond_text)
    local self          = LibCraftText

                        -- Alchemy and Enchanting materials
    local acquire_mat = self.ParseConsumableAcquireMat(crafting_type, cond_text)
    if acquire_mat then return acquire_mat end

                        -- Provisioning Recpies
                        -- Enchanting Glyphs
                        -- Alchemy Potions/Poisons
    local craft_item = self.ParseConsumableItem(crafting_type, cond_text)
    if craft_item then return craft_item end

    return nil
end

function LibCraftText.ParseConsumableAcquireMat(crafting_type, cond_text)
    local self          = LibCraftText
    local lang          = self.CurrLang()
    local found_mat     = self.ParseRegexable(
                                   crafting_type
                                 , cond_text
                                 , self.RE_CONDITION_ACQUIRE[lang]
                                 , self.CONSUMABLE_MATERIAL
                                 , { "name", "name_2" }
                                 )
    if found_mat then
        return { material = found_mat }
    end
    return nil
end

LibCraftText.RE_CONDITION_CONSUMABLE_ITEM = {
    ["en"] = { "Craft ([^:]*)"
             }
,   ["de"] = { "Besorgt ([^:]*)"
             , "Beschafft ([^:]*)"
             }
,   ["fr"] = { "Acquérez ([^:]*)"
             , "Acquérir ([^:]*)"
             }
,   ["ru"] = { "Раздобыть — ([^:]*)"
             , "Добыть ([^:]*)"
             , "Достать ([^:]*)"
             }
,   ["es"] = { "Adquiere ([^:]*)"
             }
,   ["ja"] = { "(.*)を手に入れる" }
}

function LibCraftText.ParseConsumableItem(crafting_type, cond_text)
    local self          = LibCraftText
    local lang          = self.CurrLang()
    local found_item    = self.ParseRegexable(
                                   crafting_type
                                 , cond_text
                                 , self.RE_CONDITION_CONSUMABLE_ITEM[lang]
                                 , self.ITEM
                                 , { "name", "name_2" }
                                 )
    if found_item then
        return { item = found_item }
    end
    return nil
end

function LibCraftText.ParseRegexable( crafting_type
                                    , cond_text
                                    , re_list_list
                                    , result_list
                                    , result_name_field_list
                                    )
    local self          = LibCraftText
    local lang          = self.CurrLang()
    local cond_sub_str  = nil
    for _,re in ipairs(re_list_list) do
        _,_,g1 = string.find(cond_text, re)
        if g1 then
            cond_sub_str = g1
            break
        end
    end
    if not cond_sub_str then return nil end

    cond_sub_str = cond_sub_str:lower()
    local exact_match = self.ExactMatch(cond_sub_str, result_list , crafting_type
                            , unpack(result_name_field_list))
    if exact_match then return exact_match end

    local longest_match = self.LongestMatch(cond_sub_str, result_list , crafting_type
                            , unpack(result_name_field_list))
    if longest_match then return longest_match end

    return nil
end


-- Test Scaffolding ----------------------------------------------------------
--
-- To enable unit tests to force a specific language.
--

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


-- Internal Utility ----------------------------------------------------------


local DE_UMLAUT = { ["ä"] = "a"
                  , ["ö"] = "o"
                  , ["ü"] = "u"
                  }
function LibCraftText.DeUmlaut(t)
    tt = t
    for k,v in pairs(DE_UMLAUT) do
        tt = tt:gsub(k,v)
    end
    return tt
end
                        -- Return the row with the longest matching field.
function LibCraftText.LongestMatch(find_me, rows, crafting_type, field_name, ... )
    if not find_me then return nil end
    local self               = LibCraftText
    local longest_match      = { name=nil, row=nil }
    local find_me_lower      = find_me:lower()
    local find_me_deumlauted = self.DeUmlaut(find_me_lower)
    for _,fieldname in pairs({ field_name, ... }) do
        if not fieldname then break end
        for _, row in pairs(rows) do
            if row.crafting_type == crafting_type then
                local name = row[fieldname]
                if name then
                    name = self.escape_re(name:lower())
                    if name and (  find_me_lower:find(name)
                                 or find_me_deumlauted:find(self.DeUmlaut(name)) ) then
                        if (not longest_match.name) or (longest_match.name:len() < name:len()) then
                            longest_match.name = name
                            longest_match.row  = row
-- print(string.format("yep   find_me:'%s'  row:'%s'", find_me, name:lower()))
                        end
                    end
                end
            end
        end
    end
    return longest_match.row
end

                        -- Return the first row with an EXACT match (lowercased)
function LibCraftText.ExactMatch(find_me, rows, crafting_type, field_name, ... )
    if not find_me then return nil end
    local find_me_lower      = find_me:lower()
    local find_me_deumlauted = LibCraftText.DeUmlaut(find_me_lower)
    for _,fieldname in pairs({ field_name, ... }) do
        if not fieldname then break end
        for _, row in pairs(rows) do
            if row.crafting_type == crafting_type then
                local name = row[fieldname]
                if name and (  find_me_lower == name:lower()
                             or find_me_deumlauted == LibCraftText.DeUmlaut(name) ) then

                    return row
                end
            end
        end
    end
    return nil
end

-- Build reverse lookup tables to accelerate lookups
function LibCraftText.BuildReverseLookupTables()
    if LibCraftText.reverse_tables_built then
        return
    end

    for _,ctype in pairs(LibCraftText.CRAFTING_TYPES) do
        local txt = LibCraftText.DAILY_QUEST_TITLES[ctype]
        LibCraftText.DAILY_QUEST_TITLES[txt] = ctype

        local tlist = LibCraftText.MASTER_QUEST_TITLES[ctype]
        for _,txt in pairs(tlist) do
            if not LibCraftText.MASTER_QUEST_TITLES[txt] then
                LibCraftText.MASTER_QUEST_TITLES[txt] = {}
            end
            table.insert(LibCraftText.MASTER_QUEST_TITLES[txt], ctype)
        end

        local txt = LibCraftText.ROLIS_QUEST_TURN_IN[ctype]
        LibCraftText.ROLIS_QUEST_TURN_IN[txt] = ctype
    end

    LibCraftText.reverse_tables_built = true
end

LibCraftText.CRAFTING_TYPES = {
  CRAFTING_TYPE_BLACKSMITHING
, CRAFTING_TYPE_CLOTHIER
, CRAFTING_TYPE_ENCHANTING
, CRAFTING_TYPE_ALCHEMY
, CRAFTING_TYPE_PROVISIONING
, CRAFTING_TYPE_WOODWORKING
, CRAFTING_TYPE_JEWELRYCRAFTING
}


                        -- Convert hyphen-carrying FR French "épine-de-dragon"
                        -- into something that can we can successfully pass
                        -- as a search expression to string.find().
function LibCraftText.escape_re(t)
    local r = t:gsub("%%","%%%%")
    r       = r:gsub("-" ,"%%-" )
    return r
end


-- To help see surprise unicode chars like non-breaking-space.
local function hex_dump(buf)
  for i=1,math.ceil(#buf/16) * 16 do
     if (i-1) % 16 == 0 then io.write(string.format('%08X  ', i-1)) end
     io.write( i > #buf and '   ' or string.format('%02X ', buf:byte(i)) )
     if i %  8 == 0 then io.write(' ') end
     if i % 16 == 0 then io.write( buf:sub(i-16+1, i):gsub('%c','.'), '\n' ) end
  end
end
