/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  led_controller.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 5, 2016  
 *
 * Purpose: The purpose of this module is to drive the basic concept of 
 displays: selecting one pixel at a time and sending that pixel its 
 corresponding pixel "data". This is achieved in this project using 
 two modules: (1) This led controller module & (2) an 8 to 1 multiplexer. 
 This module is an autonomous finite state machine which changes state 
 every positive edge of the clock and outputs a 3-bit select value 
 and asserts one anode at avery state. 
 *         
 * Notes: 
 *
 ****************************************************************************/

`timescale 1ns / 1ps

module led_controller( clk, reset, an, seg_sel );

	input clk, reset; 
	output reg [7:0] an;
	output reg [2:0] seg_sel;
	
	reg [2:0] present_state; 
	reg [2:0] next_state; 
	
	//===================================================
	//		Next State Combinational Logic
	//===================================================
	always @(present_state) 
	begin 
		case (present_state)
		3'b000	:	next_state = 3'b001; 
		3'b001	: 	next_state = 3'b010; 
		3'b010	: 	next_state = 3'b011; 
		3'b011	: 	next_state = 3'b100; 
		3'b100 	: 	next_state = 3'b101; 
		3'b101	: 	next_state = 3'b110; 
		3'b110	:  next_state = 3'b111; 
		3'b111	:  next_state = 3'b000; 
		default 	: 	next_state = 3'b000; 
		endcase 
	end 
	
	//===================================================
	//		State Register Logic (Sequential Logic)
	//===================================================		
	always @(posedge clk or posedge reset) 
		begin
			if (reset == 1'b1) 
			present_state = 3'b000; 
			else 
			present_state = next_state; 
		end	
		
	//===================================================
	//		Output Combinational Logic
	//===================================================
	always @(present_state) 
	begin 
		case (present_state) 
		3'b000	: {seg_sel, an} = 11'b000_11111110; 
		3'b001	: {seg_sel, an} = 11'b001_11111101; 
		3'b010	: {seg_sel, an} = 11'b010_11111011; 
		3'b011	: {seg_sel, an} = 11'b011_11110111; 
		3'b100	: {seg_sel, an} = 11'b100_11101111; 
		3'b101 	: {seg_sel, an} = 11'b101_11011111; 
		3'b110	: {seg_sel, an} = 11'b110_10111111; 
		3'b111	: {seg_sel, an} = 11'b111_01111111;
		default 	: {seg_sel, an} = 11'b000_11111110; 
		endcase
	end 
	
endmodule 



