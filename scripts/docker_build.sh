#!/bin/sh

ROOT_DIR="Microservice-boilerplate" # NOTE: Make sure to rename this variable to match the root directory of this project
SERVICES_PATH=$(pwd)/cmd
TMP_BUILD_DIR=$(pwd)/tmp

OS_TYPE=linux
ARCH_TYPE=amd64

if [ ${PWD##*/} != $ROOT_DIR ]; then
	echo 'Warning: Please make sure you are in the root directory of this project. ROOT_DIR should equal ${PWD##*/}'
	exit 1
fi

# Clean build directory
rm -rf $TMP_BUILD_DIR
mkdir -p $TMP_BUILD_DIR

# Build docker image for each service
for dir in $SERVICES_PATH/*; do
	PACKAGE_NAME="${dir%"${dir##*[!/]}"}"
	PACKAGE_NAME="${PACKAGE_NAME##*/}" 
	echo "Building $PACKAGE_NAME image..."

	echo "
# STEP 1: Build executable binaries
FROM golang:alpine AS builder

# Add git to download dependencies
RUN apk update && apk add --no-cache git

# Create user
ENV USER=appuser
ENV UID=10001 

# See https://stackoverflow.com/a/55757473/12429735 
RUN adduser \    
	--disabled-password \    
	--gecos \"\" \
	--home \"/nonexistent\" \    
	--shell \"/sbin/nologin\" \    
	--no-create-home \    
	--uid \"\${UID}\" \    
	\"\${USER}\"

# Copy project to builder
WORKDIR \$GOPATH/src/
COPY . .

# Build binary
WORKDIR \$GOPATH/src/cmd/$PACKAGE_NAME/
RUN CGO_ENABLED=0 GOOS=$OS_TYPE GOARCH=$ARCH_TYPE go build -o /go/bin/service


# STEP 2: Build final images
FROM scratch

# Import the user and group files from the builder
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Copy our static executable
COPY --from=builder /go/bin/service /go/bin/service

# Run the binary
ENTRYPOINT [\"/go/bin/service\"]	
	" >> $TMP_BUILD_DIR/Dockerfile

	docker build -f $TMP_BUILD_DIR/Dockerfile -t $PACKAGE_NAME .
	rm -rf $TMP_BUILD_DIR/Dockerfile
	docker rmi $(docker images -q -f dangling=true)
done

# Cleanup
rm -rf $TMP_BUILD_DIR

# Exit
echo "Successfully generated docker images."
exit 0