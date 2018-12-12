`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:14 11/19/2017 
// Design Name: 
// Module Name:    mux5bit 
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
