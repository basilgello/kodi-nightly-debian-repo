#!/bin/sh

set -e
export LC_ALL=C

# Decide which packages should be reinstalled

KODI_DBGSYMS=$(dpkg -l | awk '/kodi.*-dbgsym/{print $2}')
KODI_PACKAGES=$(dpkg -l | awk '/kodi/{print $2}' | grep -v dbgsym)
NON_KODI_DBGSYMS=$(dpkg -l \
	ffmpeg-dbgsym \
	flatbuffers-compiler-dbgsym \
	gstreamer1.0-pocketsphinx-dbgsym \
	kissfft-tools-dbgsym \
	libavcodec58-dbgsym \
	libavcodec-extra58-dbgsym \
	libavdevice58-dbgsym \
	libavfilter7-dbgsym \
	libavfilter-extra7-dbgsym \
	libavformat58-dbgsym \
	libavresample4-dbgsym \
	libavutil56-dbgsym \
	libcdio19-dbgsym \
	libcdio++1-dbgsym \
	libcdio-utils-dbgsym \
	libdav1d4-dbgsym \
	libdc1394-25-dbgsym \
	libdc1394-utils-dbgsym \
	libflatbuffers1-dbgsym \
	libiso9660++0-dbgsym \
	libiso9660-11-dbgsym \
	libkissfft-float131-dbgsym \
	libldap-2.4-2-dbgsym \
	libmfx1-dbgsym \
	libmfx-tools-dbgsym \
	libmysofa1-dbgsym \
	libmysofa-utils-dbgsym \
	libpocketsphinx3-dbgsym \
	libpostproc55-dbgsym \
	libshairplay0-dbgsym \
	libspdlog1-dbgsym \
	libsrt1-gnutls-dbgsym \
	libsrt1-openssl-dbgsym \
	libswresample3-dbgsym \
	libswscale5-dbgsym \
	libudf0-dbgsym \
	libudfread0-dbgsym \
	libva2-dbgsym \
	libva-drm2-dbgsym \
	libva-glx2-dbgsym \
	libva-wayland2-dbgsym \
	libva-x11-2-dbgsym \
	libwayland-client++0-dbgsym \
	libwayland-client-extra++0-dbgsym \
	libwayland-cursor++0-dbgsym \
	libwayland-egl++0-dbgsym \
	libwebm1-dbgsym \
	libwebm-tools-dbgsym \
	pocketsphinx-dbgsym \
	srt-tools-dbgsym \
	wayland-scanner++-dbgsym \
	2>/dev/null | awk '/dbgsym/{print $2}')
NON_KODI_PACKAGES_BUSTER_BACKPORTS=$(dpkg -l \
	dav1d \
	flatbuffers-compiler \
	flatbuffers-compiler-dev \
	google-mock \
	googletest \
	googletest-tools \
	hdhomerun-config \
	kissfft-tools \
	libcdio++1 \
	libcdio19 \
	libcdio++-dev \
	libcdio-dev \
	libcdio-utils \
	libdav1d-dev \
	libdav1d4 \
	libfmt-dev \
	libfmt-doc \
	libflatbuffers1 \
	libflatbuffers-dev \
	libgmock-dev \
	libgtest-dev \
	libhdhomerun-dev \
	libhdhomerun4 \
	libiso9660++0 \
	libiso9660-11 \
	libiso9660-dev \
	libiso9660++-dev \
	libkissfft-dev \
	libkissfft-float131 \
	libshairplay-dev \
	libshairplay0 \
	libspdlog-dev \
	libspdlog1 \
	libudf0 \
	libudf-dev \
	libudfread-dev \
	libudfread0 \
	libwayland-client++0 \
	libwayland-client-extra++0 \
	libwayland-cursor++0 \
	libwayland-egl++0 \
	libwebm1 \
	libwebm-dev \
	libwebm-tools \
	python3-flatbuffers \
	shairplay \
	waylandpp-dev \
	wayland-scanner++ \
	2>/dev/null | awk '/^ii /{print $2"/buster-backports"}')
NON_KODI_PACKAGES_BUSTER=$(dpkg -l \
	ffmpeg \
	ffmpeg-doc \
	libavcodec58 \
	libavcodec-dev \
	libavcodec-extra \
	libavcodec-extra58 \
	libavdevice58 \
	libavdevice-dev \
	libavfilter7 \
	libavfilter-dev \
	libavfilter-extra \
	libavfilter-extra7 \
	libavformat58 \
	libavformat-dev \
	libavresample4 \
	libavresample-dev \
	libavutil56 \
	libavutil-dev \
	libpostproc55 \
	libpostproc-dev \
	libswresample3 \
	libswresample-dev \
	libswscale5 \
	libswscale-dev \
	libva2 \
	libva-dev \
	libva-drm2 \
	libva-glx2 \
	libva-wayland2 \
	libva-x11-2 \
	va-driver-all \
	2>/dev/null | awk '/^ii /{print $2"/buster"}')
