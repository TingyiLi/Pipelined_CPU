`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:38 11/19/2017 
// Design Name: 
// Module Name:    pipeline 
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

module pipeline(clock,reset);
	input clock;
	input reset;
	//if stage
	wire [31:0]PC_if;
	wire RegDst,Jump,Branch,bne,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite;//controlunit
	wire IFIDWrite,PCWrite,IDFlush;//Hazard detection lw
	wire [31:0]ReadData1; //= regfile[readReg1];
	wire [31:0]ReadData2; //= regfile[readReg2];
	wire [31:0]ReadData;
	//reg [4:0]WriteReg;//which register to write back
	wire [31:0]WriteData;
	wire [31:0]extendedIm;
	wire [31:0]ALUsrc2,ALUsrc1; //input of ALU
	wire [3:0]aluControl;
	wire [31:0]ALUresult;
	wire [4:0] WriteReg;
	wire [31:0]targetPC1,targetPC2;
	wire [31:0]targetPC;
	wire [31:0] ReadData2_temp;
	//wire ifbranch;
	//or gate4(ifbranch,temp1,temp3);
	wire[31:0] NextPC_if;
	wire[31:0] Instruction_if;
	
	//IF/ID wires
	wire[31:0] NextPC_id;//newPC from previous
	wire[31:0] Instruction_id;
	wire[31:0] NextPC_temp;//data hazard lw bubble
	/****************************************/
	//ID/EX wires
	wire RegDst_ex,MemRead_ex,MemtoReg_ex,MemWrite_ex,ALUSrc_ex,RegWrite_ex;
	wire[1:0] ALUop_ex;
	wire[31:0] Instuction_ex;
	wire[31:0] ReadData1_ex;
	wire[31:0] ReadData2_ex;
	wire[31:0] Extended_ex;
	wire[4:0] rs_ex;//[25:21]
	wire[4:0] rt_ex;//[20:16]
	wire[4:0] rd_ex;//[15:11]
	wire[1:0] forward1,forward2;
	/*****************************************/
	//EX/MEM wires
	wire MemRead_mem,MemtoReg_mem,MemWrite_mem,RegWrite_mem;
	wire[31:0] ALUresult_mem;
	wire[31:0] ReadData2_mem;
	wire[4:0] WriteReg_mem;
	/****************************************/
	//MEM/WB wires
	wire MemtoReg_wb,RegWrite_wb;
	wire[31:0] ALUresult_wb;
	wire[4:0] WriteReg_wb;//writeback register
	wire[31:0] ReadData_wb;//data to write back
	/****************************************/
	mux2_1 mux_pc2(NextPC_if,targetPC,CHmux,targetPC1);
	mux2_1 mux_pc1(targetPC1,PC_if,PCWrite,targetPC2);
	pc PC_counter(targetPC2,reset,clock,PC_if);
	InstructionMemory IM(PC_if,Instruction_if);
	mux2_1 mux_Ins(Instruction_if,Instruction_id,IFIDWrite,Instruction_temp);
	Adder_32b adder1(PC_if,4,NextPC_if);
	mux2_1 mux_Next(NextPC_if,NextPC_id,IFIDWrite,NextPC_temp);
	/*****************************************************************************/					
	//IF/ID
	IF_ID II(clock,reset,IFFlush,NextPC_temp,Instruction_temp,Instruction_id,NextPC_id);
	Hazard_Detection HD(rt_ex,Instruction_id[25:21],Instruction_id[20:16],MemRead_ex,IDFlush,PCWrite,IFIDWrite);
	control controlUnit(Instruction_id[31:26],RegDst,Jump,Branch,bne,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
	RegFile RF(clock,Instruction_id[25:21],Instruction_id[20:16],WriteReg_wb,WriteData,RegWrite_wb,ReadData1,ReadData2);
	signExtension ImExtend(Instruction_id[15:0],extendedIm);
	wire [31:0] JumpAddress = {NextPC_id[31:28],Instruction_id[25:0],2'b00};
	wire [31:0] BranchAddr = NextPC_id + extendedIm*4;
	mux2_1 mux_Branch_Jump(BranchAddr,JumpAddress,Jump,targetPC);
	Control_Hazard CH(Jump,Branch,bne,WriteReg,WriteReg_mem,MemRead_ex,MemRead_mem,RegWrite_ex,RegWrite_mem,Instruction_id,ReadData1,ReadData2,ReadData,ALUresult,ALUresult_mem,CHmux,IFFlush);
	//control hazard
	/*******************************************************************************/
	//ID/EX
	ID_EX IE(clock,reset,IDFlush,Instruction_id,ReadData1,ReadData2,extendedIm,RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUop,RegDst_ex,MemRead_ex,MemtoReg_ex,MemWrite_ex,ALUSrc_ex,RegWrite_ex,ALUop_ex,Instuction_ex,ReadData1_ex,ReadData2_ex,Extended_ex,rt_ex,rs_ex,rd_ex);
	ALUcontrol alu_control(Extended_ex[5:0],ALUop_ex,aluControl);
	
	mux3_1 mux_alu3_rs(ReadData1_ex,WriteData,ALUresult_mem,forward1,ALUsrc1);
	
	mux3_1 mux_alu3_rt(ReadData2_ex,WriteData,ALUresult_mem,forward2,ReadData2_temp);
	
	mux2_1 mux_alu(ReadData2_temp,Extended_ex,ALUSrc_ex,ALUsrc2);

	mux5bit mux_writeReg(rt_ex,rd_ex,RegDst_ex,WriteReg);
	
	ALU alu_1(ALUsrc1,ALUsrc2,aluControl,ALUresult);
	
	ForwardUnit FU(rt_ex,rs_ex,WriteReg_mem,WriteReg_wb,RegWrite_mem,RegWrite_wb,forward1,forward2);
	/**********************************************************************************/
	//EX/MEM
	EX_MEM EM(clock,reset,MemRead_ex,MemtoReg_ex,MemWrite_ex,RegWrite_ex,ALUresult,ReadData2_temp,WriteReg,MemRead_mem,MemtoReg_mem,MemWrite_mem,RegWrite_mem,ALUresult_mem,ReadData2_mem,WriteReg_mem);
	
	DataMem DM(clock,ALUresult_mem,ReadData2_mem,MemWrite_mem,MemRead_mem,ReadData);
	/***********************************************************************************/
	//MEM/WB
	MEM_WB MW(clock,reset,MemtoReg_mem,RegWrite_mem,ALUresult_mem,ReadData,WriteReg_mem,MemtoReg_wb,RegWrite_wb,ALUresult_wb,WriteReg_wb,ReadData_wb);
	
	mux2_1 mux_writeback(ALUresult_wb,ReadData_wb,MemtoReg_wb,WriteData);
	
endmodule
