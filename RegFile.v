`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:14 11/19/2017 
// Design Name: 
// Module Name:    RegFile 
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


module RegFile(clk,readReg1,readReg2,writeReg,writeData,regWrite,readData1,readData2);
	input [4:0]readReg1,readReg2,writeReg;
	input regWrite,clk;
	input [31:0]writeData;
	output [31:0]readData1,readData2;
	//output [31:0]s0,s1,s2,s3,s4,s5,s6,s7,t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;
	reg [31:0]regfile[31:0];
	initial begin
		regfile[0]=32'b0;
		regfile[1]=32'b0;
		regfile[2]=32'b0;
		regfile[3]=32'b0;
		regfile[4]=32'b0;
		regfile[5]=32'b0;
		regfile[6]=32'b0;
		regfile[7]=32'b0;
		regfile[8]=32'b0;
		regfile[9]=32'b0;
		regfile[10]=32'b0;
		regfile[11]=32'b0;
		regfile[12]=32'b0;
		regfile[13]=32'b0;
		regfile[14]=32'b0;
		regfile[15]=32'b0;
		regfile[16]=32'b0;
		regfile[17]=32'b0;
		regfile[18]=32'b0;
		regfile[19]=32'b0;
		regfile[20]=32'b0;
		regfile[21]=32'b0;
		regfile[22]=32'b0;
		regfile[23]=32'b0;
		regfile[24]=32'b0;
		regfile[25]=32'b0;
		regfile[26]=32'b0;
		regfile[27]=32'b0;
		regfile[28]=32'b0;
		regfile[29]=32'b0;
		regfile[30]=32'b0;
		regfile[31]=32'b0;
	end
	always @(negedge clk) begin
		if (regWrite) regfile[writeReg] = writeData;
	end
		assign readData1 = regfile[readReg1];
		assign readData2 = regfile[readReg2];
		/*
		assign s0=regfile[16];
		assign s1=regfile[17];
		assign s2=regfile[18];
		assign s3=regfile[19];
		assign s4=regfile[20];
		assign s5=regfile[21];
		assign s6=regfile[22];
		assign s7=regfile[23];
		assign t0=regfile[8];
		assign t1=regfile[9];
		assign t2=regfile[10];
		assign t3=regfile[11];
		assign t4=regfile[12];
		assign t5=regfile[13];
		assign t6=regfile[14];
		assign t7=regfile[15];
		assign t8=regfile[24];
		assign t9=regfile[25];
		*/
endmodule		
