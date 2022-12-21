% 2a
mask_M = ones(6);
mask_M = padarray(mask_M, [2, 2], 0, 'both');
mask_S = ones(3);
randM = mask_M - imerode(mask_M, mask_S);
nachbarnN = imdilate(mask_M, mask_S) - mask_M;




