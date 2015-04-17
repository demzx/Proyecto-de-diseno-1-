`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:09 04/03/2015
// Design Name:   Prueba_ADC
// Module Name:   E:/lab_de_Digitales/Proyecto_De_diseno_1/simu_ADC.v
// Project Name:  Proyecto_De_diseno_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Prueba_ADC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module simu_ADC;

	// Inputs
	reg Clock_Nexys;
	reg Reset;
	reg reset_Clck;
	reg data_ADC;
	reg start;

	// Outputs
	wire done;
	wire CS;
	wire Clock_Muestreo;
	wire [3:0] data_basura;
	wire [11:0] Dato;

	// Instantiate the Unit Under Test (UUT)
	Prueba_ADC uut (
		.Clock_Nexys(Clock_Nexys), 
		.Reset(Reset), 
		.reset_Clck(reset_Clck), 
		.data_ADC(data_ADC), 
		.start(start), 
		.done(done), 
		.CS(CS),  
		.Clock_Muestreo(Clock_Muestreo), 
		.data_basura(data_basura), 
		.Dato(Dato)
	);

   initial forever 

		#5 Clock_Nexys = ~Clock_Nexys;
		
	initial begin
		// Initialize Inputs
		Clock_Nexys = 0;
		Reset = 1;
		reset_Clck = 1;
		data_ADC = 0;
		start = 0;
      #10;
		Reset = 0;
		reset_Clck = 0;
		
	end 
	 
	 initial begin 
	   #10;
		@(negedge Clock_Muestreo)
		start = 1;
      repeat(4) @(posedge Clock_Muestreo); // espero 4 ciclos de reloj para mandar los datos de 0 del adc 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 1 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 2 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 3 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 4 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 5 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 6 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 7 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 8 del dato
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 9 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 10 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 11 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 12 del dato
		start = 0; 
		#100;
      repeat(5) @(posedge Clock_Muestreo);
		
		// se manda por segunda vez el dato 
		@(negedge Clock_Muestreo)
		start = 1;
      repeat(4) @(posedge Clock_Muestreo); // espero 4 ciclos de reloj para mandar los datos de 0 del adc 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 1 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 2 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 3 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 4 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 5 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 6 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 7 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 8 del dato
		@(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 9 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 10 del dato 
      @(negedge Clock_Muestreo)
		data_ADC = 0; // bit numero 11 del dato 
		@(negedge Clock_Muestreo)
		data_ADC = 1; // bit numero 12 del dato
		start = 0; 
		#100;
      repeat(5) @(posedge Clock_Muestreo);
		$stop; 
      
		
	end
      
endmodule

