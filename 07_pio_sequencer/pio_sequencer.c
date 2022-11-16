#include <stdio.h>
#include <stdbool.h>
#include <pico/stdlib.h>
#include <hardware/pio.h>
#include <sequencer.pio.h>
#include "hardware/clocks.h"
#define OUT_PIN 26



int main() {
  stdio_init_all();
  set_sys_clock_48mhz();
  PIO pio = pio0;
  uint state_machine_id = 0;
  uint offset = pio_add_program(pio, &sequencer_program);  
  sequencer_program_init(pio, state_machine_id, offset, OUT_PIN,16);


  while(true) {
    bool current_value = gpio_get(OUT_PIN);
    printf("%d",current_value);
    // sleep_ms(160);
  }
}