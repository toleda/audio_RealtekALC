audio_RealtekALC
============
Realtek ALC Audio - Patched AppleHDA.kext

The Realtek ALC Patched AppleHDA kext enables full onboard, HDMI and DP audio (Note 1).  The v2 script patches the audio codec binary and installs config data (pin configs) and layouts (audio devices) and platforms (pathmap) files.  Other than the script, no file downloads are required. 

Other OS X Realtek ALC Onboard Audio Solutions
  1. https://github.com/toleda/audio_pikeralphaALC
  2. https://github.com/toleda/audio_CloverALC

Requirements
  1. Chameleon/Chimera/Clover 
        1. Optional/Clover, see https://github.com/toleda/audio_CloverALC
  2. OS X
	1. 10.9 or newer
  3. Native AppleHDA.kext  (If not installed, run Mavericks installer)
  4. Supported Realtek on board audio codec
  5. Audio ID Injection, see https://github.com/toleda/audio_ALCinjectiom

Required Information (Select one from each category)
  1. Codec/ALC
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
  3. Mavericks version
	1. 10.9 (all versions)

Realtek ALC Patched AppleHDA Kext Method
  1. Patched AppleHDA.kext - ConfigData, layouts, Platforms and HDA binary patch
	1. Native AppleHDA.kext untouched

Realtek ALC Patched AppleHDA Kext - Installation
  1. Patched AppleHDA.kext  (patch in place)
	1. https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-90_patch_v2.command.zip
	2. Download (View Raw)
	3. Double click Downloads/audio_realtekALC-90_patch_v2.command
	4. Password?
	5. Installed Codec? (885, 887, 888, 889, 892, 898, 1150 only)
	6. Enable HD4600 HDMI audio - y/n? (887, 892, 898, 1150 only)
	7. Legacy_v100202 - y/n? (887, 888 only)
  2. Restart
  3. Verify Patched AppleHDA kext installed
	1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
  5. Verify ALC onboard audio
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
Last login: Thu Jul 24 14:19:15 on ttys000
$ audio_realtekALC-90_patch_v2.0.command ; exit;
 
Supported RealtekALC codecs: 885, 887, 888, 889, 892, 898 and 1150
Enter name of installed codec: 892
Enable HD4600 HDMI audio (y/n)?: y
Preparing 10.9.4 ALC892 AppleHDA.kext_v2.6.3
 
Desktop/audio_ALC892-10.9.4
Download files ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 25382  100 25382    0     0  38783      0 --:--:-- --:--:-- --:--:-- 38751
Install files ...
Fix permissions ...
Kernel cache...
Finished, restart required.
logout

[Process completed]
toleda
https://github.com/toleda/audio_RealtekALC