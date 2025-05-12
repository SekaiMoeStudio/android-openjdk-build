#!/bin/bash
set -ex
. setdevkitpath.sh

export JDK_DEBUG_LEVEL=release

  if [[ -d "$ANDROID_NDK_HOME" ]]; then
    echo "NDK already exists: $ANDROID_NDK_HOME"
  else
    echo "Downloading NDK"
    wget -nc -nv -O android-ndk-$NDK_VERSION-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux.zip"
    unzip -q android-ndk-$NDK_VERSION-linux-x86_64.zip
  fi
cp devkit.info.${TARGET_SHORT} ${TOOLCHAIN}

# Some modifies to NDK to fix

bash -x ./getlibs.sh
bash -x ./buildlibs.sh
bash -x ./clonejdk.sh
bash -x ./buildjdk.sh
bash -x ./removejdkdebuginfo.sh
bash -x ./tarjdk.sh
