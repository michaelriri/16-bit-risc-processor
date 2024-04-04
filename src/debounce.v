/****************************** C E C S  3 0 1 ******************************
 * 
 * File Name:  debounce.v
 * Project:    Lab Project 8: 16-Bit RISC Processor
 * Designer 1: Michael Rios
 * Email:      riosmichael28@ymail.com
 * Designer 2: Yuliana Uriostegui
 * Email: 		yulove613@gmail.com
 * Rev. No.:   Version 1.1
 * Rev. Date:  November 18, 2016  
 *
 * Purpose: The purpose of this module is to counteract the bounce 
 associated with using mechanical switches. When the contacts of any
 mechanical switch make contact they rebound(or bounce) before coming 
 to a rest. This module counteracts this behavior by waiting  this bounce
 out; filtering out all unstable inputs. We  do this by shifting the
 input into a register which will, in our case, wait out the unstable 
 inputs for about 20ms --since our frequency is 500HZ. The next step, the 
 assign statement, creates the one-shot pulse which will serve as out 
 output. When all samples in the register are 1, that siginifies that the 
 inputs are stable. The reason that q9 is complemented is due to the fact
 that we are only trying to output one clock  pulse. When the oldest sample 
 is complemented, in this case q9, it will create this effect as all samples
 will be 1 for only one clock pulse. 
 *         
 * Notes:
 *
 ****************************************************************************/ 
 
`timescale 1ns / 1ps

module debounce( clk_in, reset, D_in, D_out );

	input  clk_in, reset, D_in; 
	output D_out; 
	wire	 D_out; 
	
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0; 
	
	always @ ( posedge clk_in or posedge reset) 
		if (reset == 1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0; 
		else begin 
			//Shift in the new sample that's on the D_in input.  
			q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4; 
			q4 <= q3; q3 <= q2; q2<=q1; q1 <= q0; q0 <= D_in; 
		end 
			//Create the debounced, one-shot pulse. 
			assign D_out = !q9 & q8 & q7 & q6 & q5 & 
						q4 & q3 & q2 & q1 & q0; 
						
endmodule

