#!/bin/bash

###############################################################################
# Name: run.sh
# Author:   Daniel Middleton <daniel-middleton.com>
# Description: Used as ENTRYPOINT from Tinyproxy's Dockerfile
# Usage: See displayUsage
###############################################################################

# Global vars
PROG_NAME='DockerTinyproxy'
TAIL_LOG='/var/log/tinyproxy/tinyproxy.log'
PROXY_CONF='/etc/tinyproxy.conf'

# Usage: screenOut STATUS message
screenOut() {
    timestamp=$(date +"%H:%M:%S")
    
    if [ "$#" -ne 2 ]; then
        status='INFO'
        message="$1"
    else
        status="$1"
        message="$2"
    fi

    echo -e "[$PROG_NAME][$status][$timestamp]: $message"
}

# Usage: checkStatus $? "Error message" "Success message"
checkStatus() {
    case $1 in
        0)
            screenOut "SUCCESS" "$3"
            ;;
        1)
            screenOut "ERROR" "$2 - Exiting..."
            exit 1
            ;;
        *)
            screenOut "ERROR" "Error in checkStatus function. Exiting..."
            exit 1
            ;;
    esac
}

# Functions
displayUsage() {
    echo
    echo '  Usage:'
    echo "      docker run -d --name='tinyproxy' -p <Host_Port>:8888 dannydirect/tinyproxy:latest '<Allowed_IP>'"
    echo
    echo "      - Set <Host_Port> to the port you wish the proxy to be accessible from."
    echo "      - Set <Allowed_IP> to 'ANY' to allow unrestricted proxy access, or a specific IP/CIDR for tighter security."
    echo
}

stopService() {
    screenOut "Checking for running Tinyproxy service..."
    
    if [ "$(pidof tinyproxy)" ]; then
        screenOut "Found. Stopping Tinyproxy service for pre-configuration..."
        service tinyproxy stop
        checkStatus $? "Could not stop Tinyproxy service." \
                       "Tinyproxy service stopped successfully."
    else
        screenOut "Tinyproxy service not running."
    fi
}

setAccess() {
    if [ "$1" = 'ANY' ]; then
        sed -i -e"s/^Allow /#Allow /" $PROXY_CONF
        checkStatus $? "Setting Allowed IPs - Could not edit $PROXY_CONF" \
                       "Setting Allowed IPs - Edited $PROXY_CONF successfully."
    else
        sed -i "s/^Allow.*/Allow $1/" $PROXY_CONF
        checkStatus $? "Setting Allowed IPs - Could not edit $PROXY_CONF" \
                       "Setting Allowed IPs - Edited $PROXY_CONF successfully."
    fi
}

#setPort() {
#    sed -i "s/^Port.*/Port $1/" $PROXY_CONF
#    checkStatus $? "Setting Port - Could not edit $PROXY_CONF" \
#                   "Setting Port - Edited $PROXY_CONF successfully."
#}

startService() {
    screenOut "Starting Tinyproxy service..."
    service tinyproxy start
    checkStatus $? "Could not start Tinyproxy service." \
                   "Tinyproxy service started successfully."
}

tailLog() {
    screenOut "Tailing Tinyproxy log..."
    tail -f $TAIL_LOG
    checkStatus $? "Could not tail $TAIL_LOG" \
                   "Stopped tailing $TAIL_LOG. Exiting..."
}

# Start execution
if [ "$#" -lt 1 ]; then
    displayUsage
    exit 1
fi

echo && screenOut "$PROG_NAME script started..."

stopService
setAccess $1
#setPort $2
startService
tailLog

screenOut "$PROG_NAME script ended." && echo
