--- Generate items from a treasure table
--- Written by Focus, yoinked
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
end

