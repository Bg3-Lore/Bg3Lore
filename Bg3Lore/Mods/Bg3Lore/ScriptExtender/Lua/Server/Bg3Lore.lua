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


--[[ --- Generate items from a treasure table
--- Written by focus, yoinked
---@param treasureTable string Name of the TT
---@param target? string Who to give the content to
---@param level? integer level to use for the TT loot generation
---@param finder? string idk
---@param generateInBag? boolean if true will put the content into a bag
function GenerateTreasureTable(treasureTable, target, level, finder, generateInBag)
    local bag = generateInBag ~= false and Osi.CreateAt("3e6aac21-333b-4812-a554-376c2d157ba9", 0, 0, 0, 0, 0, "")
    target = target or Osi.GetHostCharacter()

    if level == nil then
        if Osi.IsItem(target) == 1 then
            level = -1
        else
            level = Osi.GetLevel(target)
        end
    end

    if finder == nil then
        if Osi.IsItem(target) == 1 then
            finder = Osi.GetHostCharacter()
        else
            finder = target
        end
    end

    if bag then
        Osi.GenerateTreasure(bag, treasureTable, level, finder)
        Osi.ToInventory(bag, target)
    else
        Osi.GenerateTreasure(target, treasureTable, level, finder)
    end
end ]]


local commands = {
    {
        name = "GenerateTreasureTable",
        params = "treasureTable, target, level, finder, generateInBag",
        func = function(cmd, treasureTable, target, level, finder, generateInBag)
            local bag = generateInBag ~= false and Osi.CreateAt("3e6aac21-333b-4812-a554-376c2d157ba9", 0, 0, 0, 0, 0, "")
            local level = tonumber(level)

            if target == "host" then
                target = Osi.GetHostCharacter()
            else
                target = target
            end

            if level == nil then
                if Osi.IsItem(target) == 1 then
                    level = -1
                else
                    level = Osi.GetLevel(target)
                end
            end
        
            if finder == nil then
                if Osi.IsItem(target) == 1 then
                    finder = Osi.GetHostCharacter()
                else
                    finder = target
                end
            end
        
            if bag then
                Osi.GenerateTreasure(bag, treasureTable, level, finder)
                Osi.ToInventory(bag, target)
            else
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
