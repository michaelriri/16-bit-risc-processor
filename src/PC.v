/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  PC.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: This Program Counter module is a 16-bit register in a computer 
 processor that contains the address/location of the instruction being 
 executed at the current time. If the incr is enabled, the program 
 counter increases its stored value by 1.  When the computer restarts or is reset,
 the program counter normally reverts to back to 0.
 *         
 * Notes:
 ****************************************************************************/
`timescale 1ns / 1ps

module PC(clk, reset, ld, incr, Din, Dout);

	input 	clk, reset, ld, incr; 
	input 	[15:0] Din; 
	output reg 	[15:0] Dout;  
	
	// Behavioral section for writing to the register 
	always @ ( posedge clk or posedge reset ) 
		if (reset) 
			Dout <= 16'b0; 
		else 
			if (ld) 
					Dout <= Din; 
			else if (incr)
					Dout <= Dout + 1; 
			else	Dout <= Dout; 

endmodule


