fx_version 'cerulean'
game 'gta5'

author '𝓜𝓪𝓻𝓬#0001'
description 'Outfit Script'
version '1.0'

client_scripts {
    'config/cl_config.lua',
    'client/client.lua'
}

server_scripts {
    'config/cl_config.lua',
    'config/sv_config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}