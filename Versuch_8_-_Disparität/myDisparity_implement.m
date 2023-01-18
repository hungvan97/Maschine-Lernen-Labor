I1 = im2double(rgb2gray(imread('./bilder/im0.ppm')));
I2 = im2double(rgb2gray(imread('./bilder/im2.ppm')));
D = myWindowDisparity(I1, I2, 10, 10, "SAD");
figure(1); subplot(2, 2, 1); title("SAD");
imagesc(D), colormap(gray), colorbar;
E = myWindowDisparity(I1, I2, 10, 10, "SSD");
figure(1); subplot(2, 2, 2); title("SSD");
imagesc(E), colormap(gray), colorbar;
G = myWindowDisparity(I1, I2, 10, 10, "NCC");
figure(1); subplot(2, 2, 3); title("NCC");
imagesc(G), colormap(gray), colorbar;