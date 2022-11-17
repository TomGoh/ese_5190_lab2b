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
