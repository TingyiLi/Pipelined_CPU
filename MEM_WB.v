`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:31 11/19/2017 
// Design Name: 
// Module Name:    MEM_WB 
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

module MEM_WB (clock,reset,MemtoReg_mem,RegWrite_mem,ALUresult_mem,ReadData,WriteReg_mem,MemtoReg_wb,RegWrite_wb,ALUresult_wb,WriteReg_wb,ReadData_wb);
	input clock,reset,MemtoReg_mem,RegWrite_mem;
	input[31:0] ALUresult_mem,ReadData;
	input[4:0] WriteReg_mem;
	output reg MemtoReg_wb,RegWrite_wb;
	output reg[31:0] ALUresult_wb;
	output reg[4:0] WriteReg_wb;
	output reg[31:0] ReadData_wb;
	
	always @(posedge clock or posedge reset) begin
		if (reset)
			begin
				MemtoReg_wb = 0;
				RegWrite_wb = 0;
				ALUresult_wb = 32'b0;
				WriteReg_wb = 5'b0;
				ReadData_wb = 32'b0;
			end
		else
			begin
				MemtoReg_wb = MemtoReg_mem;
				RegWrite_wb = RegWrite_mem;
				ALUresult_wb = ALUresult_mem;
				WriteReg_wb = WriteReg_mem;
				ReadData_wb = ReadData;
			end
	end
endmodule
