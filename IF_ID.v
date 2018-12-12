`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:32:48 11/19/2017 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID (clock,reset,IFFlush,NextPC_temp,Instruction_temp,Instruction_id,NextPC_id);
	input clock,reset,IFFlush;
	input[31:0] NextPC_temp,Instruction_temp;
	output reg[31:0] Instruction_id,NextPC_id;
	
	always @(posedge clock or posedge reset) begin
	if (reset==1'b1)
		begin
			Instruction_id <= 32'b0;
			NextPC_id <= 32'b0;
		end
	else if (IFFlush)
	   begin
			Instruction_id <= 32'b0;
			NextPC_id <= 32'b0;
		end
	else
		begin 
			Instruction_id <= Instruction_temp;
			NextPC_id <= NextPC_temp;
		end
	end
endmodule
