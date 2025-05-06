-- Debug to get positioning, sometimes the coordinates you grab are off
-- CreateThread(function()
-- 	while (1) do
-- 		local plyPos = GetEntityCoords(PlayerPedId())
-- 		for model, machineSettings in pairs(Config.Settings.machines) do
-- 			local closest = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 5.0, model, false, false, false)
-- 			if (closest) then
-- 				local animPos = GetOffsetFromEntityInWorldCoords(closest, machineSettings.interactOffset.x, machineSettings.interactOffset.y, machineSettings.interactOffset.z)

-- 				DrawMarker(27, animPos.x, animPos.y, animPos.z + 0.1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, false, nil, nil, false)
-- 			end
-- 		end

-- 		Wait(1)
-- 	end
-- end)