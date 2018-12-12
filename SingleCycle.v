`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:16 11/15/2017 
// Design Name: 
// Module Name:    SingleCycle 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SingleCycle(clock);
	input clock;
	reg [31:0]PC = 0;
	wire [31:0]instruction;
	InstructionMemory IM(PC,instruction);
	wire [5:0]opcode = instruction[31:26];
	wire [4:0]readReg1 = instruction[25:21];
	wire [4:0]readReg2 = instruction[20:16];
	wire [4:0]RegRd = instruction[15:11];
	wire [5:0]func = instruction[5:0];
	wire [15:0]immediate = instruction[15:0];
	wire [25:0]jumpaddr = instruction[25:0];
	
	wire [31:0]extendedIm;
	signExtension ImExtend(immediate,extendedIm);
	
	wire RegDst,Jump,Branch,bne,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	wire [1:0]ALUop;
	control controlUnit(opcode,RegDst,Jump,Branch,bne,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
		
	wire [31:0]ReadData1; //= regfile[readReg1];
	wire [31:0]ReadData2; //= regfile[readReg2];
	wire [4:0]WriteReg;//which register to write back
	wire [31:0]WriteData;
	
	mux5bit mux_writeReg(readReg2,RegRd,RegDst,WriteReg);
	RegFile RF(readReg1,readReg2,WriteReg,WriteData,RegWrite,ReadData1,ReadData2);
	
	wire [31:0] ALUsrc2; //second input of ALU
	mux2_1 mux_alu(ReadData2,extendedIm,ALUSrc,ALUsrc2);
	
	wire [3:0]aluControl;
	ALUcontrol alucontrol(func,ALUop,aluControl);
	
	wire [31:0]ALUresult;
	wire ZERO;
	ALU alu(ReadData1,ALUsrc2,aluControl,ALUresult,ZERO);
	
	wire [31:0]ReadData; //data memory output
	DataMem DM(ALUresult,ReadData2,MemWrite,MemRead,ReadData);
	
	mux2_1 mux_writeback(ALUresult,ReadData,MemtoReg,WriteData);
		
	wire[31:0]newPC = PC+4;
	wire[31:0]branchAddr = newPC + extendedIm*4; 
	wire[31:0]JumpAddress = {PC[31:28],jumpaddr,2'b00};
	wire[31:0]tempPC;
	wire[31:0]targetPC;
	
	//wire temp1,temp2,temp3;
	//and gate1(temp1,Branch,ZERO);
	//not gate2(temp2,ZERO);
	//and gate3(temp3,bne,temp2);
	
	wire ifbranch = (Branch && ZERO) || (bne &&(~ZERO));
	
	//wire ifbranch;
	//or gate4(ifbranch,temp1,temp3);
	
	mux2_1 mux_ifbranch(newPC,branchAddr,ifbranch,tempPC);
	mux2_1 mux_ifjump(tempPC,JumpAddress,Jump,targetPC);
	
	always @(posedge clock) begin
		PC <= targetPC;
	end
endmodule

module InstructionMemory(ReadAddress,Instruction);
	input [31:0]ReadAddress;
	output reg [31:0]Instruction;
	reg [31:0]memory[29:0];
	initial begin
		memory[0] = 32'b00100000000010000000000000100000; //addi $t0, $zero, 0x20
		memory[1] = 32'b00100000000010010000000000100111; //addi $t1, $zero, 0x27
		memory[2] = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
		memory[3] = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
		memory[4] = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
		memory[5] = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
		memory[6] = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
		memory[7] = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
		memory[8] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
		memory[9] = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
		memory[10]= 32'b00110010001100100000000000011000; //andi $s2, $s1, 0x18
		memory[11] =32'b00010010001100100000000000001001; //beq $s1, $s2, error1
		memory[12] =32'b10001100000100110000000000001000; //lw $s3, 8($zero)
		memory[13] =32'b00010010000100110000000000001010; //beq $s0, $s3, error2
		memory[14] =32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
		memory[15] =32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
		memory[16] =32'b00000010001000001001000000100000; //add $s2, $s1, $0
		memory[17] =32'b00001000000000000000000000001110; //j Last
		memory[18] =32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
		memory[19] =32'b00100000000010010000000000000000; //addi $t1, $0, 0
		memory[20] =32'b00001000000000000000000000011111; //j EXIT
		memory[21] =32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
		memory[22] =32'b00100000000010010000000000000001; //addi $t1, $0, 1
		memory[23] =32'b00001000000000000000000000011111; //j EXIT
		memory[24] =32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
		memory[25] =32'b00100000000010010000000000000010; //addi $t1, $0, 2
		memory[26] =32'b00001000000000000000000000011111; //j EXIT
		memory[27] =32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
		memory[28] =32'b00100000000010010000000000000011; //addi $t1, $0, 3
		memory[29] =32'b00001000000000000000000000011111; //j EXIT
		//memory[30] =32'b00000000000000000000000000000000;
	end
	always @(ReadAddress) begin
		Instruction = memory[ReadAddress/4];
	end
endmodule

module RegFile(readReg1,readReg2,writeReg,writeData,regWrite,readData1,readData2);
	input [4:0]readReg1,readReg2,writeReg;
	input regWrite;
	input [31:0]writeData;
	output reg [31:0]readData1,readData2;
	reg [31:0]regfile[31:0];
	initial begin
		regfile[0]=32'b0;
		regfile[1]=32'b0;
		regfile[2]=32'b0;
		regfile[3]=32'b0;
		regfile[4]=32'b0;
		regfile[5]=32'b0;
		regfile[6]=32'b0;
		regfile[7]=32'b0;
		regfile[8]=32'b0;
		regfile[9]=32'b0;
		regfile[10]=32'b0;
		regfile[11]=32'b0;
		regfile[12]=32'b0;
		regfile[13]=32'b0;
		regfile[14]=32'b0;
		regfile[15]=32'b0;
		regfile[16]=32'b0;
		regfile[17]=32'b0;
		regfile[18]=32'b0;
		regfile[19]=32'b0;
		regfile[20]=32'b0;
		regfile[21]=32'b0;
		regfile[22]=32'b0;
		regfile[23]=32'b0;
		regfile[24]=32'b0;
		regfile[25]=32'b0;
		regfile[26]=32'b0;
		regfile[27]=32'b0;
		regfile[28]=32'b0;
		regfile[29]=32'b0;
		regfile[30]=32'b0;
		regfile[31]=32'b0;
	end
	always @(readReg1 or readReg2 or writeReg or regWrite or writeData) begin
		readData1 = regfile[readReg1];
		readData2 = regfile[readReg2];
		if (regWrite) regfile[writeReg] = writeData;
	end
endmodule

module DataMem(Address,WriteData,MemWrite,MemRead,ReadData);
	input [31:0]Address,WriteData;
	input MemWrite,MemRead;
	output reg[31:0]ReadData;
	reg [31:0]DM[31:0];
	
	initial begin
		DM[0] = 32'b0;
		DM[1] = 32'b0;
		DM[2] = 32'b0;
		DM[3] = 32'b0;
		DM[4] = 32'b0;
		DM[5] = 32'b0;
		DM[6] = 32'b0;
		DM[7] = 32'b0;
		DM[8] = 32'b0;
		DM[9] = 32'b0;
		DM[10] = 32'b0;
		DM[11] = 32'b0;
		DM[12] = 32'b0;
		DM[13] = 32'b0;
		DM[14] = 32'b0;
		DM[15] = 32'b0;
		DM[16] = 32'b0;
		DM[17] = 32'b0;
		DM[18] = 32'b0;
		DM[19] = 32'b0;
		DM[20] = 32'b0;
		DM[21] = 32'b0;
		DM[22] = 32'b0;
		DM[23] = 32'b0;
		DM[24] = 32'b0;
		DM[25] = 32'b0;
		DM[26] = 32'b0;
		DM[27] = 32'b0;
		DM[28] = 32'b0;
		DM[29] = 32'b0;
		DM[30] = 32'b0;
		DM[31] = 32'b0;
	end
	
	always @(Address or WriteData or MemWrite or MemRead) begin
		if (MemRead) ReadData = DM[Address]; //lw
		if (MemWrite) DM[Address] = WriteData; //sw
	end
endmodule

module signExtension(in,out);
	input [15:0]in;
	output [31:0]out;
	assign out = $signed(in);
endmodule

module mux2_1(src1,src2,sel,result);
	parameter N = 32;
	input [N-1:0] src1,src2;
	input sel;
	output reg [N-1:0] result;
	
	always @(sel,src1,src2) begin
		case (sel) 
			1'b0: result = src1;
			1'b1: result = src2;
		endcase
	end
endmodule

module mux5bit(src1,src2,sel,result);
	parameter size = 5;
	input [size-1:0] src1,src2;
	input sel;
	output reg [size-1:0] result;
	
	always @(sel,src1,src2) begin
		case (sel) 
			1'b0: result = src1;
			1'b1: result = src2;
		endcase
	end
endmodule

module ALUcontrol(func,ALUop,ALUControl);
	input [5:0]func;
	input [1:0]ALUop;
	output reg [3:0]ALUControl;

	always @(func or ALUop) begin
		case (ALUop)
			2'b00: ALUControl = 4'b0010; //add
			2'b01: ALUControl = 4'b0110; //subtract
			2'b10: 
				case(func)
					6'b100000: ALUControl = 4'b0010; //add
					6'b100010: ALUControl = 4'b0110; //subtract
					6'b100100: ALUControl = 4'b0000; //AND
					6'b100101: ALUControl = 4'b0001; //OR
					6'b101010: ALUControl = 4'b0111; //set-on-less-than
					default: ALUControl = 4'b0000;
				endcase
			2'b11: ALUControl = 4'b0000; //AND
			default: ALUControl = 4'b0000;
		endcase
	end
endmodule

module ALU(ALUsrc1,ALUsrc2,ALUControl,result,ZERO);
	parameter N=32;
	input [N-1:0]ALUsrc1,ALUsrc2;
	input [3:0]ALUControl;
	output reg [N-1:0]result;
	output reg ZERO;
	
	always @(ALUsrc1,ALUsrc2,ALUControl) begin
		case (ALUControl)
			4'b0000: result = ALUsrc1 & ALUsrc2; // AND
			4'b0001: result = ALUsrc1 | ALUsrc2; // OR
			4'b0010: result = ALUsrc1 + ALUsrc2; // add
			4'b0110: begin 
				result = ALUsrc1 - ALUsrc2; // subtract
				if(result == 0) ZERO = 1;
				else ZERO = 0;
			end
			4'b0111: begin
				result = ALUsrc1 < ALUsrc2; // set-on-less-than
				if(result == 0) ZERO = 1;
				else ZERO =0;
			end
			4'b1100: result = ~(ALUsrc1 | ALUsrc2); // NOR
		endcase
	end
endmodule

module control(opcode,RegDst,Jump,Branch,bne,MemRead,MemtoReg,ALUop,MemWrite,ALUsrc,RegWrite);
	input [5:0]opcode;
	output reg RegDst,Jump,Branch,bne,MemRead,MemtoReg,MemWrite,ALUsrc,RegWrite;
	output reg [1:0] ALUop;
	
	initial begin 
		RegDst=0;
		Jump=0;
		Branch=0;
		bne=0;
		MemRead=0;
		MemtoReg=0;
		ALUop=2'b00;
		MemWrite=0;
		ALUsrc=0;
		RegWrite=0;
	end

	always @(opcode) begin
		case(opcode)
			6'h0:begin //R-type
				RegDst=1;
				Jump=0;
				Branch=0;
				bne=0;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b10;
				MemWrite=0;
				ALUsrc=0;
				RegWrite=1;
			end
			6'h8:begin //addi
				RegDst=0;
				Jump=0;
				Branch=0;
				bne=0;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b00; //add
				MemWrite=0;
				ALUsrc=1;
				RegWrite=1;
			end
			6'hc:begin //andi
				RegDst=0;
				Jump=0;
				Branch=0;
				bne=0;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b11;
				MemWrite=0;
				ALUsrc=1;
				RegWrite=1;
			end
			6'h4:begin //beq
				RegDst=0;
				Jump=0;
				Branch=1;
				bne=0;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b01; //subtract
				MemWrite=0;
				ALUsrc=0;
				RegWrite=0;
			end
			6'h5:begin //bne
				RegDst=0;
				Jump=0;
				Branch=0;
				bne=1;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b01; //subtract
				MemWrite=0;
				ALUsrc=0;
				RegWrite=0;
			end
			6'h2:begin //jump
				RegDst=0;
				Jump=1;
				Branch=0;
				bne=0;
				MemRead=0;
				MemtoReg=0;
				ALUop=2'b00;
				MemWrite=0;
				ALUsrc=0;
				RegWrite=0;
			end
			6'h23:begin //lw
				RegDst=0;
				Jump=0;
				Branch=0;
				bne=0;
				MemRead=1;
				MemtoReg=1;
				ALUop=2'b00;
				MemWrite=0;
				ALUsrc=0;
				RegWrite=1;
			end
			6'h2b:begin //sw
				RegDst=0;
				Jump=0;
				Branch=0;
				bne=0;
				MemRead=1;
				MemtoReg=0;
				ALUop=2'b00;
				MemWrite=1;
				ALUsrc=0;
				RegWrite=0;
			end
		endcase
	end
endmodule
