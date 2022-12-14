function SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax)
    
%     n = 1;      % Anzahl Punkte in P (Aufgabe 1: n = 1)
    n = size(P, 1);      % Anzahl Punkte in P (Aufgabe 2: n > 1)
    m = size(X, 1);      % Anzahl Punkte in X
    
    % Bestimme Abstände der Punkte X zu den Punkten P.
    
    
        % TODO
    rX_P = zeros(m, n);
    for j = 1:n
        for i = 1:m
            rX_P(i,j)= norm(X(i, :) - P(j, :));
        end
    end
    
    % Ordne die Punkte in X den verschiedenen Bins zu, d.h. abhängig von
    % dem Abstand zu den Punkten in P werden die Punkte zusammengefasst
    % und in die Bins 1 bis nBinsR eingeteilt.
    
    % a) Bestimme die Grenzen zwischen den Bins.
    %    in Matlab: logspace
    
    
        % TODO
    r_group = logspace(log10(rMin), log10(rMax), nBinsR);
    
    % b) Weise Punkte in X den entsprechenden Bins zu, d.h. rLabel(i, j)
    %    gibt an, in welchem Bin der Punkt X(i, :) in Bezug auf P(j, :)
    %    liegt.
    rLabel = zeros(m, n);
    
        % TODO
    for j = 1:n
        for i = 1:m
            for k = 1:nBinsR
                if k < nBinsR
                    if rX_P(i, j) >= r_group(k) && rX_P(i, j) < r_group(k+1)
                        rLabel(i, j) = k;
                    end
                else
                    if rX_P(i, j) >= r_group(k)
                        rLabel(i, j) = k;
                    end
                end
            end
        end
    end
    
    
    % Bestimme Richtung der Punkte in X relativ zu den Punkten P, d.h. den 
    % Winkel zwischen X(i, :) - P(j, :) und der x-Achse.
    % in Matlab: atan2 (value measured in rad; if tan^-1 yield minus, atan2 = pi + minus_value)
    
    
        % TODO
    thetaX_P = zeros(m, n);
    for j = 1:n
        for i = 1:m
            xX_P = X(i, 1) - P(j, 1);
            yX_P = X(i, 2) - P(j, 2);
            thetaX_P(i, j) = atan2(xX_P, yX_P); % use repmat
        end
    end
    
    % Ordne die Punkte in X den Bins zu
    % a) Bestimme Grenzen zwischen den Bins
    %    in Matlab: linspace
    
    
        % TODO
    theta_group = linspace(-pi, pi, nBinsTheta+1);
    
    % b) Weise Punkte in X den entsprechenden Bins zu
    thetaLabel = zeros(m, n);
    
    
        % TODO
    for j = 1:n
        for i = 1:m
            for k = 1:nBinsTheta
                if k < nBinsTheta
                    if thetaX_P(i, j) >= theta_group(k) && thetaX_P(i, j) < theta_group(k+1)
                        thetaLabel(i, j) = k;
                    end
                else
                    if thetaX_P(i) >= theta_group(k)
                        thetaLabel(i, j) = k;
                    end
                end
            end
        end
    end
    
    % Histogramm bestimmen, Bins auszählen
    SC = zeros(nBinsR, nBinsTheta, n);
    for it_r = 1:nBinsR
        for it_theta = 1:nBinsTheta
            SC(it_r, it_theta, :) = reshape(sum((thetaLabel == it_theta).*(rLabel == it_r), 1), 1, 1, n);
        end
    end
    % Histogramm normalisieren -> Wahrscheinlichkeiten
    SC = SC ./ (repmat(sum(sum(SC, 1), 2), [size(SC, 1), size(SC, 2), 1]) + eps);
end