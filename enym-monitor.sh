#!/bin/bash

# Function to check username
check_username() {
    local username=$1
    local api_url="https://monitor.explorenym.net/check-username"
    
    response=$(curl -s -X POST "$api_url" -H "Content-Type: application/json" -d "{\"userName\": \"$username\"}")
    
    if echo "$response" | grep -q '"userNameExists": *true'; then
        echo "Username found."
        return 0  # Username exists
    elif echo "$response" | grep -q '"userNameExists": *false'; then
        echo "Username not found."
        return 1  # Username does not exist
    else
        echo "Unexpected response during username check: $response"
        return 2  # Unexpected response
    fi
}





clear ; echo
echo	" _____            _                _   ___   ____  __ "
echo -e	"| ____|_  ___ __ | | ___  _ __ ___| \ | \ \ / /  \/  |"
echo -e	"|  _| \ \/ / '_ \| |/ _ \| '__/ _ \  \| |\ V /| |\/| |"
echo -e	"| |___ >  <| |_) | | (_) | | |  __/ |\  | | | | |  | |"
echo -e "|_____/_/\_\ .__/|_|\___/|_|  \___|_| \_| |_| |_|  |_|"
echo -e	"           |_|       \033[4mhttps://explorenym.net\033[0m\n"
echo
echo
echo "Do you have an existing Explorenym username? (yes/no)"
read user_response

if [[ "$user_response" == "yes" ]]; then
    while true; do
        echo "Please enter your existing username:"
        read USER_NAME
        USER_NAME=$(echo "$USER_NAME" | xargs)  # Trim whitespace


        if check_username "$USER_NAME"; then
            PASSWORD="null"
            break
        else
            echo "Please try again."
        fi
    done

else
    while true; do
        echo "Please create a new username:"
        read USER_NAME


        if ! check_username "$USER_NAME"; then
            echo "Username is available."
            echo "Please create a password:"
            read -s PASSWORD
            break
        else
            echo "Username already exists. Please try a different username."
        fi
    done
fi

SETUP_URL="https://monitor.explorenym.net/setup-monitor"

# Send the username and password/null to the API and capture the response
# Make the POST request and separate the response body and status code
HTTP_RESPONSE=$(curl -s -w "%{http_code}" -X POST "$SETUP_URL" \
    -H "Content-Type: application/json" \
    -d "{\"userName\": \"$USER_NAME\", \"password\": \"$PASSWORD\"}")
HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/[0-9]\{3\}$//')
HTTP_STATUS=$(echo $HTTP_RESPONSE | grep -o '[0-9]\{3\}$')

# Check for HTTP status code 200
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "Request successful. Response body:"
    echo "$HTTP_BODY"
else
    echo "There has been an error.$HTTP_BODY"
fi

