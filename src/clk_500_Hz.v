/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  clk_500_Hz.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: Generally, the purpose of the a clock divider is to take 
 an input clock with a specific frequency and produce a desired output 
 clock and frequency. We achieved this by dividing the incoming clock 
 by the decimalvalue in the if-statement. In this case, since the desired 
 outgoing frequency is 500HZ and the incoming frequency is the 100MHz provided
 by the FPGA. This decimal value was achieved by dividing the incoming 
 frequency by the outgoing frequency and dividing by two to make half a period. 
 *         
 * Notes: The resulting value inside the if-statement is 100,000. 
 *
 ****************************************************************************/ 
 
 `timescale 1ns / 1ps
 
module clk_500_Hz( clk_in, reset, clk_out );
 
	input	 	clk_in, reset; 
	output 	clk_out; 
	reg 		clk_out; 
	integer 	i; 
	//***************************************************************
	// The following verilog code will "divide" an incoming clock 
	// by the 32-bit decimal value specified in the "if condition" 
	// 
	// The value of the timer that counts the incoming clock ticks 
	// is equal to [ (Incoming Freq / Outgoing Freq) / 2 ]
	//***************************************************************

		always@ (posedge clk_in or posedge reset) begin
		if (reset == 1'b1) begin 
			i = 0; 
			clk_out = 0; 
		end 
		//got a clock, so increment the counter and
		//test to see if half a period has elapsed
		else begin 
			i = i+1; 
			if (i >= ((100000000/500)/2)) begin 
				clk_out = ~clk_out; 
				i=0; 
			end//if
		end//else
	end //always
	
endmodule


