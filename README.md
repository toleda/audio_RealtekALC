![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio_realtekALC
**OS X/Patched AppleHDA Realtek ALC Audio**

The Realtek Realtek ALC Patched method enables OS X AppleHDA onboard with or without HDMI and DP audio.  The script patches the audio codec binary and installs pin configuration, layouts and platforms files.

**Versions: audio_realtekALC-100**

1. Easy/.command, see C. Installation
2. Bash/.sh, see D. Terminal

**Updates**

1.  v3.6 - audio_realtekALC-100.command_v1.0.4 release
2.  v3.5 - Realtek ALC AppleHDA - [No Audio After Sleep/Wake](https://github.com/toleda/audio_RealtekALC)
3.  v3.4 - BRIX/ALC269, BRIX Pro/ALC283 and NUC/ALC283 Support
4.  v3.3 - audio_realtekALC-100.sh (v1.0.3) release
5.  v3.2 - audio_realtekALC-100.command: UI update, ALC88x Current replaces ALC88x Legacy
6.  v3.1 - Yosemite/audio_alc_x99-hda-100.command patch added
7.  v3 - Yosemite/10.10.x, Mavericks/10.9.x and Mountain Lion/10.8.x support
    Note: audio\realtekALC-90_v2.command deprecated
8.  v2.2 - x99 motherboard support (D. More Information)
9.  v2.1 - 9 Series/EAPD added to 887, 892, 898, 1150, credit: kidalive
10. v2 - new script, no downloads, double click and done.
11. 10.10 - Yosemite Initial Realtek ALC support Update
12. 10.9 - 9 Series/Realtek ALC support, audio_alc_9series-hda-93.command added

**A. Requirements**

1.  OS X/Chameleon/Chimera/Clover
    1.  10.10/Yosemite
    2.  10.9/Mavericks
    3.  10.8/Mountain Lion
2.  Native AppleHDA.kext
3.  Supported Realtek onboard audio codec

**B. Realtek ALCxxx** (verify codec and Audio ID)

1.  Supported codecs
    1.  269 (BRIX only)
    2.  283 (BRIX Pro and NUC)
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

**C. Installation**

1. Patched AppleHDA.kext
    1. [Download (View Raw) audio\_realtekALC-100.command](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-100.command.zip)
    2. Double click Downloads/audio_realtekALC-100.command
    3. Password:
    4. Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
    5. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
2. Verify Patched AppleHDA kext installed
    1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
3. Restart
4. Verify ALC onboard audio
    1. System Preferences/Sound/Output/select audio device

**Terminal**

1. [v1.0.4](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-100.sh): 887/888 legacy detection, bug fixes
2. v1.0.3: First release

**E. More Information**

1. https://github.com/toleda/audio_RealtekALC/blob/master/DETAILS.md
    1.  Realtek ALC Audio Solutions
    2.  Requirements - Supported/Unsupported
    3.  Notes
    4.  Guides
    5.  Tools
    6.  Problem Reporting
2. [Terminal Saved Output](https://github.com/toleda/audio_RealtekALC/blob/master/Terminal%20Saved%20Output.txt_v1.0.4

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a

toleda
https://github.com/toleda/audio_RealtekALC