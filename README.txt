audio_realtekALC
============
Realtek ALC Audio - Patched AppleHDA.kext

The Realtek ALC Patched AppleHDA kext enables full onboard, HDMI and DP audio (Note 1).  The script patches the audio codec binary and installs config data (pin configs) and layouts (audio devices) and platforms (pathmap) files.  Other than the script, no file downloads are required.

Update: v3.4 - BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support, see Note F
Update: v3.3 - audio_realtekALC-100.sh (v1.0.3) release
Update: v3.1 - Yosemite/audio_alc_x99-hda-100_patch.command added
Update: v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
	Note: audio_realtekALC-90_v2.command deprecated
Update: v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
Update: v2 - updated script; no downloads, double click and done.

Realtek ALC Patched AppleHDA Kext Method (patch in place)
  A. Patched AppleHDA.kext - ConfigData, layout1, Platforms and HDA binary patch
	1. Native AppleHDA.kext

Realtek ALC Patched AppleHDA Kext - Installation
  A. Patched Realtek ALC AppleHDA.kext
	1. audio_realtekALC-100.command.zip (above)
	2. Download (View Raw)
	3. Double click Downloads/audio_realtekALC-100.command
	4. Password:
	5. Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
	6. Current_v100302 (y/n): (887, 888 only)
	7. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
  B. Verify Patched AppleHDA kext installed
	1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
  C. Restart
  D. Verify ALC onboard audio
	1. System Preferences/Sound/Output/select audio device

Other OS X Realtek ALC Onboard Audio Solutions
  A. https://github.com/toleda/audio_pikeralphaALC
  B. https://github.com/toleda/audio_CloverALC

Requirements
  A. Chameleon/Chimera/Clover 
        1. Optional/Clover, see https://github.com/toleda/audio_CloverALC
  B. OS X
	1. 10.10 or newer
	2. 10.9 or newer
	3. 10.8 or newer
  C. Native AppleHDA.kext  (If not installed, run OS X Installer)
  D. Supported Realtek on board audio codec
  E. Audio ID Injection, see https://github.com/toleda/audio_ALCinjection

Required Information (Select one from each category)
  A. Codec/ALC Support (auto detection)
	1. 269 (BRIX only)
	2. 283 (BRIX Pro and NUC)
	3. 885
	4. 887
	5. 888
	6. 889
	7. 892
	8. 898
	9. 1150 (see Note F)
  B. Layout ID Support (Definitions, Note B)
	1. 269, 283. 885, 887, 888, 889, 892, 898, 1150
	2. 887, 888, 889, 892, 898, 1150
	3. 887, 888, 889, 892, 898

OS X Unsupported Chipsets
  A. 9 Series motherboard support (Mavericks, see Note D)
  B. X99 motherboard support (see Note E)

Notes
  A. HDMI/DP audio may require
	1. dsdt/ssdt edits
	2. framebuffer edits
  B. Layout Definitions (Layout/Audio ID injection installed separately, 
        see https://github.com/toleda/audio_ALCInjection)
	1 - 3/5/6 audio port analog audio
	2 - 3 audio port analog audio
	3 - HD3000/HD4000 HDMI audio and analog audio
  C. Recommendations
	1. Archive Desktop/audio_ALCxxx-10.x.x
	   a. Native: AppleHDA-orig.kext
	   b. Patched: AppleHDA.kext
	2. If audio fails after Software Update
	   a. See Installation above (run script)
	   b. If new patch fails, install working archived patched AppleHDA.kext
  D. OS X/AppleHDA.kext/9 Series motherboard support (Mavericks only, select one)
	1. Download/Install/audio_alc_9series-hda-93_patch.command
	2. ApppleHDAController binary patch:
	   a. Find: 20 8C
	   b. Replace (4x): A0 8C
	   c. Save
	   d. Restart
  E. OS X/AppleHDA.kext/x99 motherboard support (temporary, select one)
	1. Download/Install/audio_alc_x99-hda-100_patch.command
	2. ApppleHDAController binary patch:
	   a. Find: 20 8C
	   b. Replace (4x): 20 8D
	   c. Save
	   d. Restart
  F. BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support
	1. Installation methods
	   a. realtekALC/patch in place
	2. Audio Devices
	   a. ALC269 - BRIX/Headphones and SPDIF out
	   b. ALC283 - BRIX Pro and NUC/Headphones (Microphone is not supported)
	   c. HDMI audio with dsdt edits or ssdt, see
	      i.  HD4600 - https://github.com/toleda/audio_hdmi_8series
	      ii. HD4000 - https://github.com/toleda/audio_hdmi_hd4000

Tools
  A. IOReg (View Raw) - https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip
  B. DPCIManger - http://sourceforge.net/projects/dpcimanager/
  C. audio_codecdetect.command (above) - detects, identifies and installed audio codecs
	2. Download: Select audio_codecdetect.command, Select View Raw
	1. Installation: Double click, Downloads/audio_codecdetect.command
	2. Password:

Problem Reporting (include the following information)
  A. Description of audio problem
	1. OS X version/motherboard model/BIOS version/processor/graphics
	2. Procedure/Guide Used/AppleHDA.kext version
	3. Copy of IOReg - IOReg_v2.1/File/Save a Copy As…, verify file (not
           ioreg.txt)
	4. Installed S/L/E/AppleHDA.kext
	5. AppleHDA(codec).kext (i.e., AppleHDA1150.kext, if installed)
	6. DPCIManager/Misc/Boot Log
	7. Screenshot of System Information/Hardware/Audio/Intel High
           Definition Audio (not Devices)
	8. Console/All Messages/kernel Sound assertions selected/Save
           Selection As…..
	9. Chameleon/Chimera (if installed)
	   a. Extra/org.chameleon.Boot.plist
	   b. Extra/dsdt.aml (if installed)
	   c. Extra/ssdt.aml (if installed)
	10. Clover (if installed)
	   a. EFI/CLOVER/config.plist
	   b. EFI/CLOVER/ACPI/Patched/dsdt.aml (if installed) 
	   c. EFI/CLOVER/ACPI/Patched/ssdt.aml (if installed)
  B. Post to:
	1. http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html
	2. http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/
	3. http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/

Credit
bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a

toleda
https://github.com/toleda/audio_RealtekALC