#!/bin/bash
# ------------------------------------------------------------------
# Script Name:  ram_status.sh
# Description:  Monitors available RAM and sends email alerts via SSMTP
# Author:       Muhammad Ali
# ------------------------------------------------------------------

# Threshold limit in Megabytes (Alert if available RAM is less than 500MB)
THRESHOLD=500
ALERT_EMAIL="your-email@gmail.com"

# Extracting the 'Available' RAM (Column 7) from the free -m command
AVAILABLE_RAM=$(free -m | awk 'NR==2{print $7}')

# Check if available RAM is lower than the defined threshold
if [ "$AVAILABLE_RAM" -lt "$THRESHOLD" ]; then
    # Sending the email alert securely via SSMTP
    echo -e "Subject: 🔥 CRITICAL ALERT: Low Memory on Server\n\nWarning: Server Available RAM has dropped to $AVAILABLE_RAM MB!\nThreshold limit set to: $THRESHOLD MB.\n\nPlease check system processes immediately." | ssmtp $ALERT_EMAIL
fi
