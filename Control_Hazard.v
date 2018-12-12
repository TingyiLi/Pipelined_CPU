`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:32 11/20/2017 
// Design Name: 
// Module Name:    Control_Hazard 
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
module Control_Hazard(Jump,Branch,bne,WriteReg,WriteReg_mem,MemRead_ex,MemRead_mem,RegWrite_ex,RegWrite_mem,Instruction_id,ReadData1,ReadData2,ReadData,ALUresult,ALUresult_mem,CHmux,IFFlush);
	 input Jump,Branch,bne,MemRead_ex,MemRead_mem,RegWrite_ex,RegWrite_mem;
	 input [4:0] WriteReg,WriteReg_mem;
	 input [31:0] Instruction_id,ReadData1,ReadData2,ReadData,ALUresult,ALUresult_mem; 
	 output reg CHmux,IFFlush;
	 always @ (Jump or Branch or bne or WriteReg or WriteReg_mem or MemRead_ex or MemRead_mem or RegWrite_ex or RegWrite_mem or Instruction_id or ReadData1 or ReadData2 or ReadData or ALUresult or ALUresult_mem) begin
	 if(Jump) begin
	     IFFlush=1;
		  CHmux=1;
		  end
	 else if(Branch) begin
	     if ((WriteReg_mem==Instruction_id[25:21]) && (WriteReg_mem!=0) && (MemRead_mem==1)) begin
		      if(ReadData2==ReadData) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg_mem==Instruction_id[20:16]) && (WriteReg_mem!=0) && (MemRead_mem==1)) begin
	         if(ReadData1==ReadData) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  
		  if ((WriteReg_mem==Instruction_id[25:21]) && (RegWrite_mem==1) && (WriteReg_mem!=0) && (MemRead_mem==0)) begin
		      if(ReadData2==ALUresult_mem) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg_mem==Instruction_id[20:16]) && (RegWrite_mem==1) && (WriteReg_mem!=0) && (MemRead_mem==0)) begin
	         if(ReadData1==ALUresult_mem) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  
		  if ((WriteReg==Instruction_id[25:21]) && (RegWrite_ex==1) && (WriteReg!=0) && (MemRead_ex==0)) begin
		      if(ReadData2==ALUresult) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg==Instruction_id[20:16]) && (RegWrite_ex==1) && (WriteReg!=0) && (MemRead_ex==0)) begin
	         if(ReadData1==ALUresult) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
	 end
		  
	 else if(bne) begin
	     if ((WriteReg_mem==Instruction_id[25:21]) && (WriteReg_mem!=0) && (MemRead_mem==1)) begin
		      if(ReadData2!=ReadData) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg_mem==Instruction_id[20:16]) && (WriteReg_mem!=0) && (MemRead_mem==1)) begin
	         if(ReadData1!=ReadData) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  
		  if ((WriteReg_mem==Instruction_id[25:21]) && (RegWrite_mem==1) && (WriteReg_mem!=0) && (MemRead_mem==0)) begin
		      if(ReadData2!=ALUresult_mem) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg_mem==Instruction_id[20:16]) && (RegWrite_mem==1) && (WriteReg_mem!=0) && (MemRead_mem==0)) begin
	         if(ReadData1!=ALUresult_mem) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  
		  if ((WriteReg==Instruction_id[25:21]) && (RegWrite_ex==1) && (WriteReg!=0) && (MemRead_ex==0)) begin
		      if(ReadData2!=ALUresult) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
		  else if ((WriteReg==Instruction_id[20:16]) && (RegWrite_ex==1) && (WriteReg!=0) && (MemRead_ex==0)) begin
	         if(ReadData1!=ALUresult) begin
				IFFlush=1;
				CHmux=1;
				end
				else begin
				IFFlush=0;
				CHmux=0;
				end
		  end
	 end
	 
	 else begin
	      IFFlush=0;
			CHmux=0;
	 end
end
		  
endmodule
