fx_version 'cerulean'
game 'gta5'

lua54 'yes'
author 'hamptonn'
description 'simple calculator command using ox_lib'

shared_script '@ox_lib/init.lua'

server_scripts {
    'server/versioncheck.lua',
    'server/calculator.lua'
}
client_script 'client/calculator.lua'

dependency 'ox_lib'