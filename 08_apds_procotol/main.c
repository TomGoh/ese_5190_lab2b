#include "APDS9960.h"
#include "pio_i2c.h"

const int addr = 0x39;
const int max_read = 250;

#define PIN_SDA 22
#define PIN_SCL 23

struct Info{
    int32_t r;
    int32_t g;
    int32_t b;
    int32_t c;
    int32_t proximity;
};

void readInfo(struct Info* info, PIO pio, uint sm, uint8_t addr, bool nostop){
    read_proximity(&info->proximity, pio, sm, addr, nostop);
    read_rgbc(&info->r, &info->g, &info->b, &info->c, pio, sm, addr, nostop);
    // Print out the values
    printf("Proximity: %d, red: %d, green: %d, blue: %d, clear: %d\n", info->proximity, info->r, info->g, info->b, info->c);
}

int main(){

    stdio_init_all();

    PIO pio = pio0;
    uint sm = 0;

    uint offset = pio_add_program(pio, &i2c_program);
    i2c_program_init(pio, sm, offset, PIN_SDA, PIN_SCL);
    
    APDS9960_init(pio, sm, addr, false);
    
    struct Info info;

    while(true){
        sleep_ms(1000);
        readInfo(&info, pio, sm, addr, false); 
    }
}

