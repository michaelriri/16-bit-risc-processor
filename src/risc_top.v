/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  risc_top.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 28, 2016  
 *
 * Purpose: This is the top level module to the RISC Processor Project. 
 The purpose of this module is to interconnect all of the modules that make 
 up the RISC project. Also, this module is responsible for mapping the control 
 words which will connect to the I/O ports on the Nexys 4 board. 
 *         
 * Notes: Three bit files will be created from this top level module w/ only 
 the init file of the Ram Module changing. 
 *
 ****************************************************************************/ 
`timescale 1ns / 1ps

module risc_top( clk, reset, step_clk, step_mem, dump_mem, 
					  led, an, a , b, c, d, e, f, g );

	input 	clk, reset; 
	input 	step_clk, step_mem; 
	input 	dump_mem; 
	output 	[7:0] led;
	output 	[7:0] an; 
	output 	a, b, c, d, e, f, g; 
	
	//wires:
	wire clk_500Hz, db_step_clk, db_step_mem; 
	wire 	[15:0] D_out, Address, D_in; 
	wire 	[15:0] mem_dump_out, mem_address; 
	wire 	mw_en; 
	
	// The line below instantiates the 500Hz clock divider. The input will 
	// come from the 100MHz board clock of the Nexys 4DDR, and reset will be 
	// controlled by the btn_up of the board. The output will be the divided 
	// 500Hz clock that will be used for out debounce module. 
	clk_500_Hz 			u0 ( .clk_in(clk), .reset(reset), .clk_out(clk_500Hz)); 
	
	// The lines below instantiate the first debounce module which will debounce 
	// the btn_dn of the Nexys 4DDR board. This button will be used to step the 
	// clock forward. 
	debounce 			u1 ( .clk_in(clk_500Hz), .reset(reset), .D_in(step_clk), 
								  .D_out(db_step_clk)); 
	
	// The lines below instantiate the second debounce module which will be used 
	// to debounce the left button of our Nexys 4DDR. This button will be used to 
	// step through memory. 
	debounce 			u2 ( .clk_in(clk_500Hz), .reset(reset), .D_in(step_mem), 
								  .D_out(db_step_mem)); 
	
	// The code block below instantiates our RISC Processor module. This module 
	// is made up by a control unit, and our CPU. Modifications were made to 
	// the CPU in order to be able to execute jump instructions. 
	RISC_Processor 	u3 ( .clk(db_step_clk), .reset(reset), 
								  .D_out(D_out), .Address(Address), .D_in(D_in), 
								  .mw_en(mw_en), .status(led)); 
	
   // The lines below instantiate the 256x16 memory. The address input will come 
	// from the CPU_EU module's output address. 
	ram1 					u4 ( .clk(clk), .we(mw_en), 
								  .addr(mem_address), .din(D_out), .dout(D_in)); 
	
	// This line below instantiates then Memory dump counter. A 16-bit up-counter. 
	MemDumpCounter		u5 ( .clk(db_step_mem), .reset(reset), .addr(mem_dump_out)); 
	
	// The code block below instantiates the display controller module which will dispay 
	// 'Address' output of the CPU_EU in the first four segments and the 'D_in input to 
	// the CPU_EU in the next four segments. 
	Display_Controller u6( .clk(clk), .reset(reset), 
								  .seg0(mem_address[3:0]), .seg1(mem_address[7:4]), 				 
								  .seg2(mem_address[11:8]), .seg3(mem_address[15:12]), 
								  .seg4(D_in[3:0]), .seg5(D_in[7:4]), 
								  .seg6(D_in[11:8]), .seg7(D_in[15:12]), 
								  .an(an), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)); 
	
	// Assign statement represents a 2-to-1 multiplexer. 
	// will choose which address location is chosen based on the dump_mem switch.
	assign mem_address = (dump_mem) ? mem_dump_out : Address; 
	
endmodule



