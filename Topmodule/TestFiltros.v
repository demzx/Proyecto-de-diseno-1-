`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:14:51 04/27/2015
// Design Name:   EtapaFiltros
// Module Name:   C:/Users/ohskr_000/Documents/Universidad/Lab de Digitales/Tercer Proyecto/PROYECTOFINAL/Verilog/EtapaFiltros/TestFiltros.v
// Project Name:  EtapaFiltros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: EtapaFiltros
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestFiltros;

	// Inputs
	reg [22:0] Data_In;
	reg clock_In;
	reg Reset;
	reg enable;

	// Outputs
	wire [22:0] Data_Out_bajos;
	wire [22:0] Data_Out_medios;
	wire [22:0] Data_Out_altos;

	// Instantiate the Unit Under Test (UUT)
	EtapaFiltros uut (
		.Data_In(Data_In), 
		.clock_In(clock_In), 
		.Reset(Reset), 
		.enable(enable), 
		.Data_Out_bajos(Data_Out_bajos), 
		.Data_Out_medios(Data_Out_medios), 
		.Data_Out_altos(Data_Out_altos)
	);

integer PB, PM, PA, k;
reg [22:0]mem[5000:0];//Se genera una memoria para abir el fichero .txt, donde la primera prametrzacion(los primeros parentesis cuadrados leyendo de izquierda a derecha) son para determinar el tamaño de los bits en el arreglo, mientras que los segundos es para decirmel cuantos datos ahi en el fichero .txt 

initial forever
	# 20 clock_In = ~clock_In;
initial begin
		// Initialize Inputs
		clock_In = 0;
		Reset = 0;
		enable = 0;
		Data_In = 0;

		#100;

		clock_In = 0;
		Reset = 1;
		enable = 0;
		Data_In = 0;

		#100;
		
		Reset = 0;
		enable = 0;
		Data_In = 0;

		#100;
	PB = $fopen("PasoBajos.txt");
	PM = $fopen("PasoMedios.txt");
	PA = $fopen("PasoAltos.txt");// abre el fichero en donde se va a guardar los nuevos datos
	$readmemb("Entradas23bits.txt",mem);// carga en mem el los datos del fichero .txt
	for (k=0; k<5000; k=k+1)// ciclo for para recorrer el fichero cargado
	begin
		Reset = 0;
		@(posedge clock_In);
		Data_In = mem[k];
		enable = 1;
		@(negedge clock_In);
		enable = 0;
		$fdisplayb(PB, Data_Out_bajos);
		$fdisplayb(PM, Data_Out_medios);
		$fdisplayb(PA, Data_Out_altos);
	end
	enable = 1;
	$fclose(PB);//cierra el fichero Documento
	$fclose(PM);//cierra el fichero Documento
	$fclose(PA);//cierra el fichero Documento
	
#99999;
$stop;
	end

      
endmodule

