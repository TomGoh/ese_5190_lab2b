cmake_minimum_required(VERSION 3.12)

include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include(example_auto_set_url.cmake)
include($ENV{PICO_SDK_PATH}/tools/CMakeLists.txt)

project(la2b_audio C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()

add_executable(audio audio.c)

pico_enable_stdio_usb(audio 1)
pico_enable_stdio_usb(audio 1)

target_link_libraries(
    audio
    pico_stdlib
    hardware_dma
    hardware_pio
    hardware_timer
    hardware_clocks
    hardware_pwm
)

pico_add_extra_outputs(audio)
