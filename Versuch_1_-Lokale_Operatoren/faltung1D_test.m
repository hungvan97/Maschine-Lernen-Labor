% Script zur Einführung in die eindimensionale Faltung

%% Testfunktion

% generiere Stützstellen, an denen die Funktion ausgewertet werden soll
dx = 0.5;
xs = -5:dx:5;

x = 1/4 * sqrt(abs(xs));

%% Faltung

% Filterkern f
f = 1/dx * [1/2, 0, -1/2];
%f = 1/dx * [1, -1, 0];
%f = 1/dx * [0, 1, -1];
% TODO b)

y = conv(x, f, 'same');

%% Darstellung

figure(1);

subplot(1, 2, 1);
plot(xs, x, '-b.');
title('Funktion');
subplot(1, 2, 2);
plot(xs, y, '-b.');
title(['Ergebnis mit Filter ', mat2str(f)]);

%% Randbehandlung
% TODO c)


  % Achtung: Filtermask will have odd number of element, so anchor/center point of the kernel 
  % will be calculated based on its neighbor to extract feature, or else we have
  % to account for distortion across the layers, which happens using an even sized kernel
  n1 = size(f,2);                                       % Anzahl der Element von Filter bekommen (dim = 2, number of col)
  n2 = size(x,2);                                           % Anzahl der Element von Input_x bekommen
  n3 = (n1-1)/2;                                                  % Anzahl der added 0 Element 
  
% Randbehandlung: Zero padding
  z1 = zeros(1,n3);                                                
  input_x1 = [z1 x z1];   
  output_x1 = conv(input_x1,f,'valid');
  
 % Randbehandlung: Spiegelung
  z2 = fliplr(x(:,1:n3));                                   % Vor der Element von Input_x bekommen                                    
  z3 = fliplr(x(:,n2-n3+1:n2));                             % Nach der Element von Input_x bekommen
  input_x2 = [z2 x z3];                                     % Eingabe mit hinzugefügte Zeros
  output_x2 = conv(input_x2,f,'valid');
  
 % Darstellung 
  figure;
  subplot(2,2,1);
  plot( x, '-b.');title("Darstellung von Input_x");
  subplot(2,2,3);
  plot( output_x1, '-b.');title("Zero padding");
  subplot(2,2,4);
  plot( output_x2, '-b.');title("Spiegelung");

  %=============== Frage antworten ===============%
  %{
       Aufgabe1.a
       Welche Auswirkung hat der Parameter "same"? 
       ==> Parameter "same" gibt nur die zentral Teil von der Faltung zurück. 
       Die Länge des Ausgangsignals (zentral Teil von der Faltung) ist gleich die Länge des Eingangsignals.
       Welche Varianten sind ebenfalls implementiert?
       ==> full(default), valid und same.
        
       Aufgabe1.b   
       Welche Unterschiede bestehen zwischen den Filtern?
       Wofür könnten die verschiedenen Filter genutzt werden?
       Antwort: 
       - Die Gewichte der Elemente von Filterkerne sind unterschiedlich.
       - Die Koeffizienten von zweite 1.Abteilung verschieben sich nach recht im Vergleich zu der Koeffizienten erste 1.Abteilung bei 1 Element. 
         Das führt dazu, das jeweilige Ergebnis sich gegenüber auch genau bei 1 Element verschieben in gleichen Reihenfolge.
       - Da meist jeder Element von 3 Filter liegt nur in den Wert-Bereich [-0,4 0,4], dient diese Filter dazu, um die Ausgangpunkt zu reduzieren und weiter spater aufzuarbeiten.
       - Verschiedene Bilder brauchen verschiedene Kantenfilter, um bestimmt benoetigte Ausgangsbilder zu bekommen.
         Das heisst, die Effekte der Ausgangsbilder sind abhaengig von Filterkernen.            
                    
  
       Aufgabe1.c
       Welche Randbehandlung verwendet die Funktion conv?
       Antwort: Zero padding, mit 0 hinzufuegen
  
       Was sind Vor- und Nachteile der verschiedenen Varianten?
       Antwort: 
       - Im Bezug auf Zero-padding
         Vorteile: einfach zu berechnen
         Nachteil: Im Rand gibt es "black frame".
       - Im bezug auf Spiegelung
         Vorteile: Im Rand gibt es keine dunkele Linie.
         Nachteile: Höherer Rechenaufwand, wenn die Anzahl der Element von Filter sehr gross ist.
  %}
  %==============================================%