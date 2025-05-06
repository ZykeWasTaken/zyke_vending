if (not Target) then
	error("This requires a target system.")
end

---@type table<CharacterIdentifier, OsTime>
local authorizedPlayers = {}

-- At the very end of the interaction, give us the item if we are authorized to do so
---@param plyId integer
---@param model integer
---@param itemIdx integer
---@return boolean, string?
Z.callback.register("zyke_vending:GetItem", function(plyId, model, itemIdx)
	local modelSettings = Config.Settings.machines[model]
	if (not modelSettings) then return false, "invalidMachine" end

	local item = modelSettings.items[itemIdx]
	if (not item) then return false, "invalidItem" end

	local identifier = Z.getIdentifier(plyId)
	local authTime = authorizedPlayers[identifier]

	if not authTime then return false, "notAuthorized" end
	if (os.time() - authorizedPlayers[identifier] > 60) then
		authorizedPlayers[identifier] = nil
		return false, "authorizationExpired"
	end

	Z.addItem(plyId, item.name, 1)
	authorizedPlayers[identifier] = nil
	return true
end)

-- To make the interaction nicer, we pay at the very start and authorize our character to make a purchase
---@param plyId integer
---@param model integer
---@param itemIdx integer
Z.callback.register("zyke_vending:PayForDrink", function(plyId, model, itemIdx)
	local modelSettings = Config.Settings.machines[model]
	if (not modelSettings) then return false, "invalidMachine" end

	local item = modelSettings.items[itemIdx]
	if (not item) then return false, "invalidItem" end

	local itemLabel = Items[item.name].label

	if (Z.money.get(plyId, "cash") >= item.price) then
		Z.money.remove(plyId, "cash", item.price, T("purchasedDrinkDetails", {itemLabel, T("currency", {item.price})}))
		authorizedPlayers[Z.getIdentifier(plyId)] = os.time()

		return true
	else
		return false, "notEnoughMoney"
	end
end)

RegisterNetEvent("zyke_lib:OnCharacterLogout", function(plyId)
	local identifier = Z.getIdentifier(plyId)
	if (not identifier) then return end

	authorizedPlayers[identifier] = nil
end)