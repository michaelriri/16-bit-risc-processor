/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  Display_Controller.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 15, 2016  
 *
 * Purpose: This module will serve as a "wrapper" for the modules making up the 
 display controller: the led clock, led controller, 8 to 1 multiplexer, and hex 
 to 7 segment display modules. The modules will be instantiated into this block 
 "Display Controller" module for ease of use in supsequent projects and 
 applications. 
 *         
 * Notes: Instead of instantiating the modules in the top level, they are 
 instantiated here to hide the details and ease the debugging process. 
 *
 ****************************************************************************/

`timescale 1ns / 1ps

module Display_Controller( clk, reset, seg0, seg1, seg2, seg3, seg4, 
									seg5, seg6, seg7, an, a, b, c, d, e, f, g );
	
	input 	clk, reset; 
	input 	[3:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7; 
	output 	a, b, c, d, e, f, g; 
	output 	[7:0] an; 
	
	wire 		clk_out; 
	wire 		[2:0] mux_sel; 
	wire 		[3:0] mux_out; 
	
	// This module instantiated below divides the 100MHz board clock to 
	// a 480Hz clock necessary for refreshing the 7-Segment Displays. 
	led_clk 				u0 (.clk_in(clk), .reset(reset), .clk_out(clk_out)); 
	
	// The Led Controller uses the led clock to select one pixel at a time. 
	// This module is an autonomous finite state maching that outputs a value 
	// for select and asserts one anode at every state. 
	led_controller 	u1 (.clk(clk_out), .reset(reset), .an(an), .seg_sel(mux_sel)); 
	
	//This module will be incharch of sending a pixel its corresponding pixel data. 
	mux_8_to_1			u2 (.d0(seg0), .d1(seg1), .d2(seg2), .d3(seg3), .d4(seg4), 
								 .d5(seg5), .d6(seg6), .d7(seg7), .sel(mux_sel), .Y(mux_out)); 
								 
	// This module controls the logic of the 7-segment display.					  
	Hex_to_7Seg 		u3 (.hex(mux_out), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)); 

endmodule



