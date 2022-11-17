## <span id="9"> Chapter 9 09_lab_on_a_chip <span>

### TODO:
> - Make sure the system have the following functions:
>   1. color packet delivered to PIO module
>   2. bit delivered to WS2812 (24x/packet)
>   3. full packet delivered to WS2812
>   4. brightness changed on APD
> - Besides that:
>   1. Run this experiment in both dark and light room settings (record initial ambient brightness in each case). The Neopixel should start 'off' and the ADPS9960 should be initialized with your preferred sampling rate (you may want to try a few different rates).
>   2. Run the experiment for at least 100 samples at brightness settings of 0%, 25%, 50%, 75%, 100% (making sure to give the ADPS reading enough time to 'settle' each time Neopixel is turned off).
>   3. Report the observed 'jitter' based on misalignment with the free-running PWM module on the WS2012.

### Intro
In this part, we combine what we have in the section 8 with ws2812 program we already have to build up a system that could diliver the information from APDS9960 to WS2812 with the help of PIO. 

### Main
In `main.c`  we first initialize our i2c and APDS9960 program we have in the section 8, and in the main loop, we periodically read the data from PIO and pass the data using GPIO to WS2812. Notice that we save our APDS9960 in `pio0` and save WS2812 in `pio1`.

1. Initialize the i2c and APDS9960 program.
```c
    // Initialize the PIO
    uint offset_0 = pio_add_program(pio_0, &i2c_program);
    // Initialize the 
    i2c_program_init(pio_0, sm_0, offset_0, PIN_SDA, PIN_SCL);
    APDS9960_init(pio_0, sm_0, addr, false);
```

1. Pass data in WS2812. Here we encapsulate the whole process including from initialization to transmitting data. As we said before, we use `info` struct to save the data. 
```c
    set_neopixel_color(rgb_to_neopixel(info.r, info.g, info.b));
```

### APDS9960 program
Since we have already explain this part, we skip it in this section. 

### WS2812 program
We encapsulate all process in `set_neopixel_color` function and use `pio_sm_put_blocking` to pass all data into WS2812. Here is some part of code in `set_neopixel_color`. 

```c
    // Initialize the pio program 
    uint offset = pio_add_program(pio, &ws2812_program);

    // Initialize the WS2812 program 
    ws2812_program_init(pio, sm, offset, WS2812_PIN, 800000, IS_RGBW);

    // Change the form of color.   
    uint32_t result=((uint32_t)(color&0xff0000) >>8) | ((uint32_t)(color&0x00ff00)<<8) | ((uint32_t)(color&0x0000ff));

    // pass color into pio 
    pio_sm_put_blocking(pio1, 1, result << 8u);
```

### Conclusion
Finally, We could use two PIOs in a RP2040 to complete the data transmission from APDS9960 to WS2812. 



The effect of this part is as follows:
![](/assets/09.gif)