`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:27 04/12/2015 
// Design Name: 
// Module Name:    Suma 
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
module Suma
#(parameter N = 25)
(
	input wire [N-1:0] A, B,
	output reg [N-1:0] SUMA
    );

reg [N-1:0] SUMAAux;
reg [N-1:0] maximo;
reg [N-1:0] minimo;
reg [N:0] M,m;
always @*
	begin
	SUMAAux = A+B;
	
	M = (2**(N-1)-1); // se utiliza para quitar el warning de truncaiento 
	m = (-2**(N-1)); // se utilia para quitar el warning de truncamiento
	maximo = M[N-1:0] ; // se determina el valor maximo que se puede represenatr con esta cantidad de bits 
	minimo = m[N-1:0]; // se determina el valor maximo que se puede represenatr con esta cantidad de bits
	end
	
always @*
begin
	if (A[N-1] == 0 && B[N-1] == 0 && SUMAAux[N-1] == 1)
		begin
		SUMA = maximo;
		end
	else if (A[N-1] == 1 && B[N-1] == 1 && SUMAAux[N-1] == 0)
		begin
		SUMA = minimo;
		end
	else
		SUMA = SUMAAux;
		
end
endmodule

