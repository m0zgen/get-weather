#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Get weather from yandex

# Telegram settings
# CHATID="<ID>"
# KEY="<TOKEN>"

# Get yandex weather xml
curl -s https://export.yandex.ru/bar/reginfo.xml?region=Almaty > ya.xml && sed -i -n '/<day_part typeid=/,/<\/day_part>/p' ya.xml

getdata() {
	res=$(cat ya.xml | grep $1 | sed -e 's/<[^>]*>//g' | head -1 | tr -s " ")
	echo $res
}

TYPE=$(getdata weather_type)
TEMP=$(getdata temperature)
CITY=$(getdata time_zone)

echo "$CITY $TYPE $TEMP°"

# curl -s --max-time 10 -d "chat_id=$CHATID&disable_web_page_preview=1&text=$RESULT" https://api.telegram.org/bot$KEY/sendMessage >/dev/null