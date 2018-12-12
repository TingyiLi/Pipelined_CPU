`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:42 11/19/2017 
// Design Name: 
// Module Name:    control 
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
module control(opcode,RegDst,Jump,Branch,bne,MemRead,MemtoReg,ALUop,MemWrite,ALUsrc,RegWrite);
	input [5:0]opcode;
	output reg RegDst,Jump,Branch,bne,MemRead,MemtoReg,MemWrite,ALUsrc,RegWrite;
	output reg [1:0] ALUop;
	
	initial begin 
		RegDst<=0;
		Jump<=0;
		Branch<=0;
		bne<=0;
		MemRead<=0;
		MemtoReg<=0;
		ALUop<=2'b00;
		MemWrite<=0;
		ALUsrc<=0;
		RegWrite<=0;
	end

	always @(opcode) begin
		case(opcode)
			6'h0:begin //R-type
				RegDst<=1;
				Jump<=0;
				Branch<=0;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b10;
				MemWrite<=0;
				ALUsrc<=0;
				RegWrite<=1;
			end
			6'h8:begin //addi
				RegDst<=0;
				Jump<=0;
				Branch<=0;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b00; //add
				MemWrite<=0;
				ALUsrc<=1;
				RegWrite<=1;
			end
			6'hc:begin //andi
				RegDst<=0;
				Jump<=0;
				Branch<=0;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b11;
				MemWrite<=0;
				ALUsrc<=1;
				RegWrite<=1;
			end
			6'h4:begin //beq
				RegDst<=0;
				Jump<=0;
				Branch<=1;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b01; //subtract
				MemWrite<=0;
				ALUsrc<=0;
				RegWrite<=0;
			end
			6'h5:begin //bne
				RegDst<=0;
				Jump<=0;
				Branch<=0;
				bne<=1;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b01; //subtract
				MemWrite<=0;
				ALUsrc<=0;
				RegWrite<=0;
			end
			6'h2:begin //jump
				RegDst<=0;
				Jump<=1;
				Branch<=0;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b00;
				MemWrite<=0;
				ALUsrc<=0;
				RegWrite<=0;
			end
			6'h23:begin //lw
				RegDst<=0;
				Jump<=0;
				Branch<=0;
				bne<=0;
				MemRead<=1;
				MemtoReg<=1;
				ALUop<=2'b00;
				MemWrite<=0;
				ALUsrc<=1;
				RegWrite<=1;
			end
			6'h2b:begin //sw
				RegDst<=0;
				Jump<=0;
				Branch<=0;
				bne<=0;
				MemRead<=0;
				MemtoReg<=0;
				ALUop<=2'b00;
				MemWrite<=1;
				ALUsrc<=1;
				RegWrite<=0;
			end
			default:begin
			RegDst<=0;
		   Jump<=0;
		   Branch<=0;
		   bne<=0;
		   MemRead<=0;
		   MemtoReg<=0;
		   ALUop<=2'b00;
		   MemWrite<=0;
		   ALUsrc<=0;
		   RegWrite<=0;
		   end
		endcase
	end
endmodule

