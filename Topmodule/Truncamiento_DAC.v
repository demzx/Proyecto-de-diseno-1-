`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:41 04/28/2015 
// Design Name: 
// Module Name:    Truncamiento_DAC 
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
module Truncamiento_DAC #(parameter N_ADC = 12, Magnitud=8, Decimal=14, N = Magnitud+Decimal+1)

(input wire signed [N-1:0] Salida_Filtros ,
 output wire  [N_ADC-1:0] Dac
    );
wire signed [N-1:0] Data_23;

	 
Suma #(.N(N)) sum (
.A(Salida_Filtros),
.B(23'b00000000010000000000000),
.SUMA(Data_23));

assign Dac = Data_23 [N-2-Magnitud:Decimal-12];



endmodule
