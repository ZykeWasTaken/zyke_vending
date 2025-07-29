fx_version "cerulean"
game "gta5"
lua54 "yes"
author "discord.gg/zykeresources"
version "1.0.2"

shared_script "@zyke_lib/imports.lua"

files {
	"locales/*.lua",

	-- Make sure these files can be found
	"shared/*.lua",
	"client/*.lua",
}

loader {
	"shared/config.lua",

	"client/main.lua",
	"client/debug.lua",

	"server/main.lua",
	"server/validate_items.lua"
}

dependency "zyke_lib"
-- No target system listed here as we support multiple alternatives with zyke_lib
-- The files won't start & will throw an error if no target system is found