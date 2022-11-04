#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/irq.h"
#include "hardware/pwm.h"
#include "hardware/sync.h"
#include "music.h"

#define AUDIO_PIN 29
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

void init_audio(uint16_t wrap){

    gpio_set_function(AUDIO_PIN, GPIO_FUNC_PWM);

    uint pwm_pin = pwm_gpio_to_slice_num(AUDIO_PIN);
    pwm_clear_irq(pwm_pin);
    pwm_set_irq_enabled(pwm_pin, true);

    irq_set_exclusive_handler(PWM_IRQ_WRAP, pwm_interrput_handler);
    irq_set_enabled(PWM_IRQ_WRAP, true);

    pwm_config cfg = pwm_get_default_config();
    // pwm_config_set_clkdiv(&cfg, div);
    pwm_config_set_wrap(&cfg, wrap);
    // printf("wrap: %d\n",wrap);
    pwm_init(pwm_pin, &cfg, true);
    pwm_set_gpio_level(AUDIO_PIN, 0);
}

int main(void){

    stdio_init_all(); // init stdio
    // sleep_ms(10000);
    set_sys_clock_khz(22000, true); // set sys clock
    init_audio((uint16_t)250); // init audio

    while (true){
        __wfi();
    }
}
