`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:18 04/18/2015 
// Design Name: 
// Module Name:    Etapa_Filtros 
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
module Etapa_Filtros
#(parameter N=25 ,S=1, Magnitud = 8, Decimal = 16)
(
input wire clock_In,Reset,enable,
input wire [N-1:0] Data_In,
output wire [N-1:0] Data_Out_bajos,Data_Out_medios,Data_Out_altos
 );

 localparam [N-1:0]

// Paso Bajo 200Hz

a1_PB200 = 25'b1111111100000101000111110, //a1 = -1.96
a2_PB200 = 25'b0000000001111010111100011, //a2 = 0.9605
b0_PB200 = 25'b0000000000000000000001101,//b0 = 0.000199
b1_PB200 = 25'b0000000000000000000011010, //b1 = 0.0003979
b2_PB200 = 25'b0000000000000000000001101, //b2 = 0.000199

//Paso Bajo 20KHz

a1_PB20k = 25'b0000000011001011101001011,//a1 = 1.591
a2_PB20k = 25'b0000000001010100101100101,//a2 = 0.6617
b0_PB20k = 25'b0000000001101000000101101,//b0 = 0.8132
b1_PB20k = 25'b0000000011010000001000001,//b1 = 1.626
b2_PB20k = 25'b0000000001101000000101101,//b2 = 0.8132

// Paso Bajo 5KHz

a1_PB5k = 25'b1111111101111011100001011, //a1 = -1.035
a2_PB5k = 25'b0000000000101111000101000, //a2 = 0.3678
b0_PB5k = 25'b0000000000001010101001001, //b0 = 0.08316
b1_PB5k = 25'b0000000000010101010010010, //b1 = 0.1663
b2_PB5k = 25'b0000000000001010101001001, //b2 = 0.08316

//Paso Alto 5KHz

a1_PA5k = 25'b1111111101111011100001011, //a1 = -1.035
a2_PA5k = 25'b0000000000101111000101000, //a2 = 0.3678
b0_PA5k = 25'b0000000001001100111000111, //b0 = 0.6007
b1_PA5k = 25'b1111111101100110010001100, //b1 = -1.201
b2_PA5k = 25'b0000000001001100111000111, //b2 = 0.6007
 
// Paso Alto 200Hz
 
a1_PA200 = 25'b1111111100000101000111110,//a1 = -1.96
a2_PA200 = 25'b0000000001111010111100011,//a2 = 0.9605
b0_PA200 = 25'b0000000010000000000000000,//b0 = 1
b1_PA200 = 25'b1111111100000000000000000,//b1 = -2
b2_PA200 = 25'b0000000010000000000000000,//b2 = 1

// Paso Alto 20Hz

a1_PA20 = 25'b1111111100000000100000111, //a1 = -1.996
a2_PA20 = 25'b0000000001111111011111001, //a2 = 0.996
b0_PA20 = 25'b0000000001111111101111100, //b0 = 0.998
b1_PA20 = 25'b1111111100000000100000111, //b1 = -1.996
b2_PA20 = 25'b0000000001111111101111100; //b2 = 0.998

wire [N-1:0] Sal_PA20,Sal_PA200,Sal_PA5k;

// Filtro pasa bandas para bajos 
Filtro_generico #(.a1(a1_PA20),.a2(a2_PA20),.b0(b0_PA20),.b1(b1_PA20),.b2(b2_PA20),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_Alto_20Hz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Data_In),.Data_Out(Sal_PA20));

Filtro_generico #(.a1(a1_PB200),.a2(a2_PB200),.b0(b0_PB200),.b1(b1_PB200),.b2(b2_PB200),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_bajo_200Hz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Sal_PA20),.Data_Out(Data_Out_bajos));

// Filtro pasa bandas para medios
Filtro_generico #(.a1(a1_PA200),.a2(a2_PA200),.b0(b0_PA200),.b1(b1_PA200),.b2(b2_PA200),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_Alto_200Hz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Data_In),.Data_Out(Sal_PA200));

Filtro_generico #(.a1(a1_PB5k),.a2(a2_PB5k),.b0(b0_PB5k),.b1(b1_PB5k),.b2(b2_PB5k),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_bajo_5khz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Sal_PA200),.Data_Out(Data_Out_medios));

// Filtro pasa bandas para altos
Filtro_generico #(.a1(a1_PA5k),.a2(a2_PA5k),.b0(b0_PA5k),.b1(b1_PA5k),.b2(b2_PA5k),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_Alto_5kHz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Data_In),.Data_Out(Sal_PA5k));

Filtro_generico #(.a1(a1_PB20k),.a2(a2_PB20k),.b0(b0_PB20k),.b1(b1_PB20k),.b2(b2_PB20k),.NF(N),.SF(S),.MagnitudF(Magnitud),.DecimalF(Decimal)) 
Paso_bajo_20khz (.clock_In(clock_In),.Reset(Reset),.enable(enable),.Data_In(Sal_PA5k),.Data_Out(Data_Out_altos));




endmodule
