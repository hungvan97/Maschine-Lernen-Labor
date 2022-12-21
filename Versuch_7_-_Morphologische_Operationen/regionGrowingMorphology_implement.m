I = rgb2gray(imread("./bilder/Emphysem.png"));
threshold = 20;
imshow(I);
[x, y] = ginput(1);
xStart = round(x); yStart = round(y);
mask = regionGrowingMorphology(I, xStart, yStart, threshold);
region = uint8(I) .* uint8(mask);
imshow(double(region));

