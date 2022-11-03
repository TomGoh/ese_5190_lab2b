from time import sleep

import serial.tools.list_ports


def recv(serial):
    global data
    while True:
        data = serial.read(14)
        if data == '':
            continue
        else:
            break
        sleep(0.02)
    return data


if __name__ == '__main__':

    press_button = b'0x00000001'
    no_button = b'0x00000000'
    pressed = b's'
    no_press = b'k'

    path = '/Users/lize/Desktop/test.txt'
    port_list = list(serial.tools.list_ports.comports())

    pico = serial.Serial('/dev/cu.usbmodem1101', 115200, timeout=0.05)

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
