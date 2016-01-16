![alt text](https://github.com/toleda/audio_RealtekALC/blob/master/sound.jpeg)
#audio_realtekALC
**OS X/Patch in Place AppleHDA Realtek ALC Audio**  
Native AppleHDA

The Realtek Realtek ALC Patched method enables OS X AppleHDA onboard with or without HDMI and DP audio.  The script patches the audio codec binary and installs pin configuration, layouts and platforms files.

**Updates**

1. 11/8/15 - Skylake/Series 100 Update, Add 1150/Audio ID: 3
2. 6/15/15 - 10.11 - El Capitan Realtek ALC AppleHDA.kext Initial Support

**Versions: audio_realtekALC-110**

1. Easy: .command, see A. Installation
2. Bash: .sh, see B. Terminal

**A. Installation**

1. Patched AppleHDA.kext
    1. [audio_realtekALC-110.command](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-110.command.zip) (select View Raw)
    2. Double click Downloads/audio_realtekALC-110.command
    3. Password:
    4. Confirm Codec ALCxxx: (885, 887, 888, 889, 892, 898, 1150 only)
    5. Enable HD4600 HDMI audio (y/n): (887, 892, 898, 1150 only)
2. Verify Patched AppleHDA kext installed
    1. S/L/E/AppleHDA.kext_vx.x-toledaALCxxx
3. Restart
4. Verify ALC onboard audio
    1. System Preferences/Sound/Output/select audio device

**B. Terminal**

1. Clover patched AppleHDA
    1. [audio_realtekALC-110.sh](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-110.sh) (select View Raw)
    2. Terminal $ ./audio_cloverALC-110....sh
    3. Same (as above)

**C. Requirements**

1.  OS X/Chameleon/Chimera/Clover
    1.  10.11/El Capitan, set boot flag: rootless=0 
    2.  10.10/Yosemite, set boot flag: kext-dev-mode=1
    3.  10.9/Mavericks
    4.  10.8/Mountain Lion
2.  Native AppleHDA.kext
    1.  [Need native?](https://github.com/toleda/audio_ALC_guides/blob/master/Restore%20native%20AppleHDA%20%5BGuide%5D.pdf)
3.  Supported Realtek onboard audio codec
    1.  [Unknown codec?](https://github.com/toleda/audio_ALC_guides/blob/master/Identify%20Audio%20Codec%20%5BGuide%5D.pdf)

**D. Realtek ALCxxx** (verify codec and Audio ID)

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
    -  Audio ID: 1 supports 269, 283, 885, 887, 888, 889, 892, 898, 1150  
        Realtek ALC audio (default, 1/2/3/5/6 motherboard audio ports)

    -  Audio ID: 2 supports 887, 888, 889, 892, 898, 1150   
        Realtek ALC/5.1 surround sound (3 motherboard audio ports) 

    -  Audio ID: 3 supports 887, 888, 889, 892, 898, 1150  
        HD3000/HD4000 HDMI audio with Realtek ALC audio

**E. More Information**

1. [Audio ID Injection](https://github.com/toleda/audio_ALCInjection)
2. [Details](https://github.com/toleda/audio_RealtekALC/blob/master/DETAILS.md)
    1.  Realtek ALC Audio Solutions
    2.  Requirements - Supported/Unsupported
    3.  Notes
    4.  Guides
    5.  Tools
    6.  Problem Reporting
3. [Terminal Saved Output](https://github.com/toleda/audio_RealtekALC/blob/master/Terminal%20Saved%20Output_v1.0.4)

Credit
THe KiNG, bcc9, RevoGirl, PikeRAlpha, SJ_UnderWater, RehabMan, TimeWalker75a, lisai9093

toleda
https://github.com/toleda/audio_realtekALC