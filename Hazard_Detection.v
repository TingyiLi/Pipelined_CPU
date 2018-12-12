`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:28 11/20/2017 
// Design Name: 
// Module Name:    Hazard_Detection 
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
module Hazard_Detection(rt_ex,rs,rt,MemRead_ex,IDFlush,PCWrite,IFIDWrite);//data
	input[4:0] rt_ex,rs,rt;
	input MemRead_ex;
	output reg IDFlush,PCWrite,IFIDWrite;
	
	initial begin
	   IFIDWrite <= 1'b0;
	   PCWrite <= 1'b0;
		IDFlush <= 1'b0;
	end
	
	always @(rt_ex or rs or rt or MemRead_ex) 
	begin
	if ((MemRead_ex==1) && ((rt_ex==rs) || (rt_ex==rt))) 
	   begin
		IFIDWrite <= 1'b1;
		PCWrite <= 1'b1;
		IDFlush <= 1'b1;
		end
	else
	   begin
			IFIDWrite <= 1'b0;
			PCWrite <= 1'b0;
			IDFlush <= 1'b0;
		end
	end
endmodule
