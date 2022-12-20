% 2a
mask_M = ones(6);
mask_M = padarray(mask_M, [2, 2], 0, 'both');
mask_S = ones(3);
randM = mask_M - imerode(mask_M, mask_S);
nachbarnN = imdilate(mask_M, mask_S) - mask_M;
a = nachbarnN + mask_M;
a(1, 2) = 2; a(1, 3) = 3; 
b = false(size(a));
b(1, 3) = true; b(1, 2) = true;
a(b)
mask_M
mask_M(a(b) < 4 & a(b) > 0) = 1;
mask_M





