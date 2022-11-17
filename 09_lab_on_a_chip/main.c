#include "APDS9960.h"
#include "pio_i2c.h"
#include "ws2812.h"

#define PIN_SDA 22
#define PIN_SCL 23

const int addr = 0x39;
const int max_read = 250;


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
    sleep_ms(5000);
    printf("=========");

    PIO pio_0 = pio0;
    uint sm_0 = 0;

    uint offset_0 = pio_add_program(pio_0, &i2c_program);
    i2c_program_init(pio_0, sm_0, offset_0, PIN_SDA, PIN_SCL);
    
    APDS9960_init(pio_0, sm_0, addr, false);
    
    printf("APDS9960 initialized\n");
    
    struct Info info;
    while(true){
        printf("====In Loop=====\n");
        sleep_ms(1000);
        readInfo(&info, pio_0, sm_0, addr, false);

        printf("Finished the readInfo\n");

        set_neopixel_color(rgb_to_neopixel(info.r, info.g, info.b));

        printf("Finished the set_neopixel_color\n");
    }

}