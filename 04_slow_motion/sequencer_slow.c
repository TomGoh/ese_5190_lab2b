#include <stdio.h>
#include <stdlib.h>
#include "pico/stdlib.h"
#include "ws2812/ws2812.h"
#define button_pin 21
#define base 0x40014000
#define button_color_ address 0x20000000
#define color_address_counte 0x04


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


void Macros(){
    int flag =0;
    while(flag<=3){
    set_neopixel_color(color_table[flag].color);
    flag++;
    sleep_ms(500);
    }
}

void recording(int button_counter,uint32_t color,int time){
    int counter = button_counter;
    while(counter!=0){
        set_neopixel_color(color);
        counter--;
        sleep_ms(time);
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
    int recording_flag=0; // Judge the status of sequencer.1 is read from PC
    int button_counter=0;
    int delay_time=10000;

    while(true){
        status.last_serial_byte = getchar_timeout_us(0);
        switch(status.last_serial_byte) { // get the value from Computer
            case 's':
                status.button_is_pressed=0x00000001;
                recording_flag = 1;
                break;
            case 'k':
                status.button_is_pressed=0x00000000;
                recording_flag = 1;
                break;
            case '1':
                delay_time++; //set the Recording time
                break; 
            case '0':
                delay_time--; //set the Recording time
                break;
            case 'r':
                recording(button_counter,status.light_color,delay_time);
                break;
        }
        if(recording_flag == 0){
        if (gpio_get(button_pin)) { // poll every cycle, 0 = "pressed"
            status.button_is_pressed = 0x00000000;
        } else {
            status.button_is_pressed = 0x00000001;
            button_counter++;
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
        
    
    
        sleep_ms(10);
    }
    return 0;
}


