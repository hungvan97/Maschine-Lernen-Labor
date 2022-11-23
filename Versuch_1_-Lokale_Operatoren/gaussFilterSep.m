function I_gauss = gaussFilterSep(I, sigma)
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
    % Formular erstellen
    h = 1/(sqrt(2*pi*sigma^2))*exp(-(x.^2)/(2*sigma^2));
    % Überprufen, ob alle Element des Filter sich zu 1 addieren
    flag = sum(h);
    if flag == 1
        disp(" geeignete Filter ")
    else
        disp(" ungeignete Filter, nochmal einstellen ") %% somehow filter can be processed without the needed of sum = 1 ??
    end
        
    % Faltung des Bildes mit dem Filter
    % Befehl: conv2, imfilter
    % TODO 
    I_gauss = imfilter(I,h,'symmetric','same');
    ausgewahlter_func = input (" Mit 1d Filter, wähl aus: conv2 oder imfilter? ", 's');
    switch ausgewahlter_func
        case ausgewahlter_func == "conv2"
            I_gauss = conv2(h,h.',I,'same');            %% first convolves along x-axis(column) with vector h, then along y-axis(row) with vector h.'
        case ausgewahlter_func == "imfilter"
            I_gauss = imfilter(h,h.',I,'symmetric','same');
        otherwise
            disp(" noch mal eingen bitte! ")
    end     
end