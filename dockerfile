FROM python as requirements_stage

WORKDIR /wheel

RUN python -m pip install --user pipx

COPY ./pyproject.toml \
  ./requirements.txt \
  /wheel/


RUN python -m pip wheel --wheel-dir=/wheel --no-cache-dir --requirement ./requirements.txt

RUN python -m pipx run --no-cache nb-cli generate -f /tmp/bot.py


FROM python:slim

WORKDIR /app

ENV TZ Asia/Shanghai
ENV PYTHONPATH=/app

COPY --from=requirements_stage /tmp/bot.py /app

COPY --from=requirements_stage /wheel /wheel

RUN pip install --no-cache-dir nonebot2 \
  && pip install --no-cache-dir --no-index --force-reinstall --find-links=/wheel -r /wheel/requirements.txt && rm -rf /wheel \
  && apt update && apt install -y adwaita-icon-theme alsa-topology-conf alsa-ucm-conf aspell aspell-en at-spi2-common at-spi2-core curl dbus dbus-bin \
  dbus-daemon dbus-session-bus-common dbus-system-bus-common dbus-user-session dconf-gsettings-backend dconf-service \
  dictionaries-common dmsetup emacsen-common enchant-2 fontconfig fontconfig-config fonts-droid-fallback \
  fonts-freefont-ttf fonts-ipafont-gothic fonts-ipafont-mincho fonts-liberation fonts-noto-color-emoji fonts-noto-mono \
  fonts-tlwg-loma fonts-tlwg-loma-otf fonts-unifont fonts-urw-base35 fonts-wqy-zenhei ghostscript glib-networking \
  glib-networking-common glib-networking-services gsettings-desktop-schemas gsfonts gstreamer1.0-gl gstreamer1.0-libav \
  gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-x gtk-update-icon-cache \
  hicolor-icon-theme hunspell-en-us i965-va-driver imagemagick-6-common intel-media-va-driver iso-codes libaa1 \
  libaacs0 libaom3 libapparmor1 libargon2-1 libasound2 libasound2-data libaspell15 libass9 libasyncns0 \
  libatk-bridge2.0-0 libatk1.0-0 libatomic1 libatspi2.0-0 libavahi-client3 libavahi-common-data libavahi-common3 \
  libavc1394-0 libavcodec59 libavfilter8 libavformat59 libavutil57 libbdplus0 libblas3 libbluray2 libbrotli1 libbs2b0 \
  libbsd0 libcaca0 libcairo-gobject2 libcairo2 libcap2-bin libcdparanoia0 libchromaprint1 libcjson1 libcodec2-1.0 \
  libcolord2 libcryptsetup12 libcups2 libcurl3-gnutls libcurl4 libdatrie1 libdav1d6 libdbus-1-3 libdbus-glib-1-2 \
  libdc1394-25 libdca0 libdconf1 libde265-0 libdecor-0-0 libdecor-0-plugin-1-cairo libdeflate0 libdevmapper1.02.1 \
  libdirectfb-1.7-7 libdjvulibre-text libdjvulibre21 libdrm-amdgpu1 libdrm-common libdrm-intel1 libdrm-nouveau2 \
  libdrm-radeon1 libdrm2 libdv4 libdvdnav4 libdvdread8 libdw1 libedit2 libegl-mesa0 libegl1 libelf1 libenchant-2-2 \
  libepoxy0 libevdev2 libevent-2.1-7 libfaad2 libfdisk1 libfftw3-double3 libflac12 libflite1 libfluidsynth3 \
  libfontconfig1 libfontenc1 libfreeaptx0 libfreetype6 libfribidi0 libgbm1 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-bin \
  libgdk-pixbuf2.0-common libgfortran5 libgl1 libgl1-mesa-dri libglapi-mesa libgles2 libglib2.0-0 libglib2.0-data \
  libglvnd0 libglx-mesa0 libglx0 libgme0 libgomp1 libgpm2 libgraphene-1.0-0 libgraphite2-3 libgs-common libgs10 \
  libgs10-common libgsm1 libgssdp-1.6-0 libgstreamer-gl1.0-0 libgstreamer-plugins-bad1.0-0 \
  libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libgtk-3-0 libgtk-3-bin libgtk-3-common libgudev-1.0-0 \
  libgupnp-1.6-0 libgupnp-igd-1.0-4 libharfbuzz-icu0 libharfbuzz0b libheif1 libhunspell-1.7-0 libhwy1 libhyphen0 \
  libice6 libicu72 libidn12 libiec61883-0 libigdgmm12 libijs-0.35 libimath-3-1-29 libinstpatch-1.0-2 libip4tc2 \
  libjack-jackd2-0 libjbig0 libjbig2dec0 libjpeg62-turbo libjson-c5 libjson-glib-1.0-0 libjson-glib-1.0-common \
  libjxl0.7 libjxr-tools libjxr0 libkate1 libkmod2 liblapack3 liblcms2-2 libldacbt-enc2 libldap-2.5-0 libldap-common \
  liblerc4 liblilv-0-0 libllvm15 liblqr-1-0 liblrdf0 libltc11 libltdl7 libmagickcore-6.q16-6 \
  libmagickcore-6.q16-6-extra libmagickwand-6.q16-6 libmanette-0.2-0 libmbedcrypto7 libmfx1 libmjpegutils-2.1-0 \
  libmodplug1 libmp3lame0 libmpcdec6 libmpeg2encpp-2.1-0 libmpg123-0 libmplex2-2.1-0 libmysofa1 libncurses6 libneon27 \
  libnghttp2-14 libnice10 libnorm1 libnotify4 libnspr4 libnss-systemd libnss3 libnuma1 libogg0 libopenal-data \
  libopenal1 libopenexr-3-1-30 libopengl0 libopenh264-7 libopenjp2-7 libopenmpt0 libopenni2-0 libopus0 liborc-0.4-0 \
  libpam-cap libpam-systemd libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpaper-utils libpaper1 \
  libpciaccess0 libpgm-5.3-0 libpixman-1-0 libplacebo208 libpng16-16 libpocketsphinx3 libpostproc56 libproc2-0 \
  libproxy1v5 libpsl5 libpulse0 libpython3-stdlib libpython3.11-minimal libpython3.11-stdlib libqrencode4 libquadmath0 \
  librabbitmq4 libraptor2-0 librav1e0 libraw1394-11 librist4 librsvg2-2 librsvg2-common librtmp1 librubberband2 \
  libsamplerate0 libsasl2-2 libsasl2-modules libsasl2-modules-db libsbc1 libsdl2-2.0-0 libsecret-1-0 libsecret-common \
  libsensors-config libsensors5 libserd-0-0 libshine3 libshout3 libslang2 libsm6 libsnappy1v5 libsndfile1 libsndio7.0 \
  libsodium23 libsord-0-0 libsoundtouch1 libsoup-3.0-0 libsoup-3.0-common libsoxr0 libspandsp2 libspeex1 \
  libsphinxbase3 libsratom-0-0 libsrt1.5-gnutls libsrtp2-1 libssh-gcrypt-4 libssh2-1 libsvtav1enc1 libswresample4 \
  libswscale6 libsystemd-shared libtag1v5 libtag1v5-vanilla libtext-iconv-perl libthai-data libthai0 libtheora0 \
  libtiff6 libtwolame0 libudfread0 libunwind8 libusb-1.0-0 libv4l-0 libv4lconvert0 libva-drm2 libva-x11-2 libva2 \
  libvdpau-va-gl1 libvdpau1 libvidstab1.1 libvisual-0.4-0 libvo-aacenc0 libvo-amrwbenc0 libvorbis0a libvorbisenc2 \
  libvorbisfile3 libvpx7 libvulkan1 libwavpack1 libwayland-client0 libwayland-cursor0 libwayland-egl1 \
  libwayland-server0 libwebp7 libwebpdemux2 libwebpmux3 libwebrtc-audio-processing1 libwildmidi2 libwmflite-0.2-7 \
  libwoff1 libx11-6 libx11-data libx11-xcb1 libx264-164 libx265-199 libxau6 libxaw7 libxcb-dri2-0 libxcb-dri3-0 \
  libxcb-glx0 libxcb-present0 libxcb-randr0 libxcb-render0 libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 libxcb1 \
  libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxfont2 libxi6 libxinerama1 \
  libxkbcommon-x11-0 libxkbcommon0 libxkbfile1 libxml2 libxmu6 libxmuu1 libxpm4 libxrandr2 libxrender1 libxshmfence1 \
  libxslt1.1 libxss1 libxt6 libxtst6 libxv1 libxvidcore4 libxxf86vm1 libyajl2 libz3-4 libzbar0 libzimg2 libzmq5 \
  libzvbi-common libzvbi0 libzxing2 media-types mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers net-tools \
  ocl-icd-libopencl1 pocketsphinx-en-us poppler-data procps psmisc publicsuffix python3 python3-minimal python3.11 \
  python3.11-minimal sensible-utils shared-mime-info systemd systemd-sysv systemd-timesyncd timgm6mb-soundfont ucf \
  va-driver-all vdpau-driver-all x11-common x11-xkb-utils xauth xdg-user-dirs xfonts-base xfonts-encodings \
  xfonts-scalable xfonts-utils xkb-data xserver-common xvfb
  
COPY . /app/

CMD ["python", "bot.py"]