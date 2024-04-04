/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  reg16.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  October 13, 2016  
 *
 * Purpose: This module represents a 16-bit register with an asynchronous 
 reset and a synchronous load for the Din input. Just like we know, a 
 register is made up of an array of flip flops, therefore this 16 bit 
 register will be used to store information in this case it to store 16 bits.
 *         
 * Notes: It is written in behavioral verilog and it will only operate on the 
 positive edge of the clock or when the reset button in pressed. If the reset 
 is pressed the register will make Dout equal to 16'b0 or else if load is used
 than it will output the Din or else it will ouput the Dout. We also used an 
 assign statement for reading the register.
 *
 ****************************************************************************/
`timescale 1ns / 1ps

module reg16( clk, reset, ld, Din, DA, DB, oeA, oeB );

	input 	clk, reset, ld, oeA, oeB; 
	input 	[15:0] Din; 
	output 	[15:0] DA, DB; 
	reg 		[15:0] Dout; 
	
	// Behavioral section for writing to the register 
	always @ ( posedge clk or posedge reset ) 
		if (reset) 
			Dout <= 16'b0; 
		else 
			if (ld) 
					Dout <= Din; 
			else	Dout <= Dout; 
			
	// Conditional continuous assignments for reading the register 
	assign DA = oeA ? Dout : 16'hz; 
	assign DB = oeB ? Dout : 16'hz; 

endmodule

