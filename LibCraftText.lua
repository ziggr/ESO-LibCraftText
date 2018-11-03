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
function LibCraftText.RolixDialogOptionToCraftingType(dialog_text)
    LibCraftText.BuildReverseLookupTables()
    return LibCraftText.ROLIS_QUEST_TURN_IN[dialog_text]
end


-- Internal stuff ------------------------------------------------------------

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


-- Daily Crafting Conditions Parser ------------------------------------------
--
-- Turn condition text into "what do I need to make/acquire?" constants.
--

LibCraftText.RE_CONDITION_DAILY = {
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

-- Linen Hat is broken, the "peau" in "chapeau en lin" matches mat X and is longer than the "lin" for Linen.
-- Oak Shield is broken, "Fabriquez un bouclier normal" should include "en chêne" somewhere.

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
             }
,   ["es"] = { "Fabrica [unaos]+ (.*) de (.*) norm"
             , "Fabrica un (.*) de ([^:]*)"
             }
,   ["ja"] = { "(.*)の(.*)%(ノーマル%)を生産する"
             , "(.*)の(.*)を作る"
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
    local g1,g2
    for _,re in ipairs(re_list) do
        _,_,g1,g2 = string.find(cond_text, re)
        matitem = g1
        if g2 then matitem = matitem .. "/" .. g2 end
        if matitem then break end

        -- print(string.format( "matitem:'%s' cond_text:'%s'  re:'%s'"
        --                    , tostring(matitem)
        --                    , tostring(cond_text)
        --                    , tostring(re)
        --                    ))
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

-- If the supplied condition requests that we craft a potion or poison at
-- an AL station, return the requested item and level.
--
-- If the supplied condition requests something else, such as gear,
-- or acquire some alchemy or enchanting material, return nil.
--
function LibCraftText.ParseDailyConditionCraftAL(cond_text)
    return "Essence of Stamina"
end

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
    local longest_match      = { name=nil, row=nil }
    local find_me_lower      = find_me:lower()
    local find_me_deumlauted = LibCraftText.DeUmlaut(find_me_lower)
    for _,fieldname in pairs({ field_name, ... }) do
        if not fieldname then break end
        for _, row in pairs(rows) do
            if row.crafting_type == crafting_type then
                local name = row[fieldname]
                if name and (  find_me_lower:find(name:lower())
                             or find_me_deumlauted:find(LibCraftText.DeUmlaut(name)) ) then
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
