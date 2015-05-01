`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:28 04/28/2015 
// Design Name: 
// Module Name:    Proyecto_1 
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
module Proyecto_1 #(parameter Magnitud=8, Decimal=14, N = Magnitud+Decimal+1, N_ADC = 12)
(
input wire Reset,clock_In,reset_Clock,
input wire data_ADC,start,
//input wire [1:0] Filtro,
output wire done,
output wire CS,Clock_Muestreo1,Sync,Data_DAC,
output wire [3:0] data_basura
    );
	 
	 
Divisor_Clock_ADC c (.Clck_in(clock_In),.reset_Clock(reset_Clock),.Clock_out(Clock_Muestreo1));

wire [N_ADC-1:0] Dato,Dac,Dac2,ent_filt;

wire signed [N-1:0] Entrada_Filtros,Data_Out_bajos,Data_Out_medios,Data_Out_altos,Salida_Filtros;

divisor50MHZmodule c1 (
    .Clck_in(clock_In), 
    .reset_Clock(reset_Clock), 
    .Clock_out(Clock1)
    );


Prueba_ADC adc (
    .Clock_Nexys(clock_In), 
    .Reset(Reset), 
    .reset_Clck(reset_Clock), 
    .data_ADC(data_ADC), 
    .start(start), 
    .done(done), 
    .CS(CS), 
    .Clock_Muestreo(Clock_Muestreo), 
    .data_basura(data_basura), 
    .Dato(Dato)
    );

Registro_N_bits #(.N(N_ADC)) adc1 (.clock(clock_In),.reset(Reset),.d(Dato),.q(ent_filt));

	
Truncamiento_ADC #(.N_ADC(N_ADC),.N(N)) tadc
(.data_ADC(ent_filt),.Entrada_Filtros(Entrada_Filtros));

EtapaFiltros #(.Magnitud(Magnitud),.Decimal(Decimal)) f 
(   
    .Data_In(Entrada_Filtros), 
    .clock_In(Clock1), 
	 .clk_Registros(Clock_Muestreo),
    .Reset(Reset), 
    .enable(done), 
    .Data_Out_bajos(Data_Out_bajos), 
    .Data_Out_medios(Data_Out_medios), 
    .Data_Out_altos(Data_Out_altos)
    );
	 
Mux_Filtros #(.N(N)) sel_sal 
(
 .bajos(Data_Out_bajos)
 ,.medios(Data_Out_medios)
 ,.altos(Data_Out_altos)
 ,.caso(Filtro)
 ,.sal_Mux(Salida_Filtros)
    );



Truncamiento_DAC #(.N_ADC(N_ADC),.Magnitud(Magnitud),.Decimal(Decimal)) tdac 
(.Salida_Filtros(Salida_Filtros),.Dac(Dac));

Registro_N_bits #(.N(N_ADC)) adc2 (.clock(clock_In),.reset(Reset),.d(Dac),.q(Dac2));



Protocolo_DAC d (
    .Clock_Muestreo(Clock_Muestreo), 
    .Clock(clock_In), 
    .reset(Reset), 
    .data_In(Dato), 
    .start(start), 
    .Sync(Sync), 
    .Data_DAC(Data_DAC)
    );







endmodule
