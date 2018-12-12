`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:07 11/19/2017 
// Design Name: 
// Module Name:    ForwardUnit 
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
module ForwardUnit(rt_ex,rs_ex,WriteReg_mem,WriteReg_wb,RegWrite_mem,RegWrite_wb,forward1,forward2);
	input [4:0] rt_ex,rs_ex,WriteReg_mem,WriteReg_wb;
	input RegWrite_mem,RegWrite_wb;
	output reg [1:0] forward1,forward2;

	always @ (rt_ex or rs_ex or WriteReg_mem or WriteReg_wb or RegWrite_mem or RegWrite_wb) begin
	if ((WriteReg_mem == rs_ex) && (RegWrite_mem==1) && (WriteReg_mem != 0))
			forward1 <= 2'b10;
	else if ((WriteReg_wb == rs_ex) && (RegWrite_wb==1) && (WriteReg_wb!=0))
	      forward1 <= 2'b01;
	else 
	      forward1 <= 2'b00;
			
	if ((WriteReg_mem == rt_ex) && (RegWrite_mem==1) && (WriteReg_mem != 0))
			forward2 <= 2'b10;
	else if ((WriteReg_wb == rt_ex) && (RegWrite_wb==1) && (WriteReg_wb!=0))
	      forward2 <= 2'b01;
	else 
	      forward2 <= 2'b00;
	end	
endmodule
