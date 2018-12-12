`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:52 11/19/2017 
// Design Name: 
// Module Name:    mux2_1 
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
