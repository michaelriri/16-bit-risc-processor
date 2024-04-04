/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  RISC_Processor.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 28, 2016  
 *
 * Purpose: This module represents a 16 bit RISC processor;
 Reduced Instruction Set Computing Processor. RISC is a CPU design strategy 
 that implements much simpler instruction sets that require only one clock
 cycle to execute. These much simpler instructions require less transistors of
 hardware space which give more room for general purpose registers. 
 *         
 * Notes: In our module we only have a 16 bit RISC processor that is made up 
 of the timing and control unit (CU) which is a moore implementation of a finite
 state machine and the CPU_Eu. The verilog code is implemented in basic structural
 verilog.
 *
 ****************************************************************************/ 

`timescale 1ns / 1ps

module RISC_Processor(clk, reset, D_out, Address, D_in, mw_en, status);
	input 	clk, reset; 
	input 	[15:0] D_in; 
	output 	[15:0] D_out, Address;
	output 	[7:0] status; 
	output 	mw_en; 
	
	//wires: 
	wire 	[15:0] ir_out; 
	wire 	N, Z, C; 
	wire 	[2:0] W_Adr, R_Adr, S_Adr; 
	wire 	adr_sel, s_sel; 
	wire 	pc_ld, pc_inc, pc_sel, ir_ld; 
	wire 	rw_en; 
	wire	[3:0] Alu_Op; 
	
	// This instantiates the Control Unit module. We use this as a way to inner
	// connect the wires,inputs,and outputs from this module to the inputs,outputs
	// and wires from the control unit module.
	cu		u0 ( .clk(clk), .reset(reset), .IR(ir_out), .N(N), .Z(Z), .C(C),
					.W_Adr(W_Adr), .R_Adr(R_Adr), .S_Adr(S_Adr), 						 
					.adr_sel(adr_sel), .s_sel(s_sel), 							
					.pc_ld(pc_ld), .pc_inc(pc_inc), .pc_sel(pc_sel), .ir_ld(ir_ld), 	
					.mw_en(mw_en), .rw_en(rw_en), .alu_op(Alu_Op), .status(status)); 
			 
	// This instantiates the CPU_EU module that we use in order to inner connects 
	// the I/O and wires of this module to the I/O and wires from the cpu_eu.
	CPU_EU u1 ( .clk(clk), .reset(reset), 
					.pc_ld(pc_ld), .pc_sel(pc_sel), .pc_inc(pc_inc), .ir_ld(ir_ld), 
					.adr_sel(adr_sel), .W_En(rw_en), .S_Sel(s_sel), 
					.address(Address), .D_out(D_out), .D_in(D_in), .C(C), .N(N), .Z(Z),
					.W_Adr(W_Adr), .R_Adr(R_Adr), .S_Adr(S_Adr), .Alu_Op(Alu_Op), .ir_out(ir_out)); 

endmodule
