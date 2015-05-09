`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:35 04/27/2015 
// Design Name: 
// Module Name:    Truncamiento_ADC 
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
module Truncamiento_ADC  #(parameter N_ADC = 12,N=23)
(input wire [N_ADC-1:0]data_ADC,
 output wire signed [N-1:0] Entrada_Filtros 
    );
reg signed [N-1:0] Data_23;

always @* 
       begin 
		 Data_23 = {9'd0,data_ADC,2'd0};		
		 end 
		 
Suma #(.N(N)) sum (
.A(Data_23),
.B(23'b11111111110000000000000),
.SUMA(Entrada_Filtros));

endmodule
