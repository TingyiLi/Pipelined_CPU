`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:06 11/19/2017 
// Design Name: 
// Module Name:    pc 
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

module pc(in,reset,clock,out);
	input [31:0] in;
	input	clock,reset;
	output reg[31:0] out;
	
	initial begin
		out = 32'b0;
	end
	
	always @(posedge clock or posedge reset) begin
	if (reset==1'b1)
		out <= 32'b0;
	else out <= in;
	end
endmodule
