fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'A simple voting resource created by Entity Evolution'

version '1.0.0'

client_script {
    '@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
    'config/config.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'config/config.json',
    'html/fonts/*.ttf',
    'html/img/*.jpg',
    'html/css/style.css',
    'html/js/script.js'
}

dependency 'PolyZone'