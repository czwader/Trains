local spawnedMetro = false
local spawnedTrain = false
local metroTraintable = {}
local trainTable = {}

RegisterNetEvent("esx:playerLoaded2")
AddEventHandler("esx:playerLoaded2", function()
	local src = source
	if not spawnedTrain then
		TriggerClientEvent("trainDespawned", src)
	end

	if not spawnedMetro then 
		TriggerClientEvent("metroTrainDespawned", src)
	end
end)

AddEventHandler("entityCreating", function(ent)
	
	if GetVehicleType(ent) == "train" then 
		SetEntityDistanceCullingRadius(ent, 100.0)
		if GetHashKey("freight") == GetEntityModel(ent) then
			spawnedTrain = true 
			TriggerClientEvent("trainSpawned", -1)
		elseif GetHashKey("metrotrain") == GetEntityModel(ent) and #metroTraintable < 1 then 
			spawnedMetro = true
			table.insert(metroTraintable, ent)
			TriggerClientEvent("metroTrainSpawned", -1)
		end

		if GetHashKey("metrotrain") ~= GetEntityModel(ent) then 
			table.insert(trainTable, ent)
		end
	end
end)

AddEventHandler("entityRemoved", function(ent)
	if GetVehicleType(ent) == "train" then 
		if GetHashKey("freight") == GetEntityModel(ent) then 
			TriggerClientEvent("trainDespawned", -1)
			spawnedTrain = false 
			for i = 1, #trainTable do 
				DeleteEntity(trainTable[i])
			end
		elseif GetHashKey("metrotrain") == GetEntityModel(ent) and #metroTraintable ~= 0 then 
			TriggerClientEvent("metroTrainDespawned", -1)
			spawnedMetro = false
			RemoveByValue(metroTraintable, ent)
		end

		if GetHashKey("metrotrain") ~= GetEntityModel(ent) then 
			RemoveByValue(trainTable, ent)
		end
	end
end)

function RemoveByValue(list, value)
    for i, v in ipairs(list) do
        if v == value then
            table.remove(list, i)
        end
    end
end