audio_RealtekALC
============
Realtek ALC Audio - Native AppleHDA.kext

The Realtek ALC AppleHDA Support kext installed with the native AppleHDA.kext enables full onboard, HDMI and DP audio (Note 1).  The ALC Support kext provides  pin configuration, layout and pathmap injection.  Two choices for AppleHDA binary patching are available; 1. patching the native AppleHDA binaries or 2. including the patched binaries in the Realtek ALC AppleHDA Support kext.

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

Realtek ALC AppleHDA Support kext
  1. Realtek ALC AppleHDA Support kext WITH patched binaries
	1. Native AppleHDA.kext untouched
	2. Install new Realtek ALC AppleHDA Support kext WITH patched binaries
	   if no audio after Software Update

Realtek ALC AppleHDA Support kext Installation
  1. Realtek ALC AppleHDA Support kext WITH patched binaries (Use Terminal)
	1. https://github.com/Piker-Alpha/AppleHDA8Series.sh 
	2. Download Zip
	3. $ cp -R /System/Library/Extensions/AppleHDA.kext Desktop/AppleHDA-orig.kext
	4. $ cd Downloads/AppleHDA8Series.sh-master 
	5. $ ./AppleHDA8Series.sh -b AppleHDA
	  1. For HD4600 HDMI audio, use 
	     $ ./AppleHDA8Series.sh -b AppleHDA -b AppleHDAController
	6. Password
	7. Codec
	8. Layout
	9. Version
	10. Install S/L/E: y
  2. Restart
  3. Verify ALC AppleHDA Support kext installed
	1. S/L/E/AppleHDA885
	2. S/L/E/AppleHDA887 
	3. S/L/E/AppleHDA888
	4. S/L/E/AppleHDA889
	5. S/L/E/AppleHDA892
	6. S/L/E/AppleHDA898
	7. S/L/E/AppleHDA1150
  4. Verify ALC onboard audio
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
	1. Backup native AppleHDA.kext after each Software Update
	2. If audio fails after Software Update
		1. Install AppleHDA.kext backup (previous working native
                   AppleHDA.kext)

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

toleda
https://github.com/toleda/audio_RealtekALC