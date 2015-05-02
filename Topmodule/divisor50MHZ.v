`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:23 04/30/2015 
// Design Name: 
// Module Name:    divisor25MHZ 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module divisor50MHZmodule (
 input wire Clck_in,
 input wire reset_Clock,
 output reg Clock_out
 ); 
 
 

 
always @(posedge Clck_in,posedge reset_Clock) 
 begin
      if (reset_Clock)
		   begin
		   Clock_out <= 0;
			end 
      else
          begin		
		    if (Clock_out == 0)  
		        begin                        
		        Clock_out <= Clock_out+1'b1;
		        end 
		     else 
		        Clock_out <= 0; 
          end 
 end 
  
endmodule 

