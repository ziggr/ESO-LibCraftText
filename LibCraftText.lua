LibCraftText = LibCraftText or {}

local function ZZDEBUG_ON(msg, ...) print(string.format(msg, ...)) end
local function ZZDEBUG_OFF(msg, ...) end
local ZZDEBUG = ZZDEBUG_OFF
-- local ZZDEBUG_ALLOWED = true -- Define this as a global in your test script

                        -- So that this file can run in tests, outside of ESO.
local CRAFTING_TYPE_BLACKSMITHING   = CRAFTING_TYPE_BLACKSMITHING   or 1
local CRAFTING_TYPE_CLOTHIER        = CRAFTING_TYPE_CLOTHIER        or 2
local CRAFTING_TYPE_ENCHANTING      = CRAFTING_TYPE_ENCHANTING      or 3
local CRAFTING_TYPE_ALCHEMY         = CRAFTING_TYPE_ALCHEMY         or 4
local CRAFTING_TYPE_PROVISIONING    = CRAFTING_TYPE_PROVISIONING    or 5
local CRAFTING_TYPE_WOODWORKING     = CRAFTING_TYPE_WOODWORKING     or 6
local CRAFTING_TYPE_JEWELRYCRAFTING = CRAFTING_TYPE_JEWELRYCRAFTING or 7

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

-- Return a table that describes what this quest condtion requires.
--
-- Table fields vary depending on crafting type and condition, but field
-- values will be rows from lang/xx.lua tables.
--
--              BS/CL/WW/JW         "Craft Normal Rubedite Sword"
-- item         ITEM                H1_SWORD
-- material     MATERIAL            RUBEDITE
--
--              Enchanting          "Craft Grand Glyph of Health With Ta"
-- potency      MATERIAL            DERADO
-- essence      "                   OKO
-- aspect       "                   TA
--
--              Alchemy             "Craft Essence of Ravage Health"
-- trait        ALCHEMY_TRAIT       RAVAGE_HEALTH
-- solvent      MATERIAL            LORKHANS_TEARS
--
--              Provisioning        "Craft Baked Potato"
-- item         RECIPE              BAKED_POTATO
--
--              Enchanting, Alchemy "Acquire Ta Aspect Rune"
-- material     MATERIAL            TA
--
--              Miscellaneous       "Deliver Goods to Nearest Writ Quartermaster"
-- misc         DAILY_COND          DELIVER_NEAREST_QUARTERMASTER
--
function LibCraftText.ParseDailyCondition(crafting_type, cond_text)

    if not LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER then
        LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER = {
            [CRAFTING_TYPE_BLACKSMITHING  ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_CLOTHIER       ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_ENCHANTING     ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_ALCHEMY        ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_PROVISIONING   ] = LibCraftText.ParseDailyConditionConsumable
        ,   [CRAFTING_TYPE_WOODWORKING    ] = LibCraftText.ParseDailyConditionEquipment
        ,   [CRAFTING_TYPE_JEWELRYCRAFTING] = LibCraftText.ParseDailyConditionEquipment
        }
    end

    local func = nil
    if crafting_type then
        func = LibCraftText.CRAFTING_TYPE_TO_DAILY_PARSER[crafting_type]
    end
    if not func then
        func = LibCraftText.ParseDailyConditionMisc
    end
    return func(crafting_type, cond_text)
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

