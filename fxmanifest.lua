fx_version "cerulean"
game "gta5"
lua54 "yes"
author "discord.gg/zykeresources"
version "1.0.0"

shared_scripts {
	"@zyke_lib/imports.lua",
	"shared/config.lua"
}

client_script {
	"client/main.lua",
	"client/debug.lua"
}

server_script {
	"server/main.lua",
	"server/validate_items.lua"
}

files {
	"locales/*.lua"
}

dependencies {
	"zyke_lib"
	-- No target system listed here as we support multiple alternatives with zyke_lib
	-- The files won't start & will throw an error if no target system is found
}
