#!/bin/sh
# Maintained by: toleda for: github.com/toleda/audio_realtekALC
gFile="File: audio_realtekALC-100.command_v1.0.3"
# Credit: bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker
#
# OS X Realtek ALC Onboard Audio
#
# Enables OS X Realtek ALC onboard audio in 10.10, 10.9 and 10.8, all versions
# 1. Supports Realtek ALC885, 887, 888, 889, 892, 898 and 1150
# 2. Patches native AppleHDA.kext installed in System/Library/Extensions
#
# Requirements
# 1. OS X/10.10/10.9/10.8, all versions
# 2. Native AppleHDA.kext  (If not installed, run Mavericks installer)
# 3. Supported Realtek ALC on board audio codec (see above)
# 4. Audio ID: 1, 2 or 3 Injection, see https://github.com/toleda/audio_ALCinjection
#
# Installation
# 1. Double click audio_cloverALC-100.command
# 2. Enter password at prompt
# 3. Confirm Realtek ALC . . . (y/n): (885, 887, 888, 889, 892, 898, 1150 only)
# 4. Enter Legacy (y/n): (887 and 888 only)
# 5. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
#
echo " "
echo "Agreement"
echo "The audio_realtekALC-100 script is for personal use only. Do not distribute" 
echo "the patch, any or all of the files or the resulting patched AppleHDA.kext" 
echo "for any reason without permission. The audio_realtekALC-100 script is" 
echo "provided as is and without any kind of warranty."
echo " "

# set initial variables
gSysVer=`sw_vers -productVersion`
gSysName="Mavericks"
gSysFolder="10.9"
gCloverDirectory=/Volumes/EFI/EFI/CLOVER
gDesktopDirectory=/Users/$(whoami)/Desktop
gExtensionsDirectory=/System/Library/Extensions
gHDAContentsDirectory=$gExtensionsDirectory/AppleHDA.kext/Contents
gHDAHardwarConfigDirectory=$gHDAContentsDirectory/Plugins/AppleHDAHardwareConfigDriver.kext/Contents
gHDAControllerbinaryDirectory=$gHDAContentsDirectory/Plugins/AppleHDAController.kext/Contents/MacOS
gAudioid=1
gLayoutid=1
gPatch="-toledaALC"
gCodec=283
gLegacy=n
gController=n
gMake=0
gDebug=0
# gCodecsinstalled
# gCodecVendor
# gCodecDevice
# gCodecName
# gCodec
gCloverALC=0
gRealtekALC=1
gAudioidvalid=n
gCodecvalid=n

# debug
if [ $gDebug = 1 ]; then
echo "gMake = $gMake"
echo "gCloverALC = $gCloverALC"
echo "gRealtekALC = $gRealtekALC"

# while true
# do
# read -p "OK (y/n): " choice3
# case "$choice3" in
# 	[yY]* ) break;;
# 	[nN]* ) exit;;
# 	* ) echo "Try again...";;
# esac
# done
fi

#verify system version

case ${gSysVer:0:5} in
10.8|10.8. ) gSysName="Mountain Lion"
gSysFolder=/kexts/10.8
;;
10.9|10.9. ) gSysName="Mavericks"
gSysFolder=/kexts/10.9
;;
10.10 ) gSysName="Yosemite"
gSysFolder=/kexts/10.10
;;
* ) echo "OS X Version: $gSysVer is not supported"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

# debug
if [ $gDebug = 1 ]; then
# gSysVer=10.9
echo "System version: supported"
echo "gSysVer = $gSysVer"
fi

echo "$gFile"

if [ $gCloverALC = 1 ]; then
echo "Verify EFI partition mounted, Finder/Devices/EFI"
fi

if [ $gSysName = "Yosemite" ]; then
if [ $gRealtekALC = 1 ]; then
echo "Verify kext-dev-mode=1 boot flag/argument"
fi
fi

# get password
gHDAversioninstalled=$(sudo /usr/libexec/plistbuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)

# exit if error
if [ "$?" != "0" ]; then
echo "Error occurred, no S/L/E/AppleHDA.kext installed"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# set up efi/clover
if [ $gCloverALC = 1 ]; then

