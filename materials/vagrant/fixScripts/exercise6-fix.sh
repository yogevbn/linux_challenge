#!/bin/bash
#add fix to exercise6-fix here

#!/bin/bash

# Define server IP addresses
SERVER1_IP="192.168.60.10"
SERVER2_IP="192.168.60.11"

# Check for at least 2 arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <file1> [<file2> ...] <destination_path_on_other_server>"
    exit 1
fi

# Get destination path (last argument)
DESTINATION="${@: -1}"

# Get list of files (all arguments except the last)
FILES="${@:1:$#-1}"

# Determine the current server IP and the other server's IP
LOCAL_IPS=$(hostname -I)

if [[ $LOCAL_IPS == *"$SERVER1_IP"* ]]; then
    CURRENT_SERVER_IP="$SERVER1_IP"
    OTHER_SERVER_IP="$SERVER2_IP"
elif [[ $LOCAL_IPS == *"$SERVER2_IP"* ]]; then
    CURRENT_SERVER_IP="$SERVER2_IP"
    OTHER_SERVER_IP="$SERVER1_IP"
else
    echo "Error: Cannot determine current server IP."
    exit 1
fi

# Get the current username
USERNAME=$(whoami)

# Ensure the destination directory exists on the other server
ssh "$USERNAME@$OTHER_SERVER_IP" "mkdir -p '$DESTINATION'"

# Initialize total bytes counter
TOTAL_BYTES=0

# Loop over files to copy
for FILE in $FILES; do
    if [ -f "$FILE" ]; then
        # Get the file size in bytes
        FILE_SIZE=$(stat -c%s "$FILE")
        TOTAL_BYTES=$((TOTAL_BYTES + FILE_SIZE))

        # Copy the file to the other server
        scp "$FILE" "$USERNAME@$OTHER_SERVER_IP:'$DESTINATION'"
    else
        echo "Warning: File '$FILE' does not exist and will be skipped."
    fi
done

# Print the total number of bytes copied (only the number)
echo "$TOTAL_BYTES"

