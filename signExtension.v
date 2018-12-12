`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:26 11/19/2017 
// Design Name: 
// Module Name:    signExtension 
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

module signExtension(in,out);
	input [15:0]in;
	output [31:0]out;
	assign out = $signed(in);
endmodule
