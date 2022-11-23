function I_gauss = gaussFilter(I, sigma, choose)
% Filtert das Bild I mit einem (zweidimensionalen) Gauss-Filter mit
% Standardabweichung sigma.

    % Konvertierung des Bildes
    I = double(I);

    % Bestimme Impulsantwort des zweidimensionalen Gauss-Filters
    % (siehe z.B. Normalverteilung Einführung).

 
    % TODO
    % 1. Filter h(x,y) erstellen
    % Konstant parameter
    std_abweichung = sigma;
    % Eingangsvariable anpassen
    abs_wert_bereich = ceil(3*std_abweichung); %% Wertebereich fur Impulsantwort nach 3*sigma einstellen
    x = -abs_wert_bereich:abs_wert_bereich;
    y = -abs_wert_bereich:abs_wert_bereich;
    [X,Y] = meshgrid(x,y);
    % Formular erstellen
    h = 1/(2*pi*std_abweichung^2)*exp(-(X.^2+Y.^2)/(2*sigma^2));
    % Uberprufen, ob alle Element des Filter sich zu 1 addieren
    flag=sum(h);
    if flag == 1
        disp(" geeignete Filter ")
    else
        disp(" ungeignete Filter, nochmal einstellen ") %% somehow filter can be processed without the needed of sum = 1 ??
    end
        
    % Faltung des Bildes mit dem Filter
    % Befehl: conv2, imfilter
    % TODO 
    I_gauss = imfilter(I,h,'symmetric','same');
    if exist('choose', 'var') 
        ausgewahlter_func = input (" Mit 2d Filter, wähl aus: conv2 oder imfilter? ", 's');
        switch ausgewahlter_func
            case ausgewahlter_func == "conv2"
                I_gauss = conv2(I,h,'same');
            case ausgewahlter_func == "imfilter"
                I_gauss = imfilter(I,h,'symmetric','same');
            otherwise
                disp(" noch mal eingen bitte! ")
        end
    else 
         I_gauss = imfilter(I,h,'symmetric','same');
    end
end

 %=============== Antworten von der Fragen ===============%
  %{
       Aufgabe2.a
       Welche Unterschiede bestehen zwischen den Funktionen (conv2 oder imfilter)?
       Antwort: 
       Durch conv2 wird der Filterkern um 180 Grad umgekehrt. (Korrelation anwenden)
       Durch imfilter wird der Filterkern nicht um 180 Grad umgekehrt.
  %}
   %================ Antworten von der Frage ===============%
