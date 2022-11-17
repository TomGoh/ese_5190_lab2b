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