CreateThread(function()
	SetTrainTrackSpawnFrequency(0, 120000) -- The Train spawn frequency set for the game engine
	SetTrainTrackSpawnFrequency(3, 120000) -- The Metro spawn frequency set for the game engine
	SetRandomTrains(true)
end)

RegisterNetEvent("trainSpawned")
AddEventHandler("trainSpawned", function()
	SwitchTrainTrack(0, false)
end)

RegisterNetEvent("trainDespawned")
AddEventHandler("trainDespawned", function()
	SwitchTrainTrack(0, true)
end)

RegisterNetEvent("metroTrainSpawned")
AddEventHandler("metroTrainSpawned", function()
	SwitchTrainTrack(3, false)
end)

RegisterNetEvent("metroTrainDespawned")
AddEventHandler("metroTrainDespawned", function()
	SwitchTrainTrack(3, true)
end)