# debug
case $gDebug in
0 )
gCloverDirectory=/Volumes/EFI/EFI/CLOVER
gCloverDirectorykexts=$gCloverDirectory$gSysFolder
sudo rm -R $gCloverDirectory/config-backup.plist
sudo cp -p $gCloverDirectory/config.plist /tmp/config.plist
sudo cp -p $gCloverDirectory/config.plist $gCloverDirectory/config-backup.plist
;;
1 )
echo "gHDAversioninstalled = $gHDAversioninstalled"
echo "Desktop/config-basic.plist copied to /tmp/config.plist"
sudo cp -R config-basic.plist /tmp/config.plist
;;
* )
echo "gDebug = $gDebug, fix"
exit 1
;;
esac

# exit if error
if [ "$?" != "0" ]; then
echo "Error, EFI partition not mounted"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

fi

# debug
if [ $gDebug = 1 ]; then
echo "EFI: success"
fi

# verify ioreg/HDEF
ioreg -rw 0 -p IODeviceTree -n HDEF > /tmp/HDEF.txt

if [ $(cat /tmp/HDEF.txt | grep -o "HDEF@1B") == "HDEF@1B" ]; then
gLayoutidioreg=$(cat /tmp/HDEF.txt | grep layout-id | sed -e 's/.*<//' -e 's/>//')
gLayoutidhex="0x${gLayoutidioreg:6:2}${gLayoutidioreg:4:2}${gLayoutidioreg:2:2}${gLayoutidioreg:0:2}"
let gAudioid=$gLayoutidhex
sudo rm -R /tmp/HDEF.txt
else
echo "Error: no IOReg/HDEF; BIOS/audio/disabled or ACPI problem"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 1 ]; then
echo "gLayoutidioreg = $gLayoutidioreg"
echo "gLayoutidihex = $gLayoutidhex"
echo "gAudioid = $gAudioid"
echo "HDEF/Audio ID: success"
fi


# verify native s/l/e/applehda.kext 
if [ $gMake = 0 ]; then

if [ $(perl -le "print scalar grep /\x8b\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\x84\x19\xd4\x11/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\xff\x87\xec\x1a/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

if [ $(perl -le "print scalar grep /\x62\x02\xec\x10/, <>;" $gHDAContentsDirectory/MacOS/AppleHDA) = 0 ]; then
echo "S/L/E/AppleHDA.kext is not native"
echo "Install native AppleHDA.kext"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi
fi

# debug
if [ $gDebug = 1 ]; then
echo "Native AppleHDA: success"
fi

# get installed codec ids
gCodecsInstalled=$(ioreg -rxn IOHDACodecDevice | grep VendorID | awk '{ print $4 }' | sed -e 's/ffffffff//')

# debug
# gCodecsInstalled=0x10ec0900
# gCodecsInstalled=0x10134206

# debug
if [ $gDebug = 1 ]; then
echo "gCodecsInstalled = $gCodecsInstalled"
fi

# no codecs detected
if [ -z "${gCodecsInstalled}" ]; then
echo ""
echo "No audio codec detected"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# initialize variables
intel=n
amd=n
nvidia=n
realtek=n
unknown=n
alternate=n

# find realtek codecs
for codec in $gCodecsInstalled
do
case ${codec:2:4} in

8086 ) Codecintelhdmi=$codec; intel=y
;;
1002 ) Codecamdhdmi=$codec; amd=y
;;
10de ) Codecnvidiahdmi=$codec; nvidia=y
;;
10ec ) Codecrealtekaudio=$codec; realtek=y
;;
*) Codecunknownaudio=$codec; unknown=y
;;
esac
done

# debug
if [ $gDebug = 1 ]; then
echo "HDMI audio codec(s)"
if [ $intel = y ]; then
echo "Intel:    $Codecintelhdmi"
fi
if [ $amd = y ]; then
echo "AMD:      $Codecamdhdmi"
fi
if [ $nvidia = y ]; then
echo "Nvidia:   $Codecnvidiahdmi"
fi
echo ""
echo "Onboard audio codec"
if [ $realtek = y ]; then
echo "Realtek:  $Codecrealtekaudio"
fi
if [ $unknown = y ]; then
echo "Unknown:  $Codecunknownaudio"
fi
fi

