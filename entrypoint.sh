#!/bin/sh -l

set -eu

echo "Running on $HOSTNAME"

TEMP_SSH_PRIVATE_KEY_FILE='private_key.pem'

printf "%s" "$INPUT_SSH_PRIVATE_KEY" > $TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

rsync $INPUT_SWITCHES $INPUT_LOCAL_PATH -e "ssh -o StrictHostKeyChecking=no -o LogLevel=quiet -p $INPUT_PORT -i $TEMP_SSH_PRIVATE_KEY_FILE" $INPUT_USER@$INPUT_SERVER:$INPUT_REMOTE_PATH

exit 0
