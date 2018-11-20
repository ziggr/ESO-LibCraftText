-- Example code for LibCraftText

-- If you have other crafting add-ons such as Dolgubon's, disable them while
-- running with this example. Otherwise the other add-ons will try to control
-- the same dialogs that this example code does.

LibCraftText_Example2 = {}
local Example2 = LibCraftText_Example2
Example2.name = "LibCraftText_Example2"

SLASH_COMMANDS["/example2"] = function() LibCraftText_Example2.SlashCommand() end

local red   = "|cFF6666"
local green = "|c66FF66"
local grey  = "|c999999"
local white = "|cFFFFFF"

local function Info(msg, ...)
    local s = string.format(grey..msg, ...)
    d(s)
end

-- Example2 ------------------------------------------------------------------
--
-- Automate dialog and quest interaction for daily and master writs
--
-- Daily Writ sequence:
--
--  1. Interact with writ board
--
--      EVENT_CHATTER_BEGIN
--        title = "-Equipment Crafting Writs-"
--        opt   = "<Examine the Clothier Writ>"
--
--    choose option 1 if it's a crafting option
--
function Example2.ChatterWritBoard()
    local self          = Example2
    local title         = self.GetDialogTitle()
    local data          = { GetChatterData() }
    local option_ct     = data[2]
    local option_text_1 = GetChatterOption(1)

                        -- If the writ board offers us an option
                        -- to start a daily writ, choose that option.
    local row = LibCraftText.DailyWritOptionToRow(option_text_1)
    if row then
                        -- Must choose options after a delay: picking them
                        -- right away tends to fail silently.
        zo_callLater(function() SelectChatterOption(1) end, 500)
    else
        Info("No more crafting quests to accept."
             .." Go craft something then turn it in.")
    end
end

--  2. EVENT_QUEST_OFFERED
--      title = "-Equipment Crafting Writs-"
--      info[1] "blah blah blah"
--      info[2] "<Pull a writ from the Board.>"
--
--  Choosing an option to start a daily writ opens a quest offer dialog.
--  Accept that quest.
--
function Example2.QuestOfferedDailyWrit()
    local dialog_text, response = GetOfferedQuestInfo()
    if response == LibCraftText.DIALOG.DAILY.OPTION_ACCEPT then
        AcceptOfferedQuest()
    end
end

--  3. EVENT_QUEST_ADDDED(quest_index,quest_name)
--
-- Accepting the offered quest fires EVENT_QUEST_ADDED
--
-- Report the requested item
function Example2.QuestAdded(quest_index, quest_name)
    Info(green.."Quest added:|r", quest_name)

                        -- If you have Example1 code loaded, it can dump all
                        -- about this shiny new daily crafting quest.
    if LibCraftText_Example1 and LibCraftText_Example1.Example1_OneQuest then
        LibCraftText_Example1.Example1_OneQuest(quest_index)
    end
end

--  4. EVENT_CHATTER_BEGIN
--       back to the daily writ board
--
-- Accepting the offered quest returns us to the daily writ board, where we
-- can choose another quest, or exit.
--
-- WHILE there are still remaining daily writs to acquire,
-- GOTO 1. "Interact with writ board" above

--  5. Exit writ board interaction after you have acquired.
--
--  6. EVENT_CHATTER_END
--     Fired in response to exiting the writ board interaction.
--
--  7. Craft the required item(s).
--
--     EVENT_QUEST_CONDITION_COUNTER_CHANGED(quest_index, quest_name,...)
--
--  8. Exit crafting station
--     EVENT_CHATTER_END  (for exiting the crafting station)
--

--  9. Interact with daily writ turn-in crate.
--
-- 10. EVENT_CHATTER_BEGIN()
--     title  = "-Blacksmith Delivery Crate-"
--     option = "<Place the goods within the crate.>"
function Example2.ChatterDeliveryCrate()
    local self          = Example2
    local title         = self.GetDialogTitle()
    local data          = { GetChatterData() }
    local option_ct     = data[2]
    local option_text_1 = GetChatterOption(1)

    local
end


--[[



    choose option 1 (place the...)

    EVENT_QUEST_CONDITION_COUNTER_CHANGED()
    EVENT_QUEST_ADVANCED(qi,qname)
    EVENT_QUEST_COMPLETE_DIALOG(qi)

    GetJournalQuestEnding(qi)
        1. Sign Delivery Manifest
        2. THe client blah blah
        3. ""
        4. ""
        5. "Ite taken a contract blah blah"
        6. "I've placed my delivery..."

    CompleteQuest()

    EVENT_QUEST_REMOVED(true, qi, qname)
    EVENT_QUEST_COMPLETE
    EVENT_CHATTER_END

]]

function Example2.SlashCommand()
    local self = Example2
    if not self.registered then
        self.RegisterEventListeners()
        self.registered = true
    else
        self.UnregisterEventListeners()
        self.registered = false
    end
end

