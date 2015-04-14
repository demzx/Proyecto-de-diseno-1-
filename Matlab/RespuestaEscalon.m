T=(0:50.0000:50000);
Entra_da = ones(1,10001);

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

%Se realiza la sumatoria de todas las señales que da por resultado la
%entrada senoidal original
Salida = salBajos + salMedios + salAltos;


%Se genera un grafico con iteraciones de 1 a 200 del tiempo T contra la
%salida deseada en este caso salBajos
%for r = 1:1:200
subplot(5,1,1), plot(T(1:400),salBajos(1:400));
subplot(5,1,2), plot(T(1:400),salMedios(1:400));
subplot(5,1,3), plot(T(1:400),salAltos(1:400));
subplot(5,1,4), plot(T(1:400),Salida(1:400));
subplot(5,1,5), plot(T(1:400),Entra_da(1:400));
%    hold on;
%end

%Continuando con lo referente a la simlacion de ModelSim, se genera un
%archivo .txt con todos los valores generados en signal
EscalonUnitario=fopen('Escalon.txt', 'w');
fprintf(EscalonUnitario, '%f \n', Entra_da);
fclose(EscalonUnitario);