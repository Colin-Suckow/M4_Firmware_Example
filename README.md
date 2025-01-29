# STM32MP1 M4 firmware minus STM32CubeIDE

This repo (attempts) to implement a buildable project for the stm32mp1's arm m4 subprocessor.

## Build Instructions

### Cloning Repository
This project uses git submodules to download dependencies. When cloning make sure you recursively pull submodules.

`git clone --recursive <repository_url>`

### Setup
You only need to run this step after cloning the repository or deleting the build directory.

1. `mkdir build`
2. `cd build`
3. `cmake ..`

### Build
1. If not already in the build directory, cd into it (`cd build`).
2. `cmake --build .` 