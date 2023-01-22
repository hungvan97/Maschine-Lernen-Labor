clear all;
close all;

%% Beispielgesichter (Trainingsdaten) laden
CPath = './att_faces/';
ReconPath = './recon_faces/';

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

% mittelwertfreie Gesichter generieren

% TODO

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

%% b) Visualisieren Sie 4 Hauptkomponenten (z.B. 1, 50, 100, 300)
% Verwenden Sie imagesc oder normalisieren Sie die Bilder.

% TODO


%% c) Bildrekonstruktion aus dem Unterraum
filename = cat(2, ReconPath, num2str(8), '.pgm');
F_original = reshape(im2double(imread(filename)), [], 1);

% Anzahl Eigenfaces
% Testen Sie auch verschiedene Werte!
d = 300;

% ersten d Eigenvektoren (Eigenfaces) auswählen

% TODO

% Mittelwert vom Bild abziehen

% TODO

% Projektion in den Unterraum

% TODO

% Rekonstruktion aus dem Unterraum

% TODO

% Rekonstruktion darstellen

% TODO


%% d) Rekonstruktion fehlender Daten
filename = cat(2, ReconPath, num2str(11), '.pgm');
F_corrupted = reshape(im2double(imread(filename)), [], 1);

% Bereich fehlender Daten bestimmen

% TODO

% iterative Rekonstruktion:
% Projektion -> Rekonstruktion -> Bereich mit Daten füllen -> Projektion...

% TODO


%% e) Rekonstruktion ohne exakte Trainingsdaten
%  -> Wiederholen Sie obige Schritte, ohne dass Bilder der zu
%  rekonstruierenden Person in den PCA-Raum integriert werden, d.h. laden
%  Sie Bilder von Person 8 nicht zum Training.

% TODO


%% *Rekonstruktion des eigenen Gesichts
% Mit webcam_simple.mlapp kann ein Bild aufgenommen werden.
% Mit prepareFace kann ein passender Bildausschnitt gewählt werden.
% Erfordert Image Acquisition Toolbox + Support Package for OS Generic Video Interface

% TODO