function LibCraftText.ParseMasterCondition(crafting_type, cond_text)
    if not LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER then
        LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER = {
            [CRAFTING_TYPE_BLACKSMITHING  ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_CLOTHIER       ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_ENCHANTING     ] = LibCraftText.ParseMasterConditionEnchanting
        ,   [CRAFTING_TYPE_ALCHEMY        ] = LibCraftText.ParseMasterConditionAlchemy
        ,   [CRAFTING_TYPE_PROVISIONING   ] = LibCraftText.ParseMasterConditionProvisioning
        ,   [CRAFTING_TYPE_WOODWORKING    ] = LibCraftText.ParseMasterConditionEquipment
        ,   [CRAFTING_TYPE_JEWELRYCRAFTING] = LibCraftText.ParseMasterConditionEquipment
        }
    end

    local func = nil
    if crafting_type then
        func = LibCraftText.CRAFTING_TYPE_TO_MASTER_PARSER[crafting_type]
    end
    if not func then
        func = LibCraftText.ParseMasterConditionMisc
    end
    return func(crafting_type, cond_text)
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
    if not (found.item or found.material) then return nil end
    return found
end
                        -- Regexes that can extract all gear crafting
                        -- materials and items.
LibCraftText.RE_CONDITION_DAILY_EQUIPMENT = {
    ["en"] = { "Craft Normal ([^:]*)"
             , "Craft an? ([^:]*)"
             , "Craft Two ([^:]*)"
             , "Craft Three ([^:]*)"
             }
,   ["de"] = { "Stellt normale (.*) her"
             , "Stellt ein[enig]* (.*) her"
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
             , "Fabriquez [uneds]+ (.*) en (.*) avec"
             }
,   ["ru"] = { "Craft Normal ([^:]*)"
             , "Craft an? ([^:]*)"
             , "Craft two ([^:]*)"
             , "Craft three ([^:]*)"
             , "Создать предмет %((.*)%) со следующими"
             }
,   ["es"] = { "Fabrica [unaos]+ (.*) norm"
             , "Fabrica [unaos]+ (.*) de (.*) norm"
             , "Fabrica un (.*) de ([^:]*)"
             , "Fabrica dos (.*) de ([^:]*)"
             , "Fabrica tres (.*) de ([^:]*)"
             , "Fabricar: (.*) con los"
             }
,   ["ja"] = { "(.*)%(ノーマル%)を生産する"
             , "(.*)の(.*)%(ノーマル%)を生産する"
             , "(.*)の(.*)を作る"
             , "(.*)を2個作る"
             , "(.*)を3個作る"
             , "Craft a (.*) with the"
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
    if acquire_mat then
        return acquire_mat
    end

                        -- Enchanting Glyphs
    if crafting_type == CRAFTING_TYPE_ENCHANTING then
        return self.ParseDailyConditionGlyph(cond_text)
    end
                        -- Provisioning Recpies
    if crafting_type == CRAFTING_TYPE_PROVISIONING then
        return self.ParseDailyConditionProvisioning(cond_text)
    end
                        -- Alchemy Potions/Poisons
    if crafting_type == CRAFTING_TYPE_ALCHEMY then
        return self.ParseDailyConditionAlchemy(cond_text)
    end

    return nil
end

function LibCraftText.ParseConsumableAcquireMat(crafting_type, cond_text)
                        -- Only Enchanting and Alchemy have "Acquire Ta" and
                        -- "Acquire Nirnroot" conditions.
    if not (crafting_type == CRAFTING_TYPE_ENCHANTING
         or crafting_type == CRAFTING_TYPE_ALCHEMY) then
        return nil
    end

    local self          = LibCraftText
    local lang          = self.CurrLang()
    local found_mat     = self.ParseRegexableOptional(
                                   crafting_type
                                 , cond_text
                                 , self.RE_CONDITION_ACQUIRE[lang]
                                 , self.MATERIAL
                                 , { "name", "name_2" }
                                 )
    if found_mat then
        return { material = found_mat }
    end
    return nil
end


LibCraftText.RE_CONDITION_DAILY_RECIPE = {
    ["en"] = { "Craft ([^:]*)"
             }
,   ["de"] = { "Stellt [etwaseinige]+ (.*) her"
             , "Stellt (.*) her"
             }
,   ["fr"] = { "Préparez [uneds]+ ([^\n]*)"
             , "Fabriquez [uneds]+ ([^\n]*)"
             }
,   ["ru"] = { "Создать — ([^\n]*)"
             , "Создать предмет:\n([^\n]*)"
             }
,   ["es"] = { "Preparæ ([^\n]*)"
             }
,   ["ja"] = { "(.*)を生産する"
             , "Craft a ([^\n]*)"
             }
}

function LibCraftText.ParseDailyConditionProvisioning(cond_text)
    local self          = LibCraftText
    local lang          = self.CurrLang()
    local args          = { nil
                          , cond_text
                          , self.RE_CONDITION_DAILY_RECIPE[lang]
                          , self.RECIPE
                          , { "name", "name_2" }
                          }
    local found_item    = self.ParseRegexable(unpack(args))
    if not found_item then return nil end
    return { item = found_item }
end


LibCraftText.RE_POTENCY = {
    en = { "Craft (.*) Glyph of" }
,   de = { "eine (.*) Glyphe de[sr]"}
,   fr = { "glyphe (.*)"
         , "(petit) glyphe "}
,   es = { "glifo (.*) de"
         , "Craft (.*) Glyph of" }  -- Ayep, there are still untranslated lines in ES Spanish
,   it = { "(.*) glyph of"}         -- "glifo of health" for all 10 potencies. Broken.
,   ru = { "(.*) Glyph of"}
,   ja = { "(.*)のグリフ"
         , "(.*)なグリフ"}
}

function LibCraftText.ParseEnchantingPotency(cond_text)
    local self = LibCraftText
    local lang = self.CurrLang()
    local m    = LibCraftText.MATERIAL -- for less typing
    local POTENCY_LIST = {
                           m.JORA    -- trifling
                         , m.JERA    -- petty
                         , m.ODRA    -- minor
                         , m.EDORA   -- moderate
                         , m.PORA    -- strong
                         , m.RERA    -- greater
                         , m.DERADO  -- grand
                         , m.REKURA  -- splendid
                         , m.KURA    -- monumental
                         , m.REJERA  -- superb
                         , m.REPORA  -- truly superb  not used in daily,
                                     --               but used in master writs.
                         }
    local potency = self.ParseRegexable(
                                         CRAFTING_TYPE_ENCHANTING
                                       , cond_text
                                       , self.RE_POTENCY[lang]
                                       , POTENCY_LIST
                                       , { "name_2", "name_3" }
                                       )
    return potency
end

LibCraftText.RE_ESSENCE = {
    en = { "Glyph of ([^\n]*)" }
,   de = { "Glyphe de[sr] (.*) her"}
,   fr = { "glyphe (.*) avec"
         , "glyphe ([^\n]*)"}
,   es = { "glifo (.*) con Ta"
         , "glifo ([^\n]*)"
         , "Glyph of ([^\n]*)" }    -- Untranslated lines in ES Spanish
,   it = { "glifo of ([^\n]*)"
         , "glyph of ([^\n]*)" }
,   ru = { "Glyph of ([^\n]*)"}
,   ja = { "グリフ ?%((.*)%)"}
}

function LibCraftText.ParseDailyConditionGlyph(cond_text)
    local self = LibCraftText
    local m    = LibCraftText.MATERIAL -- for less typing
    local ESSENCE_LIST = {
                           m.DENI    -- stamina
                         , m.MAKKO   -- magicka
                         , m.OKO     -- health
                         }
    local lang    = self.CurrLang()
    local potency = self.ParseEnchantingPotency(cond_text)
    local essence = self.ParseRegexable( CRAFTING_TYPE_ENCHANTING
                                       , cond_text
                                       , self.RE_ESSENCE[lang]
                                       , ESSENCE_LIST
                                       , { "add", "add_2" }
                                       )
    if not (potency or essence) then
        return nil
    end
    return { ["potency"] = potency
           , ["essence"] = essence
           , ["aspect" ] = m.TA
           }
end

                        -- REs should go from specific to general. That
                        -- increases the chance of matching just the right
                        -- parts instead of most of the string. Match too wide
                        -- a substring and you'll erroneously find a potion or
                        -- trait within that unwanted text.
LibCraftText.RE_ALCHEMY_TRAIT = {
    en = { "Craft .* of (.*)"
         , "Craft (.*) Poison" }
,   de = { "Stellt etwas Gift [ders]+ (.*) [IVX]+ her"  -- NBSP before [IVX] !
         , "Stellt .* [ders]+ (.*) her" }               -- Must come after Gift re.
,   fr = { "Fabriquer un poison de (.*) [IVX]+"
         , "Préparez une? [^ ]+ de (.*)"
         , "Fabriquez une? [^ ]+ de (.*)"}
,   es = { "Prepara un veneno de (.*) [IVX]+"
         , "Prepara veneno de (.*) [IVX]+"
         , "Prepara un[ea]? [^ ]+ (.*)"
         , "Crea un[ea]? [^ ]+ de (.*)"
         }
         -- Prepara veneno de absorción de vida IX
,   it = { "(.*) glyph of"}         -- "health" for all 9 ranks.
,   ru = { "Craft .* of (.*)"
         , "Craft (.*) Poison"
         , "[^ ]+ of (.*)" }
,   ja = { "(.*)の.*を" }
}
LibCraftText.RE_ALCHEMY_SOLVENT = {
    en = { "([IVX]+)$"          -- [IVX]+ re must occur before any other
         , "Craft (.*) of " }   -- re that might carry an i, v, or x.
,   de = { "Stellt etwas Gift [ders]+ .* ([IVX]+) her"
         , "Stellt (.*) [ders]+ .* her" }   -- Must come after Gift re.
,   fr = { "([IVX]+)$"
         , "Préparez une? (.*) de (.*)"
         , "Fabriquez une? ([^ ]+) de .*" }
,   es = { "([IVX]+)$"
         , "Prepara un[ea]? (.*) de .*"
         , "Crea un[ea]? (.*) de .*"
         }
,   it = { "(.*) glyph of"}         -- "health" for all 9 ranks.
,   ru = { "([IVX]+)$"
         , "Craft (.*) of "
         , "([^ ]+) of " }
,   ja = { "毒(.*)を生産する"
         , ".*の(.*)を"}
}

function LibCraftText.ParseDailyConditionAlchemy(cond_text)
    local self  = LibCraftText
    local lang  = self.CurrLang()
    local args  =   {
                      nil
                    , cond_text
                    , self.RE_ALCHEMY_TRAIT[lang]
                    , self.ALCHEMY_TRAIT
                    , { "daily_potion_name"
                      , "daily_poison_name", "daily_poison_name2" }
                    }
    local trait = self.ParseRegexable(unpack(args))
    args =  {
              CRAFTING_TYPE_ALCHEMY
            , cond_text
            , self.RE_ALCHEMY_SOLVENT[lang]
            , self.MATERIAL
            , { "potion_name"--, "potion_name2"
              , "poison_name" }
            }

    local solvent = self.ParseRegexable(unpack(args))

    if not (trait or solvent) then return nil end
    return { trait   = trait
           , solvent = solvent
           }
end

function LibCraftText.ParseDailyConditionMisc(crafting_type, cond_text)
    for k,v in pairs(LibCraftText.DAILY_COND) do
        if cond_text == v then return
            { misc=LibCraftText.DAILY_COND[k] }
        end
    end
    return nil
end

-- Parse Master Writ Conditions ----------------------------------------------

-- Break a multi-line condition into its bullet-prefixed substrings.
function LibCraftText.MasterConditionSplit(cond_text)
    local self = LibCraftText
    local lang = self.CurrLang()
                        -- All languages except ES Spanish use newlines
                        -- to break up their alchemy traits.
                        -- ES Spanish just continues the same line
                        -- without newline, so you have to break on bullet.
    local BULLET    = "•"   -- UTF-8 E2 80 A2 = U2022 "bullet"
    local lines = self.split_plain(cond_text, BULLET.." ")
    -- table.remove(lines,1)
    return lines
end

LibCraftText.RE_MASTER_ALCHEMY_NAME_TRAIT = {
    en = { "Craft an? (.*) with the following Traits"
         }
,   de = { "Stellt eine? (.*) mit bestimmten Eigenschaften her"
         }
,   fr = { "Fabriquez une? (.*) avec les traits suivants"
         }
,   es = { "Fabricæ una? (.*) con las siguientes propiedades:"
         }
,   it = { "Crea un (.*) con i seguenti tratti:"
         }
,   ru = { "Создать предмет %((.*)%) со следующими эффектами:"
         }
,   ja = { "Craft a (.*) with the following Traits:"
         }
}

-- Parse the condition text from an alchemy master writ quest.
--
-- solvent      MATERIAL            LORKHANS_TEARS or AKLAHEST
--
-- name_trait   ALCHEMY_TRAITS      RAVAGE_HEALTH
--                                  The trait that gives this potion/poison
--                                  its name. This same trait also appears
--                                  as one of the three elements of trait_list.
--
-- trait_list   MATERIAL            3 traits required for this potion/poison
--
function LibCraftText.ParseMasterConditionAlchemy(crafting_type, cond_text)
    local self = LibCraftText
    local lang = self.CurrLang()
    local args = { nil
                 , cond_text
                 , self.RE_MASTER_ALCHEMY_NAME_TRAIT[lang]
                 , self.ALCHEMY_TRAIT
                 , { "master_potion", "master_poison" }
             }
    local name_trait    = self.ParseRegexable(unpack(args))
    local solvent = nil
    if name_trait and cond_text then
                        -- The 1,true args to string.find() here are
                        -- "plain=true" string matches: aka "ignore any special
                        -- chars in the potion/poison name." Necessary to avoid
                        -- hyphens in "Stealth-Draining Poison" from failing to
                        -- match anything.
        if cond_text:lower():find(name_trait.master_poison:lower(),1,true) then
            solvent = self.MATERIAL.ALKAHEST
        elseif cond_text:find(name_trait.master_potion,1,true) then
            solvent = self.MATERIAL.LORKHANS_TEARS
        end
    end

    local lines = self.MasterConditionSplit(cond_text)
    table.remove(lines,1)   -- Skip the "Craft a xxx" line. We just need the traits.
    local trait_list = {}
    args = { nil
           , "<line goes here>"
           , { "(.*)" }
           , self.ALCHEMY_TRAIT
           , { "name" }
           }
    for _,line in ipairs(lines) do
        args[2] = line
        local trait = self.ParseRegexable(unpack(args))
        if trait then
            table.insert(trait_list, trait)
        end
    end

    if ZZDEBUG_ALLOWED and (#trait_list ~= 3) then
                        -- Alchemy master writs always have exactly three
                        -- traits. Dump the parse failure if we didn't get that
                        -- many.
        ZZDEBUG=ZZDEBUG_ON
        ZZDEBUG("### ParseMasterConditionAlchemy() trait_list.ct not 3. line_ct:%d"
               , #lines)
        for i,line in ipairs(lines) do
            args[2] = line
            ZZDEBUG("###  cond_text[%d]:'%s'", i, line)
            self.ParseRegexable(unpack(args))
        end
        ZZDEBUG=ZZDEBUG_OFF
    end

    return { solvent    = solvent
           , name_trait = name_trait
           , trait_list = trait_list
           }
end

function LibCraftText.ParseMasterConditionEnchanting(crafting_type, cond_text)
    local self = LibCraftText
    local lang = self.CurrLang()

    local lines = self.MasterConditionSplit(cond_text)

                        -- Master writs call for CP150 or CP160 potencies.
                        -- Find out which using additive potencies. They have
                        -- name_2 fields with "Superb" and "Truly Superb" that
                        -- subtractive potencies lack. We can switch to
                        -- subtractive counterparts later.
    local potency = self.ParseEnchantingPotency(lines[1])

    local ESSENCE_LIST = { self.MATERIAL.DEKEIPA
                         , self.MATERIAL.DENI
                         , self.MATERIAL.DENIMA
                         , self.MATERIAL.DETERI
                         , self.MATERIAL.HAOKO
                         , self.MATERIAL.HAKEIJO
                         , self.MATERIAL.KADERI
                         , self.MATERIAL.KUOKO
                         , self.MATERIAL.MAKDERI
                         , self.MATERIAL.MAKKO
                         , self.MATERIAL.MAKKOMA
                         , self.MATERIAL.MEIP
                         , self.MATERIAL.OKO
                         , self.MATERIAL.OKOMA
                         , self.MATERIAL.OKORI
                         , self.MATERIAL.ORU
                         , self.MATERIAL.RAKEIPA
                         , self.MATERIAL.TADERI
                         }

    local ASPECT_LIST  = { [4] = self.MATERIAL.REKUTA
                         , [5] = self.MATERIAL.KUTA
                         }

    args = { nil
           , lines[1]
           , self.RE_ESSENCE[lang]
           , ESSENCE_LIST
           , { "add", "add_2", "sub" }
           }
    local essence    = self.ParseRegexable(unpack(args))

                        -- Whether we use additive or subtractive potencies
                        -- depends on which field of the essence mat we
                        -- matched.
    local find_me = self.DeUmlaut(lines[1]:lower())
    for _,field_name in ipairs({"sub"}) do
        if essence and essence[field_name] then
            local val = self.DeUmlaut(essence[field_name]:lower())
            if find_me:find(val) then
                        -- It was a subtractive match.
                if potency == self.MATERIAL.REJERA then     -- CP150
                    potency = self.MATERIAL.JEHADE
                elseif potency == self.MATERIAL.REPORA then -- CP160
                    potency = self.MATERIAL.ITADE
                end
                break
            end
        end
    end

    local quality = self.ParseMasterQuality(lines[2])
    local aspect = nil
    if quality then
        aspect = ASPECT_LIST[quality.index]
    end

    return { potency = potency
           , essence = essence
           , aspect  = aspect
           }
end

function LibCraftText.ParseMasterConditionProvisioning(crafting_type, cond_text)
    return LibCraftText.ParseDailyConditionProvisioning(cond_text)
end

function LibCraftText.ParseMasterConditionEquipment(crafting_type, cond_text)
    local self     = LibCraftText
    local lines    = self.MasterConditionSplit(cond_text)
    local result   = self.ParseDailyConditionEquipment(crafting_type, lines[1])
    if not result then return nil end

                        -- Most languages sequence their items in this order:
    local line = { quality = 2
                 , trait   = 3
                 , set     = 4
                 , motif   = 5
                 }
    if self.CurrLang() == "de" then
                        -- But DE German differs, because why not?
        line = { set     = 2
               , motif   = 3
               , trait   = 4
               , quality = 5
               }
        if crafting_type == CRAFTING_TYPE_JEWELRYCRAFTING then
            line = { set     = 2
                   , motif   = nil
                   , trait   = 3
                   , quality = 4
                   }
        end
    end

    result.quality = self.ParseMasterQuality(lines[line.quality])
    result.trait   = self.ParseMasterTrait(lines[line.trait], result.item.trait_set_id)
    result.set     = self.ParseMasterSet(lines[line.set])
    result.motif   = self.ParseMasterMotif(lines[line.motif])
    return result
end

LibCraftText.RE_MASTER_QUALITY = {
    en  = { "Quality: ([^%\n]*)" }
,   de  = { "Qualität: ([^\n]*)" }
,   fr  = { "Qualité : ([^\n]*)" }
,   es  = { "Calidad: ([^\n]*)" }
,   it  = { "Qualità: ([^\n]*)" }
,   ru  = { "Качество: ([^\n]*)" }
,   ja  = { "Quality: ([^\n]*)" }
}
function LibCraftText.ParseMasterQuality(cond_line)
    local self = LibCraftText
    return self.ParseMasterLine(cond_line, self.RE_MASTER_QUALITY, self.QUALITY)
end

LibCraftText.RE_MASTER_TRAIT = {
    en  = { "Trait: ([^\n]*)" }
,   de  = { "Eigenschaft: ([^\n]*)" }
,   fr  = { "Trait : ([^\n]*)" }
,   es  = { "Rasgo: ([^\n]*)" }
,   it  = { "Tratti: ([^\n]*)" }
,   ru  = { "Особенность: ([^\n]*)" }
,   ja  = { "Trait: ([^\n]*)" }
}
function LibCraftText.ParseMasterTrait(cond_line, trait_set_id)
    local self = LibCraftText

                        -- Limit the trait scan to just the nine traits
                        -- appropriate for this trait_set_id. Otherwise we end
                        -- up with "Robust" erroneously matching ARMOR_ROBUST
                        -- for rings. Training,  Ninrhoned, others also suffer
                        -- similar mismatches.
    local trait_set = {}
    for _,trait in pairs(self.TRAIT) do
        if trait_set_id == trait.trait_set_id then
            table.insert(trait_set, trait)
        end
    end

    return self.ParseMasterLine(cond_line, self.RE_MASTER_TRAIT, trait_set)
end

LibCraftText.RE_MASTER_SET = {
    en  = { "Set: ([^\n]*)" }
,   de  = { "Set: ([^\n]*)" }
,   fr  = { "Ensemble : ([^\n]*)" }
,   es  = { "Conjunto: ([^\n]*)" }
,   it  = { "Set: ([^\n]*)" }
,   ru  = { "Комплект: ([^\n]*)" }
,   ja  = { "Set: ([^\n]*)" }
}
function LibCraftText.ParseMasterSet(cond_line)
    local self = LibCraftText
    return self.ParseMasterLine(cond_line, self.RE_MASTER_SET, self.SET)
end

LibCraftText.RE_MASTER_MOTIF = {
    en  = { "Style: ([^\n]*)" }
,   de  = { "Stil: ([^\n]*)" }
,   fr  = { "Style : ([^\n]*)" }
,   es  = { "Estilo: ([^\n]*)" }
,   it  = { "Stile:([^\n]*)" }
,   ru  = { "Стиль: ([^\n]*)" }
,   ja  = { "Style: ([^\n]*)" }
}
function LibCraftText.ParseMasterMotif(cond_line)
    local self = LibCraftText
    return self.ParseMasterLine(cond_line, self.RE_MASTER_MOTIF, self.MOTIF)
end

function LibCraftText.ParseMasterLine(cond_line, re_set, row_table)
    local self = LibCraftText
    local lang = self.CurrLang()
    local args = { nil
                 , cond_line
                 , re_set[lang]
                 , row_table
                 , { "name" }
             }
    return self.ParseRegexable(unpack(args))
end

function LibCraftText.ParseMasterConditionMisc(crafting_type, cond_text)
    for k,v in pairs(LibCraftText.MASTER_COND) do
        if cond_text == v then
            return { misc=LibCraftText.MASTER_COND[k] }
        end
    end
    return nil

end

-- Parse Util ----------------------------------------------------------------

                        -- Parse a string cond_text for a matching row
                        -- from result_list. Return a match.
                        --
                        -- If no match, re-run the parse, but with debugging
                        -- turned on to dump info to stdout so that you can
                        -- see what failed where.
                        --
function LibCraftText.ParseRegexable(...)
    local self      = LibCraftText
    local result    = self.ParseRegexableOptional(...)
    if ZZDEBUG_ALLOWED and not result then
        ZZDEBUG=ZZDEBUG_ON
        self.ParseRegexableOptional(...)
        ZZDEBUG=ZZDEBUG_OFF
    end
    return result
end

                        -- Parse a string cond_text, but don't dump to stdout
                        -- if the result is empty.
function LibCraftText.ParseRegexableOptional( crafting_type
                                            , cond_text
                                            , re_list
                                            , result_list
                                            , result_name_field_list
                                            )
    if not cond_text then return nil end
    local self              = LibCraftText
    for _,re in ipairs(re_list) do
        local match = self.ParseRegexableOneRE( crafting_type
                                         , cond_text
                                         , re
                                         , result_list
                                         , result_name_field_list
                                         )
        if match then return match end
    end
    return nil
end

function LibCraftText.ParseRegexableOneRE( crafting_type
                                         , cond_text
                                         , re
                                         , result_list
                                         , result_name_field_list
                                         )
    local self   = LibCraftText
    local _,_,g1 = string.find(cond_text, re)
    if not g1 then
        ZZDEBUG( "### ParseRegexableOneRE() no match cond_text:'%s'  re:'%s'"
               , cond_text, re )
        return nil
    end
    local cond_sub_str = g1
    ZZDEBUG("### cond_sub_str:'%s'", cond_sub_str)
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
            if (not crafting_type) or row.crafting_type == crafting_type then
                local name = row[fieldname]
                if name then
                    name = self.escape_re(name:lower())
                    if name and (  find_me_lower:find(name)
                                 or find_me_deumlauted:find(self.DeUmlaut(name)) ) then
                        if (not longest_match.name) or (longest_match.name:len() < name:len()) then
                            longest_match.name = name
                            longest_match.row  = row
                            -- 7 indents?! This is what happens when your
                            -- programming language refuses to support
                            -- "continue".
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
            if (not crafting_type) or row.crafting_type == crafting_type then
                local name = row[fieldname]
                if name and (  find_me_lower == name:lower()
                             or find_me_deumlauted == LibCraftText.DeUmlaut(name) ) then

                    ZZDEBUG("    exact: '%s'", tostring(name))
                    return row
                else
                    ZZDEBUG("not exact: '%s' != '%s'", tostring(name), find_me_lower)
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
-- Copied from http://lua-users.org/wiki/HexDump
function LibCraftText.hex_dump(buf)
  for i=1,math.ceil(#buf/16) * 16 do
     if (i-1) % 16 == 0 then io.write(string.format('%08X  ', i-1)) end
     io.write( i > #buf and '   ' or string.format('%02X ', buf:byte(i)) )
     if i %  8 == 0 then io.write(' ') end
     if i % 16 == 0 then io.write( buf:sub(i-16+1, i):gsub('%c','.'), '\n' ) end
  end
end

-- From http://lua-users.org/wiki/SplitJoin
--
-- A split that accepts regexes as delimiters, but which returns incorrect
-- results for UTF-8 delimiters such as E2 *0 A2 = U2022 "Bullet".
function LibCraftText.split(str,sep)
    local ret={}
    local n=1
    for w in str:gmatch("([^"..sep.."]*)") do
        ret[n] = ret[n] or w -- only set once (so the blank after a string is ignored)
        if w=="" then
            n = n + 1
        end -- step forwards on a blank but not a string
    end
    return ret
end


-- A split which works for string constant delimiters such as bullet.
function LibCraftText.split_plain(str,sep)
    local ret={}
    local n=1
    local offset = 1
                        -- "true" here is arg "plain", which turns off
                        -- pattern expressions and uses just boring old
                        -- byte matching.
    local delim_begin, delim_end = str:find(sep, offset, true)
    while delim_begin do
        local sub = str:sub(offset, delim_begin - 1)
        table.insert(ret, sub)
        offset = delim_end + 1
        delim_begin, delim_end = str:find(sep, offset, true)
    end
    return ret
end





