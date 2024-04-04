/****************************** C E C S  3 0 1 ******************************
 * File Name:  alu.v
 * Project:    Lab Project 7: CPU Execution Unit
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 5, 2016  
 *
 * Purpose: This module represents a Arithmetic Logic Unit (ALU).
            The Alu unit is a very important part of a computer's
				central processing unit. Its function is to perform
				arithmetic and logic operations on the values that are held 
				in the registers. In this case we have a 16-bit Alu, which
				means we are performing a variety of manipulations on 16 bit
				integers. In this case, we are only performing 13 different 
				operations.
 *         
 * Notes:  This module is written in behavioral verilog. R and S both 
           represent the data that has the contents of the register 
			  addressed by the R_Adr and S_Adr of the register file.
			  In the Alu R and S data will be used in order to perform
			  various manipulations of this data. Alu_op is an input that 
			  will come from 4 of our switches in Nexys 4 board. Y is the 
			  ouput of the ALU and basically its content to display depends
			  on the Alu_op, S_Adr, and S_sel inputs.
 *
  ****************************************************************************/ 
 /**************************************************************************** 
  * Written by: R. W. Allison 
  * Date: July 20, 2016
  * File: 301_alu.v
  * 
  * This 16-bit ALU will be used in the 301 "Integer Datapath" project 
  * to perform various manipulations on 16-bit integers. 
  * There are 4 "Op" inputs to perform up to 16 basic operations. 
  * Currently, there are only 13 of the 16 operations used. 
  * 
  * The alu status flags represent the Y output being negative (N), 
  * zero(Z), and a carry out (C). 
  ****************************************************************************/ 
 `timescale 1ns / 1ps
 
module alu ( R, S, Alu_op, Y, N, Z, C );

   input  [15:0] R, S;
	input  [3:0]  Alu_op;
	output [15:0] Y;         reg [15:0] Y;
	output        N, Z, C;   reg  [15:0] N, Z, C;
	
	always @(R or S or Alu_op)begin 
	   case (Alu_op)
		   4'b0000   :   {C, Y} =  {1'b0, S};     // pass S
			4'b0001   :   {C, Y} =  {1'b0, R};     // pass R
			4'b0010   :   {C, Y} =  S + 1;         // increment S
			4'b0011   :   {C, Y} =  S - 1;         // decrement S
			4'b0100   :   {C, Y} =  R + S;         // add
			4'b0101   :   {C, Y} =  R - S;         // Subtract
			4'b0110   :    begin                   // right shift S (logic)
			                  C = S[0];
									Y = S >> 1;
								end
			4'b0111   :    begin
			                  C = S[15];           // left shift S (logic)
									Y = S << 1;
								end
		   4'b1000   :   {C, Y} = {1'b0, R & S};  // logic and
			4'b1001   :   {C, Y} = {1'b0, R | S};  // logic or
			4'b1010   :   {C, Y} = {1'b0, R ^ S};  // logic xor
			4'b1011   :   {C, Y} = {1'b0, ~S};     // logic not S   (1's comp)
			4'b1100   :   {C, Y} = 0 - S;          // negate S      (2's comp)
			default   :   {C, Y} = {1'b0, S};      // pass S for default
		endcase
		
		//handle last two status flags
		N = Y[15];
		if  (Y == 16'b0)
		      Z = 1'b1;
		else
		      Z = 1'b0;
				
	end  //end always
	
endmodule

