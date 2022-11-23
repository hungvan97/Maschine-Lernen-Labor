function ecken = harrisCorner(I, sigma_I, sigma_M, schwellwert) 
% Implementiert einen Harris-Corner-Detektor.

    % 1. Konvertierung des Eingangsbildes in double.
      I = double(I);

    % 2. Glaettung des Bildes mit Gauss-Filter (sigma_I).
      
      % TODO
      I = gaussFilter(I,sigma_I);  
    % 3. Strukturtensor M = [Iu^2, Iu*Iv; Iu*Iv, Iv^2] bilden.
    % a) Ableitung in x-Richtung (Sobel, ...)

    
      % TODO
      kernel_sobelx = [-1 -2 -1; 0 0 0;1 2 1];           %% kernel für Sobel in x-Richtung(VL s14)
      Iu = conv2(I,kernel_sobelx,'same');
   
    % b) Ableitung in y-Richtung (Sobel, ...)

    
      % TODO
      kernel_sobely = [-1 0 1;-2 0 2;-1 0 1];            %% kernel für Sobel in y-Richtung(VL s14)
      Iv = conv2(I,kernel_sobely,'same');
    
    % c) Elemente des Strukturtensors bestimmen. Diese sollten in 
    %    einzelnen Matrizen gespeichert werden.

    
      % TODO
      A = Iu.^2;
      B = Iv.^2;
      C = Iu.*Iv;
            
    % 4. Aufsummierung des Strukturtensors M mit Gaussfilter (sigma_M), d.h.
    %    Glaettung der einzelnen Bestandteile.
    %    Matrix M = ((A, C), (C, B)) ==> det(M) = A.*B. - C.^2
    
      % TODO
    
      A = gaussFilter(A,sigma_M);
      B = gaussFilter(B,sigma_M);
      C = gaussFilter(C,sigma_M);
    
    % 5. Auswertung des Strukturtensors. 
    % a) Bestimmung der Detektorantwort R, um die explizite Berechnung der
    %    Eigenwerte zu vermeiden.
    %
    %    R = det(M) - kappa*trace(M)^2
    %
    %    Hinweis:
    %    det(M) = Iu^2*Iv^2-(Iu*Iv)^2
    %    trace(M) = Iu^2+Iv^2    
    kappa = 0.04;   % Standardwert

    
      % TODO
      R = A.*B-C.^2 - kappa*((A+B).^2);                %% Formular in VL s27
    
    % b) Werte unterhalb des Schwellwertes auf 0 setzen.
    %    Befehl: find, alternativ "logical indexing"

    
      % TODO
      R(R<schwellwert) = 0;
    
    % c) Bestimmung der lokalen Maxima in einer 8er-Nachbarschaft.
    %    Befehl: imregionalmax, 
    %    alternativ elementweise Bestimmung (Nichtmaxima auf 0 setzen)

    
      % TODO
      R = imregionalmax(R); 
    
    % 6. Ecken bestimmen
    %    Befehl: find
    
    
      % TODO
      [row,col] = find(R == 1);
      ecken = [row,col];
end

