#!/bin/sh
# Maintained by: toleda for: github.com/toleda/
gFile="audio_alc_x99-hda-100_patch_v2.0"
#
# X99 Realtek ALC onboard audio applehda edit
#
# NOTE: Run this patch file only once on a AppleHDA.kext
#
# Requirements
# 1. 10.9.4 or newer
# 2. Realtek ALC/X99 IHDA Audio (Intel High Definition Audio)
# 3. 10.9.4 - 10.19.5: Device_ID: 8680 208D; patch over 8680 208C (8series IHDA)
# 4. 10.10 and newer: Device_ID: 8680 208D; patch over 8680 A08C (9series IHDA)
# 5. S/L/E/AppleHDA_v266.5 or newer (or AppleHDA_v2.6.3 or newer)
# 6. 10.11 and newer, disable SIP and restart before running script
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
gSysVer=`sw_vers -productVersion`
gSysName="El Capitan"
gDebug=0

# verify system version
case ${gSysVer} in

10.11* ) gSysName="El Capitan"
gSID=$(csrutil status)
;;

10.10* ) gSysName="Yosemite"
;;

10.9.4|10.9.5 ) gSysName="Mavericks"
;;

* )
echo "OS X Version: $gSysVer is not supported"
echo "No system files were changed"
echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

esac

# debug
if [ $gDebug = 2 ]; then
# gSysVer=10.9
echo "System version: supported"
echo "gSysVer = $gSysVer"
fi

echo "File: $gFile"

# verify sip disabled
case $gSysName in

"El Capitan" )
echo $gSID > /tmp/gsid.txt
if [[ $(cat /tmp/gsid.txt | grep -c "disabled") = 0 ]]; then
rm -R /tmp/gsid.txt
# echo "$gSID"
# echo ""
echo "NOK to patch"
echo "Set CsrActiveConfig=0x3 and restart"
echo "No system files were changed"
echo "To save a Copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
else
rm -R /tmp/gsid.txt
# echo "$gSID"
# echo ""
echo "OK to patch"
fi
;;

esac

echo "Patch binary ..."
case $gSysName in

"El Capitan"|"Yosemite" )
sudo perl -pi -e 's|\xa0\x8c|\x20\x8d|g' /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController
;;

"Mavericks"|"Mountain Lion" )
sudo perl -pi -e 's|\x20\x8c|\x20\x8d|g' /System/Library/Extensions/AppleHDA.kext/Contents/Plugins/AppleHDAController.kext/Contents/MacOS/AppleHDAController
;;

esac

# permissions and kernel cache
case $gSysName in

"El Capitan"|"Yosemite" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
sudo kextcache -Boot -U /
;;

"Mavericks" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
echo "Allow a few minutes for kernel cache rebuild."
;;

esac

echo "Finished, restart required."
exit 0