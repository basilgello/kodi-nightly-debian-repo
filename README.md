# Kodi from Debian - Nightly Repository

## (2021-07-04) WARNING: 

**Kodi 19.1 and its addons are made available via official Debian buster-backports repository. After the final batch of addons is uploaded, packages targeting buster-backports will be removed from this repo! Users will be presented the migration instruction and script!**

This is the unofficial binary repository of Kodi from Debian 19.0 "Matrix" targeting Debian 10 "buster".

Supported architectures for now include only amd64 and i386 (32-bit and 64-bit x86 CPUs, like Intel or AMD)

**(2020-07-18) WARNING: I made a mistake versioning Kodi packages as 19.0+git... that will result in inability to update when official Kodi 19.0 is out. The correct packages are versioned as 19.0~git... now. Please delete Kodi from local installation with "apt --purge autoremove kodi" and reinstall it back to get further updates!**

**(2020-07-22) WARNING: As Kodi build dependencies roll into buster-backports, it becomes mandatory to add buster-backports to the APT sources list. Please refer to 'Installation' paragraph for instructions.**

**(2020-10-25) INFO: I added Debian i386 builds**

## Motivation

The official Team Kodi's nightly PPA targets only Ubuntu distributions. Debian ships its own 'Kodi from Debian' flavor with following changes:

 * Only system libraries are used (no embedded third-party libraries except of libdvdread and libdvdnav)
 * Old web interface (Chorus) is shipped to ensure Debian Free Software Guides (DFSG) compatibility

With deprecation of Python 2 in favor of Python 3, Kodi 18.x will be eventually removed from unstable and testing Debian distributions.
This repository was created to prepare and test the upcoming "Matrix" release for inclusion into Debian main repository after Kodi gets an official release.

## Installation

The installation is straghtforward for those familiar with Debian APT package manager:

 * Install Vasyl Gello's signing key:

```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
curl 'https://basilgello.github.io/kodi-nightly-debian-repo/repository-key.asc' | sudo apt-key add -
``` 

 * Add 'buster-backports' repositories to APT configuration:

```
if ! apt policy 2>/dev/null | grep -v "basilgello" | grep -q "https://.*buster-backports"; then echo "deb http://deb.debian.org/debian/ buster-backports main contrib" | sudo tee /etc/apt/sources.list.d/buster-backports.list; fi
```

 * Add the repository to APT configuration:

```
echo "deb https://basilgello.github.io/kodi-nightly-debian-repo buster-backports main" | sudo tee /etc/apt/sources.list.d/kodi-nightly-debian-repo.list
```

 * Pin Kodi to the unofficial repository to ensure automatic updates:

```
echo 'Package: *' | sudo tee /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo 'Pin: release l=kodi-nightly-debian-repo' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo 'Pin-Priority: 1' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo '' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo 'Package: kodi*' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo 'Pin: release l=kodi-nightly-debian-repo' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
echo 'Pin-Priority: 500' | sudo tee -a /etc/apt/preferences.d/01kodi-nightly-debian-repo
```

 * Update the package lists and install Kodi:

```
sudo apt-get update
sudo apt-get install --install-recommends {kodi,kodi-bin,kodi-data,kodi-repository-kodi,libspdlog1}/buster-backports
```

## What is Included

Here is the table of repository contents. New add-ons are gradually added to the table once they are pushed to the repository.

### Kodi

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi)|Yes||

### Kodi Audio Decoder binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-audiodecoder-fluidsynth](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audiodecoder-fluidsynth)|Yes||
|[kodi-audiodecoder-openmpt](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audiodecoder-openmpt)|Yes||
|[kodi-audiodecoder-sidplay](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audiodecoder-sidplay)|Yes||

### Kodi Audio Encoder binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-audioencoder-flac](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audioencoder-flac)|Yes||
|[kodi-audioencoder-lame](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audioencoder-lame)|Yes||
|[kodi-audioencoder-vorbis](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audioencoder-vorbis)|Yes||
|[kodi-audioencoder-wav](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-audioencoder-wav)|Yes||

### Kodi Image Decoder binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-imagedecoder-heif](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-imagedecoder-heif)|Yes||
|[kodi-imagedecoder-raw](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-imagedecoder-raw)|Yes||

### Kodi Input Stream binary add-ons:

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-inputstream-adaptive](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-inputstream-adaptive)|Yes||
|[kodi-inputstream-ffmpegdirect](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-inputstream-ffmpegdirect)|Yes||
|[kodi-inputstream-rtmp](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-inputstream-rtmp)|Yes||

### Kodi Peripheral Controller binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-peripheral-joystick](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-peripheral-joystick)|Yes||
|[kodi-peripheral-xarcade](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-peripheral-xarcade)|Yes||

