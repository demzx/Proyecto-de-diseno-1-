`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:14:25 04/23/2015 
// Design Name: 
// Module Name:    Protocolo_DAC 
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
module Protocolo_DAC
#(parameter N=12)
(
input wire Clock_Muestreo,
input wire Clock,reset, 
input wire [N-1:0] data_In,
input wire start,
output wire Sync,
output wire Data_DAC
);
 
// se definen los estados de la maquina 

localparam [1:0]
                Inicio = 2'b00,
					 enviar = 2'b01,
					 Listo  = 2'b10;
// variables de logica de la maquina 
					 
reg Data_Act,Data_next;
reg [3:0] bit_num_A, bit_num_N;
reg Sync_A , Sync_N; 
reg [1:0] Estado_Act,Estado_Next;
reg [3:0]contador_A,contador_N; 
reg done; 
reg [1:0] valor_A;
wire [1:0] Valor_next; 
reg  clockd_A;
wire clockd_next;

always @(posedge Clock, posedge reset)
  if (reset)
     begin 
	        valor_A <= 0 ;
			  clockd_A <= 0 ;
	  end   
  else 
     begin 
	       valor_A <= Valor_next ;
			 clockd_A <= clockd_next ;
			end 
	assign Valor_next =  {Clock_Muestreo,valor_A[1]};
   assign clockd_next =  (valor_A==2'b11) ? 1'b1 :
		                   (valor_A==2'b00) ? 1'b0 :
								  clockd_A;
								  
	assign fall_edge = clockd_A & ~ clockd_next ; 

// Acualizacion de los estados actuales y reset
always@(negedge Clock, posedge reset)
       begin 
		      if(reset)
				   begin
				   Data_Act <= 0;
               Sync_A <= 1;
					Estado_Act <= 0;
					contador_A <= 0;
					bit_num_A <= 0;
				   end
            else 
				   begin 
				   Data_Act <= Data_next;
					Sync_A <= Sync_N;
					Estado_Act <= Estado_Next;
					contador_A <= contador_N;
					bit_num_A <= bit_num_N;
					end 
			end 
			
// logica de estado proximo de la maquina 

always @*
      begin 
		Data_next = Data_Act;
		Sync_N =Sync_A;
		Estado_Next = Estado_Act;
		contador_N = contador_A;
		bit_num_N = bit_num_A; 
		case (Estado_Act)
		      
				Inicio :  if(start && Sync_N && fall_edge)
				             begin
				             Sync_N = 1'b0;
								 bit_num_N = 4'd11; 
								 contador_N = 4'd0;

							    Estado_Next = enviar;
							    end 
							 else 
							    Estado_Next = Inicio;
		    enviar :  if(fall_edge)
			              begin
			               if (contador_N == 15)
						          begin
								    Estado_Next = Listo;
                            end 
						  
						      else if (contador_N >= 3)
							        begin 
							        Data_next = data_In [bit_num_N] ;
							        bit_num_N = bit_num_N - 1'b1 ;
							        contador_N = contador_N + 1'b1 ;
							        end
							    else 
							        begin 
								     Data_next = 1'b0;
								     contador_N = contador_N + 1'b1;
								     end 
								end 
			 Listo :
			            begin
						   Data_next = 1'b0;
							Sync_N = 1'b1;
							Estado_Next = Inicio;
							end 
							
			default :   Estado_Next = Inicio;
			endcase
			end 
// asignaciones a las salidas del modulo 

assign Sync = Sync_A;
assign Data_DAC= Data_Act;
endmodule

