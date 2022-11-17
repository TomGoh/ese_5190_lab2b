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
