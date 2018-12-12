`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:45 11/19/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(ALUsrc1,ALUsrc2,ALUControl,result);
	parameter N=32;
	input [N-1:0]ALUsrc1,ALUsrc2;
	input [3:0]ALUControl;
	output reg [N-1:0]result;
	
	always @(ALUsrc1,ALUsrc2,ALUControl) begin
		case (ALUControl)
			4'b0000: result = ALUsrc1 & ALUsrc2; // AND
			4'b0001: result = ALUsrc1 | ALUsrc2; // OR
			4'b0010: result = ALUsrc1 + ALUsrc2; // add
			4'b0110: begin 
				result = ALUsrc1 - ALUsrc2; // subtract
			end
			4'b0111: begin
				result = ALUsrc1 < ALUsrc2; // set-on-less-than
			end
			4'b1100: result = ~(ALUsrc1 | ALUsrc2); // NOR
		endcase
	end
endmodule
