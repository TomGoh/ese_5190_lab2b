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