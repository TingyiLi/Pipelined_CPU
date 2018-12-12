`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:52 11/19/2017 
// Design Name: 
// Module Name:    DataMem 
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
module DataMem(clock,ALUresult_mem,ReadData2_mem,MemWrite_mem,MemRead_mem,ReadData);//unchanged
	input clock;
	input [31:0]ALUresult_mem,ReadData2_mem;
	input MemWrite_mem,MemRead_mem;
	output [31:0]ReadData;
	reg [31:0] DM[0:31];
	
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
	
	always @(negedge clock) begin
		//if (MemRead_mem) ReadData = DM[ALUresult_mem/4]; //lw
		if (MemWrite_mem) DM[ALUresult_mem/4] = ReadData2_mem; //sw
	end
	assign ReadData=(MemRead_mem)?DM[ALUresult_mem/4]:32'bx;
endmodule
