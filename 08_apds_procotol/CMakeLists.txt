cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(pio_sequencer)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(PICO_EXAMPLES_PATH ${PROJECT_SOURCE_DIR})
pico_sdk_init()
include(example_auto_set_url.cmake)

add_executable(APDS9960_pio main.c)

pico_generate_pio_header(APDS9960_pio ${CMAKE_CURRENT_LIST_DIR}/i2c.pio)

target_sources(APDS9960_pio PRIVATE
        pio_i2c.c
        pio_i2c.h
        APDS9960.c
        APDS9960.h
        main.c
        )

pico_enable_stdio_usb(APDS9960_pio 1) # PICO SDK (USB)
pico_enable_stdio_uart(APDS9960_pio 0) # PICO SDK (USB)

target_link_libraries(APDS9960_pio PRIVATE pico_stdlib hardware_pio)
pico_add_extra_outputs(APDS9960_pio)

