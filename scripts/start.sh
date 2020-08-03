#!/bin/sh

ROOT_DIR="Microservice-boilerplate" # NOTE: Make sure to rename this variable to match the root directory of this project
CURRENT_PATH=$(pwd)

# Validate current location
if [ ${PWD##*/} != $ROOT_DIR ]; then
	echo 'Warning: Please make sure you are in the root directory of this project. ROOT_DIR should equal ${PWD##*/}'
	exit 1
fi

# Start each service in the background
for file in $CURRENT_PATH/bin/*; do
	$file &
done

# Exit
clear
exit 0