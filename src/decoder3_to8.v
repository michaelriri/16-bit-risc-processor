/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  decoder3_to8.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: The purpose of this module represents a 3-8 decoder that 
 we will need in order to have register selection done with the W_Adr, R_Adr
 and S_Adr address inputs.
 *         
 * Notes: This 3-8 decoder is written in behavioral verilog that uses an 
 always block and a case statement since a decoder will only output only 
 one byte depending on the 3 bit	input enters the decoder. two of the
 three decoders will always be enabled while the otherwhich is the decoder 
 the is in control of the W_Adr will only be enabled when we push the btn_down
 of the Nexys 4 board.
 *
 ****************************************************************************/
 
`timescale 1ns / 1ps

module decoder3_to8( in, enable, y );

  input			[2:0] in;
  input 			enable;
  output reg 	[7:0] y;
  
  always @(in or enable) begin
	 y = 8'b00000000;
    if(enable == 1) begin
		case(in)
			3'b000  : y = 8'b00000001;
			3'b001  : y = 8'b00000010;
			3'b010  : y = 8'b00000100;
			3'b011  : y = 8'b00001000;
			3'b100  : y = 8'b00010000;
			3'b101  : y = 8'b00100000;
			3'b110  : y = 8'b01000000;
			3'b111  : y = 8'b10000000;
			default : y = 8'b00000000;
		endcase
	end
 end
 
endmodule

