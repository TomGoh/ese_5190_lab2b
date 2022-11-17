#include "ws2812.h"

#define IS_RGBW true
#define NUM_PIXELS 150

#ifdef PICO_DEFAULT_WS2812_PIN
#define WS2812_PIN PICO_DEFAULT_WS2812_PIN
#else
// default to pin 11 if the board doesn't have a default WS2812 pin defined
#define WS2812_PIN 11
#endif

void set_neopixel_color(uint32_t color){

    const uint POWER_PIN = PICO_DEFAULT_WS2812_POWER_PIN;
    gpio_init(POWER_PIN);
    gpio_set_dir(POWER_PIN, GPIO_OUT);
    gpio_put(POWER_PIN,1);
    
    PIO pio = pio1;
    int sm = 1;
    uint offset = pio_add_program(pio, &ws2812_program);

    ws2812_program_init(pio, sm, offset, WS2812_PIN, 800000, IS_RGBW);
    
    uint32_t result=((uint32_t)(color&0xff0000) >>8) | ((uint32_t)(color&0x00ff00)<<8) | ((uint32_t)(color&0x0000ff));

    // char str[6+1];
    // sprintf(str,"%x",color);
    // str[0]=str[0]^str[2];
    // str[2]=str[0]^str[2];
    // str[0]=str[0]^str[2];
    // str[1]=str[1]^str[3];
    // str[3]=str[1]^str[3];
    // str[1]=str[1]^str[3];
    // // printf("%s\n",str);

    // uint32_t result=(uint32_t)strtol(str,NULL,16);


    pio_sm_put_blocking(pio1, 1, result << 8u);
    if(result==0){
        printf("Lights out.\n");
    }else{
        printf("Lights up!\n");
    }
    pio_clear_instruction_memory(pio1);
    return;
}

uint32_t rgb_to_neopixel(uint8_t r, uint8_t g, uint8_t b){
    uint32_t result = 0;
    result |= (uint32_t)r << 16u;
    result |= (uint32_t)g << 8u;
    result |= (uint32_t)b;
    return result;
}
