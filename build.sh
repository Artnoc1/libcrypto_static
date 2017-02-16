#!/bin/sh

case "$(uname -s)" in
  CYGWIN*|MINGW32*|MSYS*) ext=.cmd;
esac;

case $1 in
  clean)
    rm -rf obj;
    exit 0;
  ;;
esac;

if [ ! "$NDK_ROOT" ]; then
  NDK_ROOT=~/android/android-ndk-r*;
fi;

for TARGET_ARCH in arm arm64 x86 x86_64 mips mips64; do
  APP_ABI=$TARGET_ARCH;
  case $TARGET_ARCH in
       arm) NDK_TOOLCHAIN=arm-linux-androideabi-4.9; APP_ABI=armeabi;;
     arm64) NDK_TOOLCHAIN=aarch64-linux-android-4.9; APP_ABI=arm64-v8a;;
       x86) NDK_TOOLCHAIN=x86-4.9;;
    x86_64) NDK_TOOLCHAIN=x86_64-4.9;;
      mips) NDK_TOOLCHAIN=mipsel-linux-android-4.9;;
    mips64) NDK_TOOLCHAIN=mips64el-linux-android-4.9;;
  esac;
  case $TARGET_ARCH in
    *64) TARGET_2ND_ARCH=64; APP_PLATFORM=android-21;;
      *) TARGET_2ND_ARCH=32; APP_PLATFORM=android-9;;
  esac;
  TARGET_ARCH=$TARGET_ARCH TARGET_2ND_ARCH=$TARGET_2ND_ARCH $NDK_ROOT/ndk-build$ext NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk NDK_TOOLCHAIN=$NDK_TOOLCHAIN APP_ABI=$APP_ABI APP_PLATFORM=$APP_PLATFORM APP_STL=gnustl_static;
done;

exit 0;

