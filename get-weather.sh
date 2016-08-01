#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Get weather from yandex

# Telegram Data
CHATID="<ID>"
KEY="<KEY>"

# Get yandex weather xml
curl -s https://export.yandex.ru/bar/reginfo.xml?region=Almaty > ya.xml && sed -i -n '/<day_part typeid=/,/<\/day_part>/p' ya.xml

# Get weather types
TYPE=$(cat ya.xml | grep weather_type | sed -e 's/<[^>]*>//g')
TEMP=$(cat ya.xml | grep temperature | sed -e 's/<[^>]*>//g' | head -1)
CITY=$(cat ya.xml | grep time_zone | sed -e 's/<[^>]*>//g')

# Remove spaces
RESULT=$(echo "$CITY $TYPE $TEMP°" | tr -s " ")

# Data to screen
# echo $RESULT

curl -s --max-time 10 -d "chat_id=$CHATID&disable_web_page_preview=1&text=$RESULT" https://api.telegram.org/bot$KEY/sendMessage >/dev/null