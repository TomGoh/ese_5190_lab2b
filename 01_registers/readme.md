## <span id="1">Chapter 1  01_register<span>

### TODO:

Toggle the Qt Py's Neopixel LED when the BOOT button is pressed, using only direct register reads to access the boot button status. You may use the SDK to initialize the board and the pins, and the WS2812 example code to toggle the Neopixel.

In this part, we need to read the status of BOOT Button by reading BOOT Button status register.
```c
 add = base + 0x0a8; // add is the address of the button's status register

        uint32_t button_value = *add;

        
        if(button_value){
            set_neopixel_color(0x000000);
        }
        else if(!button_value){
            set_neopixel_color(0x00ff00);
        }
```