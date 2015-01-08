![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)

##audio\_realtekALC
##S X Realtek ALC AppleHDA Onboard Audio Solutions**

##Details/Contents

**I.   Onboard Audio Solutions**
**II.  Requirements - Supported/Unsupported**
**III. Notes**
**IV.  Guides**
**V.   Tools**
**VI.  Problem Reporting**

###I.   OS X Realtek ALC AppleHDA Onboard Audio Solutions
[**A. Realtek ALC Patched AppleHDA Method**](https://github.com/toleda/audio_RealtekALC)  Credit: THe KiNG

1.  Native AppleHDA.kext
    1.  binary patch (device_id, hex edit)
    2.  layouts/devices and platforms/pathmaps installed (remove native .xml)
    3.  configdata/pins installed (replace Info.plist)
2.  Audio ID Injection required
    1.  [audio_ALCInjection](https://github.com/toleda/audio_ALCInjection)

[**B. Piker-Alpha AppleHDA8series**](https://github.com/toleda/audio_pikeralphaALC)  Credit: Piker-Alpha
    
1.  Native AppleHDA.kext
2.  AppleHDAxxx.kext (codec specific support)
    1.  binary patch (device_id, hex edit)
    2.  layouts/devices and platforms/pathmaps installed (.xml)
    3.  configdata/pins installed (Info.plist)
2.  Audio ID Injection required
    1.  [audio_ALCInjection](https://github.com/toleda/audio_ALCInjection)

[**C. Clover Patched AppleHDA Method**](https://github.com/toleda/audio_CloverALC) Credit: abxite

1.  Native AppleHDA.kext
    1.  renamed layouts/devices and platforms/pathmaps installed (.zml, persistent)
2.  Clover/patch kernel cache on boot
    1.  KernelAndKextPatches/KextsToPatch/AppleHDA (2 patches, persistent)
    2.  EFI/CLOVER/kexts/10.xx/realtekALC.kext (configdata/pins, persistent)
3.  Clover/Devices/Audio/Inject/Audio ID (persistent)

###II.  Requirements - Supported/Unsupported

**A. OS X Requirements**

1.  OS X/Clover_v2696 or newer
    1.  10.10/Yosemite
    2.  10.9/Mavericks
    3.  10.8/Mountain Lion
2.  Native AppleHDA.kext
3.  Supported Realtek onboard audio codec

**B. Realtek ALCxxxn** (verify codec and Audio ID)

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

    1.  Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150
        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    2.  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150
        Realtek ALC/5.1 surround sound (3 motherboard audio ports)

    3.  Audio ID: 3 supports 887, 888, 889, 892, 898
        HD3000/HD4000 HDMI audio with Realtek ALC audio

**C. OS X Unsupported Intel Chipsets**

1.  9 Series motherboard support (Mavericks only, Note 2)
2.  X99 motherboard support (Note 3)

###III. Notes

1.  Backup working AppleHDA.kext

    1.  After Software Update
        1.  Verify audio
        1.  If working, Backup System/Library/Extensions/AppleHDA.kext 
    2.  If audio fails after Software Update
        1.  Run script (same method, same script)
        2.  Install Previous working AppleHDA.kext (backup, above)

2.  OS X/AppleHDA.kext/9 Series motherboard support (Mavericks only, select 1, 2 or 3)

    1.  AppleHDAController binary patch:
        1.  Find: 20 8C
        2.  Replace (4x): A0 8C
        3.  Save
        4.  Restart
    2. [alc_9series-hda-93](https://github.com/toleda/audio_RealtekALC/blob/master/audio_alc_9series-hda-93_patch.command.zip)
    	1.  Download/View Raw
    	2.  Double click Downloads/audio_alc_9series-hda-93_patch.command
    3. [cloverALC-9series](https://github.com/toleda/audio_CloverALC/blob/master/config-audio_cloverALC-9series.plist.zip)
    	1.  Install/config.plist/KernelAndKextPatches/KextsToPatch/

3.  OS X/AppleHDA.kext/x99 motherboard support (temporary, select 1, 2 or 3)
    1.  AppleHDAController binary patch:
        1.  Find: 20 8C
        2.  Replace (4x): 20 8D
        3.  Save
        4.  Restart
    2. [alc_x99-hda-100](https://github.com/toleda/audio_RealtekALC/blob/master/audio_alc_x99-hda-100_patch.command.zip)
    	1.  Download/View Raw
    	2.  Double click Downloads/audio_alc_x99-hda-100_patch.command
    3. [cloverALC-x99](https://github.com/toleda/audio_CloverALC/blob/master/config-audio_cloverALC-x99.plist.zip)
    	1.  Install/config.plist/KernelAndKextPatches/KextsToPatch/

4.  BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support

    1.  Installation methods
        1.  cloverALC/Clover patched
    2.  Audio Devices
        1.  ALC269 - BRIX/Headphones and SPDIF out
        2.  ALC283 - BRIX Pro and NUC/Headphones (Microphone is not supported)
        3.  HDMI audio with dsdt edits or ssdt, see

            1.  [HD4600](https://github.com/toleda/audio_hdmi_8series)

            2.  [HD4000](https://github.com/toleda/audio_hdmi_hd4000)

###IV. [Realtek ALC AppleHDA Guides](https://github.com/toleda/audio_ALC_guides)
1.  Capabilities - Realtek ALC AppleHDA_v2 [Guide]
2.  Customization - Realtek ALC AppleHDA_v2 [Guide]
3.  No Audio After Sleep/Wake - Realtek ALC AppleHDA [Fixes]
4.  No Audio Devices - Realtek ALC AppleHDA [Guide]
5.  No Sound - Realtek ALC AppleHDA [Guide]
6.  Screenshots - Realtek ALC AppleHDA_v2
7.  Surround Sound - Realtek ALC -  AppleHDA [Guide]

###V.   Tools

1.  [Clover Configurator](http://www.osx86.net/files/file/49-clover-configurator/)

2.  [Clover Wiki](http://clover-wiki.zetam.org/Home)

3.  [IOReg (Download/select View Raw)](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip)

4.  [DPCIManger](http://sourceforge.net/projects/dpcimanager/)

5.  Property List Editors
    1.  Xcode
    2.  Property List Editor
    3.  PlistEdit Pro
    4.  TextEdit
    5.  etc.

###VI.  Problem Reporting

1.  Description of onboard audio problem (attach the following information)

    1.  OS X version/motherboard model/BIOS version/processor/graphics
    2.  Procedure/Guide Used
    3.  Copy of IOReg - IOReg/File/Save a Copy As. . ., verify file (no ioreg.txt)
    4.  Installed System/Library/Extensions/AppleHDA.kext
    5.  Installed System/Library/Extensions/AppleHDAxxx.kext (if Piker-Alpha)
    6.  DPCIManager/Misc/Boot Log
    7.  Screenshot of System Information/Hardware/Audio/Intel High Definition
        Audio (not Devices)
    8.  Console/All Messages/kernel Sound assertions selected/Save Selection
        As. . .
    9.  Chameleon/Chimera
        1.  Extra/org.chameleon.Boot.plist
        2.  Extra/dsdt.aml (if installed)
        3.  Extra/ssdt.aml (if installed)
    10. Clover/EFI or Legacy 
        1.  EFI/CLOVER/config.plist
        2.  EFI/CLOVER/ACPI/Patched/dsdt.aml (if installed)
        3.  EFI/CLOVER/ACPI/Patched/ssdt.aml (if installed)

2.  Post to:
    1.  [tonymacx86 - Realtek ALC AppleHDA](http://www.tonymacx86.com/audio/143752-no-audio-devices-realtek-alc-applehda-guide.html#post886726)
    2.  [InsanelyMac - Realtek ALC AppleHDA](http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/)

Credit:
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ\_UnderWater, RehabMan, TimeWalker75a, [abxite](http://applelife.ru/threads/patchim-applehda-s-pomoschju-zagruzchika.39406/#post-353647)
