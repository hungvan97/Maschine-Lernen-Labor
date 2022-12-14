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
    B = imadjust(A);
    figure(1),imshow(B);


% Histogramm bestimmen
% Befehl: imhist

    % TODO
    figure(2), imhist(B);


% Schwellwerte aus Histogramm bestimmen (manuell oder automatisch) und
% Zellen-Labelbild aus der Durchschnittszelle definieren, z.B.
% Wert 1 - Zellkern (helle Bereiche)
% Wert 2 - Zellwand (dunkle Bereiche)
% Wert 3 - übrige Bereiche

    % TODO
    thresh = multithresh(B,2); % Calculate two threshold levels.
    mask = imquantize(B,thresh); % Segment the image into three levels using imquantize 
    rgb = label2rgb(mask);
    figure(3),imshow(rgb);

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
    Zellkerns_p = mean(im(mask ==3));
    Zellwand_p = mean(im(mask==1));
    Merkmal_p (it)= abs(Zellkerns_p - Zellwand_p);
    
end

% Bestimme Mittelwert und Varianz der postiven Beispiele

    % TODO
    pd_p = fitdist(Merkmal_p','Normal');


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
    Zellkerns_n = mean(im(mask ==3));
    Zellwand_n = mean(im(mask==1));
    Merkmal_n(it)= abs(Zellkerns_n - Zellwand_n); 
    
end

% Bestimme Mittelwert und Varianz der negativen Beispiele

    % TODO
    pd_n  = fitdist(Merkmal_n','Normal');


%% Schwellwert für die Klassifikation bestimmen

% Verteilungen (positive und negative Beispiele) plotten

    % TODO
    xgrid = linspace(min(min(Merkmal_p), min(Merkmal_n))-0.1,max(max(Merkmal_p),max(Merkmal_n))+0.1); 
%     xgrid = linspace(-0.1, 0.7);
    pd_pos=pdf(pd_p,xgrid);
    pd_neg=pdf(pd_n,xgrid);
    figure(4);
    plot(xgrid,pd_pos,'r');
    hold on;
    plot(xgrid,pd_neg,'b');
    hold on;
    
% Schwellwert bestimmen, der eine (optimale) Trennung zwischen Zelle und
% Hintergrund auf der Basis des Merkmals angibt und im Plot markieren

    % TODO
    [a, b] = polyxpoly(xgrid,pd_pos,xgrid,pd_neg);
    x = [a, a];
    y = [0, max(pd_neg)];
    plot(x,y,'k');
    legend('good','bad');
    hold off;


%% Bild(ausschnitte) klassifizieren und gefundene Zellen markieren

% Testbild laden
%img = im2double(rgb2gray(imread('CellDetectPreFreeze.jpg')));
img = im2double(rgb2gray(imread('CellDetectFreeze.jpg')));
%img = im2double(rgb2gray(imread('CellDetectPostFreeze.jpg')));


% Bild mit einem "Sliding Window" absuchen und Zellen über die Differenz des
% mittleren Grauwerts der maskierten Zellbestandteile und den Schwellwert detektieren.
% Zur Beschleunigung ist es ausreichend, das Fenster in 5er-Schritten weiterzuschieben.
    
    % TODO
    [m,n]=size(img);
    img_Cell=zeros(m,n);
    for i=1:5:m-100 
        for j=1:5:n-100     
            im=img(i:i+100,j:j+100);                    % create rectangle window with 100pix length
            Zellkerns_i = mean(im(mask ==3));           % top left corner has (i, j) coordinate 
            Zellwand_i = mean(im(mask==1));
            Merkmal_i = abs(Zellkerns_i - Zellwand_i);
            
            if Merkmal_i>= a 
                 img_Cell(i+50,j+50)=1;                 % defined the cell of window as value 1
                    
            end
        end
    end
    [row,col] = ind2sub(size(img),find(img_Cell==1));

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
