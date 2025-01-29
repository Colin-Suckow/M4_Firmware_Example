#!/usr/bin/env bash

usage() {
    echo "Usage: $0 <hostname>"
    echo "Upload and start M4 firmware on the target STM32MP1 device"
    echo ""
    echo "Arguments:"
    echo "  hostname    Target device hostname or IP address"
    exit 1
}

# Check if hostname argument is provided
if [ $# -ne 1 ]; then
    usage
fi

HOST=$1

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    mkdir build
fi

# Configure and build project 
cd build || { echo "Error: Failed to enter build directory"; exit 1; }
cmake .. || { echo "Error: CMAKE configuration failed"; exit 1; }
make || { echo "Error: Build failed"; exit 1; }

# Check if binary exists
if [ ! -f "src/m4_firmware.elf" ]; then
    echo "Error: Binary not found at build/src/m4_firmware.elf"
    exit 1
fi

# Stop remoteproc0
ssh root@"$HOST" "echo stop > /sys/class/remoteproc/remoteproc0/state" || { echo "Error: Failed to stop remoteproc0"; exit 1; }

# Upload firmware
scp src/m4_firmware.elf root@"$HOST":/lib/firmware/m4_firmware.elf || { echo "Error: Failed to upload firmware"; exit 1; }

# Set firmware name and start processor
ssh root@"$HOST" "echo m4_firmware.elf > /sys/class/remoteproc/remoteproc0/firmware" || { echo "Error: Failed to set firmware name"; exit 1; }
ssh root@"$HOST" "echo start > /sys/class/remoteproc/remoteproc0/state" || { echo "Error: Failed to start remoteproc0"; exit 1; }

echo "Successfully compiled and uploaded firmware"
