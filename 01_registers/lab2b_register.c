#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "pico/stdlib.h"

#define GPIO_REGISTER_BASE 0x40014000

// get the address of a register by base address and offset
uint32_t* get_address_by_base_offset(uint32_t base, uint32_t offset){

    return (uint32_t*) (base+offset);

}

// set values into an assgined address
void set_values_by_address(uint32_t address, uint32_t value){
    
    volatile uint32_t* address_pointer=get_address_by_base_offset(GPIO_REGISTER_BASE,address);
    *address_pointer|=value;

}

// generating a mask for a specific bit
uint32_t generate_mask(int position){
    uint32_t* mask=(uint32_t*) malloc(sizeof(uint32_t));
    *mask=1<<position;
    return ~(*mask);
}

// get the value of a specific bit of a register address
uint32_t get_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    return (*address & ~*mask)>>position;
}

// set the value of a specific bit of a register address
void set_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    *address&=*mask;
    *address|=(value<<position);
}

// get the value of a specific bit of a register address
void gpio_out_sample(int gpio_number){
    volatile uint32_t* address=get_address_by_base_offset(GPIO_REGISTER_BASE,(uint32_t)(0x008*gpio_number));
    printf("GPIO PUT SAMPLE ASSIGNING PORT\n");
    // Initialize the GPIO assigned just to avoid default values on the GPIO Status Register
    gpio_init(gpio_number);
    gpio_set_dir(gpio_number,GPIO_OUT);
    printf("Before GPIO OUT:\n");
    printf("%08x\n",*address);
    printf("AFTER GPIO OUT:\n");
    gpio_put(gpio_number,1);
    printf("%08x\n",*address);
    printf("===============================\n");
    sleep_ms(4000);
}

// read the status change of a specific GPIO port
void gpio_in_sample(){

    volatile uint32_t* address=GPIO_REGISTER_BASE+(uint32_t) 0x0A8;

    printf("GPIO IN SAMPLE BY PRESSING BOOT BUTTON\n");
    // gpio_init(21);
    // gpio_set_dir(21,GPIO_IN);
    printf("%08x\n",*address);
    printf("===============================\n");
    sleep_ms(4000);


}



int main(){

    stdio_init_all();
    sleep_ms(4000);
    while(true){
        printf("Choose from below:\n");
        printf("a. Read From Any Register by address;\n");
        printf("b. Load GPIO IN sample of pressing BOOT button;\n");
        printf("c. Load GPIO OUT sample for an pre-defined port;\n");
        int c = getchar_timeout_us(4 * 1000 * 1000);
        switch(c){
            case 'a':
                stdio_flush();
                printf("Input a regitser address:\n");
                char adds[8];
                bool is_invalid = false;
                int count = 0;
                while (count < 8){
                    int c = getchar_timeout_us(4 * 1000 * 1000);
                    if (c == PICO_ERROR_TIMEOUT){
                        printf("Input Time Out.\n");
                        is_invalid = true;
                        break;
                    }else if (!isxdigit(c)){
                        printf("Invalid Input.\n");
                        is_invalid = true;
                        break;
                    }
                    adds[count] = (char)c;
                    printf("%c",c);
                    count++;
                }
                if (is_invalid){
                    is_invalid = false;
                    continue;
                }else{
                    printf("%s\n",&adds);
                    uint32_t result = (uint32_t)strtol(adds, NULL, 16);
                    printf("The input address is %08x\n",result);
                    volatile uint32_t* address=get_address_by_base_offset(result,0x0);
                    printf("The values on this register are: ");
                    printf("%08x\n", *address);
                }
                break;
            case 'b':
                gpio_in_sample();
                break;
            case 'c':
                gpio_out_sample(29);
                break;
            case 'd':
                set_values_by_address(0x0A8,0x00000001);
                break;
               
        }
    }
    return 0;

}