if [ $unknown = y ]; then

while true
do
read -p "Codec $Codecunknownaudio is not supported, continue (y/n): " choice7
case "$choice7" in
	[yY]* )  break;;
	[nN]* ) echo "No system files were changed"; exit 1;;
	* ) echo "Try again..."
;;
esac
done
fi

if [ $realtek = y ]; then

gCodecVendor=${Codecrealtekaudio:2:4}
gCodecDevice=${Codecrealtekaudio:6:4}

# debug
if [ $gDebug = 1 ]; then
echo "gCodecVendor = $gCodecVendor"
echo "gCodecDevice = $gCodecDevice"
fi

if [ ${gCodecDevice:0:1} = 0 ]; then
gCodecName=${gCodecDevice:1:3}
fi

if [ $gCodecDevice = "0899" ]; then
gCodecName=898
fi

if [ $gCodecDevice = "0900" ]; then
gCodecName=1150
fi

# debug
if [ $gDebug = 1 ]; then
echo "Codec identification: success"
fi


# confirm codec, go button
while true
do
read -p "Confirm Realtek ALC$gCodecName (y/n): " choice3
case "$choice3" in
	[yY]* ) gCodec=$gCodecName; gCodecvalid=y; break;;
	[nN]* ) break;;
	* ) echo "Try again...";;
esac
done

# exit if error
if [ "$?" != "0" ]; then
echo Error: ??
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

fi

if [ $gCodecvalid != y ]; then

#  get supported codec
echo "Supported RealtekALC codecs: 885, 887, 888, 889, 892, 898 or 1150"
while true
do
read -p "Enter codec: " choice0
case "$choice0" in
	269|283|885|887|888|889|892|898|1150 ) gCodec=$choice0; break;;
	* ) echo "Try again...";;
esac
done

fi

# legacy
case "$gCodec" in

887|888 )
while true
do
# read -p "$gCodec Legacy_v100202 (y/n): " choice1
read -p "ALC$gCodec Current_v..0302 (y/n): " choice1
case "$choice1" in
#	[yY]* ) gLegacy=y; break;;
#	[nN]* ) gLegacy=n; break;;
	[nN]* ) gLegacy=y; break;;
	[yY]* ) gLegacy=n; break;;

	* ) echo "Try again...";;
esac
done
esac


# HD4600 HDMI audio patch
if [ $gRealtekALC = 1 ]; then
if [ $gCodec = 887 -a $gLegacy = y ]; then gController=n; else
case "$gCodec" in

887|892|898|1150 )
while true
do
read -p "Enable HD4600 HDMI audio (y/n): " choice2
case "$choice2" in
	[yY]* ) gController=y; break;;
	[nN]* ) gController=n; break;;
	* ) echo "Try again...";;
esac
done
esac
fi
fi

# validate audio id
case $gAudioid in
# 0|1|2|3 ) gAudioidvalid=y;;
1|2|3 ) gAudioidvalid=y;;
* )  
while true
do
read -p "Audio ID: $gAudioid is not supported, continue (y/n): " choice6
case "$choice6" in
	[yY]* ) gAudioid=0; gAudioidvalid=n break;;
	[nN]* ) echo "No system files were changed"; exit;;
	* ) echo "Try again..."
;;
esac
done
;;
esac

if [ $gRealtekALC = 1 ]; then
if [ $gAudioidvalid = n ]; then
echo ""
echo "Note"
echo "Set Audio ID injection before restart; valid IDs are:"
# echo "0 - dsdt/ssdt HDMI audio (AMD/Nvidia/Intel)"
echo "1 - 3/5/6 port Realtek ALCxxx audio"
echo "2 - 3 port (5.1) Realtek ALCxxx audio (n/a 885)"
echo "3 - HD3000/HD4000 HDMI and Realtek ALCxxx audio (n/a 885/1150 & 887/888 Legacy)"
echo "Caution: if Audio ID: $gAudioid is not fixed, no audio after restart"
fi
fi

