--- Generate items from a treasure table
--- Written by Focus, mangled by khbsd, yoinked by Suhra
---@param treasureTable string Name of the TT
---@param target? string Who to give the content to
---@param level? integer level to use for the TT loot generation
---@param finder? string idk
---@param generateInBag? boolean if true will put the content into a bag


local ID = "{Bg3Lore} "


function _IDP(message)
    _P(ID .. message)
end


local commands = {
    {
        name = "GenerateTreasureTable",
        params = "treasureTable, target, level, generateInBag",
        func = function(cmd, treasureTable, target, level, generateInBag)
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
        
            if Osi.IsItem(target) == 1 then
                finder = Osi.GetHostCharacter()
            else
                finder = target
            end
            --_IDP("finder: " .. finder)
        
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


local function RegisterCommands()
    for _, command in ipairs(commands) do
        _IDP(string.format('Registered command %s', command.name))
        Ext.RegisterConsoleCommand(command.name, command.func)
    end
end


RegisterCommands()
_IDP("Bg3Lore functions loaded.")
