#!/bin/sh
# Maintained by: toleda for: github.com/toleda/
# File: audio_alc_x99-hda-100_patch_v1.0
#
# X99 Realtek ALC onboard audio applehda edit
#
# NOTE: Run this patch file only once on a AppleHDA.kext
#
# Requirements
# 1. 10.10 or newer/10.9.4 or newer
# 2. Realtek ALC/X99 IHDA Audio (Intel High Definition Audio)
# 3. Device_ID: 8680 208D; patch over 8680 208C (8series IHDA)
# 4. S/L/E/AppleHDA_v266.5 or newer (or AppleHDA_v2.6.3 or newer)
#
# Installation
# 1. Downloads/audio_alc_x99-hda-100_patch.command
# 2. Double click audio_alc_x99-hda-100_patch.command
# 3. Enter password at prompt
#
# Agreement
# The audio_alc_x99-hda-100_patch is for personal use only.  Do not
# distribute the patch or the resulting patched AppleHDA.kext for any 
# reason without permission. The audio_alc_x99-hda-100_patch is
# provided as is and without any kind of warranty.
#
echo "Patch binary ..."
sudo perl -pi -e 's|\x20\x8c|\x20\x8d|g' /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController

echo "Fix permissions ..."
sudo chown -R root:wheel /System/Library/Extensions/AppleHDA.kext

echo "Kernel cache..."
sudo touch /System/Library/Extensions

echo "Finished, restart required."