if [ $gCloverALC = 1 ]; then
while true
do
read -p "Clover Audio ID Injection (y/n): " choice4
case "$choice4" in
	[yY]* ) choice4=y; break;;
	[nN]* ) gAudioid=1; choice5=y; break;;
	* ) echo "Try again...";;
esac
done

if [ $choice4 = y ]; then
while true
do
read -p "Use Audio ID: $gAudioid (y/n): " choice5
case "$choice5" in
	[yY]* ) break;;
	[nN]* ) choice5=n; break;;
	* ) echo "Try again...";;
esac
done
fi

if [ $choice5 = n ]; then
echo "Audio IDs:"
# echo "0 - dsdt/ssdt HDMI audio (AMD/Nvidia/Intel)"
echo "1 - 3/5/6 port Realtek ALCxxx audio"
echo "2 - 3 port (5.1) Realtek ALCxxx audio (n/a 885)"
echo "3 - HD3000/HD4000 HDMI and Realtek ALCxxx audio (n/a 885/1150 & 887/888 Legacy)"
while true
do
# read -p "Select Audio ID? (0, 1, 2 or 3): " choice6
read -p "Select Audio ID: " choice6
case "$choice6" in
#	0* ) gAudioid=0; break;;
	1* ) gAudioid=1; break;;
	2* ) gAudioid=2; if [ $gCodec = 885 ]; then echo "ID: 2 n/a, try again..."; else break; fi;;
	3* ) gAudioid=3; 
		if [ $gCodec = 885 ]; then valid=n; fi;
		if [ $gCodec = 1150 ]; then valid=n; fi;
		if [ $gLegacy = y ]; then valid=n; fi;
		if [ $valid = n ]; then echo "ID: 3 n/a, try again..."; else break; fi;;
	* ) echo "Try again...";;
esac
done
fi
fi

# debug
if [ $gDebug = 1 ]; then
echo "gCodec = $gCodec"
echo "gAudioid = $gAudioid"
echo "gLegacy = $gLegacy"
echo "gController = $gController"
echo "Codec configuration: success"
fi

# echo $gCodec
# echo $gAudioid
# exit   # ?

echo ""
echo "Download ALC$gCodec files ..."
gDownloadLink="https://raw.githubusercontent.com/toleda/audio_ALC$gCodec/master/$gCodec.zip"
if [ $gLegacy = y ]; then
Legacy=_v100202
gDownloadLinkLegacy="https://raw.githubusercontent.com/toleda/audio_ALC$gCodec/master/$gCodec$Legacy.zip"
sudo curl -o "/tmp/ALC$gCodec.zip" $gDownloadLinkLegacy
else
sudo curl -o "/tmp/ALC$gCodec.zip" $gDownloadLink
fi
unzip -qu "/tmp/ALC$gCodec.zip" -d "/tmp/"

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Download failure, verify network"
echo "No system files were changed"
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# debug
if [ $gDebug = 1 ]; then
echo "gCloverALC = $gCloverALC"
echo "gRealtekALC = $gRealtekALC"
fi

######################

if [ $gRealtekALC = 1 ]; then    # main loop

######################
# debug
if [ $gMake = 1 ]; then 
sudo rm -fR $gExtensionsDirectory/AppleHDA.kext
sudo cp -R $gDesktopDirectory/AppleHDA.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
gHDAversioninstalled=$(sudo /usr/libexec/plistbuddy -c "Print ':CFBundleShortVersionString'" $gHDAContentsDirectory/Info.plist)
echo "Desktop/AppleHDA.kext installed in $gExtensionsDirectory"
fi

echo " "
echo "Preparing $gSysVer ALC$gCodec AppleHDA.kext_v$gHDAversioninstalled"

# manage backup folders
if [ -d "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive" ]; then
sudo rm -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive
echo "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive deleted, too late"
fi
if [ -d "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer" ]; then
sudo mv -f $gDesktopDirectory/audio_ALC$gCodec-$gSysVer $gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive
echo "$gDesktopDirectory/audio_ALC$gCodec-$gSysVer-archive created, max 1 archive"
fi
sudo mkdir -p $gDesktopDirectory/audio_ALC$gCodec-$gSysVer
sudo chown $(whoami) $gDesktopDirectory/audio_ALC$gCodec-$gSysVer
sudo cp -R $gExtensionsDirectory/AppleHDA.kext $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Backup failed"
echo "No system files were changed"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

