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
