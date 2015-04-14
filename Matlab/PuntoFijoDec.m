load DecToPF.txt; %Se carga el archivo donde se encuentran los valores en binario a convertir
PuntoFijoADecimal=fopen('PFToDec.txt', 'w'); %Se abre el archivo en donde se guardaran los valores decimales convertidos



for y = 1:5000 %Ciclo for para recorrer los datos del archivo DecToPF.txt
    LargoParteEntera = 8;
    LargoPresicion = 16;
    uAux = LargoParteEntera+LargoPresicion;
    NumBinAux2 = (1:(LargoParteEntera+LargoPresicion));
    d = LargoParteEntera+LargoPresicion;
    NumBinAux1 = DecToPF(y,:); %A NumBin se le carga la linea de los datos de DecToPF actuales
    
    if (NumBinAux1(1) == 1) %Si elnumero es negaivo se le hace el complemento a 2
        for f = (LargoParteEntera+LargoPresicion+1):-1:2
            if (uAux ~= 2)
                if (NumBinAux1(f) == 0)
                    NumBinAux2(d) = 0;
                    d = d-1;
                else
                    if (f == 2)
                        NumBinAux2(1) = 1;
                        uAux = 2;
                    else
                        NumBinAux2(d) = 1;
                        d = d-1;
                        g = f-1;
                        for uAux = g:-1:2
                            if (NumBinAux1(uAux) == 1)
                                NumBinAux2(d) = 0;
                                d = d-1;
                            else
                                NumBinAux2(d) = 1;
                                d = d-1;
                            end
                        end
                    end
                end
            else
                NumBin = [ 1 NumBinAux2(1,:)];
            end
        end
    else%Si el numero es positivo se toma tal cual
        NumBin = DecToPF(y,:);
    end
    %Tanto LargoParteEntera como LargoPresicion representan el largo de la
    %parte entera como el largo de la parte decimal respectivamenten, esto
    %se hace para parametrizar el largo de la palabra, la cual tiene un
    %ancho de 21 bits (esto es asi porque es la cantidad de bits que hay en
    %cada dato del archivo DecToPF.txt). Ahora bien de esos 21 bits 1 es de
    %signo, los 20 restantes representan tanto la parte entera como
    %decimal, en la parametrizacion (variables LargoParteEntera y
    %LargoPresicion) se puede variar la cantidad de bits que van a
    %representar la parte entera y decimal, haciendo que
    %(LargoPartePresicion = 20 - ParteEntera). Inicialmente la parte entera
    %sera de 4 bits y la parte decimal de 16 bits
    LargoParteEntera = 8;
    LargoPresicion = 16;



    PesoBitMsbParteEntera = LargoParteEntera - 1; %Se calcula el peso del MSB de la parte entera
    ParteEntera = 0; %Se inicializa en 0 la Suma de ParteEntera
    for i = 2:(LargoParteEntera + 1) %Este ciclo recorre el dato desde la posicion 2 hasta la posicion donde termina la parte entera, la cual es el largo de la parte entera + 1, esto es asi porque el espacio 1 del dato es para el bit de signo, es decir la parte del dato que representa la parte entera comienza en la posicion 2, y llega hasta la posicion LargoParteEntera + 1 pues LargoParteEntera solo es el tamaño de la parte entera sin tomar en cuenta el signo
        if (NumBin(i) == 1)%Si el bit en donde esta el ciclo for es un 1 se procede a sumar a ParteEntera 2 elevado al peso de ese bit
            ParteEntera = ParteEntera + (2^(PesoBitMsbParteEntera));
        else
            ParteEntera = ParteEntera + 0;%Si el bit en donde esta el ciclo es un 0 no se realiza ninguna suma
        end
        PesoBitMsbParteEntera = PesoBitMsbParteEntera-1; %Una vez terminado todo el calculo en la posicion del bit actual, se ajusta el peso del bit para el siguiente bit
    end

    ParteDecimal = 0;%Se inicializa la suma de la parte decimal
    PesoBitMsbParteDecimal = -1; %En el caso de los bits que representan la parte decimal de un numero su peso va desde -1 hasta -LargoPresicion que es el numero de bits que representan la parte decimal
    for j = (LargoParteEntera + 2):LargoPresicion%Este ciclo for va a recorrer los bits de presicion, los cuales comienzan un espacio despues de que termina la parte entera, pero ademas se debe tomar en cuenta tambien el espacio del signo, entonces la posicion real en donde comienza la parte decimal es LargoParteEntera + 2 y termina en LargoPresicion que es el numero total de bits que representan la parte decimal
        if (NumBin(j) == 1) %Si el bit en el que se encuentra el ciclo for determina que es un 1 procede a sumar a ParteDecimal 2 elevado al peso de ese bit
            ParteDecimal = ParteDecimal + (2^PesoBitMsbParteDecimal);
        else
            ParteDecimal = ParteDecimal + 0;%Si el bit en el que se ecuentra el ciclo for determina que es un 0 no se realiza suma a ParteDecimal
        end
        PesoBitMsbParteDecimal = PesoBitMsbParteDecimal - 1;%Una vez terminadas las instrucciones para ese bit se ajusta el peso para el siguiente bit
    end

    signo = 0;%Si el bit de signo es un 0 signo toma el valor de 1
    if (NumBin(1) == 0)
        signo = 1;
    else
        signo = -1;%Si el bit de signo es un 1 signo toma el valor de -1
    end

    NumeroEnDecimal = signo*(ParteEntera + ParteDecimal);%Una vez obtenido el signo, la parte entera y la parte decimal, se procede a sumar la parte entera con la decimal y a multiplicar el signo a esta suma, el resultado sera el dato en decimal
    fprintf(PuntoFijoADecimal, '%f \n', NumeroEnDecimal);%Se escribe el dato en un archivo .txt
end
fclose(PuntoFijoADecimal);%Se cierra el archivo .txt