echo "Patch binaries ..."

if [ $gController = y ]; then

case $gSysVer in

10.10|10.10.1|10.10.2|10.10.3|10.10.4|10.10.5 )
echo "$gSysVer controller patch"
# HD4600/0c0c HDMI audio patch (10.10)
sudo xxd -ps $gHDAControllerbinaryDirectory/AppleHDAController | tr -d '\n' > /tmp/AppleHDAController.txt
sudo /usr/bin/perl -pi -e 's|3d0c0a0000|3d0c0c0000|g' /tmp/AppleHDAController.txt
sudo /usr/bin/perl -pi -e 's|3d0b0c0000|3d0c0c0000|g' /tmp/AppleHDAController.txt

# sudo /usr/bin/perl -pi -e 's|3d0c0a0000740e|3d0c0c0000740e|g' /tmp/AppleHDAController.txt
# sudo /usr/bin/perl -pi -e 's|3d0c0a00000f84|3d0c0c00000f84|g' /tmp/AppleHDAController.txt
# sudo /usr/bin/perl -pi -e 's|3d0c0c00000f8520010000|3d0c0c0000744b90909090|g' /tmp/AppleHDAController.txt  # dp5/dp6/dp7/dp8/gmc1/gmc2/gmc3
# sudo /usr/bin/perl -pi -e 's|3d0c0c00000f8496000000|3d0c0c0000744b90909090|g' /tmp/AppleHDAController.txt  # dp1/dp2/dp3/dp4

sudo xxd -r -p /tmp/AppleHDAController.txt $gHDAControllerbinaryDirectory/AppleHDAController
sudo rm -R /tmp/AppleHDAController.txt
;;

10.9|10.9.1|10.9.2|10.9.3|10.9.4|10.9.5 )
echo "$gSysVer controller patch"
# HD4600/0c0c HDMI audio patch (10.9)
sudo xxd -ps $gHDAControllerbinaryDirectory/AppleHDAController | tr -d '\n' > /tmp/AppleHDAController.txt
sudo /usr/bin/perl -pi -e 's|0b0c0000|0c0c0000|g' /tmp/AppleHDAController.txt
sudo /usr/bin/perl -pi -e 's|0c0a0000|0c0c0000|g' /tmp/AppleHDAController.txt
sudo xxd -r -p /tmp/AppleHDAController.txt $gHDAControllerbinaryDirectory/AppleHDAController
sudo rm -R /tmp/AppleHDAController.txt
;;

* ) echo "OS X Version: $gSysVer does not support HD46000 HDMI audio"
echo "No system files were changed"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

fi

# exit if error
if [ "$?" != "0" ]; then
echo "Error: $gCodec  controller patch failure"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

# codec binary patch
case $gSysVer in

10.8.5|10.9|10.9.1|10.9.2|10.9.3|10.9.4|10.9.5|10.9.6|10.10|10.10.1|10.10.2|10.10.3|10.10.4 ) 
echo "$gSysVer codec patch"

# patch codec
case $gCodec in
269 ) sudo perl -pi -e 's|\x62\x02\xec\x10|\x69\x02\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

283 ) sudo perl -pi -e 's|\x62\x02\xec\x10|\x83\x02\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

885 ) echo “No patch, native ALC885”  
# Optional patch, remove "# " from the following two lines
# sudo perl -pi -e 's|\x85\x08\xec\x10|\x80\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
# sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x85\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

887 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x87\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

888 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x88\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

889 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x89\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

892 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x92\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

898 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x99\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

1150 ) sudo perl -pi -e 's|\x8b\x19\xd4\x11|\x00\x09\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

* )
echo "$gCodec not supported with this script"
echo "No system files were changed"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

;;

10.8|10.8.1|10.8.2|10.8.3|10.8.4 )
echo "$gSysVer codec patch"

# patch codec
case $gCodec in

885 ) echo “No patch, native ALC885, optional patch available, see script”  
# Optional patch, remove "# " from the following 3 lines
# sudo perl -pi -e 's|\x85\x08\xec\x10|\x80\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
# sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
# sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

