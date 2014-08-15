audio_realtekALC
============
Realtek ALC Audio - Patched AppleHDA.kext

The Realtek ALC Patched AppleHDA kext enables full onboard, HDMI and DP audio (Note 1).  The v2 script patches the audio codec binary and installs config data (pin configs) and layouts (audio devices) and platforms (pathmap) files.  Other than the script, no file downloads are required.

Update: v2.1, 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
Update: v2, updated script, no downloads, double click and done.

Other OS X Realtek ALC Onboard Audio Solutions
  1. https://github.com/toleda/audio_pikeralphaALC
  2. https://github.com/toleda/audio_CloverALC

Requirements
  1. Chameleon/Chimera/Clover 
        1. Optional/Clover, see https://github.com/toleda/audio_CloverALC
  2. OS X
	1. 10.10 or newer
	2. 10.9 or newer
	3. 10.8 or newer
  3. Native AppleHDA.kext  (If not installed, run Mavericks installer)
  4. Supported Realtek on board audio codec
  5. Audio ID Injection, see https://github.com/toleda/audio_ALCinjectiom

Required Information (Select one from each category)
  1. Codec/ALC Support (auto detection)
	1. 885
	2. 887
	3. 888
	4. 889
	5. 892
	6. 898
	7. 1150
  2. Layout Support (Definitions, Note 2)
	1. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898

Realtek ALC Patched AppleHDA Kext Method
  1. Patched AppleHDA.kext - ConfigData, layouts, Platforms and HDA binary patch
	1. Native AppleHDA.kext

Realtek ALC Patched AppleHDA Kext - Installation
  1. v2 Patched Realtek ALC AppleHDA.kext  (patch in place)
	1. https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-90_v2_patch.command.zip
	2. Download (View Raw)
	3. Double click Downloads/audio_realtekALC-90_patch_v2.command
	4. Password?
	5. Verify Codec? (885, 887, 888, 889, 892, 898, 1150 only)
	6. Legacy_v100202 - y/n? (887, 888 only)
	7. Enable HD4600 HDMI audio - y/n? (887, 892, 898, 1150 only)
  2. Restart
  3. Verify Patched AppleHDA kext installed
	1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
  4. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device

Notes
  1. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  2. Layout Definitions (Layout/Audio ID injection installed separately, 
        see https://github.com/toleda/audio_ALCInjection)
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  3. Recommendations
	1. Archive Desktop/audio_ALCxxx-10.9.x
	   1. Native: AppleHDA-orig.kext
	   2. Patched: AppleHDA.kext
	2. If audio fails after Software Update
	   1. See Installation above
	   2. If new patch fails, install working archived patched AppleHDA.kext

Tools
  1. IOReg (View Raw) - https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip
  2. audio_codecdetect.command (above) - detects, identifies and reports install audio codecs. Installation: Double click, Downloads/audio_codecdetect.command

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
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Patched AppleHDA Kext Method/Terminal Output
Last login: Wed Aug  6 16:11:37 on console
 
File: audio_realtekALC-90_v2.command
Verify kext-dev-mode=1 boot flag/argument
Password:
Confirm Realtek ALC1150 (y/n): y
Enable HD4600 HDMI audio (y/n)?: y

Download ALC1150 files ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21163  100 21163    0     0  48910      0 --:--:-- --:--:-- --:--:-- 48875
 
Preparing 10.10 ALC1150 AppleHDA.kext_v
Patch binaries ...
10.10 controller patch
10.10 codec patch
Install files ...
Fix permissions ...
Kernel cache...
kextcache -Boot -U /
rebuilding //System/Library/Caches/com.apple.kext.caches/Startup/kernelcache
kextcache -arch x86_64 -local-root -all-loaded -kernel /System/Library/Kernels/kernel -prelinked-kernel /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache -volume-root / /System/Library/Extensions /Library/Extensions
kext file:///System/Library/Extensions/Soundflower.kext/ is in hash exception list, allowing to load
kext com.jmicron.JMicronATA  101069000 is in exception list, allowing to load
kext com.intel.driver.EnergyDriver  200009000 is in exception list, allowing to load
kext-dev-mode allowing invalid signature -67030 0xFFFFFFFFFFFEFA2A for kext AppleKextExcludeList.kext
kext-dev-mode allowing invalid signature -67030 0xFFFFFFFFFFFEFA2A for kext AppleHDAHardwareConfigDriver.kext
kext-dev-mode allowing invalid signature -67061 0xFFFFFFFFFFFEFA0B for kext AppleHDAController.kext
kext com.apple.driver.AppleHDA  26569009000 is in exception list, allowing to load
kext com.apple.driver.AppleHDA  26569009000 is in exception list, allowing to load
Install finished, restart required.
logout

[Process completed]
toleda
https://github.com/toleda/audio_RealtekALC