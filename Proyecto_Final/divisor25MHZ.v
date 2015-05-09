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
module divisor25MHZmodule (
 input wire Clck_in,
 input wire reset_Clock,
 output reg Clock_out
 ); 
 
 
 reg [5:0]contador ; 

 
always @(posedge Clck_in,posedge reset_Clock) 
 begin
      if (reset_Clock)
		   begin
		   Clock_out <= 0;
			contador <= 0;
			end 
      else
          begin		
		    if (contador == 6'd49)  
		        begin                    
			     contador <=1'd0;       
		        Clock_out <= ~Clock_out;
		        end 
		     else 
		        contador <= contador + 1'b1; 
          end 
 end 
  
endmodule 

