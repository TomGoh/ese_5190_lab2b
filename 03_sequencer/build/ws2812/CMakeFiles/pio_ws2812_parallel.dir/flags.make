# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# compile ASM with /opt/homebrew/bin/arm-none-eabi-gcc
# compile C with /opt/homebrew/bin/arm-none-eabi-gcc
# compile CXX with /opt/homebrew/bin/arm-none-eabi-g++
ASM_DEFINES = -DLIB_PICO_BIT_OPS=1 -DLIB_PICO_BIT_OPS_PICO=1 -DLIB_PICO_DIVIDER=1 -DLIB_PICO_DIVIDER_HARDWARE=1 -DLIB_PICO_DOUBLE=1 -DLIB_PICO_DOUBLE_PICO=1 -DLIB_PICO_FLOAT=1 -DLIB_PICO_FLOAT_PICO=1 -DLIB_PICO_INT64_OPS=1 -DLIB_PICO_INT64_OPS_PICO=1 -DLIB_PICO_MALLOC=1 -DLIB_PICO_MEM_OPS=1 -DLIB_PICO_MEM_OPS_PICO=1 -DLIB_PICO_PLATFORM=1 -DLIB_PICO_PRINTF=1 -DLIB_PICO_PRINTF_PICO=1 -DLIB_PICO_RUNTIME=1 -DLIB_PICO_STANDARD_LINK=1 -DLIB_PICO_STDIO=1 -DLIB_PICO_STDIO_UART=1 -DLIB_PICO_STDLIB=1 -DLIB_PICO_SYNC=1 -DLIB_PICO_SYNC_CORE=1 -DLIB_PICO_SYNC_CRITICAL_SECTION=1 -DLIB_PICO_SYNC_MUTEX=1 -DLIB_PICO_SYNC_SEM=1 -DLIB_PICO_TIME=1 -DLIB_PICO_UTIL=1 -DPICO_BOARD=\"pico\" -DPICO_BUILD=1 -DPICO_CMAKE_BUILD_TYPE=\"Debug\" -DPICO_COPY_TO_RAM=0 -DPICO_CXX_ENABLE_EXCEPTIONS=0 -DPICO_NO_FLASH=0 -DPICO_NO_HARDWARE=0 -DPICO_ON_DEVICE=1 -DPICO_PROGRAM_URL=\"https://github.com/raspberrypi/pico-examples/tree/HEAD/ws2812\" -DPICO_TARGET_NAME=\"pio_ws2812_parallel\" -DPICO_USE_BLOCKED_RAM=0 -DPIN_DBG1=3

ASM_INCLUDES = -I/Users/lize/pico/test/ws2812 -I/Users/lize/pico/test/ws2812/generated -I/Users/lize/pico/pico-sdk/src/common/pico_stdlib/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_gpio/include -I/Users/lize/pico/pico-sdk/src/common/pico_base/include -I/Users/lize/pico/test/build/generated/pico_base -I/Users/lize/pico/pico-sdk/src/boards/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_platform/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_regs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_base/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_structs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_claim/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_sync/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_irq/include -I/Users/lize/pico/pico-sdk/src/common/pico_sync/include -I/Users/lize/pico/pico-sdk/src/common/pico_time/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_timer/include -I/Users/lize/pico/pico-sdk/src/common/pico_util/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_runtime/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_clocks/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_resets/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pll/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_vreg/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_watchdog/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_xosc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_printf/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_bootrom/include -I/Users/lize/pico/pico-sdk/src/common/pico_bit_ops/include -I/Users/lize/pico/pico-sdk/src/common/pico_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_double/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_int64_ops/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_float/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_malloc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/boot_stage2/include -I/Users/lize/pico/pico-sdk/src/common/pico_binary_info/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_dma/include

ASM_FLAGS = -mcpu=cortex-m0plus -mthumb -Og -g -ffunction-sections -fdata-sections

C_DEFINES = -DLIB_PICO_BIT_OPS=1 -DLIB_PICO_BIT_OPS_PICO=1 -DLIB_PICO_DIVIDER=1 -DLIB_PICO_DIVIDER_HARDWARE=1 -DLIB_PICO_DOUBLE=1 -DLIB_PICO_DOUBLE_PICO=1 -DLIB_PICO_FLOAT=1 -DLIB_PICO_FLOAT_PICO=1 -DLIB_PICO_INT64_OPS=1 -DLIB_PICO_INT64_OPS_PICO=1 -DLIB_PICO_MALLOC=1 -DLIB_PICO_MEM_OPS=1 -DLIB_PICO_MEM_OPS_PICO=1 -DLIB_PICO_PLATFORM=1 -DLIB_PICO_PRINTF=1 -DLIB_PICO_PRINTF_PICO=1 -DLIB_PICO_RUNTIME=1 -DLIB_PICO_STANDARD_LINK=1 -DLIB_PICO_STDIO=1 -DLIB_PICO_STDIO_UART=1 -DLIB_PICO_STDLIB=1 -DLIB_PICO_SYNC=1 -DLIB_PICO_SYNC_CORE=1 -DLIB_PICO_SYNC_CRITICAL_SECTION=1 -DLIB_PICO_SYNC_MUTEX=1 -DLIB_PICO_SYNC_SEM=1 -DLIB_PICO_TIME=1 -DLIB_PICO_UTIL=1 -DPICO_BOARD=\"pico\" -DPICO_BUILD=1 -DPICO_CMAKE_BUILD_TYPE=\"Debug\" -DPICO_COPY_TO_RAM=0 -DPICO_CXX_ENABLE_EXCEPTIONS=0 -DPICO_NO_FLASH=0 -DPICO_NO_HARDWARE=0 -DPICO_ON_DEVICE=1 -DPICO_PROGRAM_URL=\"https://github.com/raspberrypi/pico-examples/tree/HEAD/ws2812\" -DPICO_TARGET_NAME=\"pio_ws2812_parallel\" -DPICO_USE_BLOCKED_RAM=0 -DPIN_DBG1=3

