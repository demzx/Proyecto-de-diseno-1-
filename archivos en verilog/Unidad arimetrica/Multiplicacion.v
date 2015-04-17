`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:48 04/15/2015 
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
#(parameter Decimal = 16, S=1 ,Magnitud = 8, N = (Decimal + Magnitud + 1)) // se establecen los parametros del modulo 
(
	input wire [N-1:0]A,B,
	output reg [N-1:0]Multiplicacion
    );

reg [N-1:0]Aaux, Baux; // se definen las variables que me avna ayudar a calcular el complemento
reg [2*N-1:0]MultiAux, Multi; // estos son los valores opara poder realizar las operaciones
reg [N-1:0] maximo,minimo; // se establecen maximo y minimo valores de saturacion
reg [N:0] M,m; // se utiliza para corregirt un warning de truncado 

always @*
	begin
	M = (2**(N-1)-1); // se utiliza para quitar el warning de truncaiento 
	m = (2**(N-1)+1); // se utilia para quitar el warning de truncamiento
	maximo = M[N-1:0] ; // se determina el valor maximo que se puede represenatr con esta cantidad de bits 
	minimo = m[N-1:0]; // se determina el valor maximo que se puede represenatr con esta cantidad de bits
	end
	
always @* // si se da que a es negativo se le calcula el complemento a 2
   begin 
     Multi = A*B; // se realiza la multiplicacion 
	if (A[N-1] == 1) // se pregunta por si a es negativo
		Aaux = -A; // se le aplica el complemento a 2 
	else
		Aaux = A; // si es positivo se deja cm esta 
   end 
always @*  // si se da que b es negativo se le calcula el complemento a 2
	if (B[N-1] == 1) // se pregunta por si b es negativo
		Baux = -B; // se le aplica el complemento a 2
	else
		Baux = B; // si es positivo se deja cm esta 
		

	
always @* // se empieza a seleccionar los casos de la multiplicacion 
    begin 
      MultiAux = Aaux[N-2:0]*Baux[N-2:0]; // se realizan los casos de la multplicacion si tuviera que hacer se el compmlemtno a 2 o dependiendo de las condiciones 
		if  (MultiAux[2*Magnitud+2*Decimal-1:Decimal]> maximo) // si se diera el caso que las magnitudes dan mayor al valor maximo se tiene que saturar las salidas
		     begin 
			  if ((A[N-1] == 1) && (B[N-1] == 1)) // si se multiplican 2 negativos tira a maximo
			  Multiplicacion = maximo; 
			  else if ((A[N-1] == 0) && (B[N-1] == 0)) // si son dos positivos dan al maximo 
			  Multiplicacion = maximo; 
			  else 
			  Multiplicacion = minimo; // si uno de los dos es negativo y se paso del maximo saturo al negativo 
           end 
	   else  
		Multiplicacion = Multi[2*N-1-S-Magnitud:Decimal]; // si no se tiene que saturar se tira el valor de la multiplicion normal 
     end 
endmodule
