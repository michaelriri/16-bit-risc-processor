/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  Register_File.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: This module instantiates all of the modules that make up the
 register file. That includes 3 instantiations of a 3-to 8 decoder that 
 will be used as register selection done with W_Adr R_Adr and S_Adr, and
 eight instances of a 16 bit register.          
 *         
 * Notes: Like the top level module, this module is also written in structural
 verilog, which is the easiest method to connect all module of the register 
 file together. Since it is a structural module, we use wires in order to 
 inner connect the load,oea, and oeb wires  to its certain instantiation.
 *
 ****************************************************************************/
 
`timescale 1ns / 1ps

module Register_File( clk, reset, W_Adr, we, R_Adr, S_Adr, W, R, S );
	
	input 	clk, reset; 
	input 	we; 
	input 	[2:0] W_Adr; 
	input 	[2:0] R_Adr; 
	input 	[2:0] S_Adr; 
	input 	[15:0] W; 
	output 	[15:0] R; 
	output 	[15:0] S; 

	wire	r7_ld, r7_oea, r7_oeb; 
	wire 	r6_ld, r6_oea, r6_oeb; 
	wire 	r5_ld, r5_oea, r5_oeb; 
	wire 	r4_ld, r4_oea, r4_oeb; 
	wire 	r3_ld, r3_oea, r3_oeb; 
	wire 	r2_ld, r2_oea, r2_oeb; 
	wire 	r1_ld, r1_oea, r1_oeb; 
	wire 	r0_ld, r0_oea, r0_oeb; 
	
	
	decoder3_to8 
			W_dec	(.in(W_Adr), .enable(we), 
					 .y({r7_ld,r6_ld, r5_ld,r4_ld,r3_ld,r2_ld,r1_ld,r0_ld})), 
								 
			R_dec (.in(R_Adr), .enable(1'b1), 
					 .y({r7_oea, r6_oea,r5_oea, r4_oea, r3_oea, r2_oea, r1_oea, r0_oea})),
								 
			S_dec (.in(S_Adr), .enable(1'b1), 
					 .y({r7_oeb, r6_oeb,r5_oeb, r4_oeb, r3_oeb, r2_oeb, r1_oeb, r0_oeb})); 
						
	reg16		
			R7 (.clk(clk), .reset(reset), .Din(W), .ld(r7_ld), .oeA(r7_oea), .oeB(r7_oeb),.DA(R), .DB(S)), 
			R6 (.clk(clk), .reset(reset), .Din(W), .ld(r6_ld), .oeA(r6_oea), .oeB(r6_oeb),.DA(R), .DB(S)), 
			R5 (.clk(clk), .reset(reset), .Din(W), .ld(r5_ld), .oeA(r5_oea), .oeB(r5_oeb),.DA(R), .DB(S)), 
			R4 (.clk(clk), .reset(reset), .Din(W), .ld(r4_ld), .oeA(r4_oea), .oeB(r4_oeb),.DA(R), .DB(S)), 
			R3 (.clk(clk), .reset(reset), .Din(W), .ld(r3_ld), .oeA(r3_oea), .oeB(r3_oeb),.DA(R), .DB(S)),
			R2 (.clk(clk), .reset(reset), .Din(W), .ld(r2_ld), .oeA(r2_oea), .oeB(r2_oeb),.DA(R), .DB(S)),
			R1 (.clk(clk), .reset(reset), .Din(W), .ld(r1_ld), .oeA(r1_oea), .oeB(r1_oeb),.DA(R), .DB(S)), 
			R0 (.clk(clk), .reset(reset), .Din(W), .ld(r0_ld), .oeA(r0_oea), .oeB(r0_oeb),.DA(R), .DB(S)); 
				
endmodule
