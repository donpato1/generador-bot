#!/bin/bash

#==>> admin:
admin=''

# -*- ENCODING: UTF-8 -*-
#https://github.com/joao-lucas/ShellBot
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
CIDimg=/etc/tokenIMG && [[ ! -d ${CIDimg} ]] && mkdir ${CIDimg}
SRC="${CIDdir}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
CIDRESS="${CIDdir}/RESSELLERS" && [[ ! -e ${CIDRESS} ]] &&  mkdir ${CIDRESS}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
timg="${CIDimg}/img" && [[ ! -d ${timg} ]] && mkdir ${timg}
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://raw.githubusercontent.com/NetVPS/Generador-BOT/main/Otros/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE="   ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
# Importando API
source ShellBot.sh

bot_token="$(cat ${CIDdir}/token)"

ShellBot.init --token "$bot_token" --monitor --flush --return map
ShellBot.username

reply () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		 	 ShellBot.sendMessage	--chat_id  $var \
									--text "$comando" \
									--parse_mode html \
									--reply_markup "$(ShellBot.ForceReply)"
	[[ "${callback_query_data}" = /del || "${message_text}" = /del ]] && listID_src
	#[[ "${callback_query_data}" = /img || "${message_text}" = /img ]] && listID_src
	[[ "${callback_query_data}" = '/banIP' || "${message_text}" = '/banIP' ]] && list_IP
	
}
menu_print () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_user')"
	else
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_conf')"
	fi
}
menu_printSN () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				ShellBot.sendMessage 	--chat_id $var \
				--text "<i>$(echo -e $bot_retorno)</i>" \
				--parse_mode html \
				--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_send_id')"
	fi
}
download_file () {
# shellbot.sh editado linea 3986
user=User-ID
[[ -e ${CID} ]] && rm ${CID}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
		  [[ -e ${return[file_path]} ]] && mv ${return[file_path]} ${CID}
local bot_retorno="ID user botgen\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" FILE ${return[file_path]} \n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html
return 0
}
msj_add () {
	      ShellBot.sendMessage --chat_id ${1} \
							--text "<i>$(echo -e $bot_retor)</i>" \
							--parse_mode html
}
upfile_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var  \
                             --document @${1} \
                             #--caption  "$(echo -e "$bot_retorno")" \
                             #--parse_mode html \
                             #--reply_markup "$(ShellBot.ForceReply)"
							 #--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"							 
}
upimg_fun () {
          ShellBot.sendDocument --chat_id $(cat ${CIDdir}/Admin-ID)  \
                             --document @${1} \
                             #--caption  "$(echo -e "$bot_retorno")" \
                             #--parse_mode html \
                             #--reply_markup "$(ShellBot.ForceReply)"
							 #--reply_markup "$(ShellBot.InlineKeyboardMarkup -b "$2")"							 
}
invalido_fun () {
MSG_id=$((${message_message_id} + 1 ))
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	local bot_retorno="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙰𝙳𝙼  🎊\n"
		bot_retorno+="$LINE\n"
        bot_retorno+=" COMANDO NO PERMITIDO !!\n Quizas debes usar este /keygen \n O Posiblemente no estas Autorizado, clic aqui /prices o \n Contacta a $(cat < /etc/ADM-db/resell) y adquiere una subscripcion \n Toca aqui para ayuda /ayuda \n"
        bot_retorno+="$LINE\n"
	    ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e $bot_retorno)</i>" \
							--parse_mode html
		sleep 5s
		msj_del ${message_message_id}
		msj_del ${MSG_id}
							return 0	
}
send_admin(){
	local bot_retorno2="$LINE\n"
	bot_retorno2+="🔰 Solicitud de autorizacion 🔰\n"
	bot_retorno2+="$LINE\n"
	bot_retorno2+="<u>Nombre</u>: ${callback_query_from_first_name}\n"
	[[ ! -z ${callback_query_from_username} ]] && bot_retorno2+="<u>Alias</u>: @${callback_query_from_username}\n"
	bot_retorno2+="<u>ID</u>: <code>${callback_query_from_id}</code>\n"
	bot_retorno2+="$LINE"
	bot_retorno="$LINE\n"
	bot_retorno+="     🔰 Bot generador de key 🔰\n"
	bot_retorno+="           ⚜ by ${admin} ⚜\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="      ✅ ID enviado al admin ✅\n"
	bot_retorno+="$LINE"
	comand_boton "atras"
	saveID "${callback_query_from_id}"
	var=$(cat < ${CIDdir}/Admin-ID)
	ShellBot.sendMessage 	--chat_id $var \
							--text "$(echo -e "$bot_retorno2")" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_save_id')"
	return 0
}
msj_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
	return 0
}
msj_del () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      ShellBot.deleteMessage --chat_id $var --message_id $1 			  
	return 0
}
msj_img () {
#${timg}/id_${usrLOP}.png
local file_id
          ShellBot.getFile --file_id "$1"
          #ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${timg}/id_${usrLOP}.png"
		  #[[ -e ${return[file_path]} ]] && mv ${return[file_path]} "${timg}/id_${usrLOP}.png1"
	#[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      #ShellBot.sendPhoto --chat_id $var --photo @${timg}/id_${usrLOP}.png
			  #ShellBot.deleteMessage --chat_id $var --message_id $1
			  upimg_fun
local bot_retorno="ID user botgen\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" FILE ${return[file_path]} \n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e $bot_retorno)</i>" \
									--parse_mode html	
	
	return 0
}
msj_chat () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
		      ShellBot.sendChatAction --chat_id $var --action typing
			  #ShellBot.deleteMessage --chat_id $var --message_id $1 
	return 0
}
msj_donar () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html \
							--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_donar')"
	return 0
}
saveID(){
	unset botao_save_id
	botao_save_id=''
	ShellBot.InlineKeyboardButton 	--button 'botao_save_id' --line 1 --text "Autorizar ID" --callback_data "/saveid $1"
}
botao_conf=''
botao_user=''
botao_donar=''
unset botao_send_id
botao_send_id=''
ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text "ENVIAR al ADM" --callback_data '/sendid'
ShellBot.InlineKeyboardButton --button 'botao_send_id' --line 1 --text "menu" --callback_data '/menu'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'NEW ID' --callback_data '/add'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'QUITAR 🗑' --callback_data '/del'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text 'LISTAR 📋' --callback_data '/list'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text ' 🔎 ID' --callback_data '/buscar'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text ' ✅ | ❌ ' --callback_data '/power'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text 'MENU' --callback_data '/menu'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text '🔑 GEN KEY 🔑' --callback_data '/keygen'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text '🔑 GEN KEY 🔑' --callback_data '/keygen'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' 🧿 Ban|IP 📲' --callback_data '/banIP' # '1' --url "https://t.me/$(cat < /etc/ADM-db/resell)"
ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' 🛒 CATALOGO 📝 ' --callback_data  '1' --url "$(cat < /etc/urlCT)"
ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text '💰 DONAR 💰' --callback_data  '1' --url "$(cat < /etc/urlDN)"
ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text ' 🪀 WTS 📲' --callback_data  '1' --url "https://wa.me/$(cat < /etc/numctc)"
ShellBot.InlineKeyboardButton --button 'botao_user' --line 3 --text ' MENU ' --callback_data '/menu'
#ShellBot.InlineKeyboardButton --button 'botao_user' --line 2 --text ' Contacto 📲' --callback_data  '1' --url 'https://wa.me/593987072611?text=Hola!,%20ℂ𝕙𝕦𝕞𝕠𝔾ℍ%20Me%20interesa%20Conocer%20más%20sobre%20el%20ADM.'
ShellBot.InlineKeyboardButton --button 'botao_donar' --line 2 --text 'Donar Paypal' --callback_data '1' --url "$(cat < /etc/urlDN)"
ShellBot.InlineKeyboardButton --button 'botao_donar' --line 2 --text 'ACCEDER WHATSAPP' --callback_data '1' --url "https://wa.me/$(cat < /etc/numctc)"
# Ejecutando escucha del bot

