clear all;
close all;
clc;

%% Bestimme ("ideale") Zellmaske

% Beispielbilder laden und als (dreidimensionale) Matrix abspeichern
dir = './Good/';
n_img = 150;

% 150 layers mask, each layer equal to 1 "good" cell image
pos_images = [];
for im = 1:n_img
    filename = cat(2, dir, 'Good', num2str(im), '.bmp');
    if exist(filename, 'file')
        pos_images = cat(3, pos_images, im2double(imread(filename)));
    end
end


% Bestimmung einer "durchschnittlichen" Zelle aus den Beispielbildern
% Hinweis: imadjust kann den Kontrast in diesem Bild verbessern
    % TODO
    
    A = mean(pos_images,3); 
    % Bestimmt  die "durchschnittliche" Zelle aus den Beispielbildern in der 3. Dimension.
    % gibt den Mittelwert entlang 3. Dimension zurück.
    B = imadjust(A);
%     figure(1),imshow(B);


% Histogramm bestimmen
% Befehl: imhist

    % TODO
%     figure(2), imhist(B);

% Schwellwerte aus Histogramm bestimmen (manuell oder automatisch) und
% Zellen-Labelbild aus der Durchschnittszelle definieren, z.B.
% Wert 1 - Zellkern (helle Bereiche)
% Wert 2 - Zellwand (dunkle Bereiche)
% Wert 3 - übrige Bereiche % der Rest liegt in übrige Bereiche

    % TODO
    thresh = multithresh(B,2);
    % Berechnen Sie zwei Schwellenwerte
    %gibt einen 1-mal-2-Vektor zurück,der 2 Schwellenwerte enthält.
    mask = imquantize(B,thresh); 
    % Segmentieren  das Bild mit imquantize in drei Ebenen
    % imquantize(A,levels) quantisiert Bild A unter Verwendung spezifizierter Quantisierungswerte, die in den N Elementvektorleveln enthalten sind.
    rgb = label2rgb(mask);
%     figure(3),imshow(rgb);

%% Bestimmung der Verteilungsfunktionen
%  Als Merkmal wird die Differenz des mittleren Grauwerts von Zellkern und
%  Zellwand verwendet. Es wird die Annahme getroffen dieses Merkmal ist
%  normalverteilt.

%  Merkmal für die postiven Beispiele bestimmen, d.h. in jedem Beispielbild
%  wird der Mittelwert im Bereich des Zellkerns und der Zellwand bestimmt
%  und abschließend voneinander abgezogen.
%  Die entsprechenden Bereiche sind durch die definierte Zellmaske gegeben.

for it = 1:size(pos_images, 3)
    im = pos_images(:, :, it);
    
    % TODO
    Zellkerns_p = mean(im(mask == 3)); % git Mittelwert von im mit mask = 3 zủuck
    Zellwand_p = mean(im(mask == 1 ));
    Merkmal_p(it)= Zellkerns_p - Zellwand_p;
    
end

