Realtek ALC Audio - Native AppleHDA.kext
https://github.com/toleda/audio_RealtekALC

The Realtek ALC AppleHDA Support kext installed with the native AppleHDA.kext enables full onboard, HDMI and DP audio (Note 1).  The ALC Support kext provides  pin configuration, layout and pathmap injection.  Two choices for AppleHDA binary patching are available; 1. patching the native AppleHDA binaries or including the patched binaries in the Realtek ALC AppleHDA Support kext.

Requirements
  1. Chameleon/Chimera (For Clover, see https://github.com/toleda/audio_CloverALC)
  2. Mavericks
  3. Native AppleHDA.kext  (If not installed, apply Combo Update)
  4. Supported Realtek on board audio codec

Required Information (Select one from each category)
  1. Codec/ALC
	1. 885
	2. 887 (Legacy only, Note 2)
	3. 888 (Legacy only, Note 2)
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

Realtek ALC AppleHDA Support kext Configurations:
  1. Realtek ALC AppleHDA Support kext WITHOUT patched binaries 
     (Installation, Step 1)
	1. Native AppleHDA.kext binaries must be patched after each 
	   Software Update
	  1. Script provided
	2. Realtek ALC AppleHDA Support kext WITHOUT patched binaries
	  1. Persistent, use as is after each Software Update
  2. Realtek ALC AppleHDA Support kext WITH patched binaries 
     (Installation, Step 2)
	1. Native AppleHDA.kext untouched
	2. Install new Realtek ALC AppleHDA Support kext WITH patched binaries
	   after each Software Update

Realtek ALC AppleHDA Support kext Installation (Start with 1 or 2, not both)
  1. Realtek ALC AppleHDA Support kext WITHOUT patched binaries (Use Terminal)
	1. Downloads/audio_RealtekALC-master
	2. Select ALC codec patch and double click
	   1. ex. audio_realtek-alc1150-patch.command
	   2. For HD4600 HDMI audio, select
	      1. audio_hdmi_hd5K-hda-90_patch.command
	3. https://github.com/Piker-Alpha/AppleHDA8Series.sh 
	4. Download Zip
	5. $ cd Downloads/AppleHDA8Series.sh-master 
	6. $ ./AppleHDA8Series  (no arguments required)
	7. Password
	8. Codec
	8. Layout
	10. Version
	11. Install S/L/E
	12. Jump to Step 3.
  2. Realtek ALC AppleHDA Support kext WITH patched binaries (Use Terminal)
	1. https://github.com/Piker-Alpha/AppleHDA8Series.sh 
	2. Download Zip
	3. $ cd Downloads/AppleHDA8Series.sh-master 
	4. $ ./AppleHDA8Series -b AppleHDA
	  1. For HD4600 HDMI audio, use 
	     $ ./AppleHDA8Series -b AppleHDA -b AppleHDAController
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
	1. System Preferences/Sound/Output

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