`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:05 04/01/2015 
// Design Name: 
// Module Name:    Protocolo_ADC 
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

module Protocolo_ADC(
input wire Clock_Muestreo,reset, 
input wire data_ADC,
input wire start,
output reg done,
output wire CS,
output wire [3:0] data_basura,
////CREADO PARA REVISION
output wire [11:0] Dato
//output wire [3:0]contador,
//output wire [1:0]Estado,
//output wire [15:0]Dato_Moviendose
);
 
// se definen los estados de la maquina 

localparam [1:0]
                Inicio=2'b00,
					 Capturar=2'b01,
					 Listo=2'b10;
// variables de logica de la maquina 
					 
reg [15:0] Data_Act,Data_next;
reg [11:0] Dato_final_A,Dato_final_N;
reg CS_A , CS_N; 
reg [1:0] Estado_Act,Estado_Next;
reg [3:0]contador_A,contador_N; 

// Acualizacion de los estados actuales y reset

always@(posedge Clock_Muestreo,posedge reset)
       begin 
		      if(reset)
				   begin
				   Data_Act <= 0;
//				   Data_Act <= 1;
               CS_A <= 1;
					Estado_Act <= 0;
					contador_A <= 0;
					Dato_final_A <=0;
				   end
            else 
				   begin 
				   Data_Act <= Data_next;
					CS_A <= CS_N;
					Estado_Act <= Estado_Next;
					contador_A <= contador_N;
					Dato_final_A <= Dato_final_N;
					end 
			end 
			
// logica de estado proximo de la maquina 

always @*
      begin 
		Data_next = Data_Act;
		CS_N = CS_A;
		Estado_Next = Estado_Act;
		contador_N = contador_A;
		Dato_final_N = Dato_final_A;
		done = 1'b0; 
		case (Estado_Act)
		      
				Inicio :  if(start && CS_N)
				             begin
				             CS_N = 1'b0;
							    Estado_Next = Capturar;
							    contador_N = 4'd0;
							    end 
							 else 
							    Estado_Next = Inicio;
		    Capturar :  
			           if(contador_N == 15)
						     Estado_Next = Listo;
							else 
							  begin 
							  Data_next = {data_ADC,Data_next[15:1]};
							 // Data_next = {Data_next[14:0],data_ADC};
							  contador_N = contador_N + 1'b1;
							  end
			 Listo :
			            begin
							done = 1'b1;
							CS_N = 1'b1;
							Dato_final_N [0] = Data_next[15];
							Dato_final_N [1] = Data_next[14];
                     Dato_final_N [2] = Data_next[13];
						   Dato_final_N [3] = Data_next[12];
						   Dato_final_N [4] = Data_next[11];
						   Dato_final_N [5] = Data_next[10];
						   Dato_final_N [6] = Data_next[9];
						   Dato_final_N [7] = Data_next[8];
						   Dato_final_N [8] = Data_next[7];
						   Dato_final_N [9] = Data_next[6];
                     Dato_final_N [10] = Data_next[5];
                     Dato_final_N [11] = Data_next[4];
							Estado_Next = Inicio;
							end 
							
			default :   Estado_Next = Inicio;
			endcase
			end 
// asignaciones a las salidas del modulo 
assign CS = CS_A;
assign data_basura = Data_Act[3:0];
assign Dato = Dato_final_N;
//Revision
//assign contador = contador_A;
//assign Estado = Estado_Act;
//assign Dato_Moviendose = Data_Act;
endmodule
