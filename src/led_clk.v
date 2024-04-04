/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  led_clk.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 5, 2016  
 *
 * Purpose: The purpose of this module is to divide the 100MHz board clock 
 to a 480Hz clock for refreshing the 7-segment displays. This is clocks 
 purpose is to assert one anode at a time at a proper frequency to make 
 it seem as though all of the 7-segment displays are on at the same time. 
 *         
 * Notes: Nexys 4 has a "8x1" display; 8 pixels in total. Since our desired 
 refresh frequency is 60Hz(60 times per second) we will have to refresh 
 60*8 pixels every second. This is how the 480 pixel clock was calculated. 
 *
 ****************************************************************************/

`timescale 1ns / 1ps

 module led_clk( clk_in, reset, clk_out );

	input 		clk_in, reset; 
	output reg	clk_out;	
	integer 		i; 
	//***************************************************************
	// The following verilog code will "divide" an incoming clock 
	// by the 32-bit decimal value specified in the "if condition" 
	// 
	// The value of the timer that counts the incoming clock ticks 
	// is equal to [ (Incoming Freq / Outgoing Freq) / 2 ]
	//***************************************************************
	
	always @( posedge clk_in or posedge reset) begin 
		if ( reset == 1 ) begin 
			clk_out = 0; 
			i = 0; 
		end else begin 
			i = i+1; 
			if ( i >= ((100000000/480)/2)) begin 
				clk_out = ~clk_out; 
				i = 0; 
			end //if 
		end //else 
	end // always 

endmodule


