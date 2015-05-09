`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:31 04/03/2015 
// Design Name: 
// Module Name:    Prueba_ADC 
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
module Prueba_ADC(
input wire Clock_Nexys,Reset,reset_Clck,
input wire  data_ADC,start,
output wire done,CS,Clock_Muestreo,
output wire [3:0] data_basura,
//Para revision
output wire [11:0] Dato
//output wire [3:0]contador,
//output wire [1:0]Estado,
//output wire [15:0]Dato_Moviendose
 );

wire Clock_out;
assign Clock_Muestreo = Clock_out;

Divisor_Clock_ADC divisor (
    .Clck_in(Clock_Nexys), 
    .reset_Clock(reset_Clck), 
    .Clock_out(Clock_out)
    );

Protocolo_ADC ObtenerDato (
    .Clock_Muestreo(Clock_out), 
    .reset(Reset), 
    .data_ADC(data_ADC), 
    .start(start), 
    .done(done), 
    .CS(CS), 
    .data_basura(data_basura), 
	 //Para revision
	 .Dato(Dato)
//	 .contador(contador),
//	 .Estado(Estado),
//	 .Dato_Moviendose(Dato_Moviendose)
    );






endmodule
