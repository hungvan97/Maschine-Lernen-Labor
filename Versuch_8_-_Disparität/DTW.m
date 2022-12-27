function [p1, p2, C, D] = DTW(v1, v2, weight, maxDisp)
% Dynamic Time Warping
%
% Eingabe: v1, v2  - Zeilenvektoren, enthält Merkmale
%          weight  - Strafterm für "Verdeckung"
%          maxDisp - maximal zu untersuchende Disparität
% Ausgabe: p1, p2  - Zeilenvektoren, gibt (optimale) Pfade durch die
%                    Vektoren an
%          C - Kostenmatrix
%          D - Distanzmatrix
    
    n1 = size(v1, 2);
    n2 = size(v2, 2);
    
    % Bestimmung Kostenmatrix C
    % -> C(i, j) gibt Unterschied (z.B. SSD) zwischen v1(i) und v2(j) an

        % TODO
    
    % Bestimmung Distanzmatrix D und "Pfadmatrix" M:
    % - D enthält die minimale Kosten bis zu jedem Punkt D(i, j)
    % - M kodiert die Richtung, in der das vorherige Minimum liegt
    %   z.B.: M(i,j) = 1 -> Minimum links oben:        C(i,j) + D(i-1,j-1) ist minimal
    %         M(i,j) = 2 -> Minimum oben:       weight*C(i,j) + D(i-1,j)   ist minimal
    %         M(i,j) = 3 -> Minimum links:      weight*C(i,j) + D(i,  j-1) ist minimal
    C = zeros(n1, n2);
    D = inf * ones(n1, n2) * (-1);
    M = zeros(n1, n2);
    for i = 1:n1
        for j = 1:n2
            % SAD
            C(i, j) = abs(v1(i) - v2(j));
%             % SSD
%             C(i, j) = (v1(i) - v2(j))^2;
            D(i, j) = C(i, j) + min(addNeighbor(D, i, j));
            M(i, j) = minPos(weight, C(i,j), D, i, j);
        end
    end
    
    
    % Backtracking mit Hilfe von M
    % -> Finden des optimalen Pfades von C(1, 1) nach C(n1, n2) über M
    %
    % - Start bei i = n1 und j = n2
    % - Ende bei i = 1 und j = 1
    % - p1 enthält die Werte von i (gewarpte Indizes aus v1)
    % - p2 enthält die Werte von j (gewarpte Indizes aus v2)
    
    
        % TODO
    i = n1; j = n2;
    p1 = [i]; p2 = [j];
    while(i ~=1 && j ~= 1)
        switch M(i, j)
            case 1
                i = i-1;
                j = j-1;
                p1 = [p1, i]; p2 = [p2, j];
            case 2
                i = i-1;
                p1 = [p1, i]; p2 = [p2, j];
            case 3
                j = j-1;
                p1 = [p1, i]; p2 = [p2, j];
        end
    end
    
    % gegebenenfalls die Pfade umdrehen, damit Start bei 1
    
    
        % TODO
    p1 = flip(p1, 2);
    p2 = flip(p2, 2);
end

