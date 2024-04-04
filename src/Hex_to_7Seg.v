/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  Hex_to_7Seg.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer:   Michael Rios
 * Email:      riosmichael28@ymail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 5, 2016  
 *
 * Purpose: This module controls the logic of the 7-segment display. When the 
 input to the module(hex) contains a binary value of 0, then the 7segments on 
 the FPGA will be manipulated in such a way to form a zero; if the input to 
 the module(hex) contains a binary value of 1, then then the 7-segments on the
 FPGA will be manipulated to form a one; etc. This logic is achieved using a 
 case statement. 
 *         
 * Notes: There exists two types of LED 7-segment displays: Common Cathode 
 and Common Anode. Common Cathode displays have all cathodes tied together 
 to logic "0" and the anodes are therefore illumianted through application of
 logic "1". In Common Anode displays, all anode connections are joined together 
 to logic "1" and the individual segments are illuminated through application 
 of a logic "0" signal.
 * The Nexys 4 DDR's 7-segment display uses common anode circuitry; therefore, the 
 cathodes must be driven low to become illuminated. 
 *
 ****************************************************************************/
 
`timescale 1ns / 1ps

module Hex_to_7Seg( hex, a, b, c, d ,e, f, g );

	input 		[3:0] hex; 
	output reg	a, b, c, d, e, f, g; 

	always @(*) 
	begin 
		case(hex) 
		4'b0000: {a, b, c, d, e, f, g} = 7'b0000001; 
		4'b0001: {a, b, c, d, e, f, g} = 7'b1001111; 
		4'b0010: {a, b, c, d, e, f, g} = 7'b0010010;
		4'b0011: {a, b, c, d, e, f, g} = 7'b0000110;
		4'b0100: {a, b, c, d, e, f, g} = 7'b1001100;
		4'b0101: {a, b, c, d, e, f, g} = 7'b0100100; 
		4'b0110: {a, b, c, d, e, f, g} = 7'b0100000;
		4'b0111: {a, b, c, d, e, f, g} = 7'b0001111;
		4'b1000: {a, b, c, d, e, f, g} = 7'b0000000; 
		4'b1001: {a, b, c, d, e, f, g} = 7'b0000100;
		4'b1010: {a, b, c, d, e, f, g} = 7'b0001000; 
		4'b1011: {a, b, c, d, e, f, g} = 7'b1100000;
		4'b1100: {a, b, c, d, e, f, g} = 7'b0110001;
		4'b1101: {a, b, c, d, e, f, g} = 7'b1000010; 
		4'b1110: {a, b, c, d, e, f, g} = 7'b0110000;
		4'b1111: {a, b, c, d, e, f, g} = 7'b0111000;
		default: {a, b, c, d, e, f, g} = 7'b0000000; 
		endcase//case
	end//always
endmodule

