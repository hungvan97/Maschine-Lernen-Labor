% 2b
I = imbinarize(imread("./bilder/coins.png"));
threshold = 6;
imshow(I);
[x, y] = ginput(1);
xStart = round(x); yStart = round(y);
mask = regionGrowingMorphology(I, xStart, yStart, threshold);
region = I .* mask;
imshow(region);
contour(region, 'r');


function mask = regionGrowingMorphology(I, xStart, yStart, threshold)
    mask = false(size(I)); 
    mask(yStart, xStart) = true;
    while 1
        % 2. epsilon: Mittelwerte in der segmentierten Region M
        epsilon = mean(I(mask == 1));
        % 3. bestimmen der neue Nachbarn N(M)
        maskN = imdilate(mask, ones(3, 3)) - mask;
        % 4. Aufnahme der ähnlichen Nachbarn in die segmentierte Region
        temp = (abs(I - epsilon) < threshold);
        % intersection with N(M)
        temp_2 = maskN - temp == 0;
        % union with mask M
        mask_neu = mask + temp_2 ~= 0;
        if mask_neu == mask
            break;
        else
            mask = mask_neu;
        end
    end
end
