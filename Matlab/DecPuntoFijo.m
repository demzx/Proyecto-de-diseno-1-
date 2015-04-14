load VectorEntrada.txt;

DecimalAPuntoFijo=fopen('DecToPF.txt', 'w');
i = 1;
for i = 1:5000
    Binario =  ConversionDecimalPuntoFijo(VectorEntrada(i));
    DatosBin = num2str(Binario);
    fprintf(DecimalAPuntoFijo, '%s \n', DatosBin)
end

fclose(DecimalAPuntoFijo);