SYSTEM_PACKAGES_BUSTER=$(dpkg -l \
	dirmngr \
	gnupg \
	gnupg-l10n \
	gnupg-utils \
	gpg \
	gpgconf \
	gpgsm \
	gpgv \
	gpg-agent \
	gpg-wks-client \
	gpg-wks-server \
	libbluetooth3 \
	libcryptsetup12 \
	libcurl3-gnutls \
	libdrm2 \
	libdrm-amdgpu1 \
	libdrm-common \
	libdrm-intel1 \
	libdrm-nouveau2 \
	libdrm-radeon1 \
	libegl1 \
	libgl1 \
	libglvnd0 \
	libglx0 \
	libjs-jquery \
	libldap-2.4-2 \
	libldap-common \
	libnss-systemd \
	libpam-systemd \
	libpulse0 \
	libpulse-mainloop-glib0 \
	libsystemd0 \
	libudev1 \
	libzstd1 \
	node-jquery \
	pulseaudio \
	systemd \
	systemd-sysv \
	systemd-timesyncd \
	udev \
	2>/dev/null | awk '/^ii .*~bpo10\+/{print $2"/buster"}')

# Delete old APT preferences
rm -f /etc/apt/sources.list.d/kodi-nightly-debian-repo.list
rm -f /etc/apt/preferences.d/01kodi-nightly-debian-repo

# Create temporary APT pinning
cat > /etc/apt/preferences.d/01kodi-nightly-debian-repo <<.p
# Debian Backports

Package: dav1d libdav1d-dev libdav1d4
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: flatbuffers-compiler flatbuffers-compiler-dev libflatbuffers1 libflatbuffers-dev python3-flatbuffers
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libfmt-dev libfmt-doc
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: googletest googletest-tools google-mock libgmock-dev libgtest-dev
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: kissfft-tools libkissfft-dev libkissfft-float131
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: kodi*
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libcdio19 libcdio++1 libcdio++-dev libcdio-dev libcdio-utils libiso9660++0 libiso9660++-dev libiso9660-11 libiso9660-dev libudf0 libudf-dev
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: hdhomerun-config libhdhomerun-dev libhdhomerun4
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: shairplay libshairplay-dev libshairplay0
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libspdlog-dev libspdlog1-dev
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libudfread-dev libudfread0
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libwebm1 libwebm-dev libwebm-tools
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

Package: libwayland-client++0 libwayland-client-extra++0 libwayland-cursor++0 libwayland-egl++0 waylandpp-dev wayland-scanner++
Pin: release l="Debian Backports" n=buster-backports
Pin-Priority: 1001

# Debian buster

Package: dirmngr gnupg gnupg-l10n gnupg-utils gpg gpgconf gpgsm gpgv gpg-agent gpg-wks-client gpg-wks-server
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: ffmpeg ffmpeg-doc libavcodec* libavdevice* libavfilter* libavformat* libavresample* libavutil* libpostproc* libswresample* libswscale*
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libbluetooth3
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libcryptsetup12
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libcurl3-gnutls
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libdrm2 libdrm-amdgpu1 libdrm-common libdrm-intel1 libdrm-nouveau2 libdrm-radeon1
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libegl1 libgl1 libglvnd0 libglx0
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libjs-jquery node-jquery
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libldap-2.4-2 libldap-common
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libpulse0 libpulse-mainloop-glib0 pulseaudio
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libnss-systemd libsystemd0 libpam-systemd libudev1 systemd systemd-sysv systemd-timesyncdudev
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libva2 libva-dev libva-drm2 libva-glx2 libva-wayland2 libva-x11-2 va-driver-all
Pin: release l=Debian n=buster
Pin-Priority: 1001

Package: libzstd1
Pin: release l=Debian n=buster
Pin-Priority: 1001
.p

# Perform migration

export DEBIAN_FRONTEND=noninteractive
apt-get update
[ ! -z "$KODI_DBGSYMS$NON_KODI_DBGSYMS" ] && apt-get remove -yq $KODI_DBGSYMS $NON_KODI_DBGSYMS
[ ! -z "$KODI_PACKAGES" ] && apt-get install --reinstall --allow-downgrades -yq $KODI_PACKAGES
[ ! -z "$NON_KODI_PACKAGES_BUSTER_BACKPORTS" ] && apt-get install --reinstall --allow-downgrades -yq $NON_KODI_PACKAGES_BUSTER_BACKPORTS
[ ! -z "$NON_KODI_PACKAGES_BUSTER" ] && apt-get install --reinstall --allow-downgrades -yq $NON_KODI_PACKAGES_BUSTER
[ ! -z "$SYSTEM_PACKAGES_BUSTER" ] && apt-get install --reinstall --allow-downgrades -yq $SYSTEM_PACKAGES_BUSTER

# Clean up
rm -f /etc/apt/preferences.d/01kodi-nightly-debian-repo
apt-mark auto node-jquery
apt-get update
apt-get full-upgrade -yq
apt-get --purge autoremove -yq
apt-get autoclean
apt-get clean