ayuda_src () {
bot_retorno="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  $message_from_first_name $message_from_last_name  𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
	 if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
			 bot_retorno+="/ID\n 𝚖𝚞𝚎𝚜𝚝𝚛𝚊 𝚜𝚞𝚜 𝙸𝙳 𝚍𝚎 𝚝𝚎𝚕𝚎𝚐𝚛𝚊𝚖 \n 𝚙𝚊𝚛𝚊 𝚝𝚎𝚗𝚎𝚛 𝚊𝚌𝚌𝚎𝚜𝚘 𝚊𝚕 /𝚔𝚎𝚢𝚐𝚎𝚗\n 𝚍𝚎𝚟𝚎 𝚎𝚗𝚟𝚒𝚊𝚛 𝚜𝚞 𝙸𝙳 𝚊𝚕 𝚊𝚍𝚖𝚒𝚗 $(cat < /etc/ADM-db/resell)\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="(Boton) Keygen\n genera una key para\n el instalador del script\n para tener acceso\n deve enviar su ID al admin $(cat < /etc/ADM-db/resell)\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/menu\n muestra el menu\n de comandos disponibles\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/ayuda\n muestra este menu de ayuda\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/donar\n ayuda Voluntaria\n"
			 bot_retorno+="$LINE\n"
		 else
			 bot_retorno+="/ID\n muestra sus ID de telegram\n para tener acceso al /keygen\n deve enviar su ID al admin $(cat < /etc/ADM-db/resell)\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="(Boton) Keygen\n genera una key para\n el instalador del script\n para tener acceso\n deve enviar su ID al admin $(cat < /etc/ADM-db/resell)\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/instal\n muestra el link de instalacion\n del script para usar sus key\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/menu\n muestra el menu\n de comandos disponibles\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/ayuda\n muestra este menu de ayuda\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/donar\n ayuda Voluntaria\n"
			 bot_retorno+="$LINE\n"
		 fi
	 else
		 bot_retorno+="/infosys\n muestra informacion del sistema\n Ram, Cpu, Fecha y Hora\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/ID\n muestra sus ID de telegram\n para tener acceso al /keygen\n deve enviar su ID al admin $(cat < /etc/ADM-db/resell)\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/add\n añade nuevo ID\n para dar acceso /keygen\n <u>modo de uso</u>\n /add 123456789 | dias \n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/del\n elimina los ID\n antes deves usar /list\n <u>modo de uso</u>\n /del Selecciona el ID\n \n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/list\n muestra una lista de id\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="(Boton) Keygen\n genera una key para\n el instalador del script\n para tener acceso\n deve enviar su ID al admin $(cat < /etc/ADM-db/resell)\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/instal\n muestra el link de instalacion\n del script para usar sus key\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/power\n poner o sacar de linea el generador\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/menu\n muestra el menu\n de comandos disponibles\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/ayuda\n muestra este menu de ayuda\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/cache\n limpia el cache contenido en la ram\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/reboot\n Reinicia el servidor vps\n"
		 bot_retorno+="$LINE\n"
	 fi
msj_fun
}
upfile_src () {
cp ${CID} $HOME/
upfile_fun $HOME/User-ID
rm $HOME/User-ID
}
cache_src () {
#MEMORIA RAM
unset ram1
unset ram2
unset ram3
unset _usor
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
	  bot_retorno="==========Antes==========\n"
	  bot_retorno+="Ram: $ram1 || EN Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="=========================\n"
msj_fun
sleep 2
sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1
unset ram1
unset ram2
unset ram3
unset _usor
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
	  bot_retorno="==========Ahora==========\n"
	  bot_retorno+="Ram: $ram1 || EN Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="=========================\n"
msj_fun
}
# -*- ENCODING: UTF-8 -*-
dropID () {
	unset bot_retorno
[[ -e /etc/systemd/system/btkill.service ]] && {
killall kill_drop.sh &>/dev/null
systemctl stop btkill &>/dev/null
systemctl disable btkill &>/dev/null
rm /etc/systemd/system/btkill.service &>/dev/null
bot_retorno+=" ⚠️ ALERTA DE NOTIFICACION ⚠️\n"
bot_retorno+="          Bot ID KILL fuera de linea"
bot_retorno+="$LINE\n"
} || {
echo -e '[Unit]
Description=BotGen Service by ${admin}
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart="/bin/bash" "/etc/ADM-db/sources/kill_drop.sh"
ExecReload="/bin/bash" "/etc/ADM-db/sources/kill_drop.sh"
Restart=always
RestartSec=3600s
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/btkill.service
	systemctl daemon-reload
	systemctl enable btkill &>/dev/null
	systemctl start btkill &>/dev/null
	bot_retorno+=" 🔰 AVISO DE NOTIFICACION 🔰 \n"
	bot_retorno+="           Bot ID KILL ACTIVADO"
	bot_retorno+="$LINE\n"
}
msj_fun
#[[ -e /etc/ADM-db/Admin-ID ]] && var=$(cat < /etc/ADM-db/Admin-ID) 
#[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
 #							ShellBot.sendMessage --chat_id $var \
 #                           --reply_to_message_id $var \
 #                          --text "<i>$(echo -e $bot_retorno)</i>" \
 #                           --parse_mode html
}
comand () {
	    if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
			 case ${comando[0]} in
				 /[Ii]d|/[Ii]D)myid_src &;;
				 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
				 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
				 /[Dd]onar|[Dd]onar)donar &;;
				 /[Ii]mg|[Ii]mg)reply &;;
				 /[Pp]rice|[Pp]price|[Pp]rices|/[Pp]rices)prices_on &;;
				 /sendid)send_ID;;
				 /chekid)send_ID;;
				 /upmake)dupdate2;;
				 /*|*)invalido_fun &;;
			 esac
		 else
		 	if [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
			 case ${comando[0]} in
				 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
				 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
				 /[Ii]d|/[Ii]D)myid_src &;;
				 /[Ii]nstal)link_src &;;
				 /[Kk]eygen)gerar_key &;;
				 /[Bb]anIP|[Bb]anIP)reply &;;
				 /[Pp]rice|[Pp]price|[Pp]rices|/[Pp]rices)prices_on &;;
				 /[Dd]onar|[Dd]onar)donar &;;
				 /upmake)dupdate2;;
				 /*|*)invalido_fun &;;
			 esac
			fi
			sleep 5 
			[[ -e "/etc/donar_active.txt" ]] && donar
		 fi
	    else
	    	if [[ ${message_reply_to_message_message_id[$id]} ]]; then
				case ${message_reply_to_message_text[$id]} in
					'/del')deleteID_reply;;
					'/add')addID_reply;;
					'/addrev')addID_reventa;;
					'/buscar')searchID_reply;;
					'/banIP')killIP_reply;;
					'/img')img_reply;;
					*)invalido_fun;;
				esac
			elif [[ ${message_document_file_id[$id]} ]]; then
					 download_file
	    	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
		 		case ${comando[0]} in
					 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
					 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
					 /[Ii]d|/[Ii]D)myid_src &;;
					 /[Kk]illid|[Kk]illid) dropID &;;
					 /[Cc]hat|[Ch]hat)msj_chat &;;
					 /[Ii]mg|[Ii]mg)reply &;;
					 /[Aa]dd|/[Dd]el)reply &;;
					 /[Aa]ddrev)reply &;;
					 /[Bb]uscar|[Bb]uscar)reply &;;
					 /[Bb]anIP|[Bb]anIP)reply &;;
					 /[Cc]atip|[Cc]atip)list_IP &;;
					 /[Pp]ower)start_gen &;;
					 /[Kk]eygen)gerar_key &;;
			 		 /[Ii]nfosys)infosys_src &;;
			 		 /[Ll]ist)listID_src &;;
			 		 /[Ii]dgen|[Ii]dgen)listID_GEN &;;
					 /[Rr]eboot)reboot_src &;;
			 		 /[Ii]nstal)link_src &;;
			 		 /[Cc]ache)cache_src &;;
					 /[Uu]pdate|/[Aa]ctualizar)update &;;
					 /[Dd]onar|[Dd]onar)donar_OnOff &;;
					 /[Pp]rice|[Pp]price|[Pp]rices|/[Pp]rices)prices_on &;;
					 /upmake)dupdate2;;
			 		 /*|*)invalido_fun &;;
				esac
			fi
	    fi
}
[[ -e /etc/ADM-db/idioma_menuinst ]] && tr=$(cat < /etc/ADM-db/idioma_menuinst)
prices_on () {
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
local msg
          msg=' •••••••••••••••••••••••••••••••••••••••••••••••••\n'
		  msg+=" Hola, 『 ${firsnme} ${lastnme} 』 \n"
		  msg+=' •••••••••••••••••••••••••••••••••••••••••••••••••\n' 
          msg+=' $0.70 USD - Acceso ilimitado al BOT 4 dias \n'   
		  msg+=' $1.00 USD - Acceso ilimitado al BOT 7 dias \n'   
          msg+=' $1.50 USD - Acceso ilimitado al BOT 15 dias \n'   
          msg+=' $2.00 USD - Acceso ilimitado al BOT 30 dias \n'   
		  msg+=' $3.00 USD - Acceso ilimitado al BOT 60 dias\n' 
		  msg+=' $4.00 USD - Acceso ilimitado al BOT 90 dias\n' 
		  msg+=' $5.00 USD - Acceso ilimitado al BOT 180 dias\n' 
		  msg+=' $9.00 USD - Acceso ilimitado al BOT 365 dias\n' 
		  msg+='•••••••••••••••••••••••••••••••••••••••••••••••••\n' 
		  msg+=" BOT PREMIUM CON ACCESO Ilimitado \n Incluyendo tu reseller en la Key! \n Soporte, Actualizaciones y MAS!!)\n"
		  msg+='•••••••••••••••••••••••••••••••••••••••••••••••••\n'  
		  msg+=" VISITA NUESTRO CATALOGO EN https://shoppy.gg/${admin}/ \n"
		  msg+='•••••••••••••••••••••••••••••••••••••••••••••••••\n'  
          ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
							--reply_to_message_id "${message_message_id[$id]}" \
							--text "<i>$(echo -e $msg)</i>" \
							--parse_mode html
return 0
}
donar () {
			 bot_retorno="$LINE\n"
			 bot_retorno+="        ⚠️ TENDRAS ACCESO ILIMITADO ⚠️ \n          🚫 INCLUIDO TU RESELLER EN LA KEY 🚫"
			 bot_retorno+=" 𝙴𝚜𝚝𝚎 𝙿𝚛𝚘𝚢𝚎𝚌𝚝𝚘, 𝚗𝚎𝚌𝚎𝚜𝚒𝚝𝚊 𝚊𝚢𝚞𝚍𝚊 𝚙𝚊𝚛𝚊 𝙴𝚟𝚘𝚕𝚞𝚌𝚒𝚘𝚗𝚊𝚛\n"
			 bot_retorno+="          𝙎𝙞 𝙙𝙚𝙨𝙚𝙖𝙨 𝙍𝙚𝙖𝙡𝙞𝙯𝙖𝙧 𝙪𝙣𝙖 𝘿𝙤𝙣𝙖𝙘𝙞𝙤𝙣\n"
			 bot_retorno+="                     𝙋𝙖𝙮𝙥𝙖𝙡\n"
			 bot_retorno+="            PAGO BTC - CRIPTOMONEDA\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+=" Desde ya muchas gracias\n"
			 bot_retorno+="$LINE\n"
			 msj_fun 
			 #msj_donar
}
donar_OnOff () {
if [[ ! -e "/etc/donar_active.txt" ]]; then
	echo "on" > /etc/donar_active.txt
	local bot_retorno="$LINE\n"
          bot_retorno+="MENSAJE DONATIVO : <u>ENCENDIDO</u> ✅\n"
	  bot_retorno+="$LINE\n"
	msj_fun
else
	rm -rf /etc/donar_active.txt
	local bot_retorno="$LINE\n"
          bot_retorno+="MENSAJE DONATIVO: <u>APAGADO</u> ❌\n"
	  bot_retorno+="$LINE\n"
	msj_fun
fi
}
# -*- ENCODING: UTF-8 -*-
# verificacion primarias
meu_ip_fun () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="cabecalho menu_credito ferramentas menu_inst PPub.py usercodes payloads PDirect.py v-local.log PGet.py ultrahost menu POpen.py shadowsocks.sh fai2ban PPriv.py"
SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="$(echo "NewVPS-" | rev)"
[[ -e /etc/menu_ito ]] && nomkey="$(cat /etc/menu_ito)" || nomkey="$(curl -sSL "https://www.dropbox.com/s/z38hj1mz3q9krso/menu_credito")"
gerar_key () {
unset usrLOP nombrevalue nBot nBotSS
[[ -z ${nombrevalue} ]] && nombrevalue="${message_from_id}" 
[[ -z ${nombrevalue} ]] && nombrevalue="${callback_query_from_id}"
[[ -z ${callback_query_from_username} ]] && usrLOP=${message_from_username} || usrLOP=${callback_query_from_username}
#[[ -z ${usrLOP} ]] && LIST="$(echo "NewVPS-" | rev)" || LIST="$(echo "${usrLOP}-" | rev)"
numkey_gen=$(grep -o -i $nombrevalue /etc/ADM-db/num-key.cont | wc -l)
limcont=$(cat /etc/ADM-db/limit) 
[[ "$limcont" -ge "998" ]] && limted="∞" || limted=$(cat /etc/ADM-db/limit)
[[ "$(( $limcont - $numkey_gen ))" -ge "900" ]] && credres="∞" || credres=$(( $limcont - $numkey_gen))
meu_ip_fun
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
[[ -z $nBot ]] && nBot=$(ShellBot.username)
[[ -e ${CIDdir}/ress ]] && echo $nomkey > ${SCPT_DIR}/menu_credito || echo -e "${firsnme} ${lastnme}" > ${SCPT_DIR}/menu_credito
adminV="$(less ${SCPT_DIR}/menu_credito)";
valuekey="$(date | md5sum | head -c11)"
valuekey+="$(echo $(($RANDOM*10))|head -c 6)"
#valuekey="$(date | md5sum | head -c4)"
#valuekey+="$(echo $(($RANDOM*10))|head -c 3)"
#valuekey+="$(date | md5sum | head -c5)"
#valuekey+="$(echo $(($RANDOM*10))|head -c 2)"
oUP=$(wget -qO- ipv4.icanhazip.com)
fun_list "$valuekey"
keyfinal="$(ofus "$oUP:8888/${valuekey}/$LIST")"
#local bot_retorno=" ═--💻  𝙎 𝘾 𝙍 𝙄 𝙋 𝙏  |  𝘾𝙝𝙪𝙢𝙤𝙂𝙃|𝘼𝘿𝙈   💻  --═\n" #--------------------------------------------------------------------------------------
local bot_retorno=" $LINE\n"  #--------------------------------------------------------------------------------------
#   🚫 Sin TU RESELLER EN LA KEY 🚫\n
[[ -z ${message_chat_tittle} ]] && grupCHAT="" || grupCHAT="ChatID : ${chatuser} "
#bot_retorno+="  KEY { $numkey_gen } DE @${usrLOP} con ID: ${nombrevalue} $grupCHAT \n ⚠️ VENCE EN 1 HORA O AL SER USADA ⚠️\n"
[[ -z ${usrLOP} ]] && bot_retorno+=" 🪧 USUARIO SIN ALIAS CON ID: ⚠️ADVERTIDO⚠️ \n  ⚠️ KEY VENCE EN 4 HORAS O AL USARLA ⚠️\n ⚠️\n" || bot_retorno+="  KEY { $numkey_gen } DE @${usrLOP} con ID: <tg-spoiler>${nombrevalue}</tg-spoiler> $grupCHAT \n ⚠️ VENCE EN 4 HORAS O AL SER USADA ⚠️\n"
bot_retorno+="$LINE\n"
bot_retorno+=" 🛡️ 𝚁𝙴𝚂𝙴𝙻𝙻𝙴𝚁 🛡️ : ${adminV}\n"
bot_retorno+="$LINE\n"
bot_retorno+=" 🗝️  <pre>${keyfinal}</pre> 🗝️\n"
bot_retorno+="$LINE\n"
bot_retorno+="  🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕 $(cat < /etc/SCRIPT/v-local.log) 🔐 \n"
bot_retorno+="$LINE\n"
bot_retorno+='<pre>apt update -y; apt upgrade -y; wget -q https://raw.githubusercontent.com/drowkid01/ScriptCGH/main/setup; chmod 777 setup; ./setup --install</pre>\n'
bot_retorno+="$LINE\n"
bot_retorno+="     𝙍𝙚𝙘𝙤𝙢𝙚𝙣𝙙𝙖𝙙𝙤 𝙐𝙗𝙪𝙣𝙩𝙪 18.04 \n   🧬🧬 S.O Ubuntu 14 a 22 X64(x86|ARM) 🧬🧬 \n          Debian 7,8,9,11 (x64) \n  🪦 ADQUIERE TU ACCESO EN @${nBot} 🛡️⚔️\n"
bot_retorno+="$LINE\n"
msj_fun
bot_file+="  🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕 $(cat < /etc/SCRIPT/v-local.log) 🛡️ \n\n"
bot_file+="apt update -y && apt upgrade -y && wget -q https://raw.githubusercontent.com/drowkid01/ScriptCGH/main/setup && chmod +x setup && ./setup --install\n\n"
bot_file+="  ${keyfinal} \n"
echo -e ${bot_file} > ${keytxt}/key_${usrLOP}.txt
upfile_fun ${keytxt}/key_${usrLOP}.txt
rm ${keytxt}/key_${usrLOP}.txt
}
fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS 
unset nombrevalue
[[ -z ${nombrevalue} ]] && nombrevalue="${message_from_id}" 
[[ -z ${nombrevalue} ]] && nombrevalue="${callback_query_from_id}"
[[ "$(grep -o -i $nombrevalue /etc/ADM-db/num-key.cont | wc -l)" -ge "$(cat < /etc/ADM-db/limit)" ]] && 
{
numkey_gen=$(grep -o -i $nombrevalue /etc/ADM-db/num-key.cont | wc -l)
local bot_retorno="$LINE\n"
bot_retorno+=" 🚫 OOOH!, @${callback_query_from_username} con ID:$nombrevalue ‼️\n Tus Creditos se han Agotado \n"
bot_retorno+="  TUS CREDITOS PERMITIDOS :『 $(cat < /etc/ADM-db/limit) 』, 𝙆𝙚𝙮𝙨 𝙂𝙚𝙣𝙚𝙧𝙖𝙙𝙖𝙨『 $numkey_gen 』🗝️\n"
bot_retorno+="$LINE\n"
bot_retorno+=" Si deseas Usar el Generador sin Limite , Contacta con $(cat < /etc/ADM-db/resell)\n"
bot_retorno+=" Recuerda que Todo Esfuerzo Vale, Solicita Acceso \n"
bot_retorno+=" 𝙍𝙚𝙘𝙤𝙢𝙚𝙣𝙙𝙖𝙙𝙤 𝙐𝙗𝙪𝙣𝙩𝙪 18.04 \n   🧬🧬 S.O Ubuntu 16,18,20 X64(x86|ARM) 🧬🧬 \n          Debian 7,8,9,10 (x64) \n  🪦 ADQUIERE TU ACCESO EN @${nBot} 🛡️⚔️\n"
bot_retorno+=" 🔐 𝙆𝙚𝙮𝙨 𝙐𝙨𝙖𝙙𝙖𝙨『 $(grep -o -i $nombrevalue /etc/gerar-sh-log | wc -l) 』 🔓, 𝘒𝘦𝘺𝘴 𝘈𝘤𝘵𝘪𝘷𝘢𝘴 『 $(ls /etc/http-shell/ | grep name | wc -l) 』 🗝️ \n"
bot_retorno+="$LINE\n"
msj_fun
exit
} ||
echo "$nombrevalue" >> /etc/ADM-db/num-key.cont
numkey_used=$(grep -o -i $nombrevalue /etc/gerar-sh-log | wc -l)
numkey_gen=$(grep -o -i $nombrevalue /etc/ADM-db/num-key.cont | wc -l)
#ADM BASIC
arqslist="$BASICINST"
for arqx in `echo "${arqslist}"`; do
[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
echo "$arqx" >> ${DIR}/${KEY}/${LIST}
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
_hora=$(printf '%(%D-%H:%M:%S)T') 
TOKEN="$(cat /etc/ADM-db/token)"
urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
MENSAJE=" ••••📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩••••\n"
MENSAJE+=" KEY : ${keyfinal} \n"
MENSAJE+=" CADUCADA : $_hora\n"
MENSAJE+=" ••••••••••••••••••••••••••••••••••••••••••••••••\n"
MENSAJE+='       🔰 Bot generador de key 🔰\n'
MENSAJE+='           ⚜ By ${admin} ⚜ \n'
MENSAJE+=" ••••••••••••••••••••••••••••••••••••••••••••••••\n"
#&& curl -s -X POST $urlBOT -d chat_id=$nombrevalue -d text="$(echo -e "$MENSAJE")" &>/dev/null
at now +4 hours <<< "rm -rf ${DIR}/${KEY} && rm -f ${DIR}/${KEY}.name"
}
ofus () {
unset server
server=$(echo ${txt_ofuscatw}|cut -d':' -f1)
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="x";;
"x")txt[$i]=".";;
"5")txt[$i]="s";;
"s")txt[$i]="5";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"4")txt[$i]="0";;
"0")txt[$i]="4";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
[[ -d /root/RegBOT ]] || mkdir /root/RegBOT
send_ID () {
MSG_id=$((${message_message_id} + 1 ))
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
[[ -z ${callback_query_from_username} ]] && nUSER=${message_from_username} || nUSER=${callback_query_from_username}
[[ -e /root/RegBOT/U_check.txt ]] && n_soli=$(cat /root/RegBOT/U_check.txt | grep ${chatuser} | wc -l) || n_soli=1
[[ $n_soli < 2 ]] && {
echo "${chatuser}" >> /root/RegBOT/U_check.txt
          bot_retor="$LINE\n"
          bot_retor+=" Cliente 『 ${firsnme} ${lastnme} 』\n"
		  [[ -z ${nUSER} ]] && bot_retor+=" ⚠️ USUARIO SIN ALIAS ⚠️\n" || bot_retor+=" <u> ALIAS</u>: @${nUSER} CON $n_soli INTENTOS\n"
		  bot_retor+="$LINE\n"
		  bot_retor+=" FORMATO $MSG_id <tg-spoiler>${chatuser}</tg-spoiler> | <u>DIAS</u> \n"
          bot_retor+=" PARA ACEPTAR DA CLICK AQUI 👉 /add , LUEGO\n"
          bot_retor+=" PARA 4 DIAS COPY 👉 <code>${chatuser} | 4</code> \n"
          bot_retor+=" PARA 7 DIAS COPY 👉 <code>${chatuser} | 7</code> \n"
          bot_retor+=" PARA 15 DIAS COPY 👉 <code>${chatuser} | 15</code> \n"
          bot_retor+=" PARA 30 DIAS COPY 👉 <code>${chatuser} | 30</code> \n"
          bot_retor+=" PARA 60 DIAS COPY 👉 <code>${chatuser} | 60</code> \n"
          bot_retor+=" PARA 90 DIAS COPY 👉 <code>${chatuser} | 90</code> \n"
          bot_retor+=" PARA 180 DIAS COPY 👉 <code>${chatuser} | 179</code> \n"
          bot_retor+=" PARA 1 AÑO COPY 👉 <code>${chatuser} | 364</code> \n"
		  bot_retor+=" CUSTOM COPY 👉 ♨️ <code>${chatuser} | dias</code> ♨️\n"
          bot_retor+="$LINE\n"
          bot_retor+=" VERIFIQUE SU TOKEN DE PAGO ANTES DE LA AUTORIZACION\n"
          bot_retor+="$LINE\n"
		  msj_add "$(cat < ${CIDdir}/Admin-ID)"
    	bot_retorno="$LINE\n"
        bot_retorno+=" 🔰 𝚂𝚞 𝙸𝙳 【 <code>${chatuser}</code> 】 🔰\n"
        bot_retorno+="$LINE\n"
        [[ -z ${nUSER} ]] && bot_retorno+=" ⚠️ AÑADA UN ALIAS PARA PODER SOLICITAR ⚠️\n" || bot_retorno+="UD SOLICITO AUTORIZACION A $(cat < /etc/ADM-db/resell)\n"
        [[ -z ${nUSER} ]] && bot_retorno+="   IMPOSIBLE VERIFICAR ID SIN ALIAS\n  REMARCA SU ${n_soli} SOLITUD INVALIDA \n" || bot_retorno+=" ESTA ES SU ${n_soli} SOLICITUD MEDIANTE ID DE REGISTRO\n"
        bot_retorno+="$LINE\n"
        [[ -z ${nUSER} ]] && bot_retorno+=" ⚠ ID ENVIADO CON ADVERTENCIA (POSIBLE BANEO DE ID) ⚠️\n" || bot_retorno+="      ✅ ID ENVIADO EXITOSAMENTE ✅\n"
        bot_retorno+="$LINE\n"
		bot_retorno+=" ENVIE SU COMPROBANDO O CORREO DE PAGO PARA SU AUTORIZACION\n"
		bot_retorno+="$LINE\n"
		msj_fun
			} || {
				bot_retorno="$LINE\n"
				bot_retorno+=" 🔰 𝚂𝚞 𝙸𝙳 【 <code>${chatuser}</code> 】 🔰\n"
				bot_retorno+="$LINE\n"
				[[ -z ${nUSER} ]] && bot_retorno+=" ⚠️ USUARIO SIN ALIAS ⚠️\n" || bot_retorno+=" <u> ALIAS</u>: @${nUSER} CON ID : <code>${chatuser}</code>\n"
				[[ -z ${nUSER} ]] && bot_retorno+=" ⚠️ AÑADA UN ALIAS PARA PODER SOLICITAR ⚠️\n" || bot_retorno+=" UD ENVIO ${n_soli} SOLICITUDES A $(cat < /etc/ADM-db/resell)\n"
				[[ -z ${nUSER} ]] && bot_retorno+="   IMPOSIBLE VERIFICAR ID SIN ALIAS\n  REMARCA SU ${n_soli} SOLITUD INVALIDA \n" || bot_retorno+=" SU PETICION FUE RECHAZADA POR EXCESO DE PETICIONES\n"
				bot_retorno+="     🚫🚫️ SU ID FUE BANEADO 🚫🚫 \n"
				bot_retorno+="$LINE\n"
				echo "${chatuser}" >> /root/RegBOT/banID
		bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
		bot_retorno+="$LINE\n"
		msj_fun
	}
}
myid_src () {
MSG_id=$((${message_message_id} + 1 ))
[[ -z ${callback_query_from_username} ]] && nUSER=${message_from_username} || nUSER=${callback_query_from_username}
[[ ! -z $(cat /etc/ADM-db/Admin-ID|grep "${chatuser}" ) ]] && { #ENTRA A VERIFICAR ADM
bot_retorno="  $LINE\n"
bot_retorno+=" HOLA @${nUSER} UD ES ADM \n"
bot_retorno+="$LINE\n"
bot_retorno+=" DIJITA MENU /menu   🔰\n"
bot_retorno+="\n"
bot_retorno+="$LINE\n"
bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
bot_retorno+="$LINE\n"
#bot_retorno+="<b>bold</b>, <strong> bold</strong> \n
#<i>italic</i>, <em>italic</em>\n"
bot_retorno+=" <pre>BORRAREMOS ESTE PRE ${message_message_id} </pre>\n"
bot_retorno+=" <code>BORRAREMOS ESTE CODE ${MSG_id} </code>\n"
msj_fun
sleep 5s
msj_del ${message_message_id}
msj_del ${MSG_id}
} || { # SINO ES ADM - CAMBIA A USUARIOS AUTORIZADOS
	[[ $(cat ${CID}|grep "${chatuser}" ) = "" ]] && { # ENTRA A VERIFCAR USUARIOS QUE NO EXISTEN
		bot_retorno="$LINE\n"
		[[ -z ${nUSER} ]] && bot_retorno+=" ⚠️ USUARIO SIN ALIAS ⚠️\n" || bot_retorno+="𝙃𝙤𝙡𝙖 【 @${nUSER} 】, SU ID NO ESTA AUTORIZADO\n"
		bot_retorno+="  ADQUIERE UNA MENBRESIA O DIJITA /prices \n"
		bot_retorno+=" VISITA LA TIENDA 🛒🛍️ PINCHANDO 👉<a href='https://shoppy.gg/${admin}/'>AQUI</a>👈\n"
        bot_retorno+="$LINE\n"
        bot_retorno+="𝚂𝚞 𝙸𝙳 【 <code>${chatuser}</code> 】\n"
        bot_retorno+="$LINE\n"
        bot_retorno+="👇PINCHA 👇 EN EL BOTON PARA QUE $(cat < /etc/ADM-db/resell) TE AUTORICE!!\n"
        bot_retorno+="$LINE\n"
		menu_printSN
		sleep 5s
		msj_del ${message_message_id}
		msj_del ${MSG_id}
	} || { # ENTRA A  IDS YA REGISTRADOS
			bot_retorno="  $LINE\n"
			bot_retorno+=" HOLA @${nUSER} SU ID ESTA REGISTRADO \n"
			bot_retorno+="$LINE\n"
			bot_retorno+="    🆔 : <code>${chatuser}</code> 🔰\n"
			bot_retorno+=" FECHA DE CORTE : ⏳ $(cat /etc/ADM-db/User-ID | grep ${chatuser}| awk '{print $3}') | $(date +%R)\n"
			bot_retorno+="\n"
			bot_retorno+="$LINE\n"
			bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
			bot_retorno+="$LINE\n"
			msj_fun
		}
						} # FIN VERIFICAR ADM
}
killIP_reply () {
if sed -i "/${message_text[$id]}/d" /var/www/html/drowkid01/checkIP.log; then
bot_retorno="$LINE\n"
bot_retorno+="  IP ELIMINADA DE REGISTRO EXITOSAMENTE!\n"
bot_retorno+="  IP : ${message_text[$id]} \n"
bot_retorno+="$LINE\n"
else
bot_retorno="$LINE\n"
bot_retorno+="  ERROR AL ELIMINAR IP DE REGISTROS \n"
bot_retorno+="  POSIBLEMENTE ${message_text[$id]} NO EXISTA \n"
bot_retorno+="$LINE\n"
fi
msj_fun
}
deleteID_reply () {
ids=$(echo ${message_text[$id]} | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
idc=$(echo ${message_text[$id]} | awk '{print $3}' | sed -e 's/[^a-z0-9 -]//ig')
sed -i "${message_text[$id]}/d" ${CID}
bot_retorno="$LINE\n"
          bot_retorno+=" ID ELIMINADO EXITOSAMENTE!\n"
          bot_retorno+=" ID Eliminado: ${ids}\n"
          bot_retorno+="$LINE\n"
			
          bot_retor="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  Nuevamente 𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
          #bot_retor+="𝙃𝙤𝙡𝙖 『 $message_from_first_name $message_from_last_name 』\n"
          bot_retor+="Desafortunadamente tu Membresia ha Finalizado\n"
          #bot_retor+=" ⌚⌚ Hora Actual del Bot : ⌚⌚\n"
          bot_retor+="Fecha de Corte : $(date '+%C%y-%m-%d') - $(date +%R)  \n"
          bot_retor+="Si tienes Dudas, Contacta con $(cat < /etc/ADM-db/resell)\n"
          bot_retor+="$LINE\n"
          bot_retor+="Recuerda adquirir creditos, o Realizar una Colaboracion\n $(cat < /etc/mpayu) \n"
          bot_retor+="Para mantener tu acceso al BotGen Recuerda Mostrar tu Token de Donacion o Compra\n"
          bot_retor+="$LINE\n"
      msj_fun
      msj_add ${ids}
      upfile_src
}
img_reply () {
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "/root/"
		  [[ -e ${return[file_path]} ]] && mv ${return[file_path]} "/root/"
local bot_retorno="ID user botgen\n"
		bot_retorno+="$LINE\n"
		bot_retorno+=" FILE ${return[file_path]} \n"
		bot_retorno+="$LINE"
ID_img=${message_photo_file_unique_id}
          bot_retorno+=" CALCULANDO ID DE MENSAJES \n"
          bot_retorno+=" ID FILE PHOTO : ${message_photo_file_id}\n"
		  bot_retorno+="$LINE\n"
          bot_retorno+=" ID UNICO FILE PHOTO : ${message_photo_file_unique_id}\n"
          bot_retorno+=" CAPTION : ${message_caption}\n"
          bot_retorno+="$LINE\n"
      msj_fun
      #upfile_src
	  msj_img "${ID_img}"
}
searchID_reply () {
searchID=$(cat -n /etc/ADM-db/User-ID | grep "${message_text[$id]}")
bot_retorno="$LINE\n"
        bot_retorno+=" MOSTRANDO RESULTADOS DE BUSQUEDA!\n"
		bot_retorno+=" $LINE\n"
		[[ ! -z ${searchID} ]] && bot_retorno+=" N°${searchID} \n" || bot_retorno+=" ID NO ENCONTRADO \n"
      msj_fun
}
addID_reply () {
      ids=$(echo ${message_text[$id]} | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
        idc=$(echo ${message_text[$id]} | awk '{print $3}' | sed -e 's/[^a-z0-9 -]//ig')
        valid=$(date '+%C%y-%m-%d' -d " +$idc days")
	  [[ $(cat ${CID}|grep "$ids" ) = "" ]] && {
		[[ -e /root/RegBOT/banID ]] && sed -i "/${ids}/d" /root/RegBOT/banID
        echo "/${ids} | $valid" >> ${CID}
        echo "/${ids} | $(date '+%C%y-%m-%d') | $(date +%R)" >> ${CID}.reg
          bot_retorno="  ✉️ REGISTRO ACEPTADO  ✉️ \n"
          bot_retorno+=" 🆔 : ${ids} | ACEPTADO 🧾\n"
          bot_retorno+="$LINE\n"
          bot_retorno+=" FECHA DE REGISTRO : $(date '+%C%y-%m-%d')|$(date +%R) \n VALIDO HASTA : ${valid}|$(date +%R)\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="  ✅ ID REGISTRADO EXITOSAMENTE ✅\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
unset i
for i in $(cat /etc/ADM-db/User-ID | awk '{print $3}'); do 
[[ "$(date -d $(date '+%C%y-%m-%d') +%s)" -ge "$(date -d $i +%s)" ]] && {
for id in $(cat /etc/ADM-db/User-ID | grep "$i" | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig'); do
sed -i "/${id}/d" /etc/ADM-db/User-ID
          bot_retor="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  Nuevamente 𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
          bot_retor+=" SU MEMBRESIA HA FINALIZADO POR CHECK ID\n"
          bot_retor+=" FIN DE CONTRADO : $(date '+%C%y-%m-%d') - $(date +%R) \n"
          bot_retor+=" SI DESEAS APELAR TU CONTRADO, CONTACTA CON $(cat < /etc/ADM-db/resell)\n"
          bot_retor+=" $LINE\n"
          bot_retor+=" ADQUIERE TU MEMBRESIA DESDE @$(ShellBot.username) , DIGITANDO /prices \n"
          bot_retor+=" RECUERDA MANTENER TU CAPTURA DE PAGO, PARA ALGUN RECLAMO!\n"
          bot_retor+=" $LINE\n"
msj_add ${id}
done
}
done
[[ -z ${callback_query_from_username} ]] && nUSER=${message_from_username} || nUSER=${callback_query_from_username}
[[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
[[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
		  bot_retor=" ✉️ ESTIMADO @${nUSER} SU REGISTRO FUE APROBADO  ✉️ \n"
		  bot_retor+=" $LINE\n"
          bot_retor+=" EL ADM $(cat < /etc/ADM-db/resell) APROBO TU SOLICITUD\n"
          bot_retor+="  ☺️GRACIAS POR CONFIAR EN NOSOTROS ☺️\n"
          bot_retor+=" FECHA DE REGISTRO : $(date '+%C%y-%m-%d')|$(date +%R) \n VALIDO HASTA : ${valid}|$(date +%R)\n"
		  bot_retor+=" 🆔 : ${ids} | 🔐 ACEPTADO 🧾\n"
		  bot_retor+="𝙃SU RESELLER : ${firsnme} ${lastnm} \n"
          bot_retor+=" $LINE\n"
          bot_retor+=" GENERAR Key's usar el comando /keygen\n"
          bot_retor+=" Para MENU Digita el comando /menu\n"
          bot_retor+=" $LINE\n"
          bot_retor+=" CONTACTA ESCRIBE AL ADM $(cat < /etc/ADM-db/resell)\n SI NO OBTIENES RESPUESTA O SOLUCION CONTACTA A ${admin} "
          bot_retor+=" ADQUIERE TU MEMBRESIA DESDE @$(ShellBot.username) , DIGITANDO /prices \n"
          bot_retor+=" RECUERDA MANTENER TU CAPTURA DE PAGO, PARA ALGUN RECLAMO!\n"
          bot_retor+=" $LINE\n"
      msj_fun
      msj_add ${ids}
      upfile_src
    } || {
          bot_retorno=" ✉️ ====NOTIFICACION==== ✉️ \n"
          bot_retorno+="$LINE\n"
          bot_retorno+="Este ID ya esta Registrado\n"
          bot_retorno+="  ❌ ID NO REGISTRADO ❌\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
          bot_retorno+="$LINE\n"
      msj_fun
    }
}
addID_reventa () {
bot_retorno=" -----🫥 FUNCION EN ESTADO BETA 🫥 ------\n"
bot_retorno+=" $LINE\n"
bot_retorno+=" ID ${ids} VALIDO HASTA $(cat /etc/ADM-db/User-ID | grep ${ids} | awk '{print $3}')\n"
bot_retorno+=" ❌ NO REGISTRAR DUPLICADOS ❌\n"
bot_retorno+=" SE PRESENTAN REGLAS DE ESTE FORMATO \n"
bot_retorno+=" 1 ID - Podra autorizar maximo 10 IDs  \n"
bot_retorno+="  Por maximo de 6 meses de tiempo! \n"
bot_retorno+="$LINE\n"
bot_retorno+="  EL ADMIN PRINCIPAL, PODRA CONTROLAR  \n"
bot_retorno+="         ESTAS AUTORIZACIONES  \n"
bot_retorno+="$LINE\n"
bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
bot_retorno+="$LINE\n"
msj_fun
}
addID_REV () {
      ids=$(echo ${message_text[$id]} | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
      idc=$(echo ${message_text[$id]} | awk '{print $3}' | sed -e 's/[^a-z0-9 -]//ig')
      valid=$(date '+%C%y-%m-%d' -d " +$idc days")
	  [[ $(cat ${${CIDRESS}}|grep "$ids" ) = "" ]] && {
        echo "/${ids} | $valid" >> ${CID}
          bot_retorno="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  @${callback_query_from_username}  𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
          bot_retorno+="$LINE\n"
          bot_retorno+=" New ID: ${ids}\n"
		  bot_retorno+=" FECHA DE REGISTRO : $(date '+%C%y-%m-%d')|$(date +%R) \n VALIDO HASTA : ${valid}|$(date +%R)\n"
          bot_retorno+="$LINE"
          bot_retorno+="  ✅ ID REGISTRADO ✅\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
unset i
for i in $(cat /etc/ADM-db/User-ID | awk '{print $3}'); do 
[[ $(date -d $i +%s) -ge $(date -d $(date '+%C%y-%m-%d') +%s) ]] || {
idlog=$(cat /etc/ADM-db/User-ID | grep "$i" | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig')
sed -i "/${idlog}/d" /etc/ADM-db/User-ID
          bot_retor="  🎊 𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  Nuevamente 𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  🎊\n"
          bot_retor+="Desafortunadamente tu Membresia ha Finalizado\n"
          bot_retor+="Fecha de Corte : $i \n"
          bot_retor+="Si tienes Dudas, Contacta con $(cat < /etc/ADM-db/resell)\n"
          bot_retor+="$LINE\n"
          bot_retor+="Recuerda adquirir creditos, o Realizar una Colaboracion\n $(cat < /etc/mpayu) \n"
          bot_retor+="Para mantener tu acceso al BotGen Recuerda Mostrar tu Token de Donacion o Compra\n"
          bot_retor+="$LINE\n"
msj_add ${idlog}
}
done
          bot_retor="  ✉️  𝙱𝚒𝚎𝚗𝚟𝚎𝚗𝚒𝚍𝚘  Nuevamente 𝚊𝚕  𝙱𝚘𝚝𝙶𝚎𝚗  𝙲𝚑𝚞𝚖𝚘𝙶𝙷-𝙰𝙳𝙼  ✉️ \n"
          bot_retor+="𝙃𝙤𝙡𝙖 『 ${callback_query_from_first_name} ${callback_query_from_last_name} 』\n"
          bot_retor+=" EL ADM $(cat < /etc/ADM-db/resell) te autorizo\n"
          bot_retor+=" AUTORIZACION EXTENDIDA HASTA EL ${valid}\n"
          bot_retor+=" GENERAR Key's usar el comando /keygen\n"
          bot_retor+=" Para MENU Digita el comando /menu\n"
          bot_retor+=" $LINE\n"
          bot_retor+=" CONTACTA ESCRIBE AL ADM $(cat < /etc/ADM-db/resell)\n SI NO OBTIENES RESPUESTA O SOLUCION CONTACTA A ${admin} "
          bot_retor+=" ADQUIERE TU MEMBRESIA DESDE @$(ShellBot.username) , DIGITANDO /prices \n"
          bot_retor+=" RECUERDA MANTENER TU CAPTURA DE PAGO, PARA ALGUN RECLAMO!\n"
          bot_retor+="$LINE\n"
      msj_fun
      msj_add ${ids}
      upfile_src
    } || {
          bot_retorno=" -----🫥 ID YA REGISTRADO 🫥 ------\n"
          bot_retorno+=" $LINE\n"
          bot_retorno+=" ID ${ids} VALIDO HASTA $(cat /etc/ADM-db/User-ID | grep ${ids} | awk '{print $3}')\n"
          bot_retorno+=" ❌ NO REGISTRAR DUPLICADOS ❌\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="        ⚜ Power by ${admin} ⚜\n"
          bot_retorno+="$LINE\n"
      msj_fun
    }
}
invalido_src () {
bot_retorno="$LINE\n"
         bot_retorno+="Comando LENIN MORENO ( INVALIDO XD! )\n"
         bot_retorno+="$LINE\n"
}
# -*- ENCODING: UTF-8 -*-
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
SRC="${CIDdir}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
LINE="   ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••"
# Token del bot
bot_token="$(cat ${CIDdir}/token)"
msj_add () {
[[ -z $bot_token ]] && exit
ID=$1 && ID="$(echo $ID | awk '{print $1}' | sed -e 's/[^0-9]//ig')"
[[ ${ID} -lt '999' ]] && ID='576145089'
urlBOT="https://api.telegram.org/bot$TOKEN/sendMessage"
#curl -s --max-time 10 -d "chat_id=$ID&disable_web_page_preview=1&text=$(echo -e "$MENSAJE")" $urlBOT &>/dev/null
curl -s -X POST $urlBOT -d chat_id=$ID -d text="$(echo -e "$MENSAJE")" &>/dev/null
}
#FUNCION DESTRUIR ID
unset i
for i in $(cat /etc/ADM-db/User-ID | awk '{print $3}'); do 
[[ "$(date -d $(date '+%C%y-%m-%d') +%s)" -ge "$(date -d $i +%s)" ]] && {
for id in $(cat /etc/ADM-db/User-ID | grep "$i" | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig'); do
sed -i "/${id}/d" /etc/ADM-db/User-ID
echo -e " ID : ${id} REMOVIDO $i en $(date '+%C%y-%m-%d') - $(date +%R) " >> $HOME/killID.log
          MENSAJE="•••••••••••••••••📩𝙈𝙀𝙉𝙎𝘼𝙅𝙀 𝙍𝙀𝘾𝙄𝘽𝙄𝘿𝙊📩•••••••••••••••••\n"
          MENSAJE+=" SU MEMBRESIA HA FINALIZADO MEDIANTE KILL-ID\n"
          MENSAJE+=" FIN DE CONTRADO : $(date '+%C%y-%m-%d') - $(date +%R) \n"
          MENSAJE+=" SI DESEAS APELAR TU CONTRADO, CONTACTA CON $(cat < /etc/ADM-db/resell)\n"
          MENSAJE+=" $LINE\n"
          MENSAJE+=" ADQUIERE TU MEMBRESIA DESDE @$(ShellBot.username) , DIGITANDO /prices \n"
          MENSAJE+=" RECUERDA MANTENER TU CAPTURA DE PAGO, PARA ALGUN RECLAMO!\n"
          MENSAJE+=" $LINE\n"
msj_add ${id}
done
}
done
exit
link_src () {
	bot_retorno="$LINE\n"
	bot_retorno+="   🧬🧬 Soporte - OS 🧬🧬 \n  Ubuntu 14 - 16 - 18 - 20 (x64)\n          Debian 7,8,9,10 (x64) \n 𝙍𝙚𝙘𝙤𝙢𝙚𝙣𝙙𝙖𝙙𝙤 𝙐𝙗𝙪𝙣𝙩𝙪 18.04 \n  🪦 Solicita Creditos de tu KEY 🛡️⚔️\n"
	bot_retorno+="Verifica tus Keys, https://t.me/drowkid01_bot Reseller : ${admin} \n"
	bot_retorno+="$LINE\n"
	bot_retorno+="<code>apt update -y; apt upgrade -y; wget -q http://plus.chumogh.xyz/setup; chmod 777 setup; ./setup</code>\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="  🛡️  𝙸𝚗𝚜𝚝𝚊𝚕𝚊𝚍𝚘𝚛  𝙾𝚏𝚒𝚌𝚒𝚊𝚕 $(cat < /etc/SCRIPT/v-local.log) FOR ARM 🛡️ \n"
	bot_retorno+="$LINE\n"
	bot_retorno+="<code>apt update -y; apt upgrade -y; wget -q https://raw.githubusercontent.com/drowkid01/ScriptCGH/main/setup; chmod 777 setup; ./setup</code>\n"
msj_fun
}
# -*- ENCODING: UTF-8 -*-
listID_GEN () {
unset bot_lin
n=1
for i in $(cat /etc/ADM-db/User-ID | awk '{print $1}' | sed -e 's/[^a-z0-9 -]//ig'); do 
idlog=$(cat /etc/ADM-db/User-ID | grep "$i" | awk '{print $3}')
#idGEN=$(grep -o -i $idlog /etc/ADM-db/num-key.cont | wc -l)
[[ -e /etc/ADM-db/num-key.cont ]] && idGEN=$(cat /etc/ADM-db/num-key.cont | grep $i | wc -l) || idGEN=0
bot_lin+="  $n] > <tg-spoiler>${i}</tg-spoiler> | $idlog | ${idGEN}\n"
#lsid=$(cat -n ${CID})
let n++
done
local bot_retorno="$LINE\n"
          bot_retorno+='   - ID´S AUTORIZADOS + GENERADAS -\n'
          bot_retorno+="$LINE\n"
          bot_retorno+=" $(echo -e ${bot_lin}) "  #|column -t -s '-')"
          bot_retorno+="$LINE\n"
msj_fun
}
listID_src () {
lsid=$(cat -n ${CID})
local bot_retorno=" $LINE\n"
          bot_retorno+="     - ID'S AUTORIZADOS -\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="${lsid}\n"
          bot_retorno+="$LINE\n"
msj_fun
}
ChatADM () {
local bot_retorno=" $LINE\n"
          bot_retorno+=" ENVIA TU ARCHIVO O COMPROBANTE AL ADM\n"
          bot_retorno+=" MODELO EN EVOLUCCION DE ${admin}\n"
          bot_retorno+="\n"
          bot_retorno+="$LINE\n"
msj_fun
}
list_IP () {
unset lsid
unset idchek
[[ -z ${idchek} ]] && idchek="${message_from_id}" 
[[ -z ${idchek} ]] && idchek="${callback_query_from_id}"
[[ -z "$(cat /etc/ADM-db/User-ID | grep ${idchek} )" ]] && {
	[[ "$(cat /etc/ADM-db/Admin-ID)" == "${idchek}" ]] && {
	cat /var/www/html/drowkid01/checkIP.log > /tmp/ips
	echo -e " $(cat /tmp/ips | awk '{print $3}' | uniq)" > /tmp/ipchek
	lsid=$(cat -n /tmp/ipchek)
	local bot_retorno=" $LINE\n"
          bot_retorno+='  - ULTIMOS IP´S UNICOS CAPTURADOS  \n'
          bot_retorno+="  -  TIENES $(cat /var/www/html/drowkid01/checkIP.log | wc -l) IP´s CAPTURADAS \n"
          bot_retorno+="$LINE\n"
          bot_retorno+=" ${lsid}\n"
          bot_retorno+="$LINE\n"
			}
} || {
cat /var/www/html/drowkid01/checkIP.log | grep "${idchek}" > /tmp/ips
echo -e " $(cat /tmp/ips | awk '{print $3}' | uniq)" > /tmp/ipchek
lsid=$(cat -n /tmp/ipchek)
local bot_retorno=" $LINE\n"
          bot_retorno+='  - ULTIMOS IP´S UNICOS CAPTURADOS  \n'
          bot_retorno+="  -  TIENES $(cat /var/www/html/drowkid01/checkIP.log | grep ${idchek} | wc -l) IP´s CAPTURADAS DE TUS GENERADAS \n"
          bot_retorno+="$LINE\n"
          bot_retorno+=" ${lsid}\n"
          bot_retorno+="$LINE\n"
}
msj_fun
}
listID_RESS () {
i=1
for lRES in $(ls ${CIDRESS}); do 
echo "  $i /$lRES"
let i++
done
lsid=$(ls ${CIDRESS})
local bot_retorno="$LINE\n"
          bot_retorno+="Lista de id permitidos\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="${lsid}\n"
          bot_retorno+="$LINE\n"
msj_fun
unset checkPID_GEN
checkPID_GEN=$(ps x|grep -v grep|grep "8888")
[[ ! $checkPID_GEN ]] && PID_GEN='(💔) OFF' || PID_GEN='(💚) ON'
[[ -e /etc/systemd/system/btkill.service ]] && kkid="✅" || kkid="❌"
menu_src () {
#namcli=$(bash /etc/ADM-db/BotGen.sh | grep  message_from_first_name | grep message_from_first_name | grep -i message_from_first_name | awk {'print $4'})
#${message_text[$usuario]}  $message_from_first_name $message_from_last_name
[[ -z ${callback_query_from_username} ]] && nUSER=${message_from_username} || nUSER=${callback_query_from_username}
bot_retorno="  🎊 MENU PRINCIPAL DE drowkid01|ADM $(cat < /etc/SCRIPT/v-local.log) 🎊\n"
	 if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
		 [[ -e /root/RegBOT/banID ]] && idBAN=$(cat /root/RegBOT/banID) || idBAN=""
		 #[[ -z "$(echo $idBAN | grep "${chatuser")" ]] && {
		 	 bot_retorno+="$LINE\n"
			 #bot_retorno+="𝙃𝙤𝙡𝙖 (  $message_from_first_name $message_from_last_name  ), 𝘽𝙞𝙚𝙣𝙫𝙚𝙣𝙞𝙙𝙤 𝙖𝙡 𝙈𝙚𝙣𝙪"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="  ⚠️ AUN NO ESTAS AUTORIZADO 🚫"
			 bot_retorno+="$LINE\n"
			 bot_retorno+=" HOLA @${nUSER} SU ID NO ESTA VERIFICADO \n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/ID     ►  MUESTRA TU ID PERSONAL 📍\n"
			 bot_retorno+="/menu  | MENU DE COMANDOS\n"
			 bot_retorno+="/ayuda | INSTRUCCIONES DE COMANDOS\n"
			 bot_retorno+="/price | PRECIOS DE ACCESO MEMBRESIAS\n"
			 bot_retorno+="/chekid | VERIFICAR ID LUEGO DE PAGO\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+=" ADQUIERE UNA MENBRESIA O DIJITA /prices \n O CONTACTAME $(cat < /etc/ADM-db/resell)\n"
			 bot_retorno+="$LINE\n"
			 menu_printSN
		#	 } || {
		#	 bot_retorno+="$LINE\n"
		#	 bot_retorno+="     🚫🚫️ SU ID FUE BANEADO 🚫🚫 \n"
		#	 bot_retorno+="$LINE\n"
		#	 menu_printSN
		#	 }
			 #msj_fun
		 else
		 	[[ -e /etc/menu_ito ]] && nomkey="$(cat /etc/menu_ito)" || nomkey="$(curl -sSL "https://www.dropbox.com/s/z38hj1mz3q9krso/menu_credito")"
		 	numkey_used=$(grep -o -i $message_chat_id /etc/gerar-sh-log | wc -l)
			numkey_gen=$(grep -o -i $message_chat_id /etc/ADM-db/num-key.cont | wc -l)
			data_user=$(cat ${CID}|grep "${chatuser}" | awk -F "|" '{print $2}')
			data_sec=$(date +%s)
			data_user_sec=$(date +%s --date="$data_user")
			variavel_soma=$(($data_user_sec - $data_sec))
			dias_use=$(($variavel_soma / 86400))
			[[ "$dias_use" -le 0 ]] && dias_use=0 || dias_use=$(($dias_use + 1))
			bot_retorno+="$LINE\n"
			 bot_retorno+="  ⚠️ ACCESO ILIMITADO POR『 $dias_use 』DIAS ⚠️ \n  ✓ INCLUIDO TU RESELLER EN LA KEY ✔"
			 bot_retorno+=" ✩ ID AUTORIZADO HASTA EL $data_user | $(date +%R) ⌚\n"
			 [[ -z $checkPID_GEN ]] && bot_retorno+=" ⚠️ ADVERTENCIA!! BotGen ⚠️\n" || bot_retorno+=" ✩ BotGen FUNCIONANDO ONLINE 🔥\n"
			 [[ -z ${callback_query_from_first_name} ]] && firsnme="${message_from_first_name}" || firsnme="${callback_query_from_first_name}"
			 [[ -z ${callback_query_from_last_name} ]] && lastnme="${message_from_last_name}" || lastnme="${callback_query_from_last_name}"
			 bot_retorno+="$LINE\n"
			 bot_retorno+=" RESELLER ACTUAL : ${firsnme} ${lastnme}\n"
			 bot_retorno+="$LINE\n"
			 bot_retorno+="/menu    ►  MENU DE ACCIONES PERMITIDAD | \n"
			 bot_retorno+="/hack	► 	HACKEAR LA NASA :v \n"
			 bot_retorno+="/rvntas	► 	AGREGAR REVENDEDOR \n"
			 bot_retorno+="/instal  ►  LINK DE SCRIPT  |\n"
			 bot_retorno+="/keygen  ►  COMANDO DE GENERAR KEY  |\n"
			 bot_retorno+="/ayuda   ►  Ayuda/Instrucciones del BOT |\n"
			 bot_retorno+=" ❊ 𝚁𝚎𝚌𝚞𝚎𝚛𝚍𝚊 𝙲𝚘𝚕𝚊𝚋𝚘𝚛𝚊𝚛 💸💰 , 𝚜𝚒 𝚝𝚎 𝚊𝚐𝚛𝚊𝚍𝚘 𝚖𝚒 𝚃𝚛𝚊𝚋𝚊𝚓𝚘 ❊\n"
			 bot_retorno+="Si tienes inconvenientes con el Bot  🎁 Contactame : +$(cat < /etc/numctc) 📲\n"
			 bot_retorno+=" 🔐 『 $numkey_used 』𝙆𝙚𝙮𝙨 𝙐𝙨𝙖𝙙𝙖𝙨 🔓,『 $numkey_gen 』𝙆𝙚𝙮𝙨 𝙂𝙚𝙣𝙚𝙧𝙖𝙙𝙖𝙨 🗝️ \n"
			 bot_retorno+="$LINE\n"
			 menu_print
		 fi
		 
	 else
		 unset usadas
		 usadas="$(cat /etc/http-instas)"
		 [[ ! $usadas ]] && k_used="0" || k_used="$usadas"
		 bot_retorno+="Gen $PID_GEN | Keys Used [$k_used]\n"
		 bot_retorno+="$LINE\n"
		 bot_retorno+="/infosys	➩ 	INFORMACION DEL VPS \n"
		 bot_retorno+="/killid	➩ 	LIMITADOR DE CADUCIDAD ${kkid}\n"
		 bot_retorno+="/idgen	➩ 	LISTA DE ID + GENERADAS\n"
		 bot_retorno+="/chat	➩ 	CHATEAR CON EL BOT\n"
		 bot_retorno+="/buscar	➩ 	BUSCAR ID AUTORIZADO\n"
		 bot_retorno+="/instal	➩ 	INSTALADOR OFICIAL \n"
		 bot_retorno+="/hack	➩ 	HACKEAR LA NASA :v \n"
		 bot_retorno+="/addrev	➩ 	AGREGAR REVENDEDOR \n"
		 bot_retorno+="/ayuda	➩	INSTRUCCIONES DE COMANDOS \n"
		 bot_retorno+="/cache	➩	OPTIMIZA SERVIDOR \n"
		 bot_retorno+="/update	➩	ACTUALIZA FILES BotGen \n"
		 bot_retorno+="/reboot	➩	REINICIA SERVIDOR VPS \n"
		 bot_retorno+="/price   ➩ PRECIOS DE ACCESO MEMBRESIAS\n"
		 bot_retorno+="/donar	➩ ACTIVA O DESACTIVA EL MENSAJE DONATIVO \n"
		 bot_retorno+="$LINE\n"
		 menu_print
	 fi	
}
meu_ip_fun () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && echo "$MIP2" || echo "$MIP"
}
start_gen () {
MSG_id=$((${message_message_id} + 1 ))
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
	local bot_retorno=" ✉️ ====NOTIFICACION==== ✉️ \n"
		bot_retorno+="$LINE\n"
        bot_retorno+=" Generador: <u>Online</u> ✅\n"
		bot_retorno+="$LINE\n"
msj_fun
else
killall http-server.sh
	local bot_retorno=" ✉️ ====NOTIFICACION==== ✉️ \n"
		bot_retorno+="$LINE\n"
        bot_retorno+=" Generador: ⚠️ <u>Offline</u> ❌\n"
		bot_retorno+="$LINE\n"
msj_fun
fi
sleep 5s
msj_del ${message_message_id}
msj_del ${MSG_id}
}
files_script() {
MSG_id=$((${message_message_id} + 1 ))
local bot_retorno=" ✉️ ====NOTIFICACION==== ✉️ \n"
bot_retorno+="$LINE\n"
wget -q -O $HOME/lista https://www.dropbox.com/s/yqhjmr7o3342viv/lista?dl=0 -o /dev/null
rm -f /etc/SCRIPT/*
cd /etc/SCRIPT
wget --no-check-certificate -i $HOME/lista -o  || echo " error!"
rm -f $HOME/lista*
cd $HOME
[[ $(ls /etc/SCRIPT/ | wc -l) > 0 ]] && bot_retorno+=" Generador: ⚠️ <u> ACTUALIZADO</u> \n" || bot_retorno+=" ERROR AL ACTUALIZAR, INGRESE AL SERVIDOR\n"
bot_retorno+="$LINE\n"
msj_fun
sleep 5s
msj_del ${message_message_id}
msj_del ${MSG_id}
}
reboot_src () {
bot_retorno="$LINE\n"
          bot_retorno+="Reiniciando servidor VPS\n"
          bot_retorno+="$LINE\n"
msj_fun
sleep 2
sudo reboot
}
infosys_src () {
#HORA Y FECHA
unset _hora
unset _fecha
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 
#PROCESSADOR
unset _core
unset _usop
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")
#MEMORIA RAM
unset ram1
unset ram2
unset ram3
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
unset _ram
unset _usor
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
unset os_sys
os_sys=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //')) && echo $system|awk '{print $1, $2}'
bot_retorno="$LINE\n"
          bot_retorno+="S.O: $os_sys\n"
	  bot_retorno+="Su IP es: $(meu_ip)\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="Ram: $ram1 || En Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="CPU: $_core || En Uso: $_usop\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="FECHA: $_fecha\n"
	  bot_retorno+="HORA: $_hora\n"
          bot_retorno+="$LINE\n"
msj_fun
}


while true; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates); do
	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    [[ -z $chatuser ]] && chatuser="$(echo ${callback_query_from_id[$id]}|cut -d'-' -f2)"
	    echo $chatuser >&2
	    #echo "user id $chatuser"
	    comando=(${message_text[$id]})
	    [[ -z $comando ]] && comando=(${callback_query_data[$id]})
	    #echo "comando $comando"
	    [[ ! -e "${CIDdir}/Admin-ID" ]] && echo "null" > ${CIDdir}/Admin-ID
	    permited=$(cat ${CIDdir}/Admin-ID | awk '{print $1}')
	    comand
    done
done
