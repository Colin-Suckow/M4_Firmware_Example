# Fetch the required CMSIS and HAL library code
message(STATUS "Downloading STM32 toolchain. This may take a minute.")
stm32_fetch_cube(MP1)
stm32_fetch_cmsis(MP1)
stm32_fetch_hal(MP1)

find_package(CMSIS COMPONENTS STM32MP1_M4 REQUIRED)
find_package(HAL COMPONENTS STM32MP1_M4 REQUIRED)

add_executable(m4_firmware
    ${PROJECT_SRC}/main.cpp
)

target_include_directories(m4_firmware PRIVATE
    ${PROJECT_INC}
    ${HAL_INC}
)

target_compile_options(m4_firmware PRIVATE
    -fno-exceptions
    -fno-rtti
)

target_link_libraries(m4_firmware PRIVATE
    HAL::STM32::MP1::M4
    CMSIS::STM32::MP1::M4
    STM32::NoSys
)

stm32_print_size_of_target(m4_firmware)