clear all;
close all;

%% Beispielgesichter (Trainingsdaten) laden
CPath = './att_faces/';         % actual face, quantity: 40
ReconPath = './recon_faces/';   % reconstruction face from actual face number 8th, 11th

subjects = 40;
images = 10;

filename = cat(2, CPath, 's', num2str(1), '/', num2str(1), '.pgm');
Img = im2double(imread(filename));
[six, siy] = size(Img);

F = [];
% fülle Datenmatrix
for sub = 1:subjects
%     if sub ~= 8
    for im = 1:images
        filename = cat(2, CPath, 's', num2str(sub), '/', num2str(im), '.pgm');
        if (exist(filename, 'file'))
            % Speicher Bilder spaltenweise
            F = [F, reshape(im2double(imread(filename)), [], 1)];
        end
    end
%     end
end

%% a) Erstellung des PCA-Raums

% "Meanface" erstellen und darstellen

% TODO
mean_face = mean(F, 2);    
% mittelwertfreie Gesichter generieren

% TODO
zero_mean_face = F - mean_face;
% Singulärwertzerlegung der mittelwertfreien Gesichter (svd)
%
% Die svd löst das Eigenwertproblem zu der Matrix F'*F (siehe
% "algebraischer Trick" aus der Vorlesung) und generiert direkt eine
% orthonormale Basis.
% Die Eigenvektoren stehen Spaltenweisen in U und sind absteigend geordnet.
% Die Singulärwerte stehen auf der Hauptdiagonalen in S. Es gilt
% EW = SW^2/n.
% Die Matrix V ist für uns ohne Bedeutung.

% TODO
[U, S, ~] = svd(zero_mean_face);
%% b) Visualisieren Sie 4 Hauptkomponenten (z.B. 1, 50, 100, 300)
% Verwenden Sie imagesc oder normalisieren Sie die Bilder.

% TODO
idx = 300;
row = size(Img, 1);
col = size(Img, 2);
eigenface = reshape(U(:, idx) * S(idx, idx), row, col);
eigenface = histeq(eigenface, 255);
imagesc(eigenface);

%% c) Bildrekonstruktion aus dem Unterraum
filename = cat(2, ReconPath, num2str(8), '.pgm');
img_to_reconstruct = im2double(imread(filename));
F_original = reshape(img_to_reconstruct, [], 1);

% Anzahl Eigenfaces
% Testen Sie auch verschiedene Werte!
d = 10;

% ersten d Eigenvektoren (Eigenfaces) auswählen

% TODO
U_d = U(:, 1:d);
% Mittelwert vom Bild abziehen

% TODO
F_neu = F_original - mean_face;
% Projektion in den Unterraum

% TODO
F_projected = F_neu' * U_d;
% Rekonstruktion aus dem Unterraum

% TODO
U_d_T = pinv(U_d);
F_reconstruct = (F_projected * U_d_T)' + mean_face;
% Rekonstruktion darstellen

% TODO
F_res = reshape(F_reconstruct, size(img_to_reconstruct, 1), size(img_to_reconstruct, 2));
figure(3)
imagesc(img_to_reconstruct);
figure(4)
imagesc(F_res);

% d) Rekonstruktion fehlender Daten
filename = cat(2, ReconPath, num2str(11), '.pgm');
img_to_reconstruct_fehler = im2double(imread(filename));
%
F_corrupted = reshape(img_to_reconstruct_fehler, [], 1);

% Bereich fehlender Daten bestimmen
% load histogram, find value at the far left <== hist(F_corrupted)

% TODO
F_fehler = find(F_corrupted < 0.07);

% iterative Rekonstruktion:
% Projektion -> Rekonstruktion -> Bereich mit Daten füllen -> Projektion...

% TODO
fehler_kriterien = size(F_fehler);
while(fehler_kriterien ~= 0)
    U_d_fehler = U(F_fehler, 1:d);
    mean_face_fehler = mean_face(F_fehler);
    F_neu_fehler = F_original(F_fehler) - mean_face_fehler;

    % Projektion in den Unterraum
    F_projected_fehler = F_neu_fehler' * U_d_fehler;
    % figure(5)
    % plot(F_projected_fehler, 'ob');
    % Rekonstruktion aus dem Unterraum
    U_d_T_fehler = pinv(U_d_fehler);
    F_reconstruct_fehler =  (F_projected_fehler * U_d_T_fehler)' + mean_face_fehler;


    % Rekonstruktion darstellen
    F_corrupted(F_fehler) = F_reconstruct_fehler;
    
    % Update Fehlerbereich
    F_fehler = find(F_corrupted < 0.07);
    fehler_kriterien = fehler_kriterien - size(F_fehler);
end

F_res = reshape(F_corrupted, size(img_to_reconstruct_fehler, 1), size(img_to_reconstruct_fehler, 2));
figure(10)
imshow(F_res);

%% e) Rekonstruktion ohne exakte Trainingsdaten
%  -> Wiederholen Sie obige Schritte, ohne dass Bilder der zu
%  rekonstruierenden Person in den PCA-Raum integriert werden, d.h. laden
%  Sie Bilder von Person 8 nicht zum Training. ????

% TODO


%% *Rekonstruktion des eigenen Gesichts
% Mit webcam_simple.mlapp kann ein Bild aufgenommen werden.
% Mit prepareFace kann ein passender Bildausschnitt gewählt werden.
% Erfordert Image Acquisition Toolbox + Support Package for OS Generic Video Interface

% TODO
