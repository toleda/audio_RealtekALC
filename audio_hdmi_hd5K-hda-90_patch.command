#!/bin/sh
# Maintained by: toleda for: github.com/toleda/
# File: audio_hdmi_hd5k-90_patch.command_v1.0
# Credit: PikeRAlpha
#
# Desktop/Laptop HD5K HDMI audio applehda edit
# Enables HD5K HDMI audio, additional dsdt edits required
#
# NOTE: This patch is for 8 Series/HD4600 HDMI audio only.
#
# Requirements
# 1. 10.9 or newer
# 2. Haswell/HD4600/HD5000 Graphics
# 3. Device_ID: 8086 0c0c, patch not required with 0c0a or 0c0d.
# 4. S/L/E/AppleHDA_v2.5.2 or newer
#
# Installation
# 1. Downloads/audio_hdmi_hd5k-90_patch.command
# 2. Double click audio_hdmi_hd5k-90_patch.command
# 3. Enter password at prompt

echo " "
echo "Agreement"
echo "The audio_hdmi_hd5k-90_patch is for personal use only. Do not distribute"
echo "the patch, any or all of the enclosed files or the resulting patched"
echo "AppleHDA.kext for any reason without permission."
echo "The audio_hdmi_hd5k-90_patch is provided as is and without any kind of"
echo “warranty.”
echo " "

if [[ `perl -le "print scalar grep /\x3d\x0c\x0c\x00/, <>;" "/System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController"` > 0 ]]; then

echo "Patch binary ..."
sudo perl -pi -e 's|\x3d\x0c\x0c\x00\x00\x75\x61\xeb\x30|\x3d\x0c\x0c\x00\x00\x75\x61\xeb\x0e|g' /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController
sudo perl -pi -e 's|\x3d\x0c\x0d\x00\x00\x75\x52|\x3d\x0c\x0c\x00\x00\x75\x52|g' /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController

echo "Fix permissions ..."
sudo chown -R root:wheel /System/Library/Extensions/AppleHDA.kext

echo "Kernel cache..."
sudo touch /System/Library/Extensions

echo "AppleHDA.kext patch successful, restart required."

else

echo "AppleHDA.kext already patched."

fi

#