function Example2.RegisterEventListeners()
                        -- Install event listeners to detect when a crafting
                        -- quest is offered, when a quest turn-in dialog
                        -- occurs, and so on.
    local self = Example2
    local name = self.name.."_hello"

                        -- EVENT_CHATTER_BEGIN fires when an NPC dialog appears
                        -- after you interact with them. Use this to detect
                        -- when talking to Rolis Hlaalu.
    EVENT_MANAGER:RegisterForEvent( name
                                  , EVENT_CHATTER_BEGIN
                                  , function() Example2.OnChatterBegin() end )

                        -- EVENT_QUEST_COMPLETE_DIALOG fires when turning in  a
                        -- quest. Use this to detect when the user (or your own
                        -- automation code) has turned in a quest.
    EVENT_MANAGER:RegisterForEvent( name
                                  , EVENT_QUEST_COMPLETE_DIALOG
                                  , function(quest_index)
                                        Example2.OnQuestCompleteDialog(quest_index)
                                    end )

                        -- EVENT_QUEST_OFFERED fires when a dialog offers a
                        -- quest. Fires when opening a sealed master writ, and
                        -- when interacting with the daily crafting writ
                        -- boards.
    EVENT_MANAGER:RegisterForEvent( name
                                  , EVENT_QUEST_OFFERED
                                  , function()
                                        Example2.OnQuestOffered()
                                    end )
    LibCraftText.rolis_registered = true
    Info("Dialog listeners registered."
         .." Go acquire or turn in some crafting quests.")
end

function Example2.UnregisterEventListeners()
    local name = LibCraftText.name .. "_hello"
    local event_list = { EVENT_CHATTER_BEGIN
                       , EVENT_QUEST_COMPLETE_DIALOG
                       , EVENT_QUEST_OFFERED
                       }
    for _,event_id in ipairs(event_list) do
        EVENT_MANAGER:UnregisterForEvent( name
                                        , event_id
                                        )
    end
    Info("Dialog listeners removed.")
end

function Example2.OnChatterBegin()
                        -- A dialog with an NPC (or the daily writ board!)
                        -- has begun. Who is it?
    local self       = Example2
    local title      = self.GetDialogTitle()
    local title_enum = LibCraftText.DialogTitle(title)
    if not title_enum then
        Info("Not a crafting dialog.")
        return
    end

    if title_enum == LibCraftText.DIALOG.MASTER.TITLE_ROLIS then
                        -- It's Rolis! Turn in any completed master writs.
        self.RolisChoose()


    end

end

function Example2.OnQuestOffered()

end

function Example2.OnQuestCompleteDialog(quest_index)
end


-- Utility -------------------------------------------------------------------

function Example2.GetDialogTitle()
    return ZO_InteractWindowTargetAreaTitle:GetText()
end



--[[

Master Writ Sequence

    inventory: open a sealed master writ

    EVENT_INVENTORY_ITEM_USED
    EVENT_QUEST_OFFERED
        title  = "-Sealed Blacksmithing Writ-"  -- LibCraftText.DIALOG.MASTER[bs].title_offer
        option = "<Accept the contract.>"       -- LibCraftText.DIALOG.OPTION_ACCEPT_CONTRACT[i]

    EVENT_QUEST_ADDED(quest_index, quest_name)
        quest_name = "A Masterful Plate"        -- LibCraftText.MASTER_QUEST_TITLES[bs][i]

        LibCraftText.MasterQuestNameToCraftingTypeList()
        LibCraftText.ParseMasterCondition()

    EVENT_CHATTER_END

    craft required items

    EVENT_QUEST_CONDITION_COUNTER_CHANGED
    EVENT_QUEST_ADVANCED

    cond_text is now "Deliver the Weapon"

    travel to Rolis
    interact with Rolis

    EVENT_CHATTER_BEGIN
        title  = "-Rolis Hlaalu-"               -- LibCraftText.DIALOG.MASTER.TITLE_ROLIS
                                                -- LibCraftText.DIALOG.MASTER[b].option.finish
        option = "I've finished the Blacksmithing job."

    EVENT_QUEST_ADVANCED(quest_index, quest_name, false, true, true)

    EVENT_QUEST_COMPLETE_DIALOG(quest_index)
        title  = "-Rolis Hlaalu-"               -- LibCraftText.DIALOG.MASTER.TITLE_ROLIS

        GetJournalQuestEnding(quest_index)
            [2] = "<He notes your work and tenders payment.>"

        CompleteQuest()

    EVENT_QUEST_REMOVED(true, quest_index, quest_name, 294967291,294967291,5972)
    EVENT_QUEST_COMPLETE(quest_name, 50, 545317, 619417, 1131, 4, 0)

    EVENT_CHATTER_BEGIN
        (back to rolis for next writ turn-in)

Daily Writ Board

    interact with board

    EVENT_CHATTER_BEGIN
        title = "-Equipment Crafting Writs-"
        opt   = "<Examine the Clothier Writ>"

    choose option blacksmith

    EVENT_QUEST_OFFERED
        title = "-Equipment Crafting Writs-"
        info[1] "blah seeing blah"
        info[2] "<Pull a writ from the Board.>"

    accept quest

    EVENT_QUEST_ADDED(quest_index=2,name="Clothier Writ",?="")

    EVENT_CHATTER_BEGIN
        back to the crafting board

    leave board

    craft item

    EVENT_QUEST_CONDITION_COUNTER_CHANGED(quest_index, quest_name, text, 44, 0, 1, 1, false, "", false...)
    EVENT_CHATTER_END  (for exiting the crafting station?

    interact with delivery crate

    EVENT_CHATTER_BEGIN(1)
        title = "-Blachsmith Delivery Crate-"
        option == "<Place the goods within the crate.>"

    choose option 1 (place the...)

    EVENT_QUEST_CONDITION_COUNTER_CHANGED()
    EVENT_QUEST_ADVANCED(qi,qname)
    EVENT_QUEST_COMPLETE_DIALOG(qi)

    GetJournalQuestEnding(qi)
        1. Sign Delivery Manifest
        2. THe client blah blah
        3. ""
        4. ""
        5. "Ite taken a contract blah blah"
        6. "I've placed my delivery..."

    CompleteQuest()

    EVENT_QUEST_REMOVED(true, qi, qname)
    EVENT_QUEST_COMPLETE
    EVENT_CHATTER_END

]]