C_INCLUDES = -I/Users/lize/pico/test/ws2812 -I/Users/lize/pico/test/ws2812/generated -I/Users/lize/pico/pico-sdk/src/common/pico_stdlib/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_gpio/include -I/Users/lize/pico/pico-sdk/src/common/pico_base/include -I/Users/lize/pico/test/build/generated/pico_base -I/Users/lize/pico/pico-sdk/src/boards/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_platform/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_regs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_base/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_structs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_claim/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_sync/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_irq/include -I/Users/lize/pico/pico-sdk/src/common/pico_sync/include -I/Users/lize/pico/pico-sdk/src/common/pico_time/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_timer/include -I/Users/lize/pico/pico-sdk/src/common/pico_util/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_runtime/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_clocks/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_resets/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pll/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_vreg/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_watchdog/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_xosc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_printf/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_bootrom/include -I/Users/lize/pico/pico-sdk/src/common/pico_bit_ops/include -I/Users/lize/pico/pico-sdk/src/common/pico_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_double/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_int64_ops/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_float/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_malloc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/boot_stage2/include -I/Users/lize/pico/pico-sdk/src/common/pico_binary_info/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_dma/include

C_FLAGS = -mcpu=cortex-m0plus -mthumb -Og -g -ffunction-sections -fdata-sections -std=gnu11

CXX_DEFINES = -DLIB_PICO_BIT_OPS=1 -DLIB_PICO_BIT_OPS_PICO=1 -DLIB_PICO_DIVIDER=1 -DLIB_PICO_DIVIDER_HARDWARE=1 -DLIB_PICO_DOUBLE=1 -DLIB_PICO_DOUBLE_PICO=1 -DLIB_PICO_FLOAT=1 -DLIB_PICO_FLOAT_PICO=1 -DLIB_PICO_INT64_OPS=1 -DLIB_PICO_INT64_OPS_PICO=1 -DLIB_PICO_MALLOC=1 -DLIB_PICO_MEM_OPS=1 -DLIB_PICO_MEM_OPS_PICO=1 -DLIB_PICO_PLATFORM=1 -DLIB_PICO_PRINTF=1 -DLIB_PICO_PRINTF_PICO=1 -DLIB_PICO_RUNTIME=1 -DLIB_PICO_STANDARD_LINK=1 -DLIB_PICO_STDIO=1 -DLIB_PICO_STDIO_UART=1 -DLIB_PICO_STDLIB=1 -DLIB_PICO_SYNC=1 -DLIB_PICO_SYNC_CORE=1 -DLIB_PICO_SYNC_CRITICAL_SECTION=1 -DLIB_PICO_SYNC_MUTEX=1 -DLIB_PICO_SYNC_SEM=1 -DLIB_PICO_TIME=1 -DLIB_PICO_UTIL=1 -DPICO_BOARD=\"pico\" -DPICO_BUILD=1 -DPICO_CMAKE_BUILD_TYPE=\"Debug\" -DPICO_COPY_TO_RAM=0 -DPICO_CXX_ENABLE_EXCEPTIONS=0 -DPICO_NO_FLASH=0 -DPICO_NO_HARDWARE=0 -DPICO_ON_DEVICE=1 -DPICO_PROGRAM_URL=\"https://github.com/raspberrypi/pico-examples/tree/HEAD/ws2812\" -DPICO_TARGET_NAME=\"pio_ws2812_parallel\" -DPICO_USE_BLOCKED_RAM=0 -DPIN_DBG1=3

CXX_INCLUDES = -I/Users/lize/pico/test/ws2812 -I/Users/lize/pico/test/ws2812/generated -I/Users/lize/pico/pico-sdk/src/common/pico_stdlib/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_gpio/include -I/Users/lize/pico/pico-sdk/src/common/pico_base/include -I/Users/lize/pico/test/build/generated/pico_base -I/Users/lize/pico/pico-sdk/src/boards/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_platform/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_regs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_base/include -I/Users/lize/pico/pico-sdk/src/rp2040/hardware_structs/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_claim/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_sync/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_irq/include -I/Users/lize/pico/pico-sdk/src/common/pico_sync/include -I/Users/lize/pico/pico-sdk/src/common/pico_time/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_timer/include -I/Users/lize/pico/pico-sdk/src/common/pico_util/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_runtime/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_clocks/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_resets/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pll/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_vreg/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_watchdog/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_xosc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_printf/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_bootrom/include -I/Users/lize/pico/pico-sdk/src/common/pico_bit_ops/include -I/Users/lize/pico/pico-sdk/src/common/pico_divider/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_double/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_int64_ops/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_float/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_malloc/include -I/Users/lize/pico/pico-sdk/src/rp2_common/boot_stage2/include -I/Users/lize/pico/pico-sdk/src/common/pico_binary_info/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/pico_stdio_uart/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_pio/include -I/Users/lize/pico/pico-sdk/src/rp2_common/hardware_dma/include

CXX_FLAGS = -mcpu=cortex-m0plus -mthumb -Og -g -ffunction-sections -fdata-sections -fno-exceptions -fno-unwind-tables -fno-rtti -fno-use-cxa-atexit -std=gnu++17
