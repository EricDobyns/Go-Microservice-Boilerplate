#!/bin/sh

ROOT_DIR="Microservice-boilerplate" # NOTE: Make sure to rename this variable to match the root directory of this project
CURRENT_PATH=$(pwd)

# Validate current location
if [ ${PWD##*/} != $ROOT_DIR ]; then
	echo 'Warning: Please make sure you are in the root directory of this project. ROOT_DIR should equal ${PWD##*/}'
	exit 1
fi

# Clean services
echo "Cleaning services..."
for dir in $CURRENT_PATH/cmd/*/; do
	cd $dir
	go clean
	cd ../../
done

# Remove temporary files
echo "Removing temporary files..."
rm -rf ./bin
rm -rf ./tmp
rm -rf ./tests/*

# Exit
exit 0
