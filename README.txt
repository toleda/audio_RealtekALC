audio_RealtekALC
============
Realtek ALC Audio - Native AppleHDA.kext/No Patching/Persistant

The Realtek ALC AppleHDA Support kext, installed with the native AppleHDA.kext, enables full onboard, HDMI and DP audio (Note 1).  The ALC AppleHDA Support kext provides audio codec binary patch and config data and layouts and platforms injection.

Requirements
  1. Chameleon/Chimera 
     1. For Clover, see https://github.com/toleda/audio_CloverALC
  2. Mavericks (10.9 or newer)
  3. Native AppleHDA.kext  (If not installed, apply Combo Update)
  4. Supported Realtek on board audio codec

Required Information (Select one from each category)
  1. Codec/ALC
	1. 885
	2. 887 (for Legacy only, Note 2)
	3. 888 (for Legacy only, Note 2)
	4. 889
	5. 892
	6. 898
	7. 1150
  2. Layout Support (Definitions, Note 3)
	1. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898
  3. Mavericks version (Info.plist reference)
	1. 10.9.2 (-92)
	2. 10.9.1 (-91)
	3. 10.9 (-90)

Realtek ALC AppleHDA Support Kext Method
  1. Realtek ALC AppleHDA Support kext with patched binaries
	1. Native AppleHDA.kext untouched
  2. Clover/Devices/Audio/Inject/Audio ID
  3. AppleHDA8Series - ConfigData, layouts, Platforms and HDA binary patch

Realtek ALC AppleHDA Support Kext - Installation
  1. Clover (Use Clover Configurator, Xcode, Property List Editor, etc.)
	1. EFI/Clover/config.plist/Add
	  1. Devices/Audio/Inject/Layout (1, 2 or 3)  
	  2. Save
  2. ALC Support kext (Use Terminal/Terminal output below)
	1. https://github.com/Piker-Alpha/AppleHDA8Series.sh 
	2. Download Zip
	3. $ cd Downloads/AppleHDA8Series.sh-master 
	4. $ ./AppleHDA8Series.sh  (no arguments required)
	5. Password
	6. Codec
	7. Layout
	8. Version
	9. Install S/L/E
  3. Restart
  4. Verify ALC AppleHDA Support kext installed
	1. S/L/E/AppleHDA885
	2. S/L/E/AppleHDA887 
	3. S/L/E/AppleHDA888
	4. S/L/E/AppleHDA889
	5. S/L/E/AppleHDA892
	6. S/L/E/AppleHDA898
	7. S/L/E/AppleHDA1150
  5. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device

Notes
  1. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  2. 887/888 Legacy
	1.  Replace AppleHDALoader.kext/Contents/Resources/Platforms.xml.zlib
            with Legacy Platforms.xml.zlib (v100202) from:
		1. https://github.com/toleda/audio_ALC887
		2. https://github.com/toleda/audio_ALC888
  3. Layout Definitions (Layout/Audio ID injection installed separately, 
        see https://github.com/toleda/audio_ALCInjection)
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  4. Recommendations
	1. Rename backup AppleHDA.kext after each Software Update
	   1. Rename Desktop/AppleHDA-orig.kext to AppleHDA-10-9-x.kext
	2. If audio fails after Software Update
	   1. Install AppleHDA-10-9-x-1.kext (previous working native AppleHDA.kext

Tools
  1. Clover Configurator - http://www.osx86.net/files/file/49-clover-configurator/
  2. Clover Wiki - http://clover-wiki.zetam.org/Home
  3. Property List Editor - Xcode, Property List Editor, PlistEdit Pro, TextEdit, etc.
  4. IOReg (View Raw) - https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip

Problem Reporting (include the following information)
  1. Description of audio problem
	1. OS X version/motherboard model/BIOS version/processor/graphics
	2. Procedure/Guide Used/AppleHDA.kext version
	3. AppleHDA(codec).kext (i.e., AppleHDA1150.kext)
	4. Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (not
           ioreg.txt)
	5. Extra/dsdt.aml (if installed)
	6. Console/All Messages/kernel Sound assertions selected/Save
           Selection As…..
	7. Screenshot of System Information/Hardware/Audio/Intel High
           Definition Audio (not Devices)
  2. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit: PikeRAlpha http://pikeralpha.wordpress.com/2014/01/05/new-style-of-applehda-kext-patching-take-ii/

AppleHDA Support Kext Method/Terminal Output
$ ./AppleHDA8Series.sh -b AppleHDA -b AppleHDAController

This script must be run as root!

AppleHDA8Series.sh v2.5 Copyright (c) 2013-2014 by Pike R. Alpha
                    patched XML files by Toleda and contributors
----------------------------------------------------------------
The supported Realtek ALC codecs for AppleHDA8Series.sh are:

    [1] Realtek ALC  885 (0x10EC0885 / 283904133)
    [2] Realtek ALC  887 (0x10EC0887 / 283904135)
    [3] Realtek ALC  888 (0x10EC0888 / 283904136)
    [4] Realtek ALC  889 (0x10EC0889 / 283904137)
    [5] Realtek ALC  892 (0x10EC0892 / 283904146)
    [6] Realtek ALC  898 (0x10EC0899 / 283904153)
    [7] Realtek ALC 1150 (0x10EC0900 / 283904256)

Please choose the desired codec for the hardware: 7
Do you want to use [2] as the layout-id (y/n)? y
Looking in /System/Library/Extensions/AppleHDA.kext for ConfigData
Looking in /System/Library/Extensions/FakeSMC.kext for ConfigData
Error: ConfigData NOT found!
Downloading https://raw.github.com/toleda/audio_ALC1150/master/1150.zip ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 16136  100 16136    0     0  12772      0  0:00:01  0:00:01 --:--:-- 12775

Unzipping Archive:  /tmp/ALC1150.zip
   creating: /tmp/1150/
  inflating: /tmp/1150/Info-85.plist  
  inflating: /tmp/1150/Info-90.plist  
  inflating: /tmp/1150/Info-91.plist  
  inflating: /tmp/1150/Info-92.plist  
 extracting: /tmp/1150/layout1.xml.zlib  
 extracting: /tmp/1150/layout2.xml.zlib  
  inflating: /tmp/1150/Platforms.xml.zlib  
Looking in /tmp/1150/Info-92.plist for ConfigData
ConfigData for Realtek ALC 1150 found!
------------------------------------------------------------
AUccEAFHHUABRx4RAUcfkAFXHPABVx0AAVceAAFXH0ABZxzwAWcdAAFnHgABZx9AAXcc8AF3HQABdx4AAXcfQAGHHEABhx1gAYceAQGHHwEBlxxgAZcdkAGXHqABlx+QAaccUAGnHRABpx4BAacfAQG3HHABtx1AAbceIQG3HwIB5xyQAecdYQHnHksB5x8BAfcc8AH3HQAB9x4AAfcfQAEXHPABFx0AARceAAEXH0A=
------------------------------------------------------------
Creating AppleHDA1150.kext in: ...Downloads/AppleHDA8Series.sh-master
Copying AppleHDA ...
Bin-patching AppleHDA ... Done.
Copying AppleHDAController ...
Bin-patching AppleHDAController ... Done.
AppleHDA1150.kext appears to be loadable (including linkage for on-disk libraries).
Do you want to copy AppleHDA1150.kext to: /System/Library/Extensions? (y/n) y
Do you want to reboot now? (y/n) n
Done.

toleda
https://github.com/toleda/audio_RealtekALC