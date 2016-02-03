Realtek ALC AppleHDA Audio [Guides]_v4.0  
![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio_realtekALC
============
Realtek ALC/Desktop: 269(1), 283(1), 885, 887, 888, 892, 898 and 1150 on board audio  (1) BRIX/NUC only  
Supports OS X: 10.11, 10.10, 10.9 and 10.8
Native AppleHDA

**OS X/Patch in Place AppleHDA Realtek ALC Audio**  

The Realtek Realtek ALC Patched method enables OS X AppleHDA onboard with or without HDMI and DP audio.  The script patches the audio codec binary and installs pin configuration, layouts and platforms files.

**Updates**

1. 11/8/15 - Skylake/Series 100 Update, Add 1150/Audio ID: 3
2. 6/15/15 - 10.11 - El Capitan Realtek ALC AppleHDA.kext Initial Support

**Versions: audio_realtekALC-110**

1. Easy: .command, see A. Installation
2. Bash: .sh, see B. Terminal

**A. Installation**

1. Confirm, Audio/ALC Injection: OK
	2. Download: [audio_codecdetect.command](https://github.com/toleda/audio_ALCInjection/blob/master/audio_codecdetect.command.zip) (select View Raw)
	3. Double click
	4. Result
		1. OK, proceed
		2. NOK, fix
2. Patched AppleHDA.kext
    1. [audio_realtekALC-110.command](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-110.command.zip) (select View Raw)
    2. Double click Downloads/audio_realtekALC-110.command
    3. Password:
    4. Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
    5. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
3. Verify Patched AppleHDA kext installed
    1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
4. Restart
5. Verify ALC onboard audio
    1. System Preferences/Sound/Output/select audio device

**B. Terminal**

1. Clover patched AppleHDA
    1. [audio_realtekALC-110.sh](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-110.sh) (select View Raw)
    2. Terminal $ ./audio_cloverALC-110....sh
    3. Same (as above)

**C. Requirements**

1.  OS X Versions (+ all)
    1.  10.11+/El Capitan 
    2.  10.10+/Yosemite
    3.  10.9+/Mavericks
    4.  10.8+/Mountain Lion
2. Boot Flags/Boot failure may result if ignored
	1. 10.11+/Disable SIP/set, restart, install, enable SIP, restart
		1. CLOVER/config.plist/
			1. ACPI/DSDT/Fixes/NO (all or remove)
			2.	RtVariables/BooterConfig/0x28
			3.	RtVariables/CsrActiveConfig/0x3
		2. Chameleon - Extra/org.chameleon.Boot.plist/
			1. CsrActiveConfig=3
	2. 10.10+/Allow unsigned kexts/set, restart, install
		1. Clover/config.plist/
			1. ACPI/DSDT/Fixes/NO (all or remove)
			2. Boot/Arguments/kext-dev-mode=1
		2. Chameleon/Extra/org.chameleon.Boot.plist/
			1. Kernel Flags/kext-dev-mode=1
3.  [Native AppleHDA.kext](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
4.  Audio codec? See Tools 4.  

**D. Realtek ALCxxx** - Verify, see Tools 4.

1.  Supported codecs
    1.  269 (BRIX only)
    2.  283 (BRIX Pro and NUC only)
    3.  885
    4.  887
    5.  888
    6.  889
    7.  892
    8.  898
    9.  1150
2.  Supported Audio IDs
    1. Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150  
        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    2. Audio ID: 2 supports 887, 888, 889, 892, 898, 1150   
        Realtek ALC/5.1 surround sound (3 motherboard audio ports) 

    3. Audio ID: 3 supports 887, 888, 889, 892, 898, 1150  
        HD3000/HD4000 HDMI audio with Realtek ALC audio

**E. More Information**

1. [Audio ID Injection](https://github.com/toleda/audio_ALCInjection)
1. [Realtek ALC AppleHDA](https://github.com/toleda/audio_ALC_guides/blob/master/Realtek%20ALC%20AppleHDA.pdf)

    1. Installation
    2. Details/Support  
    3. Troubleshooting
2. [Realtek ALC guides](https://github.com/toleda/audio_ALC_guides)
	1. Enhancemants
		1. Customization
		2. Surround Sound
	2. Troubleshooting
		1. No Audio Devices
		2. No Sound
		3. No Audio After Sleep/Wake
	3. Utilities
		1. Identify Audio Codec
		2. Restore native AppleHDA  
4. [Terminal Saved Output](https://github.com/toleda/audio_RealtekALC/blob/master/Terminal:audio_realtekALC-110.command_v1.0a.txt)

F. [Problem Reporting](https://github.com/toleda/audio_ALC_guides/blob/master/Problem%20Reporting.md)  

1.	Problem Reporting/Post to: 
2.	Problem Reporting/Attached requested files

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a, lisai9093

toleda
https://github.com/toleda/audio_realtekALC
