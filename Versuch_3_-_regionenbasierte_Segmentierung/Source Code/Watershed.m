
%% Vorverarbeitung
I = imread ('./bilder/Emphysem.png'); 
I = rgb2gray(I);
figure, imshow (I);
I1  = imbinarize(I); 
D = - bwdist(~I1 );% Distanz transformiert 
D2 = imhmin(D,5); % glaettet
S = watershed(D2);
figure, imshow(label2rgb(S));

%% Plot Watershed 
if size(I, 3) == 1
    I2 = cat(3, I, I, I);
else
    I2 = I;
end

S = S <= 0;
S = imdilate(S, ones(3));
if isa(I2, 'double')
    I2(S) = 1;
    I2(find(S) + numel(S)) = 0.5;
    I2(find(S) + 2*numel(S)) = 0;
else
    I2(S) = 255;
    I2(find(S) + numel(S)) = 128;
    I2(find(S) + 2*numel(S)) = 0;
end

figure, imshow(I2);





