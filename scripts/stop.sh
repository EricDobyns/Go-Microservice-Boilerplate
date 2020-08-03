#!/bin/sh

ROOT_DIR="Microservice-boilerplate" # NOTE: Make sure to rename this variable to match the root directory of this project
CURRENT_PATH=$(pwd)

# Validate current location
if [ ${PWD##*/} != $ROOT_DIR ]; then
	echo 'Warning: Please make sure you are in the root directory of this project. ROOT_DIR should equal ${PWD##*/}'
	exit 1
fi

# Stop each background process
for file in $CURRENT_PATH/bin/*; do
	service_name=${file##*/}
	pkill -f $service_name 2>/dev/null || true
done

# Exit
exit 0
