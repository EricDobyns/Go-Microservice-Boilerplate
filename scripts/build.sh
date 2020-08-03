#!/bin/sh

ROOT_DIR="Microservice-boilerplate" # NOTE: Make sure to rename this variable to match the root directory of this project
CURRENT_PATH=$(pwd)

# Validate current location
if [ ${PWD##*/} != $ROOT_DIR ]; then
	echo 'Warning: Please make sure you are in the root directory of this project. ROOT_DIR should equal ${PWD##*/}'
	exit 1
fi

# Build all services
echo "Compiling binaries..."
for dir in $CURRENT_PATH/cmd/*/; do
	cd $dir
	service_name=${PWD##*/}
	go build -o ../../bin/$service_name
	cd ../../
done

# Exit
exit 0
