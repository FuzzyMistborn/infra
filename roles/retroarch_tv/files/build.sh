#!/bin/bash
green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'
ra_ver=$1

if [[ ! -n $ra_ver ]];
then 
    echo "Must include RetroArch version as an argument, such as $green./build.sh 1.9.11"
else
    cd /tmp
    rm -r RetroArch-$ra_ver
    curl -LO 'https://github.com/libretro/RetroArch/archive/v'$ra_ver'.tar.gz'
    tar -zxvf v$ra_ver.tar.gz
    cd RetroArch-$ra_ver
    CFLAGS='-march=armv8-a+crc+simd -mcpu=cortex-a72 -mtune=cortex-a72 -mfloat-abi=hard -mfpu=neon-fp-armv8' CXXFLAGS="${CFLAGS}" ./configure  --disable-caca --disable-jack --disable-opengl1 --disable-oss --disable-sdl --enable-sdl2 --disable-videocore --disable-vulkan --disable-wayland --disable-x11 --enable-alsa --enable-egl --enable-floathard --enable-kms --enable-neon --enable-opengles --enable-opengles3 --enable-pulse --enable-udev
    make -j4
    make install
    echo RetroArch$red v.$ra_ver$reset is now installed!
fi
