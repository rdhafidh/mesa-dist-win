### Notes

[1]Executed from a x64 Native Tools Command Prompt for VS 2017 shell

[2]Executed from a x64_x86 Cross Tools Command Prompt for VS 2017 shell

[3]Executed after each build configuration on same command shell

[4]Executed from a standard Command Prompt.
### Hardware
| | |
|-|-|
System | [Dell Vostro 2521-9566 Q1 2013](http://www.dell.com/support/home/en/us/robsdt1/product-support/product/vostro-2521)
CPU | [Intel Core I3-2375M](https://ark.intel.com/products/74259/Intel-Core-i3-2375M-Processor-3M-Cache-1_50-GHz)
RAM | 4GB DDR3 1600 MHz dual channel
dGPU | None
OS | Windows 10 April 2018 Update Pro x64
### Visual Studio
| | |
|-|-|
Edition | 2017 Community
Version | 15.7.4
Windows 10 SDK Version | 10.0.17134.12
Windows 10 SDK install method | standalone
### LLVM
| | |
|-|-|
LLVM Version | 6.0.1
CMake version | 3.11.4
CMake ARCH | x64
Ninja version | 1.8.2
LLVM build configure x64[1] | cd llvm-6.0.1.src & md buildsys-x64 & cd buildsys-x64 & cmake -G "Ninja" -Thost=x64 -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_CRT_RELEASE=MT -DLLVM_ENABLE_RTTI=1 -DLLVM_ENABLE_TERMINFO=OFF -DCMAKE_INSTALL_PREFIX=../x64 ..
LLVM build configure x86[2] | cd llvm-6.0.1.src & md buildsys-x86 & cd buildsys-x86 & cmake -G "Ninja" -Thost=x64 -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_CRT_RELEASE=MT -DLLVM_ENABLE_RTTI=1 -DLLVM_ENABLE_TERMINFO=OFF -DCMAKE_INSTALL_PREFIX=../x86 ..
LLVM build execute[3] | ninja install
### Python
| | |
|-|-|
Version | 2.7.15
ARCH | x64
pip version | 10.0.1
setuptools version | 39.2.0
pywin32 / pypiwin32 version | 223
scons version | 3.0.1
Mako version | 1.0.7
MarkupSafe version | 1.0
wheel version | 0.31.1
### winflexbison
| | |
|-|-|
Package version | 2.5.14
Bison version | 3.0.4
Flex version | 2.6.4
### Git version control
| | |
|-|-|
Git For Windows portable | 2.18.0.1
### Mesa3D
| | |
|-|-|
Enable S3TC texture cache [4] | git apply -v ..\mesa-dist-win\patches\s3tc.patch
osmesa build fix patch - disables GLES in osmesa [4] | git apply -v ..\mesa-dist-win\patches\osmesa.patch
Build config and execute x64 [4] | scons build=release platform=windows machine=x86_64 texture_float=1 openmp=1 swr=1 gles=0 . & scons build=release platform=windows machine=x86_64 texture_float=1 openmp=1 swr=1 gles=1 .
Build config and execute x86 [4] | scons build=release platform=windows machine=x86 texture_float=1 openmp=1 gles=0 . & scons build=release platform=windows machine=x86 texture_float=1 openmp=1 gles=1 .
