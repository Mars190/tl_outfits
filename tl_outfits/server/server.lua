ESX  = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local errorBoolean = false
local serverSideIds = {}
local clientSideIds = {}

for k,v in pairs(TL_S.Outfits) do
    table.insert(serverSideIds, v.outfitId)
end

for k,v in pairs(TL_C.Outfits) do
    table.insert(clientSideIds, v.outfitId)
end

if table.concat(serverSideIds) ~= table.concat(clientSideIds) then
    print("^1[tl_outfits]^7 ^3[Ids]^7 Error in der Config!\n^5Registrierte Ids in der sv_config:^7")
    for k,v in pairs(serverSideIds) do
        print(v)
    end
    print("\n^5Ids die in der cl_config eingetragen sind:^7")
    for k,v in pairs(clientSideIds) do
        print(v)
    end
end

MySQL.query('SELECT * FROM items', {}, function(data)
    local successfullItems = 0
    local registeredItems = 0
    local errorItem = ''
    local registeredObject = {}
    for k1,v1 in pairs(TL_S.Outfits) do
        registeredItems = registeredItems + 1
        for _,v2 in pairs(data) do
            if v2.name == v1.itemname then
                successfullItems = successfullItems + 1
                table.insert(registeredObject, {name = v1.itemname})
                break
            end
        end
    end
    if successfullItems ~= registeredItems then
        print("^1[tl_outfits]^7 ^3[Items]^7 Error in der Config!\n^5Registrierte Items:^7")
        for _,v in pairs(registeredObject) do
            print(v.name)
        end
        print("\n^5Items die in der Config eingetragen sind:^7")
        for k,v in pairs(TL_S.Outfits) do
            print(v.itemname)
        end
    end
end)

for k,v in pairs(TL_S.Outfits) do
    ESX.RegisterUsableItem(v.itemname, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('tl_outfits', source, v.outfitId)
        xPlayer.removeInventoryItem(v.itemname, 1)
    end)
end