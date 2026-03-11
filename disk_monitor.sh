#!/bin/bash

# ---------- CONFIGURATION -----------------------------------
THRESHOLD=80
LOG_FILE="disk_monitor_$(date '+%Y-%m-%d_%H-%M-%S').log"
# ------------------------------------------------------------


# FUNCTION: log_message
#   Prints a message to the screen and saves it to the log file
log_message() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a "$LOG_FILE"
}

# FUNCTION: check_root
#   Makes sure the script is run as root
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: Please run this script as root." | tee -a "$LOG_FILE"
        exit 1
    fi
}

# FUNCTION: check_disk_usage
#   Gets current disk usage and triggers cleanup if needed
check_disk_usage() {
    local USAGE=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

    log_message "Current disk usage: $USAGE%"

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        log_message "Warning: Disk usage exceeded the threshold of $THRESHOLD%."
        cleanup_disk
    else
        log_message "Disk usage is within the safe limit."
    fi
}

# FUNCTION: cleanup_disk
#   Deletes temporary files in /tmp to free up space
cleanup_disk() {
    log_message "Starting cleanup of /tmp..."
    rm -rf /tmp/*
    log_message "Cleanup complete: temporary files removed from /tmp."
}

# MAIN
check_root
check_disk_usage
