export CC=clang -target aarch64-apple-macos-macho --sysroot /home/MacOSX11.3.sdk -fuse-ld=lld
export DYLIB_EXT=dylib

include build.mk

