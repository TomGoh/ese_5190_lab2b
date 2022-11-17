# ESE 5210 LAB2b ESP

**Group Member: Ze Li, Haoze Wu, Xuanbiao Zhu**


> University of Pennsylvania ESE 5190
> 
> Test on:
>  
> 1. MacBook Air M2 MacOS Ventura 13.0.1
> 
> 2. Lenovo Thinkbook 16+ Ubuntu 22.04 LTS

## Chapter 0. Overview 

[1. 01_registers](#1)

[2. 02_repl](#2)

[3. 03_sequencer](#3)

[4. 04_slow_motion](#4)

[5. 05_i2c_traffic](#5)

[6. 06_pioscope](#6)

[7. 07_pio_sequencer](#7)

[8. 08_adps_protocol](#8)

[9. 09_lab_on_a_chip](#9)

[10. 10_protoboard](10)

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







## <span id="2">Chapter 2 02_repl<span>

### TODO:

Create a REPL to let you read and write RP2040 registers from a console. You should be able to:
- select any 32-bit address to read/write (even if not a valid RP2020 address)
- read/write any 32-bit value to this address
- read/write using any of the atomic bit-setting aliases and a 32-bit mask 

In this part, the main purpose is to using the addressed input to write or read values from the register that mapped to that address.

First, for reading the register by assigning the address, we just create a funciton to calculate the address of a register by adding the offset to the base address :
```c
uint32_t* get_address_by_base_offset(uint32_t base, uint32_t offset){
    return (uint32_t*) (base+offset);
}

```
For the obtained address, we just using `printf` function to directly print out the values in that memory. Writing the register is similar, we just create a funtion to directly set the value in a given memory address:
```c
void set_values_by_address(uint32_t address, uint32_t value){
    volatile uint32_t* address_pointer=get_address_by_base_offset(GPIO_REGISTER_BASE,address);
    *address_pointer|=value;
}
```
by initializing a pointer and change the values of the memory connected to that pointer.

Second, foy the bit-wise read and write, we just make a little modification so that the general read and write would work. We first generate a mask by providing the ith position within the 32 bit data to change :
```c
uint32_t generate_mask(int position){
    uint32_t* mask=(uint32_t*) malloc(sizeof(uint32_t));
    *mask=1<<position;
    return ~(*mask);
}
```
to create a mask whose ith position is zero while other posistions are one. For reading the bit value, we just inverse the generated mask and using logic AND to filter the values of the positaion in the memory:
```c
uint32_t get_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    return (*address & ~*mask)>>position;
}
```
It is also similar to generate a mask, filter unrelated values and assign a bit of value to the memory address:
```c
void set_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    *address&=*mask;
    *address|=(value<<position);
}
```

## <span id="3">Chapter 3 03_sequencer<span>

### TODO:
Create a 'sequencer' that allows you to record BOOT button presses and play them on the Neopixel, and also play a sequence of read/write commands. You should be able to:
- record at a least a few seconds of button input to your RP2040 (in RAM)
- replay a recorded sequence on your NeoPixel
- loop a recording
- save a recording to your laptop (the Python Serial library is one way to do this)
- play a recording from your laptop
- record 'macros' (a sequence of console commands) based on keystrokes in your serial console
- hand-edit a list of register read/write commands on your laptop, and play them on the RP2040
- include multiple I/O sources in a recording, and remap among the following:
- inputs: BOOT button, console commands, register read/write commands
- outputs: neopixel color, neopixel brightness, data over serial, register read/write commands

### Sequencer

First, we use function getchar_timeout_us(0) to get the command from Computer.By using switch case function, sequencer can switch command from Computer and do the instruction.The code is in the folder 03_sequencer.
```c
 status.last_serial_byte = getchar_timeout_us(0);
        switch(status.last_serial_byte) { // poll every cycle
            case 's':
                status.button_is_pressed=0x00000001; // s means button is pressed 
                recording_flag = 1;
                break;
            case 'k':
                status.button_is_pressed=0x00000000;// k means button is not be pressed
                recording_flag = 1;
                break;
        }
```

### PySerial

Second, with the PySerial port, we can easily communicate with our RP2040.

```py
port_list = list(serial.tools.list_ports.comports())
pico = serial.Serial('/dev/ttyACM0', 115200, timeout=0.05)
```

Then, we use the I/O stream of Python to Read/Write the Button Data in a txt file of Computer.
```py
 recording = open(path, 'wb+')
    i = 0
    while i <= 500:
        data = recv(pico)
        recording.write(data)
        i = i + 1
    recording.close()
    print("begin.......")
    recording = open(path, 'rb+')

    line = recording.readline()[0:10]
    while line:
        if line == press_button:
            pico.write(pressed)
        if line == no_button:
            pico.write(no_press)
        line = recording.readline()[0:10]
        sleep(0.01)
    pico.close()
    recording.close()
```

### Finally, by sending s/k, RP2040 can change the status of BOOT button.

## <span id="4">Chapter 4 04_slow_motion<span>

### TODO:
- Update your sequencer to be able to slow down and speed up recordings/replay. On the input side, the goal is ultimately to be able to handle the full 4 Gbps "firehose" from the PIO logic analyzer example in the SDK manual, which would fill up 256Kb of RAM in only 31 µs at a system clock speed of 125000 MHz if captured 'raw'! On the output side, the goal is to be able to output precisely timed sequences from the PIO at system clock resolution based on a handful of control points.

First,we should define the Recording Function:

```c
void recording(int button_counter,uint32_t color,int time){
    int counter = button_counter;
    while(counter!=0){
        set_neopixel_color(color);
        counter--;
        sleep_ms(time);
    }
}

```

Second, using character '1' to add the delay time which can lead to decrease the recording time and character '0' to minus the delay time which can lead to increase the recording time.

```c
case '1':
                delay_time++; //set the Recording time
                break; 
case '0':
                delay_time--; //set the Recording time
                break;
```

Finally, using the case 'r' to record the Button status.

```c
case 'r':
                recording(button_counter,status.light_color,delay_time);
                break;
```



## <span id="5">Chapter 5 05_i2c_traffic<span>

### TODO:
- Use the firefly code to generate ADPS9960 I2C traffic and display it on a lab oscilloscope. 
- Take screenshots of some portion of this exchange, and figure out what's happening based on the protocol documentation in the ADPS9960 datasheet.

### Connection
The connection between oscilloscope and APDS9960.

We use the first probe (X probe) to connect to the SDA with x10, the second probe(Y probe) to the CLK, and two associated black probes to the GND. 

![img](/05_i2c_traffic/assets/fig_1-min.png)

### What shows in the oscilloscope: 

![img](/05_i2c_traffic/assets/fig_2-min.png)



![img](/05_i2c_traffic/assets/fig_3-min.png)



![img](/05_i2c_traffic/assets/fig_4-min.png)


## <span id="6">Chapter 6 06_pioscope<span>

### TODO

1. Update your sequencer to be able to slow down and speed up recordings/replay. On the input side, the goal is ultimately to be able to handle the full 4 Gbps "firehose" from the PIO logic analyzer example in the SDK manual, which would fill up 256Kb of RAM in only 31 µs at a system clock speed of 125000 MHz if captured 'raw'! On the output side, the goal is to be able to output precisely timed sequences from the PIO at system clock resolution based on a handful of control points.

2. update your sequencer to be able to record just the timestamped transitions between input values, and to be able to play data in this format 

3. give your sequencer the ability to select a range of output rates for both live and recorded input 

First, we need to change the pin value of pio_analyser.
```c
const uint CAPTURE_PIN_BASE = 22;
const uint CAPTURE_PIN_COUNT = 1;
const uint CAPTURE_N_SAMPLES = 9600;
const uint TRIGGER_PIN = 21;
```


![img](/06_pioscope/assests/06.png)



## <span id="7"> Chapter 7 07_pio_sequencer <span>

### TODO:

- modify your sequencer to use the PIO as its primary I/O engine, including the ability to R/W any register 

For this part, we write a pio which takes an input from an GPIO pin and move the value from the pin to the X register in the PIO module. Then, offside the values to another GPIO pin associated with the sideset. Then using the `gpio_get` function to monitor the current level of the GPIO pin:
```asm
.program sequencer
.side_set 1

; set pindirs, 0


.wrap_target
set pindirs, 1       side 0 [15]

loop:
    mov x, pins      side 0 [1]
    jmp !x do_one    side 0 [1]
do_zero:
    nop              side 0 [5]
    jmp loop         side 0 [5]
do_one:
    nop              side 1 [5]
    jmp loop         side 1 [5]
.wrap
```
In the configuration of this PIO module, we set the clock and time division based on the current level time:
```c
  int cycles_per_bit = 16;
  float div=clock_get_hz(clk_sys) / (freq*cycles_per_bit);
  sm_config_set_clkdiv(&config, div);
```
so that the output could match the time period of the time of the cycle of sampling the GPIO for one cycle.


## <span id="8"> Chapter 8 08_adps_protocol <span>

### TODO:
Use the capabilities of your sequencer to implement the ADPS9960 protocol and control the sensor.

In this section, we deploy an I2C protocol for APDS9960 using the I2C PIO from the `pico-example`, and also with reference and modification from Dang0v's [repo](https://github.com/Dang0v/ese5190-2022-lab2b-esp/tree/main/lab/08_adps_protocol).

For the  APDS9960 protocol, from the basis of Dang0v's repo, we made better encapsulation of the API provided from the APDS9960 header to the main function. 

For the Initialization funtion of APDS9960:
```c
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
```
The buffer declared at the begining of the function is used to reserved the register address and the initialize config for the sensor. Then after using the array packaging the address and data to be transmittedm the PIO would using the `pio_i2c_write_blocking` function to write a block of data to the APDS9960 sensor by providing the address to be sent to.

After initialized the sensor, reading any data from the sensor would follow the order as follows:
- Write a certain data to the address of the register, still hold the connection of the I2C protocol.
- Read a certain amount data from the sensor into a predefined array buffer then terminate the transimission.

```c
void read_proximity(int32_t* proximity, PIO pio, uint sm, uint8_t addr, bool nostop) {

    uint8_t buf[1];
    uint8_t reg = PDATA_REG;
    pio_i2c_write_blocking(pio, sm, addr, &reg, 1, nostop);  
    pio_i2c_read_blocking(pio, sm, addr, buf, 1); 

    *proximity = buf[0];
}
```
Here, to read the proximity data from the sensor, first using the PIO to send a block of data to the address of APDS9960, through assgining the data(`reg` here) and the length to be sent(1 here). Then read the data sent from the sensor in to the buffer `buf`.

After using the PIO to read data from the sensor, using the defined structure to save the data:
```c
struct Info{
    int32_t r;
    int32_t g;
    int32_t b;
    int32_t c;
    int32_t proximity;
};
```
The result could be as follows:
![](/assets/08.png)
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



## <span id="10"> Chapter 10 10_protoboard <span>
### TODO:

Add support for your custom circuit board to your sequencer, and give a demo.

### Intro
In this part, we use PWM to functionality in GPIO to generate the specific wave for different scale in music, which could be used in the speaker to play. 

### Initialize the PWM
First, we define a `init_audio` function to initialize the PWM function and play music if the interruption occurs. 

In this Init function, we do several things:
    1. Set the PWM functionality.
    2. Set the input PIN for PWM. 
    3. Configure the Interrupt function for PWM.
    4. Setup the Maximum value to the Counter, given my the param. 
    5. Initialize the PWM and default PIN level. 

```c
    void init_audio(uint16_t wrap){
        
        // Set the PWM functionality.
        gpio_set_function(AUDIO_PIN, GPIO_FUNC_PWM);

        // Define the pwm slice pin
        uint pwm_pin = pwm_gpio_to_slice_num(AUDIO_PIN);
        // clear the interruption.
        pwm_clear_irq(pwm_pin);
        // set the interruption enabled.
        pwm_set_irq_enabled(pwm_pin, true);

        irq_set_exclusive_handler(PWM_IRQ_WRAP, pwm_interrput_handler);
        irq_set_enabled(PWM_IRQ_WRAP, true);

        pwm_config cfg = pwm_get_default_config();
        // pwm_config_set_clkdiv(&cfg, div);
        // Set the wrap number, which determine the number of duty circle you want to devide. 
        pwm_config_set_wrap(&cfg, wrap);
        // printf("wrap: %d\n",wrap);

        // Initialize the pwm given the configuration.
        pwm_init(pwm_pin, &cfg, true);
        pwm_set_gpio_level(AUDIO_PIN, 0);
    }
```

The idea underhood is that we tune the duty circle for each music scale. 
In each PWM, we have a Counter that increases during time passes. Compared with input value, when Counter is smaller than input value, the GPIO outputs 0, and when it is greater, the GPIO outputs 1. 

To make use of this functionality and create different wave patterns for different music scales, we could set the `wrap` to 250, which means the maximum value the Counter could go, and we could input the music scale (which is represented as an integer in the range of [0, 249] in `music.h`). Therefore, given the different music scales, we have different wave patterns. Here is the reference [Chapter 4.5. PWM](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf)

### Listen to the interrupt
Second, we set the waiting loop to listen the interruption. If it occurs, which means a music scale data is passed, the whole program will start to send the wave to the given scale. 
```c
    while (true){
        __wfi();
    }
```

### Interrupt handler
Thrid, as what we already said, we define the `pwm_interrupt_handler()` to realize the interrupt logic.

```c
int position = 0;
void pwm_interrput_handler(){
    pwm_clear_irq(pwm_gpio_to_slice_num(AUDIO_PIN));
    if (position < (DATA_LENGTH << 3) - 1){
        pwm_set_gpio_level(AUDIO_PIN, DATA[position >> 3]);
        position++;
    }
    else{
        position = 0;
    }
}
``` 

When there is data, we move the pointer and pass the given data into the GPIO of PWM.

### Demo
The wire connection is shown as follows:
![](/assets/10.jpg)