### Kodi PVR binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-pvr-argustv](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-argustv)|Yes||
|[kodi-pvr-dvblink](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-dvblink)|Yes||
|[kodi-pvr-dvbviewer](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-dvbviewer)|Yes||
|[kodi-pvr-filmon](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-filmon)|Yes||
|[kodi-pvr-hdhomerun](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-hdhomerun)|Yes||
|[kodi-pvr-hts](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-hts)|Yes||
|[kodi-pvr-iptvsimple](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-iptvsimple)|Yes||
|[kodi-pvr-mediaportal-tvserver](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-mediaportal-tvserver)|Yes||
|[kodi-pvr-mythtv](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-mythtv)|Yes||
|[kodi-pvr-nextpvr](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-nextpvr)|Yes||
|[kodi-pvr-njoy](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-njoy)|Yes||
|[kodi-pvr-octonet](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-octonet)|Yes||
|[kodi-pvr-pctv](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-pctv)|Yes||
|[kodi-pvr-sledovanitv-cz](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-sledovanitv-cz)|Yes||
|[kodi-pvr-stalker](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-stalker)|Yes||
|[kodi-pvr-teleboy](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-teleboy)|Yes||
|[kodi-pvr-vbox](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-vbox)|Yes||
|[kodi-pvr-vdr-vnsi](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-vdr-vnsi)|Yes||
|[kodi-pvr-vuplus](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-vuplus)|Yes||
|[kodi-pvr-waipu](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-waipu)|Yes||
|[kodi-pvr-wmc](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-wmc)|Yes||
|[kodi-pvr-zattoo](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-pvr-zattoo)|Yes||

### Kodi Screen Saver binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-screensaver-asteroids](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-asteroids)|Yes||
|[kodi-screensaver-biogenesis](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-biogenesis)|Yes||
|[kodi-screensaver-greynetic](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-greynetic)|Yes||
|[kodi-screensaver-pingpong](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-pingpong)|Yes||
|[kodi-screensaver-pyro](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-pyro)|Yes||
|[kodi-screensaver-shadertoy](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-screensaver-shadertoy)|Yes||

### Kodi Virtual File System (VFS) binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-vfs-libarchive](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-vfs-libarchive)|Yes||
|[kodi-vfs-sftp](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-vfs-sftp)|Yes||

### Kodi Visualization binary add-ons

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[kodi-visualization-fishbmc](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-visualization-fishbmc)|Yes||
|[kodi-visualization-pictureit](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-visualization-pictureit)|Yes||
|[kodi-visualization-shadertoy](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-visualization-shadertoy)|Yes||
|[kodi-visualization-spectrum](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-visualization-spectrum)|Yes||
|[kodi-visualization-waveform](https://salsa.debian.org/multimedia-team/kodi-media-center/kodi-visualization-waveform)|Yes||

### Kodi build dependencies

| Source Package Name | Included | Remark |
|:-------------------:|:--------:|--------|
|[dav1d](https://salsa.debian.org/multimedia-team/dav1d)|**Removed**|The package has been backported to buster|
|[ffmpeg](https://salsa.debian.org/multimedia-team/ffmpeg)|Yes||
|[flatbuffers](https://salsa.debian.org/debian/flatbuffers)|Yes||
|fmtlib|**Removed**|The package has been backported to buster|
|[googletest](https://salsa.debian.org/debian/googletest)|Yes||
|[intel-mediasdk](https://salsa.debian.org/debian/intel-mediasdk)|Yes||
|[kissfft](https://salsa.debian.org/multimedia-team/kissfft)|Yes||
|[kodiplatform](https://salsa.debian.org/multimedia-team/kodiplatform)|**Removed**|The package is deprecated upstream|
|[libcdio](https://salsa.debian.org/debian/libcdio)|Yes||
|[libhdhomerun](https://salsa.debian.org/debian/libhdhomerun)|Yes||
|[libmysofa](https://salsa.debian.org/multimedia-team/libmysofa)|Yes||
|[libudfread](https://salsa.debian.org/multimedia-team/libudfread)|**Removed**|The package has been backported to buster|
|[libva](https://salsa.debian.org/multimedia-team/libva)|Yes||
|[libwebm](https://salsa.debian.org/multimedia-team/libwebm)|Yes||
|[pocketsphinx](https://salsa.debian.org/a11y-team/pocketsphinx)|Yes||
|[shairplay](https://salsa.debian.org/multimedia-team/shairplay)|**Removed**|The package has been backported to buster|
|[spdlog](https://salsa.debian.org/med-team/spdlog)|**Removed**|The package has been backported to buster|
|[srt](https://salsa.debian.org/debian/libsrt)|Yes||
|[waylandpp](https://salsa.debian.org/rbalint/waylandpp)|Yes||

## Contact

This repository is maintained by Vasyl Gello <vasek.gello@gmail.com>.
