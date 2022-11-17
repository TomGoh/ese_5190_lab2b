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