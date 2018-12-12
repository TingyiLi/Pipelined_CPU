`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:53 11/20/2017 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX (clock,reset,IDFlush,Instruction_id,ReadData1,ReadData2,extendedIm,RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUop,RegDst_ex,MemRead_ex,MemtoReg_ex,MemWrite_ex,ALUSrc_ex,RegWrite_ex,ALUop_ex,Instuction_ex,ReadData1_ex,ReadData2_ex,Extended_ex,rt_ex,rs_ex,rd_ex);
	input clock,reset,IDFlush;
	input[31:0] Instruction_id,ReadData1,ReadData2;
	input RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
	input[1:0] ALUop;
	input[31:0] extendedIm;
	output reg RegDst_ex,MemRead_ex,MemtoReg_ex,MemWrite_ex,ALUSrc_ex,RegWrite_ex;
	output reg[1:0] ALUop_ex;
	output reg[31:0] Instuction_ex;
	output reg[31:0] ReadData1_ex;
	output reg[31:0] ReadData2_ex;
	output reg[31:0] Extended_ex;
	output reg[4:0] rt_ex,rs_ex,rd_ex;
	
	always @(posedge clock or posedge reset) begin
	if (reset==1'b1)
		begin
			RegDst_ex <= 0;
			MemRead_ex <= 0;
			MemtoReg_ex <= 0;
			MemWrite_ex <= 0;
			ALUSrc_ex <= 0;
			RegWrite_ex <= 0;
			ALUop_ex <= 2'b00;
			Instuction_ex <= 32'b0;
			ReadData1_ex <= 32'b0;
			ReadData2_ex <= 32'b0;
			Extended_ex <= 32'b0;
			rt_ex <= 5'b0;
			rs_ex <= 5'b0;
			rd_ex <= 5'b0;
		end
	else if (IDFlush==1'b1)
		begin
			RegDst_ex <= 0;
			MemRead_ex <= 0;
			MemtoReg_ex <= 0;
			MemWrite_ex <= 0;
			ALUSrc_ex <= 0;
			RegWrite_ex <= 0;
			ALUop_ex <= 2'b00;
			Instuction_ex <= 32'b0;
			ReadData1_ex <= 32'b0;
			ReadData2_ex <= 32'b0;
			Extended_ex <= 32'b0;
			rt_ex <= 5'b0;
			rs_ex <= 5'b0;
			rd_ex <= 5'b0;
		end
	else
		begin
			RegDst_ex <= RegDst;
			MemRead_ex <= MemRead;
			MemtoReg_ex <= MemtoReg;
			MemWrite_ex <= MemWrite;
			ALUSrc_ex <= ALUSrc;
			RegWrite_ex <= RegWrite;
			ALUop_ex <= ALUop;
			Instuction_ex <= Instruction_id;
			ReadData1_ex <= ReadData1;
			ReadData2_ex <= ReadData2;
			Extended_ex <= extendedIm;
			rs_ex <= Instruction_id[25:21];
			rt_ex <= Instruction_id[20:16];
			rd_ex <= Instruction_id[15:11];
		end
	end
endmodule
