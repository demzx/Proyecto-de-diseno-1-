`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:32 04/17/2015 
// Design Name: 
// Module Name:    Multiplicacion 
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
module Multiplicacion
#(parameter Magnitud = 8, Decimal = 16) // se establecen los parametros del modulo 
(
	input wire signed[N-1:0]A,B,
	output reg signed[N-1:0]multi
    );
	 
	 localparam  N = (Decimal + Magnitud + 1),
					 M = (2**(N-1)-1),
					 m = (2**(N-1)+1),
					 maximo = M[N-1:0],
					 minimo = m[N-1:0];
					 
reg signed[2*N-1:0]MultiAux;
reg overflow, underflow;
always @*
	begin
	MultiAux =A*B;
		if ((A[N-2:0] == 0) || (B[N-2:0] == 0))
			multi = 0;
		else
		begin
			if ((A[N-1] == B[N-1]) && ((MultiAux[2*N-1:(Magnitud+Decimal+Decimal)] > 0)))
				multi = maximo;
			else if  ((A[N-1] != B[N-1]) && (~(&(MultiAux[2*N-1:(Magnitud+Decimal+Decimal)])) == 1'b1))
				multi = minimo;
			else
				multi = {MultiAux[2*N-1], MultiAux[(Magnitud+Decimal+Decimal-1):Decimal]};
		end
	end
endmodule

