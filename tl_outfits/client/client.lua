ESX = nil
local used = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function normalSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)    
	  TriggerEvent('skinchanger:loadSkin', skin)
	end)
    used = false
    ESX.ShowNotification("Outfit resetted", "success", "Outfit")
end

RegisterCommand("normalskin", function()
    if used then
        normalSkin()
    else
        ESX.ShowNotification("You didnt use an outfititem", "error", "Outfit")
    end
end)

RegisterNetEvent('tl_outfits')
AddEventHandler('tl_outfits', function(outfitId)
    local breaking
    for k,v in pairs(TL_C.Outfits) do
        if breaking then
            break
        end
        if outfitId == v.outfitId then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then 
                    TriggerEvent('skinchanger:loadClothes', skin, v.MaleSkin) 
                else 
                    TriggerEvent('skinchanger:loadClothes', skin, v.FemaleSkin) 
                end
            end)
            ESX.ShowNotification("/normalskin, to use your normal skin again", "info", "Outfit")
            breaking = true
            used = true
        end
    end
end)