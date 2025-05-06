if (not Target) then
	error("This requires a target system.")
end

for model, settings in pairs(Config.Settings.machines) do
	---@type VendingItem[]
	local options = {}

	for i = 1, #settings.items do
		if (Items[settings.items[i].name] == nil) then
			error("Item " .. settings.items[i].name .. " not found in Items table")
		end

		options[i] = {
			label = Items[settings.items[i].name].label,
			name = settings.items[i].name,
			icon = "fas fa-bottle-water",
			price = settings.items[i].price,

			onSelect = function()
				if (IsInteracting()) then
					Z.notify("alreadyOccupied")
					return
				end

				local plyPos = GetEntityCoords(PlayerPedId())
				local entity = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 2.0, model, false, false, false)
				local pos = GetEntityCoords(entity)

				---@diagnostic disable-next-line: param-type-mismatch
				PurchaseFromMachine(model, i)
			end
		}
	end

	Z.target.addModel(model, {
		distance = 2.0,
		options = options
	})
end

-- ~60.0 would be a realistic field of view for ped, 40.0 for really narrow view
---@param ped integer
---@param pos vector3 | {x: number, y: number, z: number}
---@param radius number
local function isPositionInPedFieldOfView(ped, pos, radius)
    local pedPos = GetEntityCoords(ped)

    local directionToTarget = vector3(pos.x - pedPos.x, pos.y - pedPos.y, pos.z - pedPos.z)
    local dstToTarget = #(pos - pedPos)

    local directionToTargetNormalized = directionToTarget / dstToTarget
    local forwardVec = GetEntityForwardVector(ped)

    local dotProduct =  forwardVec.x * directionToTargetNormalized.x +
                        forwardVec.y * directionToTargetNormalized.y +
                        forwardVec.z * directionToTargetNormalized.z

    local angleToTarget = math.deg(math.acos(dotProduct))

    return angleToTarget < radius
end

local function isPedLookingAtEntity(ped, entity, heading)
    local pedPos = GetEntityCoords(ped)
    local entityPos = GetEntityCoords(entity)
    local pedHeading = GetEntityHeading(ped)

    return isPositionInPedFieldOfView(ped, entityPos, 60.0) and math.abs(pedHeading - heading) < 10.0
end

