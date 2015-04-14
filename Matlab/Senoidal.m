Tiempo = 0:1:5000;%Se crea una matriz desde 0 hasta 5000, que representan el tiempo en microsegundos

%Se pretende crear una suma de se�ales senoidales las cuales al tener diferente frecuencia se suman entre si
%es decir se superponen, la frecuencia angular de cada una se define a
%continuacion

%La frecuencia angular esta en radianes por segundo, en este caso como se
%va a hacer la operacion (FrecuenciaAngular*Tiempo en microsegundos) se
%debe poner la frecuencia angular en Radianes por microsegundos para que
%las unidades de microsegundos se cancelen

frecuencia1=2*pi*(50/100000);%50 radianes por microsegundos (bajos)
frecuencia2=2*pi*(1000/100000);%1000 radianes por microsegundo (medios)
frecuencia3=2*pi*(10000/100000);%10000 radianes por microsegundos (altos)

%signal es la suma de las tres se�ales senoidales sin embargo estas van de
%1 a -1 y al ser una suma de tres se�ales signal es de 3 a -3 entonces para
%poder tener valores positivos se hace un offset de 3, y la se�al termina
%siendo de 0 a 6 pero se quiere que la magnitud sea de 0 a 0.9999 entonces se divide
%entre 6...Posteriormente esta salida sera guardada en un archivo .txt para
%ser usado como entradas de la simulacion ModelSim por ahora se continuara
%con la parte de MatLab
signal=((sin(frecuencia1*Tiempo) + sin(frecuencia2*Tiempo) + sin(frecuencia3*Tiempo))+3)/6;

%Como se dijo se quita el offset pues este solo sirve para poder meter la
%se�al en el ADC pero para poder utilizar los filtros se debe quitar ese
%offset esto es lo que se hace a continuacion. Se debe tener en cuenta que
%la se�al al ser divida entre 6 queda de -1 a 1 y por ello el offset es la
%mitad osea 0.5
Entra_da = signal-.5;

%Se invoca la funcion PasoAlto20Hz y su salida se coloca en la entrada de
%PasoBajo200Hz dando asi por resultado el paso banda de frecuencias bajas
y1 = PasoAlto20Hz( Entra_da );
salBajos = PasoBajo200Hz( y1 );

%Se invoca la funcion PasoAlto200Hz y su salida se coloca en la entrada de
%PasoBajo5KHz dando asi por resultado el paso banda de frecuencias medias
y2 = PasoAlto200Hz( Entra_da );
salMedios = PasoBajo5KHz( y2 );

%Se invoca la funcion PasoAlto5KHz y su salida se coloca en la entrada de
%PasoBajo20KHz dando asi por resultado el paso banda de frecuencias altos
y3 = PasoAlto5KHz( Entra_da );
salAltos = PasoBajo20KHz( y3 );

%Se realiza la sumatoria de todas las se�ales que da por resultado la
%entrada senoidal original
Salida = salBajos + salMedios + salAltos;


%Se genera un grafico de las 4 formas de ondas
subplot(5,1,1), plot(Tiempo, salBajos);
subplot(5,1,2), plot(Tiempo, salMedios);
subplot(5,1,3), plot(Tiempo, salAltos);
subplot(5,1,4), plot(Tiempo, Salida);
subplot(5,1,5), plot(Tiempo, Entra_da);


%Continuando con lo referente a la simlacion de ModelSim, se genera un
%archivo .txt con todos los valores generados en signal de la linea 23
senoidal=fopen('VectorEntrada.txt', 'w');
fprintf(senoidal, '%f \n', signal);
fclose(senoidal);