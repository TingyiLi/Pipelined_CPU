`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:45 11/19/2017 
// Design Name: 
// Module Name:    ALUcontrol 
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
module ALUcontrol(func,ALUop,ALUControl);
	input [5:0]func;
	input [1:0]ALUop;
	output reg [3:0]ALUControl;

	always @(func or ALUop) begin
		case (ALUop)
			2'b00: ALUControl = 4'b0010; //add
			2'b01: ALUControl = 4'b0110; //subtract
			2'b10: 
				case(func)
					6'b100000: ALUControl = 4'b0010; //add
					6'b100010: ALUControl = 4'b0110; //subtract
					6'b100100: ALUControl = 4'b0000; //AND
					6'b100101: ALUControl = 4'b0001; //OR
					6'b101010: ALUControl = 4'b0111; //set-on-less-than
					default: ALUControl = 4'b0000;
				endcase
			2'b11: ALUControl = 4'b0000; //AND
			default: ALUControl = 4'b0000;
		endcase
	end
endmodule