---@param machineEntity integer
---@param propKey string
local function spawnDrinkProp(machineEntity, propKey)
	local propSettings = Config.Settings.props[propKey]
	if (not propSettings) then return end

	if (not Z.loadModel(propSettings.model)) then return end

	local pos = GetEntityCoords(machineEntity)
	local drinkProp = CreateObject(propSettings.model, pos.x, pos.y, pos.z, true, true, false)
	while (not DoesEntityExist(drinkProp)) do Wait(0) end

	local ply = PlayerPedId()
	AttachEntityToEntity(drinkProp, ply, GetPedBoneIndex(ply, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)

	-- Debug stuff if you want to see the prop through the machine if you're trying to get the position right
	-- SetEntityDrawOutlineColor(255, 255, 255, 255)
	-- SetEntityDrawOutline(drinkProp, true)

	return drinkProp
end

---@param ply integer
---@param drinkProp integer
---@param propKey string
local function attachDrinkProp(ply, drinkProp, propKey)
	local propSettings = Config.Settings.props[propKey]
	local offset = propSettings.offset
	local rotation = propSettings.rotation
	local bone = propSettings.bone

	AttachEntityToEntity(drinkProp, ply, GetPedBoneIndex(ply, bone), offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z, false, false, false, false, 1, true)
end

local purchaseAnim = {dict = "mini@sprunk", clip = "plyr_buy_drink_pt1"}
local putIntoInventoryAnim = {dict = "anim@heists@humane_labs@finale@keycards", clip = "ped_a_pass"}
local grabMoneyAnim = {dict = "amb@world_human_smoking@male@male_a@enter", clip = "enter"}

---@param model integer
---@param itemIdx integer
function PurchaseFromMachine(model, itemIdx)
	local drinkProp

	local function reset()
		local ply = PlayerPedId()
		FreezeEntityPosition(ply, false)
		SetInteracting(false)
		ReleaseAmbientAudioBank()
		ClearPedTasks(ply)

		if (drinkProp and DoesEntityExist(drinkProp)) then
			DeleteEntity(drinkProp)
		end
	end

	-- Check again in case of any timing issues
	if (IsInteracting()) then
		Z.notify("alreadyOccupied")
		return
	end

	SetInteracting(true)

	local ply = PlayerPedId()
	local plyPos = GetEntityCoords(ply)

	-- Pre-validations
	if (IsPedInAnyVehicle(ply, false)) then
		Z.notify("inVehicle")
		reset()
		return
	end

	local machine = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 2.0, model, false, false, false)
	local machineSettings = Config.Settings.machines[model]
	if (not machineSettings) then reset() return end

	local itemSettings = machineSettings.items[itemIdx]
	if (not itemSettings) then reset() return end

	local prop = itemSettings.prop
	if (prop == nil) then
		prop = "default"
	end

	local animPos = GetOffsetFromEntityInWorldCoords(machine, machineSettings.interactOffset.x, machineSettings.interactOffset.y, machineSettings.interactOffset.z)

	local started  = GetGameTimer()

	local function isInCorrectPosition()
		local dst = #(GetEntityCoords(ply) - animPos)
		local isLooking = isPedLookingAtEntity(ply, machine, GetEntityHeading(machine))
		local isClose = dst < 0.25

		return isLooking and isClose
	end

	if (not isInCorrectPosition()) then
		TaskGoStraightToCoord(ply, animPos.x, animPos.y, animPos.z, 1.0, -1, GetEntityHeading(machine), 0.1)

		while (1) do
			-- Debug marker if you are curious where you have to stand, remember to set wait to 1 otherwise you won't be able to see it
			-- DrawMarker(27, animPos.x, animPos.y, animPos.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, false, nil, nil, false)

			-- If we are within an acceptable distance & correct heading, break out of the loop
			if (isInCorrectPosition()) then
				Wait(500)
				break
			end

			-- If we are too far away, something probably went wrong and we should cancel
			local dst = #(GetEntityCoords(ply) - animPos)
			if (dst > 5.0) then
				reset()
				return
			end

			-- Should not be longer than a second long, if it takes longer, we should cancel
			if (GetGameTimer() - started > 3000) then
				reset()
				return
			end

			Wait(250)
		end
	end

	if (not Z.loadDict(grabMoneyAnim.dict)) then reset() return end
	TaskPlayAnim(ply, grabMoneyAnim.dict, grabMoneyAnim.clip, 1.0, 1.0, 1200, 49, 0.0, false, false, false)
	Wait(1200)

	local state, reason = Z.callback.await("zyke_vending:PayForDrink", model, itemIdx)
	if (state == false) then
		Z.notify(reason)
		reset()
		return
	end

	if (not Z.loadDict(purchaseAnim.dict)) then reset() return end

	TaskPlayAnim(ply, purchaseAnim.dict, purchaseAnim.clip, 1.0, 0.5, 3800, 1, 0.0, false, false, false)
	FreezeEntityPosition(ply, true)

	Wait(1000)

	drinkProp = prop and spawnDrinkProp(machine, prop) or nil

	Z.notify("purchasedDrink", {T("currency", {itemSettings.price}), Items[machineSettings.items[itemIdx].name].label})

	Wait(2000)

	RequestAmbientAudioBank("VENDING_MACHINE", true)
	HintAmbientAudioBank("VENDING_MACHINE", true)

	Wait(800)
	ReleaseAmbientAudioBank()

	if (drinkProp and prop ~= false) then
		attachDrinkProp(ply, drinkProp, prop)
	end

	if (not Z.loadDict(putIntoInventoryAnim.dict)) then reset() return end

	TaskPlayAnim(ply, putIntoInventoryAnim.dict, putIntoInventoryAnim.clip, 0.8, 1.0, 1200, 49, 0.0, false, false, false)
	Wait(500)

	local state, reason = Z.callback.await("zyke_vending:GetItem", model, itemIdx)
	if (state == true) then
		Z.notify("receivedItem", {Items[machineSettings.items[itemIdx].name].label})
	else
		Z.notify(reason)
	end

	FreezeEntityPosition(ply, false)

	Wait(700)

	if (drinkProp and DoesEntityExist(drinkProp)) then
		DeleteEntity(drinkProp)
	end

	SetInteracting(false)
end

local isInteracting = false
local blockedKeys = Z.keys.get({"W", "A", "S", "D", "SPACE", "LEFTMOUSE", "RIGHTMOUSE"})

-- Sets our interacting state to block other interactions
-- We also block keys from being used
---@param state boolean
function SetInteracting(state)
	isInteracting = state

	-- Add additional stuff if you want here, but we want to keep it simple

	-- Disable walking/attacking when interacting
	CreateThread(function()
		while (isInteracting) do
			for i = 1, #blockedKeys do
				DisableControlAction(0, blockedKeys[i].keyCode, true)
			end

			Wait(0)
		end
	end)
end

function IsInteracting()
	-- You can add other checks in here, such as validating if the player is active in another script

	return isInteracting
end

exports("IsInteracting", IsInteracting)
exports("IsOccupied", IsInteracting)