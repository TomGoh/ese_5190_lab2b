#include <stdio.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "ws2812/ws2812.h"
#define button_pin 21
#define base 0x40014000


int main() {
    stdio_init_all();
    neopixel_init();

    gpio_init(button_pin);
    gpio_set_dir(button_pin,GPIO_IN);

    uint32_t *add;

    while(true){
        
       
        add = base + 0x0a8; // add is the address of the button's status register

        uint32_t button_value = *add;

        
        if(button_value){
            set_neopixel_color(0x000000);
        }
        else if(!button_value){
            set_neopixel_color(0x00ff00);
        }
        

        sleep_ms(10);
    }
    return 0;
}


