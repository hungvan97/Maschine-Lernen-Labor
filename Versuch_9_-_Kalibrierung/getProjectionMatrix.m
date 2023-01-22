function P = getProjectionMatrix(Xw, Ximg)
% Bestimme Projektionsmatrix aus den Korrespondenzen Xw(i, :) <-> Ximg(i, :)
%
% Eingabe: Xw    - nx3-Array, enthält 3D-Punkte
%          Ximg  - nx2-Array, enthält 2D-Punkte
% Ausgabe: P - Projektionsmatrix, 3x4-Matrix
    
    % TODO
    Ximg_round = round(Ximg);
    n = size(Xw, 1);
    pre_P = [col_bau("bot", 1, Xw(:, 1), n), ...
             col_bau("bot", 1, Xw(:, 2), n), ...
             col_bau("bot", 1, Xw(:, 3), n), ...
             col_bau("bot", 1, ones(n, 1), n), ...
             col_bau("top", -1, Xw(:, 1), n), ...
             col_bau("top", -1, Xw(:, 2), n), ...
             col_bau("top", -1, Xw(:, 3), n), ...
             col_bau("top", -1, ones(n, 1), n), ...
             col_bau("both", col_bau("top", 1, Ximg_round(:, 2), n) + col_bau("bot", -1, Ximg_round(:, 1), n), Xw(:, 1), n), ...
             col_bau("both", col_bau("top", 1, Ximg_round(:, 2), n) + col_bau("bot", -1, Ximg_round(:, 1), n), Xw(:, 2), n), ...
             col_bau("both", col_bau("top", 1, Ximg_round(:, 2), n) + col_bau("bot", -1, Ximg_round(:, 1), n), Xw(:, 3), n), ...
             col_bau("both", col_bau("top", 1, Ximg_round(:, 2), n) + col_bau("bot", -1, Ximg_round(:, 1), n), ones(n, 1), n)];
         
    pre_P_ohne_letzte_Spalte = pre_P(:, 1:end-1);
    pre_P_letzte_Spalte = pre_P(:, end);
      
          
    P_ohne_1 = pre_P_ohne_letzte_Spalte\(pre_P_letzte_Spalte*(-1));
    P = [P_ohne_1; 1];
    P = (reshape(P, [4, 3]))';
end

function col = col_bau(pos, paramet, var, length)
    col = zeros(2*length, 1);
    switch pos
        case "top"
            for i = 0:length-1
                col(2*i+1) = var(i+1);
            end
        case "bot"
            for i = 1:length
                col(i*2) = var(i);
            end
        case "both"
            for i = 1:2*length
                col(i) = var(round(i/2));
            end 
    end
    col = col .* paramet;
end
