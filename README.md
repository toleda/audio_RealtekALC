# audio_realtekALC
Realtek ALC Audio - Patched AppleHDA.kext

The Realtek ALC Patched AppleHDA kext enables full onboard, HDMI and DP audio ([Note #1](#1-hdmidp-audio-may-require)).  The script patches the audio codec binary and installs config data (pin configs) and layouts (audio devices) and platforms (pathmap) files.

Other than the script, no file downloads are required.

## Requirements
1. Chameleon/Chimera/Clover 
    * Optional/Clover (see [audio_CloverALC](https://github.com/toleda/audio_CloverALC))
2. OS X
    * 10.10 or newer
    * 10.9 or newer
    * 10.8 or newer
3. Native AppleHDA.kext  *(if not installed, run OS X Installer)*
4. Supported Realtek on board audio codec
5. [Audio ID Injection](https://github.com/toleda/audio_ALCinjection)

### Required Information (Select one from each category)

1. Codec/ALC Support (auto detection)
    1. 885
	2. 887
	3. 888
	4. 889
	5. 892
	6. 898
	7. 1150
2. Layout Support (Definitions: [Note #2](#2-layout-definitions))
    * **`1`** - 885, 887, 888, 889, 892, 898, 1150
    * **`2`** - 887, 888, 889, 892, 898, 1150
    * **`3`** - 887, 888, 889, 892, 898

### Realtek ALC Patched AppleHDA Kext Method
1. Patched AppleHDA.kext - ConfigData, layouts, Platforms and HDA binary patch
	1. Native AppleHDA.kext

## Installation
1. Patch Realtek ALC AppleHDA.kext  (patch in place)
	1. Download and unzip [`audio_realtekALC-100.command.zip`](https://github.com/toleda/audio_RealtekALC/blob/master/audio_realtekALC-100.command.zip?raw=true) to `~/Downloads`
    2. Double click: `~/Downloads/audio_realtekALC-100.command`
    2. Enter password if prompted
	4. Verify Codec? *(885, 887, 888, 889, 892, 898, 1150 only)*
	5. Legacy_v100202 - y/n? *(887, 888 only)*
	6. Enable HD4600 HDMI audio - y/n? *(887, 892, 898, 1150 only)*
2. Restart
3. Verify patched AppleHDA kext has been installed:
    * `/System/Library/Extensions/AppleHDA.kext_vx.x-toledaALCxxx`
4. Verify ALC onboard audio:
    * **System Preferences** > **Sound** > **Output** > *Select audio device*

## Notes

#### 1. HDMI/DP audio may require:
* dsdt/ssdt edits
* framebuffer edits

#### 2. Layout Definitions
###### *Layout/Audio ID injection installed separately (see: [audio_ALCInjection](https://github.com/toleda/audio_ALCInjection))*
* **`1`** - 3/5/6 audio port analog audio
* **`2`** - 3 audio port analog audio
* **`3`** - HD3000/HD4000 HDMI audio and analog audio

#### 3. Recommendations
1. Archive `~/Desktop/audio_ALCxxx-10.x.x`
    * Native: `AppleHDA-orig.kext`
    * Patched: `AppleHDA.kext`
2. If audio fails after Software Update...
    * See [Installation](#installation) section
    * If new patch fails, install working archived patched AppleHDA.kext

#### 4. OS X/AppleHDA.kext/9 Series motherboard support *(Mavericks only, select one)*
1. Download/Install **`audio_alc_9series-hda-93_patch.command`**
2. ApppleHDAController binary patch:
    * Find: **`20 8C`**
    * Replace (4x): **`A0 8C`**
    * Save and Restart

#### 5. OS X/AppleHDA.kext/x99 motherboard support *(temporary, select one)*
1. Download/Install **`audio_alc_x99-hda-100_patch.command`**
2. ApppleHDAController binary patch:
    * Find: **`20 8C`**
    * Replace (4x): **`20 8D`**
    * Save and Restart

## Tools
1. [IOReg](https://github.com/toleda/audio_ALCInjection/blob/master/IORegistryExplorer_v2.1.zip?raw=true)
2. **`audio_codecdetect.command`** (above) - Detects, identifies and reports install audio codecs. To install, double click: `~/Downloads/audio_codecdetect.command`

## Troubleshooting / Problem Reporting

1. Collect **all** of the following information:
    * System Information
        - OS X Version
        - Motherboard Model
        - BIOS Version
        - Processor
        - Graphics
    * Description of audio problem
    * Procedure/guide used
    * `AppleHDA.kext` version
    * `AppleHDA(codec).kext` (i.e. `AppleHDA1150.kext`)
    * Copy of IOReg
        - **IOReg_v2.1** > **File** > **Save a Copy As...** Verify file (not ioreg.txt)
    * `Extra/dsdt.aml` *(if installed)*
    * **Console** > **All Messages** > **Filter:** `Sound assertion` > **Select All** > **Save Selection As...**
    * Screenshot of **System Information** > **Hardware** > **Audio** > **Intel High Definition Audio** *(Not Devices)*
2. Post to:
    * [Mavericks: No Audio - Realtek ALC AppleHDA [Guide]](http://www.tonymacx86.com/audio/112461-mavericks-no-audio-realtek-alc-applehda.html)
    * [Yosemite: Audio - Realtek ALC AppleHDA](http://www.insanelymac.com/forum/topic/298819-yosemite-audio-realtek-alc-applehda/)
    * [Mavericks Realtek ALC AppleHDA Audio](http://www.insanelymac.com/forum/topic/293001-mavericks-realtek-alc-applehda-audio/)

## Sample Terminal Output
```
Last login: Wed Aug  6 16:11:37 on console
 
File: audio_realtekALC-100.command
Verify kext-dev-mode=1 boot flag/argument
Password:
Confirm Realtek ALC1150 (y/n): y
Enable HD4600 HDMI audio (y/n)?: y

Download ALC1150 files ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21163  100 21163    0     0  48910      0 --:--:-- --:--:-- --:--:-- 48875
 
Preparing 10.10 ALC1150 AppleHDA.kext_v265.88
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
```


## Other OS X Realtek ALC Onboard Audio Solutions
- https://github.com/toleda/audio_pikeralphaALC
- https://github.com/toleda/audio_CloverALC

## Release Notes

#### Version 3.1
* Added: **`audio_alc_x99-hda-100_patch.command`** (Yosemite)

#### Version 3
* Support for Yosemite (10.10.x), Mavericks (10.9.x) and Mountain Lion (10.8.x)
* Deprecated: **`audio_realtekALC-90_v2.command`**

#### Version 2.1
* Added: 9 Series/EAPD to 887, 892, 898, 1150 *(credit: kidalive)*
#### Version 2.0
* Updated script: No downloads; double click and done.

## Copyright
[@toleda](https://github.com/toleda) - [toleda/audio_RealtekALC](https://github.com/toleda/audio_RealtekALC)
