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

module EtapaFiltros 
	#(parameter Magnitud=8, Decimal=14, N = Magnitud+Decimal+1)
(
	input wire signed [N-1:0] Data_In,
	input wire clock_In,clk_Registros,Reset,
	input wire enable,
	output wire signed[N-1:0] Data_Out_bajos,Data_Out_medios,Data_Out_altos
);


wire signed[N-1:0] Data_Out_PB200,Data_Out_PB5K,Data_Out_PB20k;

//---------Filtro Bajos--------------------------------------

//Paso Bajo 200Hz
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) LPB(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_In),
	.Data_Out(Data_Out_PB200),
	.a1(-(23'h7F828F)),  //1.96
	.a2(-(23'h003D78)),  //-0.9605
	.b0(23'h000003),     //0.000199
	.b1(23'h000006),     //0.0003979
	.b2(23'h000003)      //0.000199
    );  
//Paso Alto 20Hz
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) HPB(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_Out_PB200),
	.Data_Out(Data_Out_bajos),
	.a1(-(23'h7F8041)),   //1.996
	.a2(-(23'h003FBE)),   //-0.996
	.b0(23'h003FDF),      //0.998
	.b1(23'h7F8041),      //-1.996
	.b2(23'h003FDF)       //0.998
	);
	
	
//---------Filtro Medios--------------------------------------

//Paso Bajo 5KHz 
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) LPM(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_In),
	.Data_Out(Data_Out_PB5K),
	.a1(-(23'h7FBDC2)),   //1.035
	.a2(-(23'h00178A)), 	 //-0.3678
	.b0(23'h000552),		 //0.08316
	.b1(23'h000AA4),      //0.1663
	.b2(23'h000552)       //0.08316
	); 
//Paso Alto 200Hz
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) HPM(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_Out_PB5K),
	.Data_Out(Data_Out_medios),
	.a1(-(23'h7F828F)),   //1.96
	.a2(-(23'h003D78)),   //-0.9605
	.b0(23'h004000),      //1
	.b1(23'h7F8000),      //-2
	.b2(23'h004000)       //1
	); 
	
//---------Filtro Altos--------------------------------------

//Paso Bajo 20KHz
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) LPH(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_In),
	.Data_Out(Data_Out_PB20k),
	.a1(-(23'h0065D2)),   //-1.591
	.a2(-(23'h002A59)),   //-0.6617
	.b0(23'h00340B),      //0.8132
	.b1(23'h006810),      //1.626
	.b2(23'h00340B)       //0.8132
	); 

//Paso Alto 5KHz
Filtro_Generico #(.Magnitud(Magnitud),.Decimal(Decimal)) HPH(
	.clk(clock_In),
	.clk_Registros(clk_Registros),
	.reset(Reset),
	.enable(enable),
	.Data_In(Data_Out_PB20k),
	.Data_Out(Data_Out_altos),
	.a1(-(23'h7FBDC2)),  //1.035
	.a2(-(23'h00178A)),  //-0.3678
	.b0(23'h002671),     //0.6007
	.b1(23'h7FB323),     //1.201
	.b2(23'h002671)      //0.6007
	); 

endmodule
