![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio_realtekALC
##OS X Realtek ALC AppleHDA Onboard Audio Solutions

##Details/Contents

**I.   Onboard Audio Solutions**

**II.  Requirements - Supported/Unsupported**

**III. Notes**

**IV.  Guides**

**V.   Tools**

**VI.  Problem Reporting**

###I.   OS X Realtek ALC AppleHDA Installation Methods


[**A. Clover Patched AppleHDA Method**](https://github.com/toleda/audio_CloverALC)   
Credit: abxite

1.  Native AppleHDA.kext
    1.  renamed layouts/devices and platforms/pathmaps installed (.zml, persistent)
2.  Clover/patch kernel cache on boot
    1.  KernelAndKextPatches/KextsToPatch/AppleHDA (2 patches, persistent)
    2.  EFI/CLOVER/kexts/10.xx/realtekALC.kext (configdata/pins, persistent)
3.  Clover/Devices/Audio/Inject/Audio ID (persistent)

[**B. Clover Patched Piker-Alpha AppleHDA8series**](https://github.com/toleda/audio_CloverALC)  
Credit: Piker-Alpha
    
1.  Native AppleHDA.kext
2.  AppleHDAxxx.kext (codec specific support)
    1.  binary patch (device_id, hex edit)
    2.  layouts/devices and platforms/pathmaps installed (.xml)
    3.  configdata/pins installed (Info.plist)
2.  Clover/Devices/Audio/Inject/Audio ID (persistent)

[**C. Realtek ALC Patched AppleHDA Method**](https://github.com/toleda/audio_RealtekALC)  
Credit: THe KiNG

1.  Native AppleHDA.kext
    1.  binary patch (device_id, hex edit)
    2.  layouts/devices and platforms/pathmaps installed (remove native .xml)
    3.  configdata/pins installed (replace Info.plist)
2.  Audio ID Injection required
    1.  [audio_ALCInjection](https://github.com/toleda/audio_ALCInjection)

[**D. Piker-Alpha AppleHDA8series**](https://github.com/toleda/audio_pikeralphaALC)  
Credit: Piker-Alpha  
Note: Yosemite Only
    
1.  Native AppleHDA.kext
2.  AppleHDAxxx.kext (codec specific support)
    1.  binary patch (device_id, hex edit)
    2.  layouts/devices and platforms/pathmaps installed (.xml)
    3.  configdata/pins installed (Info.plist)
2.  Audio ID Injection required
    1.  [audio_ALCInjection](https://github.com/toleda/audio_ALCInjection)

###II.  Requirements - Supported/Unsupported

**A. OS X Requirements**

1.  OS X Versions
    1.  10.11/El Capitan
    2.  10.10/Yosemite
    3.  10.9/Mavericks
    4.  10.8/Mountain Lion
2.  Native AppleHDA.kext
    1.  [Need native?](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
3.  Supported Realtek onboard audio codec
    1.  [Unknown codec?](https://github.com/toleda/audio_ALC_guides/blob/master/Identify%20Audio%20Codec%20%5BGuide%5D.pdf)

**B. Realtek ALCxxx** (verify codec and Audio ID)

1.  Supported codecs
    1.  269 (BRIX only, Note 4, NA - Piker-Alpha)
    2.  283 (BRIX Pro and NUC, Note 4, NA - Piker-Alpha)
    3.  885
    4.  887
    5.  888
    6.  889
    7.  892
    8.  898
    9.  1150

2.  Supported Audio IDs

    -  Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150

        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    -  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150

        Realtek ALC/5.1 surround sound (3 motherboard audio ports)

    -  Audio ID: 3 supports 887, 888, 889, 892, 898

        HD3000/HD4000 HDMI audio with Realtek ALC audio

**C. OS X - Unsupported Intel High Definition Audio**

1.  100 Series motherboard support (Note 2)
2.  X99 motherboard support (Note 3)

###III. Notes

1.  Backup working AppleHDA.kext

    1.  After Software Update
        1.  Verify audio
        1.  If working, Backup System/Library/Extensions/AppleHDA.kext 
    2.  If audio fails after Software Update
        1.  Run script (same method, same script)
        2.  Install Previous working AppleHDA.kext (backup, above)

2.  100 Series/Intel High Definition Audio (workaround requires 1, 2, 3, 4 and 5)

	1.	Rename dsdt/HDAS to HDEF
		1. [Clover/config-audio_cloverALC-100series.plist](https://github.com/toleda/audio_CloverALC/blob/master/config-audio_cloverALC-100series.plist.zip)
			1. Add config.plist/ACPI/DSDT/Patches/Rename HDAS to HDEF
	2. sdt injection (any bootloader, select Audio ID and install)
		1. [Audio ID: 1, ssdt_hdef-1-100-hdas](https://github.com/toleda/audio_ALCInjection/blob/master/ssdt_hdef/ssdt_hdef-1-100-hdas.zip)
		2. [Audio ID: 2, ssdt_hdef-2-100-hdas](https://github.com/toleda/audio_ALCInjection/blob/master/ssdt_hdef/ssdt_hdef-2-100-hdas.zip)
		3. [Audio ID: 3, ssdt_hdef-3-100-hdas](https://github.com/toleda/audio_ALCInjection/blob/master/ssdt_hdef/ssdt_hdef-3-100-hdas.zip)
	3. Restart
	4. Install Realtek ALC Audio
		1. see Realtek ALC Installation Methods, above
	5. Restart
	
3.  X99/Intel High Definition Audio  (workaround requires 1, 2, 3, 4 and 5)

    1.  Rename dsdt/ALSA to HDEF (select one method)
    	1. [Clover/config-audio_cloverALC-x99.plist.](https://github.com/toleda/audio_CloverALC/blob/master/config-audio_cloverALC-x99.plist.zip)
    		1. Add config.plist/ACPI/DSDT/Patches/Rename ALZA to HDEF
		2. ssdt injection (any bootloader)
			1. [Audio ID: 1, ssdt_hdef-1-x99-alza](https://github.com/toleda/audio_ALCInjection/blob/master/ssdt_hdef/ssdt_hdef-1-x99-alza.zip)

	2. Restart
	3. Install Realtek ALC Audio
		1. see Realtek ALC Installation Methods, above
	4. Add x99 HD Audio device_id (Select one method)
		1. Clover/config-audio_cloverALC-x99.plist above, select one, appropriate version)
			1. Add config.plist/KernelAndKextPatches/KextsToPatch/10.10-10.11+x99-ALC-Onboard-Audio
			2. Add config.plist/KernelAndKextPatches/KextsToPatch/110.9.4-10.9.5-x99-ALC-Onboard-Audio
		2. Patched AppleHDA.kext (RealtekALC, MultiBeast 7 and earlier)
			1. [audio_alc_x99-hda-100_patch.command](https://github.com/toleda/audio_RealtekALC/blob/master/audio_alc_x99-hda-100_patch.command.zip)
	5. Restart
	6. [Credit: bOLEMO, post #196](http://www.insanelymac.com/forum/topic/308387-el-capitan-realtek-alc-applehda-audio/page-10)

4.  BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support

    1.  Installation methods
        1.  cloverALC/Clover patched
    2.  Audio Devices
        1.  ALC269 - BRIX/Headphones and SPDIF out
        2.  ALC283 - BRIX Pro and NUC/Headphones (Microphone is not supported)
        3.  HDMI audio with dsdt edits or ssdt, see
            1.  [HD4600](https://github.com/toleda/audio_hdmi_8series)
            2.  [HD4000](https://github.com/toleda/audio_hdmi_hd4000)

###IV. More Information

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
		2. Restore native AppleHDA9.  Surround Sound - Realtek ALC -  AppleHDA [Guide]

###V.   Tools

1.  [Clover Configurator](http://www.osx86.net/files/file/49-clover-configurator/)

2.  [Clover Wiki](http://clover-wiki.zetam.org/Home)

3.  [IOReg (Download/select View Raw)](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip)

4.  [DPCIManger](http://sourceforge.net/projects/dpcimanager/)

5.  Property List Editors
    1.  App Store/Xcode
    2.  Property List Editor
    3.  PlistEdit Pro
    4.  Applications/TextEdit
    5.  etc.

###VI.  [Problem Reporting](https://github.com/toleda/audio_ALC_guides/blob/master/Problem%20Reporting.md)

1.	Problem Reporting/Post to
2.	Problem Reporting/Attached requested files

Credit:
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)

toleda
https://github.com/toleda/audio_RealtekALC