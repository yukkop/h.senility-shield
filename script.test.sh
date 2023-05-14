#!/bin/bash

# Source the secrets file
source secrets.sh

# File to parse
FILE="birthdays.csv"

# Get today's date in the format used in the file
TODAY=$(date '+%m-%d')

# Check if any birthdays are today
while IFS=',' read -r name bday pronoun; do
  echo "$bday"
  echo [[ "$bday" == *"$TODAY"* ]]
  echo $([[ "$bday" == *"$TODAY"* ]])
    if [[ "$bday" == *"$TODAY"* ]]; then
        # If there is a birthday, send a message via Telegram
        TEXT="Today is $name's birthday. Please send them your best wishes!"
        if [[ "$pronoun" == "he" ]]; then
            TEXT="Today is $name's birthday. Please congratulate him!"
        elif [[ "$pronoun" == "she" ]]; then
            TEXT="Today is $name's birthday. Please congratulate her!"
        fi
        URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"
        curl -s -X POST $URL -d chat_id=${TELEGRAM_CHAT_ID} -d text="$TEXT"
    fi
done < $FILE
