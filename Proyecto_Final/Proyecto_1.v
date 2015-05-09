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
input wire Reset,clock_In,
input wire data_ADC,start,
input wire [1:0] Filtro,
output wire done,
output wire CS,Clock_Muestreo1, clck, Sync,Data_DAC,
output wire [3:0] data_basura,
//Para revision
output wire signed [N_ADC-1:0] Dac
    );
assign clck = Clock_Muestreo;

	 
Divisor_Clock_ADC c (.Clck_in(clock_In),.reset_Clock(Reset),.Clock_out(Clock_Muestreo1));

//wire [N_ADC-1:0] Dato,Dac,Dac2,ent_filt;
wire [N_ADC-1:0] Dato,Dac2,ent_filt;//Para Revision DAC
reg Enable;
wire signed [N-1:0] Entrada_Filtros,Data_Out_bajos,Data_Out_medios,Data_Out_altos,Salida_Filtros, SalidaSuma1, SumaTotal;


divisor50MHZmodule c1 (
    .Clck_in(clock_In), 
    .reset_Clock(Reset), 
    .Clock_out(Clock1)
    );


Prueba_ADC adc (
    .Clock_Nexys(clock_In), 
    .Reset(Reset), 
    .reset_Clck(Reset), 
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

always @*
	if (done && Clock_Muestreo1)
		Enable = 0;
	else
		Enable = 1;
wire Activar;

and(Activar, Clock_Muestreo, done);

EtapaFiltros #(.Magnitud(Magnitud),.Decimal(Decimal)) f 
(   
    .Data_In(Entrada_Filtros), 
    .clock_In(Clock1), 
	 .clk_Registros(Activar),
    .Reset(Reset), 
    .enable(Enable), 
    .Data_Out_bajos(Data_Out_bajos), 
    .Data_Out_medios(Data_Out_medios), 
    .Data_Out_altos(Data_Out_altos)
    );
	 
Suma #(.N(N)) Suma1 (
    .A(Data_Out_bajos), 
    .B(Data_Out_medios), 
    .SUMA(SalidaSuma1)
    );
Suma #(.N(N)) Suma2 (
    .A(SalidaSuma1), 
    .B(Data_Out_altos), 
    .SUMA(SumaTotal)
    );
	 
Mux_Filtros #(.N(N)) sel_sal 
(
 .bajos(Data_Out_bajos)
 ,.medios(Data_Out_medios)
 ,.altos(Data_Out_altos)
 ,.SalidaTotal(SumaTotal)
 ,.caso(Filtro)
 ,.sal_Mux(Salida_Filtros)
    );



Truncamiento_DAC #(.N_ADC(N_ADC),.Magnitud(Magnitud),.Decimal(Decimal)) tdac 
(.Salida_Filtros(Salida_Filtros),.Dac(Dac));

Registro_N_bits #(.N(N_ADC)) r3 (.clock(clock_In),.reset(Reset),.d(Dac),.q(Dac2));



Protocolo_DAC d (
    .Clock_Muestreo(Clock_Muestreo), 
    .Clock(clock_In), 
    .reset(Reset), 
    .data_In(Dac2), 
    .start(start), 
    .Sync(Sync), 
    .Data_DAC(Data_DAC)
    );

endmodule
