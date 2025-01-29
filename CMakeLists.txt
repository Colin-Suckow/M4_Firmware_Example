cmake_minimum_required(VERSION 3.16)
include(${CMAKE_CURRENT_SOURCE_DIR}/lib/stm32-cmake/cmake/stm32_gcc.cmake)

project(stm32_m4_firmware ASM C CXX)

# Initialize the stm32 toolchain
set(STM32_TARGET_TRIPLET "arm-none-eabi")

set(CMAKE_INCLUDE_CURRENT_DIR TRUE)

# Define the processor we're using
add_compile_definitions(STM32MP151Fxx)

# Variables for accessing the generated HAL
set(HAL_INC ${CMAKE_CURRENT_SOURCE_DIR}/hal_conf/)

# Variables for accessing the project code
set(PROJECT_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/)
set(PROJECT_INC ${CMAKE_CURRENT_SOURCE_DIR}/include/)

add_subdirectory(${PROJECT_SRC})

