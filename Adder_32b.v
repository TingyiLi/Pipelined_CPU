`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:15 11/19/2017 
// Design Name: 
// Module Name:    Adder_32b 
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
module Adder_32b(A,B,C);
   input [31:0] A,B;
	output [31:0] C;
   assign C=A+B;
endmodule
