#!/bin/bash

IDF_TARGET=$1
FLASH_MODE="$2"
FLASH_FREQ="$3"
BOOTCONF=$FLASH_MODE"_$FLASH_FREQ"

source ./tools/config.sh

echo "Copying bootloader: $AR_SDK/bin/bootloader_$BOOTCONF.bin"

mkdir -p "$AR_SDK/bin"

# Workaround for getting the bootloaders to be flashable with esptool v4.x
# It might still be needed for IDF5, but using the included esptool instead
#cp "build/bootloader/bootloader.bin" "$AR_SDK/bin/bootloader_$BOOTCONF.bin"

# We use esptool v.4.21 in Tasmota IDF fork so no need to clone here

#if [ ! -e "tools/esptool" ]; then
#	git clone https://github.com/espressif/esptool tools/esptool
#fi
./esp-idf/components/esptool_py/esptool/esptool.py --chip "$IDF_TARGET" elf2image --dont-append-digest "build/bootloader/bootloader.elf" -o "$AR_SDK/bin/bootloader_$BOOTCONF.bin"
cp "build/bootloader/bootloader.elf" "$AR_SDK/bin/bootloader_$BOOTCONF.elf"
