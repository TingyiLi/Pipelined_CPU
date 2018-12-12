`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:25 11/19/2017 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(clock,reset,MemRead_ex,MemtoReg_ex,MemWrite_ex,RegWrite_ex,ALUresult,ReadData2_temp,WriteReg,MemRead_mem,MemtoReg_mem,MemWrite_mem,RegWrite_mem,ALUresult_mem,ReadData2_mem,WriteReg_mem);
	input clock,reset,MemRead_ex,MemtoReg_ex,MemWrite_ex,RegWrite_ex;
	input[31:0] ALUresult;
	input[31:0] ReadData2_temp;
	input[4:0] WriteReg;
	output reg MemRead_mem,MemtoReg_mem,MemWrite_mem,RegWrite_mem;
	output reg[31:0] ALUresult_mem;
	output reg[31:0] ReadData2_mem;
	output reg[4:0] WriteReg_mem;
	
	always @(posedge clock or posedge reset) begin
	if (reset==1'b1)
		begin
			MemRead_mem <= 0;
			MemtoReg_mem <= 0;
			MemWrite_mem <= 0;
			RegWrite_mem <= 0;
			ALUresult_mem <= 32'b0;
			ReadData2_mem <= 32'b0; 
			WriteReg_mem <= 5'b0;
		end
	else
		begin
			MemRead_mem <= MemRead_ex;
			MemtoReg_mem <= MemtoReg_ex;
			MemWrite_mem <= MemWrite_ex;
			RegWrite_mem <= RegWrite_ex;
			ALUresult_mem <= ALUresult;
			ReadData2_mem <= ReadData2_temp; 
			WriteReg_mem <= WriteReg;
		end
	end
endmodule
