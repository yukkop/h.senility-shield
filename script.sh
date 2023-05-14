#!/bin/bash

# Source the secrets file
source secrets.sh

# File to parse
FILE="birthdays.csv"

# Get today's date in the format used in the file
TODAY=$(date '+%Y-%m-%d')

# Check if any birthdays are today
while IFS=',' read -r name bday; do
    if [[ "$bday" == *"$TODAY"* ]]; then
        # If there is a birthday, send a message via Telegram
        TEXT="Today is $name's birthday, congratulate him, old man!"
        URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"
        curl -s -X POST $URL -d chat_id=${TELEGRAM_CHAT_ID} -d text="$TEXT"
    fi
done < $FILE
