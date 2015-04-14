%  NumDec = -10.86879; %Variable de entrada
 function [ Conversion ] = ConversionDecimalPuntoFijo( NumDec )

ParteEntera = 8;
ParteDecimal = 16;


BinarioParteDecimal = (1:ParteDecimal); %Arreglo donde se guardara la conversion de decimal(parte fraccional) a punto fijo
BinParteEnteraYDecimal = (1:(ParteEntera + ParteDecimal)); %Un arreglo donde se juntan la conversion a binario de la parte entera y la parte decimal
Conversion = (1:(1 + ParteEntera + ParteDecimal)); %Dato final convertido a binario incluyendo signo

if (NumDec >= 0)
    NumParteEntera = floor(NumDec); %Se separa la parte entera de la parte decimal
    NumParteDecimal = NumDec - NumParteEntera; %Al numero original se le resta la parte entera y queda la parte decimal
else
    NumParteEntera = abs(floor(NumDec))-1;
    NumParteDecimal = abs(NumDec) - NumParteEntera; %Al numero original se le resta la parte entera y queda la parte decimal
end
BinarioParteEntera =  decimalToBinaryVector(NumParteEntera, ParteEntera); %Se convierte a binario la parte entera
%Se procede a crear el algoritmo para convertir la parte decimal (despues de la coma) del numero
%A binario


NumParteDecimalAux = NumParteDecimal; %Variable de la parte decimal de la entrada es asignada a una variable auxiliar
for i = 1:ParteDecimal%Este ciclo realiza la conversion de la parte decimal a punto fijo
    DivisionParteDecimal = NumParteDecimalAux/(2^(-i));
    if (DivisionParteDecimal >=1)
        NumParteDecimalAux = NumParteDecimalAux - (2^(-i));
        BinarioParteDecimal(i) = 1;
    else
        BinarioParteDecimal(i) = 0;
    end
end

BinParteEnteraYDecimal = [BinarioParteEntera BinarioParteDecimal];%Se concatena la parte entera convertida a binario con la parte decimal convertida a binario
y = (ParteEntera + ParteDecimal);
if (NumDec >= 0)%Si la cantidad original es positiva se le concatena el bit de signo en este caso un 0
    Conversion = [0 BinParteEnteraYDecimal];
else%Si el valor original es negativo se procede a hacer el complemento a dos de BinParteEnteraYDecimal y posteriormente concatenarle el bit de signo que es 1
    for j = (ParteEntera + ParteDecimal):-1:1 %Se comienza a recorrer BinParteEnteraYDecimal del LSB al MSB hasta encontrar un 1, todo lo que sea 0 antes de este 1, se deja como cero, cuando se encuentra este 1 se deja igual (como un 1) y despues de este 1 se invierten los bits que quedan, sacando una bandera de la posicion en donde esta ese 1 (x) y los bits que queda son los que estan desde x-1 hasta el MSB, estos son los que se invierten, para recorrer estos ultimos bits se usa la variable y 
        if (y ~= 1)%Esta variable esta definida inicialmente como (ParteEntera + ParteDecimal), por tanto entra a los if, una vez que se encuentra la posicion del primer 1, los bis que quedan despues de esa posicion hasta el MSB se van a invertir usando a y como contador para recorrerlos, una vez que termina de recorrerlos y toma el valor de 1, esto se hace porque el ciclo for con la variable j no ha terminado de contar pero el proceso de conversion ya termino entonces para evitar errores y que el ciclo for se meta de nuevo en las instruscciones de conversion se le dice que si y es igual a 1 no entre en esas instrucciones
            if (BinParteEnteraYDecimal(j) == 0)%Los ceros antes del primero 1 no se invierten
                BinParteEnteraYDecimal(j) = 0;
            else
                x = j; %A la variable x se le asigna el valor de j 
                if (j == 1) %este paso se hace tomando en cuenta que los valores que estan despues de la posicion j donde se encontro el primer 1 se deben invertir, esa posicion es j-1, o bien si x = j  es x-1, Pero que pasa si la posicion j donde se encontro el primer 1 es 1? entonces x-1 va a ser 0 y el ciclo for y = 0:-1:1 no se puede hacer, e induce a error, poniendo este paso se evita esto
                    BinParteEnteraYDecimal(j) = 1;%La posicion donde se encontro el primer 1 no se invierte se deja igual, tal y como ocurre en el complemento a 2
                else
                    BinParteEnteraYDecimal(j) = 1;%La posicion donde se encontro el primer 1 no se invierte se deja igual, tal y como ocurre en el complemento a 2
                    for y = x-1:-1:1%Tal y como se explico los valores a invertir estan despues de la posicion del primer 1, si x = j, entonces la posicion donde estan los valores a invertir es x-1
                        if (BinParteEnteraYDecimal(y) == 0) %Lo que es 0 ahora se invierte a 1
                            BinParteEnteraYDecimal(y) = 1;
                        else                                %Lo que es 1 ahora se invierte a 0
                            BinParteEnteraYDecimal(y) = 0;
                        end
                    end
                end
            end
        else
            Conversion = [1 BinParteEnteraYDecimal]; %Se concatena un 1 de signo negativo con el resto del valor hecho en complemento a 2
        end
    end
end

        
        

    
