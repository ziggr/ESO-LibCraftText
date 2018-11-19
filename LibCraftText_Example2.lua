-- Example code for LibCraftText


LibCraftText_Example2 = {}
local Example2 = LibCraftText_Example2
Example2.name = "LibCraftText_Example2"

SLASH_COMMANDS["/example2"] = function() LibCraftText_Example2.SlashCommand() end

local red   = "|cFF6666"
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
                        -- A dialog with an NPC has begun. Who is it?
    local self       = Example2
    local title      = self.GetDialogTitle()
    local title_enum = LibCraftText.DialogTitle(title)
    if not title_enum then
        Info("Not a crafting NPC.")
        return
    end

    if title_enum == LibCraftText.DIALOG.ROLIS_CHATTER_TITLE then
                        -- It's Rolis! Turning in any completed
                        -- master writs?

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

Daily Writ Board

interact with board

    EVENT_CHATTER_BEGIN
        title = "-Equipment Crafting Writs-"
        opt   = "<Examine the Clothier Writ>"

choose option clothier

    EVENT_QUEST_OFFERED
        title = "-Equipment Crafting Writs-"
        info[1] "blah seeing blah"
        info[2] "<Pull a writ from the Board.>"

accept quest

    EVENT_QUEST_ADDED(quest_index=2,name="Clothier Writ",?="")

    EVENT_CHATTER_BEGIN
        back to the crafting board

]]
