% Testfunktion, die ein Bild einliest und interaktiv den Startpunkt und Schwellwert abfragt. 
clear,clc;

% Bild einlesen
I=imread('./bilder/coins.png');
%I=imread('./bilder/rectangle.png');
% I(120, 199)
% I(120, 202)
figure(1),clf,subplot(2,2,1),imshow(I),title('Bild');


F=fspecial('sobel');
Img = conv2(I,F,'same');
Img = abs(Img);
Img(Img>=1)=255;
subplot(2,2,3),imshow(Img),title('Bild mit Sobel-Filter');

% den Startpunkt und schwellwert abfragen
subplot(2,2,1)
disp("Klicken Sie mit der Maus auf das Bild, um den Startpunkt zu bestimmen");
[x,y]=getpts;  
xStart=round(x);
yStart=round(y);
disp(['Startpunkt: x = ', num2str(xStart), ', y = ', num2str(yStart), ' bestätigt!'])
disp("=============================================================================")

threshold=-1;
while threshold<0 || threshold>255
    threshold=input("Bitte geben Sie eine Zahl von 0 bis 255 als Schwellenwert ein: "); 
    threshold=round(threshold);
    if threshold<0 || threshold>255
        disp("illegal Schwellenwert, nochmal eingeben");
    else
        disp(['Schwellenwert: ', num2str(threshold), ' bestätigt!'])
    end
end
disp("=============================================================================")
disp("Segmentierung wird momentan bearbeitet. Bitte warten Sie einen Moment!")

% stellen die Segmentierung dar
S = regionGrowing(I, xStart, yStart, threshold);
subplot(2,2,4),imshow(S),title('Segmentisierung');
subplot(2,2,1),hold on
contour(S,'r');

disp("=============================================================================")
disp("VOILA")
