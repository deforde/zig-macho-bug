# Zig: Suspected Mach-O Linker Bug Example

Retesting with zig-linux-x86\_64-0.11.0-dev.2375+771d07268 shows that this bug has been resolved.

-------------------------------------------------------------------------------

I believe that there may be a Mach-O linker bug in Zig CC that affects the compilation of dynamic libraries targeting aarch64-macos.

This repo aims to provide a minimal example that reproduces the issue.

## Basic Reproduction

Simply run `make -f make-zig-cross.mk` to reproduce the issue.
This will attempt to cross-compile a dynamic library for aarch64-macos using the source file `foo.c`. It is in this source file that the problematic code is contained.

## More Detailed Example Using Docker

A Docker image can be built that will setup an environment in which both native and cross compilation using both `clang` and `zig cc` can be executed in order to reproduce the issue.
I built and ran this image on an x86\_64 machine.

To build the image, run the following:
```
export DOCKER_BUILDKIT=1
docker build -t zig-macho-bug:latest .
```
To run the container interactively:
```
docker run -it zig-macho-bug:latest
```
Then `cd` into `/home/test` in order to test the various builds.

Test builds:
- `make -f make-zig-cross.mk`: attempt to cross-compile the dynamic lib for aarch64-macos (this should exhibit the issue).
- `make -f make-clang-cross.mk`: cross-compile the dynamic lib for aarch64-macos (this should build successfully).
- `make -f make-zig-native.mk`: compile the dynamic lib for the host os (i.e. Ubuntu 22.04 - this should build successfully).
- `make -f make-clang-native.mk`: compile the dynamic lib for the host os (i.e. Ubuntu 22.04 - this should build successfully).
- Append `exec` to any of the make calls above to compile the dynamic lib and link it into an executable (`build/app`, e.g. `make -f make-zig-native.mk exec`).

## Versions used

Zig:
- zig-linux-x86\_64-0.11.0-dev.2375+771d07268

Host:
- x86\_64 Ubuntu 22.04

Clang:
- Ubuntu clang version 14.0.0-1ubuntu1
- Target: x86\_64-pc-linux-gnu
- Thread model: posix

MacOS SDK:
- MacOSX11.3
- Available here: https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.3.sdk.tar.xz

