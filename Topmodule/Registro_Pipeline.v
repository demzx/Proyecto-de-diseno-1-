`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:55:05 04/17/2015 
// Design Name: 
// Module Name:    Registro_Pipeline 
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
module Registro_Pipeline
#(parameter N = 8) // se define el parametro de los bits del registro
	(
		input wire clk,reset, // se define le clock y el reset 
		input wire [N-1:0] data_in, // se define el dato de entrada
		input wire enable, // el enable que solo me carag el dato cuando esta en 1
		output wire [N-1:0] q_out // el dato de salida 
    );
 reg [N-1:0] q_actual ,q_next; // se definen los valores de q actual y q next
                               // para el proceso en lalogica actual y siguente 
// logica actual dependen del clok 
always@(posedge clk, posedge reset)
	if(reset)
		q_actual <= 0; // se incializa q
	else
		q_actual <= q_next; // se actualiza q actual 
// logica siguiente 		
always@*
   begin
	q_next = q_actual;
	if(~enable) // si el enable esta activado
	   q_next =  data_in; // se deja pasar el dato
	else 
	   q_next = q_actual; // sino se mantiene las salidas iguales 
	end 
	
assign q_out = q_actual ; // se asigna a la salida el q actual 
endmodule