`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:24 11/20/2017 
// Design Name: 
// Module Name:    mux3_1 
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
module mux3_1(src1,src2,src3,sel,result);
	parameter N = 32;
	input [N-1:0] src1,src2,src3;
	input[1:0] sel;
	output reg [N-1:0] result;
	
	always @(sel,src1,src2,src3) begin
		case (sel) 
			2'b00: result = src1;
			2'b01: result = src2;
			2'b10: result = src3;
		endcase
	end
endmodule
