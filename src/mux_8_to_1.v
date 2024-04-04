/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  mux_8_to_1.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 5, 2016  
 *
 * Purpose: This module represents an 8 to 1 multiplexer that is in charge
 of selecting what data will be sent to the Hex to 7 segment decoder. In 
 specific terms, the data stored in the ram will be selected by the select 
 signal that was received from the led controller module. 
 *         
 * Notes: The module was written using behavioral verilog which uses an 
 always block and a case statement. The always block is sensetive to the 
 the inputs and select. The case statement is used to assain an output 
 according to select's value. 
 *
 ****************************************************************************/
 
`timescale 1ns / 1ps

module mux_8_to_1( d0, d1, d2, d3, d4, d5, d6, d7, sel, Y );

	input 		[2:0] sel; 
	input 		[3:0] d0;
	input 		[3:0] d1;
	input 		[3:0] d2;
	input 		[3:0] d3;
	input 		[3:0] d4;
	input 		[3:0] d5;
	input 		[3:0] d6;
	input 		[3:0] d7;
	output reg 	[3:0] Y; 
	
	always @(sel, d0,d1,d2,d3,d4,d5,d6,d7) 
	begin 
		case (sel) 
		3'b000 	: Y = d0; 
		3'b001	: Y = d1; 
		3'b010 	: Y = d2; 
		3'b011 	: Y = d3; 
		3'b100 	: Y = d4; 
		3'b101 	: Y = d5; 
		3'b110	: Y = d6; 
		3'b111 	: Y = d7; 
		default 	: Y = 4'b1111; 
		endcase  //ends case statement 
	end 		//ends always statement
	
endmodule

