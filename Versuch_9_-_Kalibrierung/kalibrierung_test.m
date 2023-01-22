close all
%% Verwendung gegebener Stereobilder
img = load('focusedStereoSetup.mat');
% img = load('parallelStereoSetup.mat');

%% Definition Kalibrierungsobjekt
Xw = [0, 0, 0; ... % 1 Ecke 1,3,5 (gelb, rot, blau)
      6, 0, 0; ... % 2 Ecke 1,4,5 (gelb, magenta, blau)
      0, 0, 6; ... % 3 Ecke 1,2,3 (gelb, cyan, rot)
      6, 0, 6; ... % 4 Ecke 1,2,4 (gelb, cyan, magenta)
      0, 6, 0; ... % 5 Ecke 3,5,6 (rot, blau, grün)
      6, 6, 0; ... % 6 Ecke 4,5,6 (magenta, blau, grün)
      0, 6, 6; ... % 7 Ecke 2,3,6 (cyan, rot, grün)
      6, 6, 6];    % 8 Ecke 2,4,6 (cyan, magenta, grün)
Xw_orginal = Xw;
     
%% Plotte Kalibrierungsobjekt
figure(1); clf;
plotCube(Xw);
view(-30, 30); axis on;

%% Aufgabe 1b) Kalibrierung einer Kamera anhand eines Bildes
% Projizierte Eckpunkte des Würfels bestimmen (getPoints.m)

% TODO
Ximg_left = getPoints(img.imgLeft);
ecke_404 = [];
for i = 1:length(Xw)
    if ~all(Ximg_left(i, :))
        ecke_404 = [ecke_404, i];
    end
end
Ximg_left(ecke_404, :) = [];
Xw(ecke_404, :) = [];

% Projektionsmatrix bestimmen (getProjectionMatrix.m)
% Achtung: Im Bild nicht gefundene Eckpunkte werden auf 0 gesetzt und
% sollten nicht zur Kalibrierung verwendet werden.
%%
% TODO
P_left = getProjectionMatrix(Xw(1:5, :), Ximg_left(1:5, :));

%% Aufgabe 1c) Test (Rückprojektion)
% Test: Projektion der Eckpunkte (X_w) des Kalibrierungsobjekts in das Bild
%  - qualitative Auswertung: Plot der projizierten Eckpunkte
%  - quantitative Auswertung: Bestimmung des mittleren Rückprojektionsfehlers

% TODO
MSE_left = 0;
for i = 1:length(Xw)
    Xw_col = [Xw(i, :)'; 1];
    
    P_mul_Xw = P_left * Xw_col;
    P_mul_Xw = P_mul_Xw / P_mul_Xw(3);
    P_mul_Xw = P_mul_Xw(1:2);
    
    MSE_left = MSE_left + norm(Ximg_left(i, :) - P_mul_Xw');
end
MSE_left = MSE_left / length(Xw);

%% Aufgabe 2: Szenenrekonstruktion und Triangulation
% a) Bestimmung der Projektionsmatrix der zweiten Kamera

% TODO
Xw = [0, 0, 0; ... % 1 Ecke 1,3,5 (gelb, rot, blau)
      6, 0, 0; ... % 2 Ecke 1,4,5 (gelb, magenta, blau)
      0, 0, 6; ... % 3 Ecke 1,2,3 (gelb, cyan, rot)
      6, 0, 6; ... % 4 Ecke 1,2,4 (gelb, cyan, magenta)
      0, 6, 0; ... % 5 Ecke 3,5,6 (rot, blau, grün)
      6, 6, 0; ... % 6 Ecke 4,5,6 (magenta, blau, grün)
      0, 6, 6; ... % 7 Ecke 2,3,6 (cyan, rot, grün)
      6, 6, 6];    % 8 Ecke 2,4,6 (cyan, magenta, grün)
Ximg_right = getPoints(img.imgRight);
ecke_404 = [];
for i = 1:length(Xw)
    if ~all(Ximg_right(i, :))
        ecke_404 = [ecke_404, i];
    end
end
Ximg_right(ecke_404, :) = [];
Xw(ecke_404, :) = [];

P_right = getProjectionMatrix(Xw, Ximg_right);
MSE_right = 0;
for i = 1:length(Xw)
    Xw_col = [Xw(i, :)'; 1];
    
    P_mul_Xw = P_right * Xw_col;
    P_mul_Xw = P_mul_Xw / P_mul_Xw(3);
    P_mul_Xw = P_mul_Xw(1:2);
    
    MSE_right = MSE_right + norm(Ximg_right(i, :) - P_mul_Xw');
end
MSE_right = MSE_right / length(Xw);

%% b) Bestimmung der Kamerazentren (in Matlab: null)

% TODO
C_left = null(P_left); 
C_right = null(P_right); 

% Norminalizierung der projiziertieren Kamerazentrum
C_left = C_left / C_left(4); 
C_right = C_right / C_right(4);

%% Plot der 3D-Szene: Kalibrierungsobjekt und Kamerazentren

% TODO
figure(1);

plot3(C_left(1), C_left(2), C_left(3), '.r');
hold on;
plot3(C_right(1), C_right(2), C_right(3), '.b');
hold on;
plotCube(Xw_orginal); view(-30, 30);
axis equal;
hold off;
%% c) Rekonstruktion von 3D-Punkten mittels Triangulation

% TODO
Xw_custom = [];
for i = 1:7
    Xw_custom = [Xw_custom; myTriangulation(Ximg_left(i, :), Ximg_right(i, :), P_left, P_right)];
end

% d) Visualisierung und Berechnung des Rekonstruktionsfehlers

% TODO
P_left = getProjectionMatrix(Xw_custom, Ximg_left);
P_right = getProjectionMatrix(Xw_custom, Ximg_right);
MSE_left_custom = 0;
MSE_right_custom = 0;
for i = 1:length(Xw_custom)
    Xw_col = [Xw_custom(i, :)'; 1];
    
    P_mul_Xw = P_right * Xw_col;
    P_mul_Xw = P_mul_Xw / P_mul_Xw(3);
    P_mul_Xw = P_mul_Xw(1:2);
    MSE_right_custom = MSE_right_custom + norm(Ximg_right(i, :) - P_mul_Xw');
    
    P_mul_Xw = P_left * Xw_col;
    P_mul_Xw = P_mul_Xw / P_mul_Xw(3);
    P_mul_Xw = P_mul_Xw(1:2);
    MSE_left_custom = MSE_left_custom + norm(Ximg_left(i, :) - P_mul_Xw');
end
MSE_left_custom = MSE_left_custom / length(Xw_custom);
MSE_right_custom = MSE_right_custom / length(Xw_custom);

%% Visualisierung 2 Xw
Xw_custom_original = [Xw_custom(1:5, :);[6 6 0];Xw_custom(6:end, :)];
figure(2);
plotCube(Xw_custom_original); view(-30, 30);
hold on;
plotCube(Xw_orginal); view(-30, 30);
axis equal;
hold off;
