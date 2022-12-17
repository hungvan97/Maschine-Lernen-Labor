data = load("shapes.mat");

% 1a. Building binary Mask
mask = data.kreis;
% se = strel(mask);

% 1b
img_hole = imbinarize(imread("./bilder/silhouette_holes.jpg"));
se_hole = strel("disk", 6);
closedImage  = imclose(img_hole, se_hole);

figure(1);
subplot(2,2,1), imshow(img_hole), title('Original Image');
subplot(2,2,2), imshow(closedImage), title('Closing Image');

% 1c
imgLine = imbinarize(imread("./bilder/lines.jpg"));
mask_line = 10;
mask_deg = 90;
se_line = strel('line', mask_line, mask_deg);
openImageLine = imopen(imgLine, se_line);

figure(1);
subplot(2,2,3), imshow(imgLine), title('Original Image Line');
subplot(2,2,4), imshow(openImageLine), title('Open Image Line');

% 1d
imgCorrupt = imbinarize(imread("./bilder/silhouette_corrupted.jpg"));

figure(2);
subplot(2,3,1), imshow(imgCorrupt), title('Original Image Corrupt');

cl = imclose(imgCorrupt, strel("square", 6));
op = imopen(cl, strel("disk", 9));
line90 = imclose(op, strel('line', 12, 90));  % vertical gap from row 350 - 360 ( col > 490 ) ==> dilate still fine
line0 = imclose(line90, strel('line', 12, 0));% horizontal gap from col 350 - 360 ( row > 700 ) ==> dilate still fine
imnew = imdilate(line0, strel("disk", 10));

subplot(2,3,2), imshow(cl), title('Close');
subplot(2,3,3), imshow(op), title('Open');
subplot(2,3,4), imshow(line90), title('Line 0 remove');
subplot(2,3,5), imshow(line0), title('Line 90 remove');
subplot(2,3,6), imshow(imnew), title('Recover Image');