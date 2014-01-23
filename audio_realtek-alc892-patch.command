#!/bin/sh
# Maintained by: toleda for: github.com/toleda/audio_RealtekALC
# File: audio_realtek-alc892-patch.command
# Credit: d-an-w
#
# OS X Realtek ALC892 Onboard Audio
#
# Enables OS X Realtek ALC892 onboard audio in Mountain Lion 10.9 and newer
# 1. Backs up native AppleHDA.kext to Desktop/AppleHDA-orig,kext
# 2. Patches native AppleHDA.kext installed in System/Library/Extensions
#
# Installation
# 1. Downloads/audio_RealtekALC-master/audio_realtek-alc892-patch.command
# 2. Double click audio_realtek-alc892-patch.command
# 3. Enter password at prompt

echo " "
echo "Agreement"
echo "The audio_realtek-alc892-patch is for personal use only. Do not distribute"
echo "the patch, any or all of the enclosed files or the resulting patched"
echo "AppleHDA.kext for any reason without permission."
echo "The audio_realtek-alc892-patch is provided as is and without any kind of"
echo “warranty.”
echo " "

if [[ `perl -le "print scalar grep /\x8b\x19\xd4\x11/, <>;" "/System/Library/Extensions/AppleHDA.kext/Contents/MacOS/AppleHDA"` > 0 ]]; then

echo "Prepare Desktop/AppleHDA-orig.kext backup ..."
cd ~
cp -R /System/Library/Extensions/AppleHDA.kext Desktop/AppleHDA-orig.kext

echo "Patch binary ..."
sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x92\x08\xec\x10|g' /System/Library/Extensions/AppleHDA.kext/Contents/MacOS/AppleHDA

echo "Fix permissions ..."
sudo chown -R root:wheel /System/Library/Extensions/AppleHDA.kext

echo "Rebuild kernel cache..."
sudo touch /System/Library/Extensions

echo "AppleHDA.kext patch successful, restart required."

else

echo "AppleHDA.kext already patched."

fi

#