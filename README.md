# Pipelined_CPU
Pipelined five-stages simple CPU with hazard detection

> The prject is based on description from Patterson, D. A., & Hennessy, J. L. (2009). Computer organization and design: The hardware/software interface. Burlington, MA: Morgan Kaufmann Publishers.

## Prerequisites

The project is implemented using Verilog. Xilinx ISE is recommended.

## Modules Introduction

* Instruction Memory
__Store the mips instructions.__ The input of this component is PC address, and the output of it is the according instructions.

* Register File
__Store information in the 32 registers.__ The inputs of this is the address of the two registers which will be read and regwrite which is used to determine whether existing data to be written in the register file. If there exists some data which should be inserted into the file, writedata contains the information of the data and writereg contains the address of register.

* Shifter with or without Length Change
__Shift the input right or left by n bits.__ It is efficient in multiplication.

* Sign Extension
__Extend a 16-bit number into a 32-bit number.__ Specially, the immediate part of “andi” instruction should be zero extended.

* ALU
__Perform operations of addition, subtraction and logic operations.__ The inputs of this component are data which will be processed and the control data which will be used to select the mode. Then the unit will output the results of the operations.

* ALU Control Unit
__Merge the information of the opcode and function.__ Return the correct control signal to ALU to select different operations.

* Data Memory
__Store the data in registers.__ The inputs of this component are the address of the data which will be read and the data which will be written. We use Aluop to control whether to use this component.

* Adder
__Add two inputs and output the result.__

* Mux
__Choose one input for the multi-input source with a selection signal.__

* Branch Detection Unit
__Use the signal zero and the “beq” or “bne” signal from the control unit, detect whether there’s a branch.__

## Hazards-avoiding design:
* Simple data hazard:
Forwarding unit can solve the problems in the consecutive instructions with data dependency. We add some mux to choose the input as either the register file or the later stage registers. Also, the forwarding unit can solve the problem of “sw” after “lw”.
* Double hazard:
The less recent forwarding method shouldn’t be called.
    * Load-use hazard:
    Insert a "nop" just after “lw” instruction is found in EX stage which has some correspondence with the instruction in ID stage. Also, we need to hold the IFID register and PC to avoid the instruction losing.
    * Control hazards:
    Add a detection unit to detect the jump/branch so that we can flush the values in the previous registers.
