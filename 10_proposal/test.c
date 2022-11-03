#include <stdio.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "ws2812/ws2812.h"
#define button_pin 21
#define base 0x40014000


typedef void (*pattern)(uint len, uint t);
const struct {
    uint32_t color ;
    char *name;
} color_table[] = {
        {0xff0000,  "Red!"},
        {0x00ff00,  "Green!"},
        {0x0000ff, "Blue!"},
        {0x00ffff,"New!"},
};

typedef struct {
    uint32_t last_serial_byte;
    uint32_t button_is_pressed;
    uint32_t light_color;
} Flashlight; 

void render_to_console(Flashlight status) {
    // adjust console window height to match 'frame size'
    for (uint8_t i=0; i<10; i++) { 
        printf("\n");
    }
    printf("button_is_pressed:  0x%08x\n",   status.button_is_pressed);
    printf("light_color:        0x%08x\n",   status.light_color);
}  

void Macros(){
    int flag =0;
    while(flag<=3){
    set_neopixel_color(color_table[flag].color);
    flag++;
    sleep_ms(500);
    }
}

int main() {
    stdio_init_all();
    neopixel_init();

    gpio_init(button_pin);
    gpio_set_dir(button_pin,GPIO_IN);

    Flashlight status;
    status.last_serial_byte =  0x00000000;
    status.button_is_pressed = 0x00000000;
    status.light_color =       0x000000ff;

    uint32_t *add;
    uint32_t *ctrl;
    int recording_flag=0;

    while(true){
        
        status.last_serial_byte = getchar_timeout_us(0);
        switch(status.last_serial_byte) { // poll every cycle
            case 's':
                status.button_is_pressed=0x00000001;
                recording_flag = 1;
                break;
            case 'k':
                status.button_is_pressed=0x00000000;
                recording_flag = 1;
                break;
        }
        if(recording_flag == 0){
        if (gpio_get(button_pin)) { // poll every cycle, 0 = "pressed"
            status.button_is_pressed = 0x00000000;
        } else {
            status.button_is_pressed = 0x00000001;
        }
        }
        if (status.button_is_pressed) { // poll every cycle
            Macros();
        } else {
            set_neopixel_color(0x000000);
        }
        if(recording_flag == 1){
            status.button_is_pressed=0x00000000;
            recording_flag = 0;
        }
        printf("0x%08x\n",   status.button_is_pressed);
        printf("0x%08x\n",   status.light_color);
        
    
    
        
        
        
        add = base + 0x0a8;
        ctrl= base + 0x0ac;

        uint32_t button_value = *add;
        uint32_t ctrl_value = *ctrl;
        
        printf("control_value ==  %lu\n",ctrl_value);
        printf("button_value ==  %lu\n",button_value);
        printf("button_value ==  %lu\n",gpio_get(button_pin));

    /*
    while(true){

    // output example
    int flag = rand() % 3;
    printf(color_table[flag].name);
    printf("\n");
    set_neopixel_color(color_table[flag].color);*/
    



    /* input example
    while((c=getchar_timeout_us(0))!= EOF){
            putchar_raw(c);
            my_toggle_flag=1;
        }
    
        if(my_toggle_flag==1){
            printf("send a char");
            set_neopixel_color(0xff0000);
            my_toggle_flag=0;
        }
        else{
            set_neopixel_color(0x000000);
        }*/

        sleep_ms(10);
        //sleep_ms(5);
    }
    return 0;
}


