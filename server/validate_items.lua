-- Iterates the config and validates that all items exist on your server
-- If you know what you are doing you could remove this file
local invalidItems = {}

for _, settings in pairs(Config.Settings.machines) do
	for i = 1, #settings.items do
		local item = settings.items[i]

		if (not Items[item.name]) then
			invalidItems[item.name] = true
		end
	end
end

if (Z.table.doesTableHaveEntries(invalidItems)) then
	print("^1Invalid items found in the config:")

	for item, _ in pairs(invalidItems) do
		print("^1- " .. item)
	end

	print("^3Please fix the config.^7")
end
