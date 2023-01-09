I1 = im2double(rgb2gray(imread('./bilder/im0.ppm')));
I2 = im2double(rgb2gray(imread('./bilder/im2.ppm')));
D = myWindowDisparity(I1, I2, 10, 10, "SSD");
figure;
imagesc(D), colormap(gray), colorbar;