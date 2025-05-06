return {
	["currency"] = "$%s", -- %s = amount
	["notEnoughMoney"] = {msg = "You don't have enough money to buy this item.", type = "error"},
	["invalidMachine"] = {msg = "This machine you tried using is invalid.", type = "error"},
	["invalidItem"] = {msg = "The item you selected is invalid.", type = "error"},
	["purchasedDrink"] = {msg = "You paid %s for a %s.", type = "success"}, -- %s = price, %s = item label
	["receivedItem"] = {msg = "You got your %s.", type = "success"}, -- %s = item label
	["purchasedDrinkDetails"] = {msg = "Purchased %s for %s from vending machine.", type = "success"}, -- %s = item label, %s = price
	["notAuthorized"] = {msg = "You are not authorized to make this purchase. Please try again.", type = "error"},
	["alreadyOccupied"] = {msg = "You are already occupied with another task.", type = "error"},
	["inVehicle"] = {msg = "You cannot make a purchase while in a vehicle.", type = "error"},
}