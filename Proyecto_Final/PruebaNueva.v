`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:10:38 05/03/2015
// Design Name:   Proyecto_1
// Module Name:   C:/Users/ohskr_000/Documents/Universidad/Lab de Digitales/Tercer Proyecto/PROYECTOFINAL/ProyectoFinal/Proyecto_1_Chacon/PruebaNueva.v
// Project Name:  Proyecto_1_Chacon
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Proyecto_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaNueva;

	// Inputs
	reg Reset;
	reg clock_In;
	reg reset_Clock;
	reg data_ADC;
	reg start;
	reg [1:0] Filtro;
	// Outputs
	wire done;
	wire CS;
	wire Clock_Muestreo1;
	wire Sync;
	wire Data_DAC;
	wire [3:0] data_basura;
	//Para Revision
	wire [11:0]Dac;

	// Instantiate the Unit Under Test (UUT)
	Proyecto_1 uut (
		.Reset(Reset), 
		.clock_In(clock_In), 
		.reset_Clock(reset_Clock), 
		.data_ADC(data_ADC), 
		.start(start),
		.Filtro(Filtro), 
		.done(done), 
		.CS(CS), 
		.Clock_Muestreo1(Clock_Muestreo1), 
		.Sync(Sync), 
		.Data_DAC(Data_DAC), 
		.data_basura(data_basura), 
		.Dac(Dac)
	);

integer SalidaTruncadoDAC, k;
reg [11:0]VariableAux;
reg [13:0]mem[5000:0];//Se genera una memoria para abir el fichero .txt, donde la primera prametrzacion(los primeros parentesis cuadrados leyendo de izquierda a derecha) son para determinar el tama�o de los bits en el arreglo, mientras que los segundos es para decirmel cuantos datos ahi en el fichero .txt 


   initial forever 

		#5 clock_In = ~clock_In;
		
	initial begin
		// Initialize Inputs
		clock_In = 0;
		Reset = 0;
		reset_Clock = 0;
		data_ADC = 0;
		start = 0;
		Filtro = 0;
      #10;
		Reset = 0;
		reset_Clock = 0;
		#100;
		
		clock_In = 0;
		Reset = 1;
		reset_Clock = 1;
		data_ADC = 0;
		start = 0;
      #10;
		Reset = 0;
		reset_Clock = 0;
		#100;
		
		clock_In = 0;
		Reset = 0;
		reset_Clock = 0;
		data_ADC = 0;
		start = 0;
      #10;
		Reset = 0;
		reset_Clock = 0;
		#100;
	end 
	 initial begin 
		Filtro = 2'b10;
		SalidaTruncadoDAC = $fopen("SalidaTruncadoParaDAC.txt");
		$readmemb("Entradas.txt",mem);// carga en mem el los datos del fichero .txt
		for (k=0; k<4999; k=k+1)// ciclo for para recorrer el fichero cargado
		begin
			VariableAux = mem[k];
			@(negedge Clock_Muestreo1)
			start = 1;
			repeat(4) @(posedge Clock_Muestreo1); // espero 4 ciclos de reloj para mandar los datos de 0 del adc 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[11]; // bit numero 1 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[10]; // bit numero 2 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[9]; // bit numero 3 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[8]; // bit numero 4 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[7]; // bit numero 5 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[6]; // bit numero 6 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[5]; // bit numero 7 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[4]; // bit numero 8 del dato
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[3]; // bit numero 9 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[2]; // bit numero 10 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[1]; // bit numero 11 del dato 
			@(negedge Clock_Muestreo1)
			data_ADC = VariableAux[0]; // bit numero 12 del dato
			start = 0; 
			#100;
			repeat(5) @(posedge Clock_Muestreo1);
			$fdisplayb(SalidaTruncadoDAC, Dac);
			
         //@(posedge Clock_Muestreo1);
		end
		$fclose(SalidaTruncadoDAC);
		$stop; 
 
	end

      
endmodule




