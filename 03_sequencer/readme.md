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