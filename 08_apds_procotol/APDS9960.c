/*
    A simple driver for APDS9960 by Dang0v

    based on PIO.I2C example in PICO_example

*/

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "pico/stdlib.h"
#include "pico/binary_info.h"
#include "string.h"
#include "APDS9960.h"
#include "pio_i2c.h"


#define POWER_ENABLE 1
#define PROXIMITY_ENABLE 1
#define ALS_ENABLE 1
#define GESTURE_ENABLE 0

#define ALS_GAIN 0
#define ALS_TIME 219

#define INIT_CONFIG (GESTURE_ENABLE << 6u) | (PROXIMITY_ENABLE << 2u) | (ALS_ENABLE << 1u) | POWER_ENABLE



void APDS9960_init(PIO pio, uint sm,uint8_t addr, bool nostop) {
    // use the "handheld device dynamic" optimal setting (see datasheet)
    uint8_t buf[2];

    // send register number followed by its corresponding value
    buf[0] = ENABLE_REG;
    buf[1] = INIT_CONFIG;
    pio_i2c_write_blocking(pio, sm, addr, buf, 2, false);

    buf[0] = ALS_TIME_REG;
    buf[1] = ALS_TIME;
    pio_i2c_write_blocking(pio, sm, addr, buf, 2, false);
}

void read_proximity(int32_t* proximity, PIO pio, uint sm, uint8_t addr, bool nostop) {

    uint8_t buf[1];
    uint8_t reg = PDATA_REG;
    pio_i2c_write_blocking(pio, sm, addr, &reg, 1, nostop);  // true to keep master control of bus
    pio_i2c_read_blocking(pio, sm, addr, buf, 1); 

    *proximity = buf[0];
}

void read_rgbc(int32_t* r, int32_t* g, int32_t* b, int32_t* c, PIO pio, uint sm,uint8_t addr, bool nostop) {

    uint8_t buf[2];
    uint8_t reg = CDATA_REG_L;
    pio_i2c_write_blocking(pio, sm, addr, &reg, 1, nostop);  // true to keep master control of bus
    pio_i2c_read_blocking(pio, sm, addr, buf, 8); 

    *c = (buf[1] << 8) | buf[0];
    *r = (buf[3] << 8) | buf[2];
    *g = (buf[5] << 8) | buf[4];
    *b = (buf[7] << 8) | buf[6];
}