function S = regionGrowing(I, xStart, yStart, threshold)
% Eingabe: I              - Bild
%          xStart, yStart - Saatpunkt
%          threshold      - Schwellwert für die Ähnlichkeit in der Region
%
% Einfacher Steppenbrand-Algorithmus.

    % TODO
    I_gray = im2gray(I);
    
    % 1. initialise segmentierung S
    S = zeros(size(I_gray));
    % 2. initialise verfuegbarer Punkte
    apList = [yStart xStart; yStart-1 xStart; yStart+1 xStart; yStart xStart-1; yStart xStart+1];
    % 3. initialise Mittlewert der segmentierten Region
    regionMean = I_gray(yStart, xStart);
    S(yStart, xStart) = 1;
    
    % while-loop
    while ~isempty(apList) 
        min_diff = threshold;
        min_inx = 0;
        nbList = [];
        
        % 5. find the neighbor which has the minimum different with
        % observed Pixel
        
%         for i = 1:length(apList(:, 1))
%             diff = abs(I_gray(apList(i, 1), apList(i, 2)) - regionMean);
%             if diff < min_diff
%                 min_diff = diff;
%                 min_inx = i;          
%             end  
%         end 
%         min() stattdessen anwenden
        
        % 6-7-8. in case we don't find any more neighbor Pixel
        if min_inx == 0
            break
        end
        
        % 10. Fugt this minimum threshold pixel zu der segmentierten Region
        % + update observerd point
        S(apList(min_inx, 1), apList(min_inx, 2)) = 1;
        akt_inx = apList(min_inx, :);                   %akt_inx: pixel, that are being observed
        
        % 9. get rid of only the minimum threshold pixel aus der verfuegbar List
        apList(min_inx, :) = [];
        
        % 11. bestimmen neue! Nachbarn von p: nbList, by moving apList by -1
        % and 1 und both direction
        x = akt_inx(2);
        y = akt_inx(1);
        
        for i = -1:1
            if S(y+i, x)==0 && abs(I(y+i, x)-regionMean)<=threshold
                nbList(end+1, :) = [y+i x]; 
            end 
        end
        for i = -1:1
            if S(y, x+i)==0 && abs(I(y, x+i)-regionMean)<=threshold
                nbList(end+1, :) = [y x+i]; 
            end 
        end
        
        % 6-7-8. in case we don't find any more neighbor Pixel
        if isempty(nbList)==1
            break
        end
        
        
        % 12. union 2 matrix apList, nbList
        apList = union(apList, nbList, 'row');
        
        % 13. check randbedingung + update the Mittlewert of "regionMean"
        sum = 0;
        for i = 1:length(apList(:, 1))
            if apList(i, 1) <= 1 || apList(i, 1) >= length(S(:, 1)) || apList(i, 2) <= 1 || apList(i, 2) >= length(S(1, :))
                apList(i, :) = [0 0];
            else
                sum = sum + I_gray(apList(i, 1), apList(i, 2));
            end
        end
        apList = apList(any(apList, 2), :);
        regionMean = sum / length(apList);
    end
end
