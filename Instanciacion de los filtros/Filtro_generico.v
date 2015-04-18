`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:00 04/18/2015 
// Design Name: 
// Module Name:    Filtro_generico 
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
module Filtro_generico
// filtro 200 hz pasa baja 
#(parameter a1=25'b1111111100000101000111110, a2 = 25'b0000000001111010111100011,
 b0 = 25'b0000000000000000000001101, b1 = 25'b0000000000000000000011010 
 ,b2 = 25'b0000000000000000000001101,NF=25 ,SF=1, MagnitudF = 8, DecimalF = 16)
 
//a1 = -1.96
//a2 = 0.9605
//b0 = 0.000199
//b1 = 0.0003979
//b2 = 0.000199

(input wire clock_In,Reset,enable,
 input wire [NF-1:0] Data_In,
 output wire [NF-1:0] Data_Out
 );

wire [NF-1:0] Suma_sal_Fk,sal_multiplicacion_b0,Reg_1,sal_multiplicacion_a1,sal_multiplicacion_b1,
      Reg_2,sal_multiplicacion_a2,sal_multiplicacion_b2,Suma_sal_iz,Suma_sal_der;

Suma #(.N(NF)) Entrada (.A(Data_In),.B(Suma_sal_iz),.SUMA(Suma_sal_Fk));

Registro_Pipeline #(.N(NF)) regp_1  (.clk(clock_In),.reset(Reset),.data_in(Suma_sal_Fk),.enable(enable),.q_out(Reg_1));

Multiplicacion #(.S(SF),.Magnitud(MagnitudF),.Decimal(DecimalF)) b_0  (.A(Suma_sal_Fk),.B(b0),.Multiplicacion(sal_multiplicacion_b0));

Multiplicacion #(.S(SF),.Magnitud(MagnitudF),.Decimal(DecimalF)) a_1 (.A(Reg_1),.B(a1),.Multiplicacion(sal_multiplicacion_a1));

Multiplicacion #(.S(SF),.Magnitud(MagnitudF),.Decimal(DecimalF)) b_1 (.A(Reg_1),.B(b1),.Multiplicacion(sal_multiplicacion_b1));

Registro_Pipeline #(.N(NF)) regp_2  (.clk(clock_In),.reset(Reset),.data_in(Reg_1),.enable(enable),.q_out(Reg_2));

Multiplicacion #(.S(SF),.Magnitud(MagnitudF),.Decimal(DecimalF)) a_2 (.A(Reg_2),.B(a2),.Multiplicacion(sal_multiplicacion_a2));

Multiplicacion #(.S(SF),.Magnitud(MagnitudF),.Decimal(DecimalF)) b_2 (.A(Reg_2),.B(b2),.Multiplicacion(sal_multiplicacion_b2));

Suma #(.N(NF)) izquierda (.A(sal_multiplicacion_a1),.B(sal_multiplicacion_a2),.SUMA(Suma_sal_iz));

Suma #(.N(NF)) derecha (.A(sal_multiplicacion_b1),.B(sal_multiplicacion_b2),.SUMA(Suma_sal_der));

Suma  #(.N(NF)) salida(.A(sal_multiplicacion_b0),.B(Suma_sal_der),.SUMA(Data_Out));

endmodule
