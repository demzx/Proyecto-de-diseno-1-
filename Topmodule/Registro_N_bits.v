`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:09 02/22/2015 
// Design Name: 
// Module Name:    Registro_N_bits 
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
module Registro_N_bits

#(parameter N = 6)
(
  input wire clock,
  input wire reset,
  input wire signed  [N-1:0] d ,
  output reg signed [N-1:0] q  
  );

// declaracion de las entradas 
// cuerpo 

always @(posedge clock , posedge reset) 
	 if (reset)
		q <= 0; // si reset esta en alto salidas en 0
	else 
      q <= d; // si el enable esta en alto q toma el valor de la entrada d 
endmodule

