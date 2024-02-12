fx_version 'cerulean'
game 'gta5'

author 'Icarus Modding'
description 'Small Resources script made by Icarus Modding'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}
