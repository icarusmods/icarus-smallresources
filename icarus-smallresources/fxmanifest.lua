fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Icarus Modding'
description 'Small Resources script made by Icarus Modding'

shared_scripts {
    'shared/config.lua',
    '@qb-core/shared/locale.lua',
    'shared/words.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'client/client.lua',
    'client/carry.lua',
    'client/vehcontrol.lua'
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

dependencies {
    'qb-core',
    'ox_lib',
}
