function p = TDLS(M, xStart, yStart, w)
% Block Matching (Two Dimensional Logarithmic Search)
%
% Eingabe: M - Video, (m x n x 3 x t)-Array
%          xStart, yStart - Startpunkt
%          w - Fenstergröße
%
% Ausgabe: p - (2 x t)-Array, verfolgter Pfad.
    [m,n,~,t] = size(M);
    p = zeros(t, 2);
    p(1, :) = [xStart, yStart];
    % Step 2
    for i = 2:t
        % Step 3
        I_old = M(:, :, :, i-1);
        I_old = double(I_old);
        % Step 4
        I = M(:, :, :, i);
        I = double(I);
        % I and I_old are uint matrix, cast to double to avoid clipping
        % Step 5
        p_i = p(i-1, :);
        % Step 6
        s = 8;
        x_old = p_i(1);
        y_old = p_i(2);
        % Step 7 - 13 - 2nd stage block choosen
        while s > 1
            
            S = [[0, 0]; [s, 0]; [-s, 0]; [0, s]; [0, -s]];
            SSD = [];
            
            for j = 1:5
                x_new = p_i(1) + S(j, 1);
                y_new = p_i(2) + S(j, 2);
                if x_new-w < 1 || x_new+w > n || y_new-w < 1 || y_new+w > m
                    continue
                end
                SSD = [SSD, sum(sum(sum((I_old(y_old-w:y_old+w, x_old-w:x_old+w, :) - I(y_new-w:y_new+w, x_new-w:x_new+w, :)).^2)))];
            end
            [~, minIdx] = min(SSD);
            if minIdx ~= 1 %% if S ~= [0,0]
                p_i = p_i + S(minIdx, :);
            else
                s = s / 2;
            end
        end
        
        % Step 14 - 3rd stage block choosen
        Slast = [[-1, -1]; [-1, 0]; [-1, 1]; [0, -1]; [0, 0]; [0, 1]; [1, -1]; [1, 0]; [1, 1]];
        SSDlast = [];
        for k = 1:9
            x_new_last = p_i(1) + Slast(k, 1);
            y_new_last = p_i(2) + Slast(k, 2);
            if x_new_last-w < 1 || x_new_last+w > n || y_new_last-w < 1 || y_new_last+w > m
                continue
            end
            SSDlast = [SSDlast, sum(sum(sum((I_old(y_old-w:y_old+w, x_old-w:x_old+w, :) - I(y_new_last-w:y_new_last+w,x_new_last-w:x_new_last+w, :)).^2)))];
        end
        [~, minIdxlast] = min(SSDlast);
        % Step 15
        p(i, :) = p_i + Slast(minIdxlast, :);              
    end
    p = p';
end