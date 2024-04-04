/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  MemDumpCounter.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 28, 2016  
 *
 * Purpose: This is a counter that we use in this lab as a way
 to insert an 16-bit address to the ram1 module when the top 
 level address mux dump_mem = 1, if dump_mem = 0 than the output 
 of this module will not be given to the address input of the ram1 
 module. 
 *         
 * Notes: This is a basic up counter; We are also using he step_mem button 
 , which comes from the top level, will be used as a way to increment this 
 16 bit counter by 1 at every positive edge.
 *
 ****************************************************************************/ 
`timescale 1ns / 1ps

module MemDumpCounter( clk, reset, addr );
	input clk, reset; 
	output reg [15:0] addr; 
	
	always @ (posedge clk or posedge reset)
	begin 
		if (reset == 1'b1) 
		addr <= 16'b0000_0000_0000_0000; 
		else 
		addr <= addr + 16'b0000_0000_0000_0001; 
	end 

endmodule