887 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x87\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x87\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA-pi -e 's|\x8b\x19\xd4\x11|\x87\x08\xec\x10|g' $gHDAContentsDirectory/MacOS/AppleHDA
;;

888 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x88\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x88\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

889 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x89\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x89\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

892 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x92\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

898 ) sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x53\x01\x00\x00|\x92\x08\xec\x10\x0f\x84\x2a\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/AppleHDA
sudo perl -pi -e 's|\xff\x87\xec\x1a\x0f\x8f\x2f\x01\x00\x00|\x99\x08\xec\x10\x0f\x84\x06\x01\x00\x00|g' $gHDAContentsDirectory/MacOS/AppleHDA/MacOS/AppleHDA
;;

1150 ) echo "ALC1150 supported in OS X 10.8.5 and newer"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

* )
echo "$gCodec not supported with this script"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;
esac

;;

* )
echo "$gSysVer not supported with this script"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
;;

esac


# exit if error
if [ "$?" != "0" ]; then
echo "Error: $gCodec codec patch failure"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

echo "Install files ..."
gPatchversion=$gHDAversioninstalled$gPatch$gCodec
sudo /usr/libexec/plistbuddy -c "Set ':CFBundleShortVersionString' $gPatchversion" $gHDAContentsDirectory/Info.plist
sudo /usr/libexec/plistbuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" $gHDAHardwarConfigDirectory/Info.plist
sudo /usr/libexec/plistbuddy -c "Merge /tmp/$gCodec/hdacd.plist ':IOKitPersonalities:HDA Hardware Config Resource'" $gHDAHardwarConfigDirectory/Info.plist

sudo rm -R $gHDAContentsDirectory/Resources/*.zlib

sudo install -m 644 -o root -g wheel /tmp/$gCodec/Platforms.xml.zlib  $gHDAContentsDirectory/Resources

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout1.xml.zlib  $gHDAContentsDirectory/Resources

case $gCodec in

887|888|889|892|898 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources

sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout3.xml.zlib  $gHDAContentsDirectory/Resources
;;
1150 )
sudo install -m 644 -o root -g wheel /tmp/$gCodec/layout2.xml.zlib  $gHDAContentsDirectory/Resources
;;
esac

# exit if error
if [ "$?" != "0" ]; then
echo "Error: Installation failure"
sudo cp -R $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA-orig.kext $gExtensionsDirectory/AppleHDA.kext
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
sudo touch $gExtensionsDirectory
echo "Original S/L/E/AppleHDA.kext restored"
echo "To save a copy of this Terminal session: Terminal/Shell/Export Text As ..."
exit 1
fi

fi    # end: if [ $gRealtekALC = 1 ]

sudo rm -R /tmp/ALC$gCodec.zip
sudo rm -R /tmp/$gCodec
sudo cp -R $gExtensionsDirectory/AppleHDA.kext $gDesktopDirectory/audio_ALC$gCodec-$gSysVer/AppleHDA.kext

case $gSysName in

"Yosemite" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
sudo kextcache -Boot -U /
;;

"Mavericks"|"Mountain Lion" )
echo "Fix permissions ..."
sudo chown -R root:wheel $gExtensionsDirectory/AppleHDA.kext
echo "Kernel cache..."
sudo touch $gExtensionsDirectory
echo "Allow a few minutes for kernel cache rebuild."
;;
esac

# exit if error
# if [ "$?" != "0" ]; then
# echo Error: Maintenance failure
# echo "Verify Permissions"
# echo "Rebuild Kernel Cache"
# echo "Verify S/L/E/AppleHDA.kext"
# echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
# exit 1
# fi

if [ $gCloverALC = 1 ]; then
if [ $gCodec = 1150 ]; then
echo " "
echo "NOTE: ALC1150 only, edit config.plist before restarting"
echo "config.plist/KernelAndKextPatches/KextsToPatch/ALC1150/Replace edit required"
echo "Before: <09ec10>    After: <0009ec10> or"
echo "Before: CewQ    After: AAnsEA=="
fi
fi

echo ""
echo "Install finished, restart required."
echo "To save a Copy to this Terminal session: Terminal/Shell/Export Text As ..."
exit