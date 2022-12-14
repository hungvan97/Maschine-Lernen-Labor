clear all;
close all;
clc;

%% Daten laden
load('ShapeContextData.mat')
aufgabe = "2c";

%% Shape Context für alle Trainingsdaten bestimmen
%  Einfache Variante: Bestimme Histogramm für Bildmittelpunkt

% setze Parameter
nBinsTheta = 50;            % Anzahl Bins für die Winkel von 0° bis 360°
nBinsR = 5;                % Anzahl Bins für Abstand von r_min bis r_max
rMin = 0.01;
rMax = 0.3;

% Shape Context der Trainingsdaten bestimmen
SC_train = zeros(nBinsR, nBinsTheta, size(train_data, 3));
for it = 1:size(train_data, 3)
    img = train_data(:, :, it);
    
    X = getEdgePoints(img, 50);
    
    % each layer contain histogram of appropriate ziffer in labelTrain
    if aufgabe == "2a"
        SC_train(:, :, it) = scCompute([0.5, 0.5], X, nBinsTheta, nBinsR, rMin, rMax);
    else
        SC_train(:, :, [it*50-49 : it*50]) = scCompute(X, X, nBinsTheta, nBinsR, rMin, rMax);
    end  
end

%% Shape Context für alle Testdaten bestimmen und klassifizieren

% Konfusionsmatrix
% K(i,j) gibt an, als welche Ziffern j die Testdaten i erkannt wurden, d.h.
% bei einer perfekten Klassifikation ist nur die Hauptdiagonale ~= 0
K = zeros(10);

for it = 1:size(test_data, 3)
    img = test_data(:, :, it);
    
    X = getEdgePoints(img, 50);
    
    % Bestimme Shape Context
    
    if aufgabe == "2a"
        % Für Aufgabe 2a
        SC = scCompute([0.5, 0.5], X, nBinsTheta, nBinsR, rMin, rMax);
    else
        % Für Aufgabe 2c
        SC = scCompute(X, X, nBinsTheta, nBinsR, rMin, rMax);
    end
     
    % Vergleich mit Shape Context der Trainingsdaten
    HC = zeros(1, size(train_data, 3));
    for it_train = 1:size(train_data, 3)
        % for each layer in 3-dimension of SC_train, compare the histograme
        % in it to the histograme (which is used to test) in SC
        if aufgabe == "2a"
        % Für Aufgabe 2a
            HC(it_train) = histCost(SC, SC_train(:, :, it_train));
        else
        % Für Aufgabe 2c
            HC(it_train) = histCost_a2(SC, SC_train(:, :, [it_train*50-49:it_train*50]));   
        end 
    end
    
    % nearest Neighbor Klassifikation
    [~, ind] = min(HC);
    
    % K-matrix: count the number of time each ziffer in label_train / train_data got
    % detected
    % for each layer got detected, increase it count by 1
    K(label_test(it)+1, label_train(ind)+1) = K(label_test(it)+1, label_train(ind)+1) + 1;
end

%% Darstellung Konfusionsmatrix
figure; clf; hold on;

for x = 1:10
    for y = 1:10
        c = 'black';
        if x == y
            c = 'blue';             % blue number: number of time that ziffer got detected correctly
        elseif K(x, y) > 0
            c = 'red';              % red number: number of time that ziffer got detected wrongly
        end
        text(x-1.15, y-0.85, num2str(K(x, y)), 'color', c, 'FontSize', 18);
    end
    plot([x - 0.5, x - 0.5], [-0.5, 9.5], 'k');
    plot([-0.5, 9.5], [x - 0.5, x - 0.5], 'k');
end

hold off;
axis ij;
set(gca, 'TickDir', 'out');
axis([-0.5, 9.5, -0.5, 9.5]);
xlabel('tatsächliche Ziffer');
ylabel('erkannte Ziffer');
title(['Fehlklassifikationen: ', num2str(sum(K(:))-sum(diag(K))), ' von ', num2str(sum(K(:)))]);
