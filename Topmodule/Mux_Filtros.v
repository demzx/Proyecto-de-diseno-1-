`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:02:16 04/28/2015 
// Design Name: 
// Module Name:    Mux_Filttros 
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
module Mux_Filtros #(parameter N = 23)
(
 input wire signed [N-1:0] bajos,medios,altos,
 input wire [1:0] caso,
 output wire signed [N-1:0] sal_Mux
    );
	 
reg signed [N-1:0] sal;

always@*
  begin 
   case(caso)  
	2'b00 : sal = bajos ; 
   2'b01 : sal = medios ; 
	2'b10 : sal = altos ; 

  default : sal = bajos;  
  endcase 
  end 
assign sal_Mux = sal;

endmodule
