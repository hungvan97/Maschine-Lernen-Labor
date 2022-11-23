% es liest ein Bild ein, glaettet und das Ergebnis anzeigt
I = imread('.\bilder\peppers.jpg');

% Filtert das Bild I mit einem (zweidimensionalen) Gauss-Filter mit Standardabweichung sigma.
sigma = input(" gewunschte Sigmal: ");
% Laufzeit aufmessen
tic
I_gauss = gaussFilter(I,sigma, 'choose');
toc
% von "double" wieder zu "uint8" casten
I_gauss = uint8(I_gauss);  
% plot
figure(1);
subplot(1,2,1),imshow(I),title('ursprungliches Bild');
subplot(1,2,2),imshow(I_gauss),title('glaettet Bild mit 2d Filter');

% Filtert das Bild I mit zwei (eindimensionalen) Gauss-Filter mit Standardabweichung sigma.
% Laufzeit aufmessen
tic
I_gauss_sep = gaussFilterSep(I,sigma);
toc
% von "double" wieder zu "uint8" casten
I_gauss_sep = uint8(I_gauss_sep);
% plot
figure(2);
subplot(1,2,1),imshow(I),title('ursprungliches Bild');
subplot(1,2,2),imshow(I_gauss_sep),title('glaettet Bild mit 1d Filter');