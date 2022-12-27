function D = distanceTransform(M)
    % data = load("shapes.mat");
    % M = data.spirale;   % M: M0 mask
    D = zeros(size(M)); % D: distance matrix
    S = strel('disk', 1);
    count = 0;

    mask_dilate = M;
    mask_erode = M;

    while ~all(D(:))
        count = count + 1;
        
        % Fur Punkt ausserhalb der Mask
        temp_mask_dilate = imdilate(mask_dilate, S);
        D = D + (temp_mask_dilate - mask_dilate) * count;
       
        % Fur Punkt innerhalb der Mask
        temp_mask_erode = imerode(mask_erode, S);
        D = D + (mask_erode - temp_mask_erode) * count * -1;

        % update M
        mask_dilate = temp_mask_dilate;
        mask_erode = temp_mask_erode;
    end
end