% Bestimme Mittelwert und Varianz der postiven Beispiele

    % TODO
    pd_p = fitdist(Merkmal_p','Normal');
    % erstellt ein Wahrscheinlichkeitsverteilungsobjekt, 
    % indem die durch distname angegebene Verteilung an die Daten in Spaltenvektor x angepasst wird.


% Merkmal für die negativen Beispiele bestimmen.
dir = './Bad/';
n_img = 460;

neg_images = [];
for im = 1:n_img
    filename = cat(2, dir, 'Bad', num2str(im), '.bmp');
    if exist(filename, 'file')
        neg_images = cat(3, neg_images, im2double(imread(filename)));
    end
end

for it = 1:size(neg_images, 3)
    im = neg_images(:, :, it);  
    % TODO
    Zellkerns_n = mean(im(mask == 3));
    Zellwand_n = mean(im(mask== 1 ));
    Merkmal_n(it)= Zellkerns_n - Zellwand_n; 
    
end

% Bestimme Mittelwert und Varianz der negativen Beispiele

    % TODO
    pd_n  = fitdist(Merkmal_n','Normal');


%% Schwellwert für die Klassifikation bestimmen

% Verteilungen (positive und negative Beispiele) plotten

    % TODO
    xgrid = linspace(-0.2,1); 
    % gibt einen Zeilenvektor von 100 gleichmäßig verteilten Punkten zwischen x1 und x2 zurück.
    % Ich sehe, du hast es so eingestellt, also habe ich es eingestellt .
    pd_pos=pdf(pd_p,xgrid);
    % Probability density function oder  Wahrscheinlichkeitsdichtefunktion
    % gibt das pdf der Wahrscheinlichkeitsverteilung zurück, ausgewertet anhand der Werte in x.
    pd_neg=pdf(pd_n,xgrid);
%     figure(4);
%     plot(xgrid,pd_pos,'r');
%     hold on;
%     plot(xgrid,pd_neg,'b');
%     hold on;
    
% Schwellwert bestimmen, der eine (optimale) Trennung zwischen Zelle und
% Hintergrund auf der Basis des Merkmals angibt und im Plot markieren

%     % TODO
%     [a, b] = polyxpoly(xgrid,pd_pos,xgrid,pd_neg);
%     x = [a, a];
%     y = [0, max(pd_neg)];
%     plot(x,y,'k');
%     hold off;
%     legend('good','bad');

 % TODO
    [a, b] = polyxpoly(xgrid,pd_pos,xgrid,pd_neg);
    x = [a, a];
    y = [0, max(pd_neg)];
    plot(x,y,'k');
    legend('good','bad');
    hold off;

%% Bild(ausschnitte) klassifizieren und gefundene Zellen markieren

% Testbild laden
img = im2double(rgb2gray(imread('CellDetectPreFreeze.jpg')));

%img = im2double(rgb2gray(imread('CellDetectFreeze.jpg')));
%img = im2double(rgb2gray(imread('CellDetectPostFreeze.jpg')));

% Bild mit einem "Sliding Window" absuchen und Zellen über die Differenz des
% mittleren Grauwerts der maskierten Zellbestandteile und den Schwellwert detektieren.
% Zur Beschleunigung ist es ausreichend, das Fenster in 5er-Schritten weiterzuschieben.
    
    % TODO
    [m,n]=size(img);
    img_Cell= zeros(m,n);
    for i=1:5:m-100 
        for j=1:5:n-100   % damit die  Arrays übereinstimmen. 
            im=img(i:i+100,j:j+100); %  es wird  der Größe der Maske entsprechen lassen. 
            Zellkerns_i = mean(im(mask == 3));
            Zellwand_i = mean(im(mask== 1 ));
            Merkmal_i = Zellkerns_i - Zellwand_i;

            if Merkmal_i >= a 
                 img_Cell(i+50,j+50)=1; % bestimmt Zellkern    
            end
        end
    end
    [row, col] = ind2sub(size(img),find(img_Cell==1));
    
    % Convert linear indices to subscripter 
    % gibt die Arrays row und col zurück, die die äquivalenten Zeilen- und Spaltenindizes enthalten, 
    % die den linearen Indizes (find(img_Cell==1)) für eine Matrix der Größe size(img) entsprechen

% Bild und gefundene Zellen darstellen
 
    % TODO
    figure(5), imshow(img);
    hold on;
    figure(5);
    hold on;
    for i=1:length(row) 
        plot(col(i),row(i),'r-o');
    end
    hold off;
    
 %% Mean-Shift Clustering
 X = [col, row ];
 [L, C] = meanshift(X, 15, 1);
 
 
 figure(6), imshow('CellDetectPreFreeze.jpg');
 hold on;
 figure(6);
 p = plot(C(:,1),C(:,2), '*');
 p.Color = "red";
 hold off;
 
 
 

 
 

 
 
 
 

    
    