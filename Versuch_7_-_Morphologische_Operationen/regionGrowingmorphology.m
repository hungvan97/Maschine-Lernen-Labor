% 2b
function mask = regionGrowingMorphology(I, xStart, yStart, threshold)
    mask = false(size(I)); 
    mask(yStart, xStart) = true;
    I = im2double(I);
    while 1
        % 2. epsilon: Mittelwerte in der segmentierten Region M
        mittleWert = mean(I(mask == 1));
        % 3. bestimmen der neue Nachbarn N(M)
        maskN = imdilate(mask, ones(3, 3)) - mask;
        % 4. Aufnahme der ähnlichen Nachbarn in die segmentierte Region
        temp_1 = abs(I - mittleWert) < threshold;
            % intersection with N(M)
        temp_2 = ((maskN + temp_1) == 2);   
            % union with mask M
        mask_neu = ((mask + temp_2) ~= 0);
        if mask_neu == mask
            break;
        else
            mask = mask_neu;
        end
    end
end
