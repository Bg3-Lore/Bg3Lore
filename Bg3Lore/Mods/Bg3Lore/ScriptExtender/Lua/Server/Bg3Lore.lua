--[[ 
    Generate items from a treasure table
    Written by Focus, mangled by khbsd, yoinked by Suhra
    @param treasureTable string Name of the TT
    @param target? string Who to give the content to
    @param level? integer level to use for the TT loot generation
    @param finder? string idk
    @param generateInBag? boolean if true will put the content into a bag

    i made it a block, muffin
    are you happy
--]]

-- a little function and var that identifies this mod's console outputs
local ID = "{Bg3Lore} "
function _IDP(message)
    _P(ID .. message)
end


--[[
    this table has one element, though it is extensible in case we need to add more
    commands later. 
    new commands need to add another {} block, and separate each command {} block with
    a comma. ostensibly they'll need name, params, and func as variables too. params 
    appears to be a reference for when you write the func variable.
--]]
local commands = {
    {
        name = "GenerateTreasureTable",
        params = "treasureTable, target, level, generateInBag",
        func = function(cmd, treasureTable, target, level, generateInBag)
            --[[ 
                RegisterCommands parses every argument as a string when passed 
                through the console, so most of this is converting arguments back 
                to the type they're supposed to be.
            --]]
            if string.lower(generateInBag) == "false" then
                generateInBag = false
            elseif string.lower(generateInBag) == "true" then
                generateInBag = true
            else
                generateInBag = true
            end
            --_IDP("generateInBag: " .. tostring(generateInBag))

            local bag = generateInBag ~= false and Osi.CreateAt("3e6aac21-333b-4812-a554-376c2d157ba9", 0, 0, 0, 0, 0, "")
            --_IDP("bag: " .. tostring(bag))
            local level = tonumber(level)

            if string.lower(target) == "host" then
                target = Osi.GetHostCharacter()
            else
                target = target
            end
            --_IDP("target: " .. target)

            if level == nil then
                if Osi.IsItem(target) == 1 then
                    level = -1
                else
                    level = Osi.GetLevel(target)
                end
            end
            --_IDP("level: " .. level)

            -- this variable sucks and i do not care about it.
            if Osi.IsItem(target) == 1 then
                finder = Osi.GetHostCharacter()
            else
                finder = target
            end
            --_IDP("finder: " .. finder)

            --[[ 
                if bag is set to "true", generate items into a bag and send that bag
                to the player specified in target. otherwise, generate those items into 
                target's inventory directly.
            --]]
            if bag then
                _IDP("Sending " .. treasureTable .. " in a bag to " .. target)
                Osi.GenerateTreasure(bag, treasureTable, level, finder)
                Osi.ToInventory(bag, target)
            else
                _IDP("Sending " .. treasureTable .. " to " .. target)
                Osi.GenerateTreasure(target, treasureTable, level, finder)
            end
        end
    }
}


--[[ 
    this takes the entire function in the second {}s up in commands and registers 
    it all at once. pretty cool honestly.
--]]
local function RegisterCommands()
    for _, command in ipairs(commands) do
        _IDP(string.format('Registered command %s', command.name))
        Ext.RegisterConsoleCommand(command.name, command.func)
    end
end


RegisterCommands()


_IDP("Bg3Lore functions loaded.")
