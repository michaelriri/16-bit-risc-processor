/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  CPU_EU.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: This module instantiates all the modules that
 make up the CPU execution unit. That includes: Integer Datapath,
 PC, IR,and the adr_mux modules.The Execution Unit overall receives
 program instruction codes and data, and what it does is execute these
 instructions and data.
 *         
 * Notes: Just like all of our previous "wrapper" modules, this module 
 is written in structural verilog in order to inner connect all of the
 modules that make up the Execution unit. 
 *
 ****************************************************************************/ 
`timescale 1ns / 1ps

module CPU_EU(clk, reset, 
				  pc_ld, pc_sel, pc_inc, ir_ld, 
				  adr_sel, W_En, S_Sel, 
				  address, D_out, D_in, 
				  C, N, Z, 
				  W_Adr, R_Adr, S_Adr, Alu_Op, ir_out); //added these

	//IDP I/0: 
	input 	clk, reset; 
	input 	W_En;
	input 	[15:0] D_in;
	input 	[2:0] W_Adr, R_Adr, S_Adr; 
	input 	[3:0] Alu_Op; 
	input 	S_Sel; 
	input 	pc_sel; 
	output 	C, N, Z; 
	output  	[15:0] D_out; 
	output 	[15:0] ir_out; 
	wire 		[15:0] reg_out; 
	
	//PC I/0: 
	input 	pc_ld, pc_inc; 
	wire 		[15:0] pc_out; 
	wire 		[15:0] pc_mux; 
	//IR I/0: 
	input 	ir_ld; 
	//wire 		[15:0] ir_out; 
	wire 		[15:0] sign_extension;
	wire 		[15:0] jaddr; 
	//ADR_MUX: 
	input 	adr_sel;
	output 	[15:0] address; 
	
	// This instantiates the instruction register module. The IR module is a register that 
	// stores instructions. In more detail, by storing an instruction in a register, we can 
	// use the output of the register to control other parts of the CPU, so the instruction can 
	// be executed.
	IR		u0 (.clk(clk), .reset(reset), .Din(D_in), .Dout(ir_out), .ld(ir_ld)); 
  
   // The block of code below instantiates the Integer Datapath module. This module is made 
	// of the register file, alu, and a multiplexer. 
	IDP 	u1 (.clk(clk), .reset(reset), .W_En(W_En), .W_Adr(W_Adr),.R_Adr(R_Adr),
	.S_Adr(S_Adr), .DS(D_in), .S_Sel(S_Sel), .C(C), .N(N), .Z(Z), .ALU_OP(Alu_Op), 
	.Reg_Out(reg_out), .Alu_Out(D_out)); 	
	
	// This instantiates the Program counter module.The PC actually holds the address of the 
	// current instruction being executed; however, once the instruction has completed, the PC
   //	is updated with a new value for the next instruction. 
	PC		u2 (.clk(clk), .reset(reset), .ld(pc_ld), .incr(pc_inc), .Din(pc_mux), .Dout(pc_out)); 
	
	// The assign statement below represents the address multiplexer
	// chooses the address to be The Reg_out output of the IDP or the 
	// ALU-out of the ALU. 
	assign address = (adr_sel) ? reg_out : pc_out; 
	
	// The sign_extension is created using "replication" operator in verilog; the most significant 
	// bit of the Instrucion is replicated 8 times to create a 16-bit output. 
	assign sign_extension = { {8{ir_out[7]}}, ir_out[7:0]};
	
	// The jump address is the PC added with the sign_extension. 
	assign jaddr = pc_out + sign_extension; 
	
	// The assign statement below represents the PC multiplexer
	// chooses the output to be the jaddr wire or the 
	// ALU-out of the ALU.	
	assign pc_mux = (pc_sel) ? D_out : jaddr; 
 
endmodule
