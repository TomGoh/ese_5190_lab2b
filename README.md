# ESE 5210 LAB2b ESP

**Group Member: Ze Li, Haoze Wu, Xuanbiao Zhu**


> University of Pennsylvania ESE 5190
> 
> Test on:
>  
> 1. MacBook Air M2 MacOS Ventura 13.0.1
> 
> 2. Lenovo Thinkbook 16+ Ubuntu 22.04 LTS

## Chapter 0. Overview 

[1. 01_registers](#1)

[2. 02_repl](#2)

3. 03_sequencer

4. 04_slow_motion

5. 05_i2c_traffic

6. 06_pioscope

7. 07_pio_sequencer

8. 08_adps_protocol

9. 09_lab_on_a_chip

10. 10_protoboard

## <span id="1">Chapter 1  01_register<span>



## <span id="2">Chapter 2  02_repl<span>

### TODO:

Create a REPL to let you read and write RP2040 registers from a console. You should be able to:
- select any 32-bit address to read/write (even if not a valid RP2020 address)
- read/write any 32-bit value to this address
- read/write using any of the atomic bit-setting aliases and a 32-bit mask

In this part, the main purpose is to using the addressed input to write or read values from the register that mapped to that address.

First, for reading the register by assigning the address, we just create a funciton to calculate the address of a register by adding the offset to the base address :
```c
uint32_t* get_address_by_base_offset(uint32_t base, uint32_t offset){
    return (uint32_t*) (base+offset);
}

```
For the obtained address, we just using `printf` function to directly print out the values in that memory. Writing the register is similar, we just create a funtion to directly set the value in a given memory address:
```c
void set_values_by_address(uint32_t address, uint32_t value){
    volatile uint32_t* address_pointer=get_address_by_base_offset(GPIO_REGISTER_BASE,address);
    *address_pointer|=value;
}
```
by initializing a pointer and change the values of the memory connected to that pointer.

Second, foy the bit-wise read and write, we just make a little modification so that the general read and write would work. We first generate a mask by providing the ith position within the 32 bit data to change :
```c
uint32_t generate_mask(int position){
    uint32_t* mask=(uint32_t*) malloc(sizeof(uint32_t));
    *mask=1<<position;
    return ~(*mask);
}
```
to create a mask whose ith position is zero while other posistions are one. For reading the bit value, we just inverse the generated mask and using logic AND to filter the values of the positaion in the memory:
```c
uint32_t get_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    return (*address & ~*mask)>>position;
}
```
It is also similar to generate a mask, filter unrelated values and assign a bit of value to the memory address:
```c
void set_bit_value_by_address(uint32_t* address, uint32_t value, int position){
    uint32_t* mask =generate_mask(position);
    *address&=*mask;
    *address|=(value<<position);
}
```


## <span id="10"> Chapter 09_lab_on_a_chip <span>

## <span id="10"> Chapter 10 10_protoboard <span>
### TODO:

Add support for your custom circuit board to your sequencer, and give a demo.

In this part, we use PWM to functionality in GPIO to generate the specific wave for different scale in music, wbi




