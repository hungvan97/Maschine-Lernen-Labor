%% a)
% Punkte generieren und plotten
n = 50;                 %% number of observed points
X = zeros(3, n);        %% matrix contains all 3 coordiaten of observed points (each column is a point)
    
sx = 5;   tx = 5;       %% seed and bias for genearate x-coordiaten
sy = 1;   ty = -3;      %% seed and bias for genearate y-coordiaten
sz = 0.5; tz = -2;      %% seed and bias for genearate z-coordiaten

X(1, :) = sx * randn(1, n) + tx;
X(2, :) = sy * randn(1, n) + ty;
X(3, :) = sz * randn(1, n) + tz;

w1 = 60;                %% weight for x
w2 = 30;                %% weight for y
w3 = 0;                 %% weight for z

R1 = [cosd(w1) -sind(w1) 0; sind(w1) cosd(w1) 0; 0 0 1]; %[1/2 v3/2 0; -v3/2 1/2 0; 0 0 1]
R2 = [cosd(w2) 0 sind(w2); 0 1 0; -sind(w2) 0 cosd(w2)]; %[v3/2 0 1/2; 0 1 0; -1/2 0 v3/2]
R3 = [1 0 0; 0 cosd(w3) -sind(w3); 0 sind(w3) cosd(w3)]; %[1 0 0; 0 1 0; 0 0 1]

X = R3 * R2 * R1 * X;

%% b)
% Hauptkomponenten bestimmen (Eigenwerte und Eigenvektoren der
% Kovarianzmatrix der Punktmenge berechnen)

% TODO
X = X';
DV = mean(X); % durchschnitt vektor
DM = X - repmat(DV, size(X, 1), 1);      % differentiale Matrix
C = cov(DM)  ;                  % covarianz Matrix
% C = 0;
% for i = 1:n
%     diff_vektor = diff_matrix(:, i) - durschnitt_vektor;
%     C = C + diff_vektor * diff_vektor';
% end
% C = C / n-1;

% V: Eigenvektor, D: Eigenwert(located on the diagonal of the matrix)
[V, D] = eig(C);

%% c)
% Hauptachsen (Eigenvektoren) plotten und deren Länge mit dem zugehörigen
% Eigenwert gewichten

% TODO


%% Visualisierung
figure(1);
plot3(X(:, 1), X(:, 2), X(:, 3), 'xb'); axis equal;
hold on
plot3([DV(1) DV(1)+D(1,1)*V(1,1)], [DV(2) DV(2)+D(1,1)*V(2,1)], [DV(3) DV(3)+D(1,1)*V(3,1)], 'r');
hold on;
plot3([DV(1) DV(1)+D(2,2)*V(1,2)], [DV(2) DV(2)+D(2,2)*V(2,2)], [DV(3) DV(3)+D(2,2)*V(3,2)], 'r');
hold on;
plot3([DV(1) DV(1)+D(3,3)*V(1,3)], [DV(2) DV(2)+D(3,3)*V(2,3)], [DV(3) DV(3)+D(3,3)*V(3,3)], 'r');
hold on;


%% d)
% Projektion auf eine der Hauptachsen über Skalarprodukt
% Tipp: Eigenvektoren haben die Länge 1

% TODO
index_projekted_axis = [1, 2, 3];   % choose the Hauptachsen to be projected on, index 3 got the largest Eigenvalue
VN = V(:, index_projekted_axis); 
VT = pinv(VN);
e = 0;                           % mittleren quadratischen Rekonstruktionfehler
var_e = [];
figure(2)
for i = 1:n
    p = X(i, :);
    
    alpha_projected = (p - DV)* VN;                     % nenner unnotwendig, cuz eigenvektor hat Length = 1; alpha_projected := projected point to choosen Hauptachse
    p_reconstructed = alpha_projected * VT + DV;        % for Teilaufgabe e,f
    e = e + (norm(p_reconstructed - p))^2;
    
    plot(alpha_projected, 'ob');
    var_e = [var_e; alpha_projected];
   
    hold on;
end

hold off;
title(['Visualisierung der Hauptachsen mit Rekonstruktionfehler = ', num2str(e/(n-1))]);
% Varianz in der Projektion

% TODO
var_e_1 = var(var_e(:, 1));
var_e_2 = var(var_e(:, 2));
var_e_3 = var(var_e(:, 3));
%% e)
% Rekonstruktion aus 1D-Unterraum und Plot

% TODO
% combined above

%% f)
% Projektion in den 2D-Unterraum der ersten beiden Hauptkomponenten und Rekonstruktion
n = 50;                 %% number of observed points
X = zeros(3, n);        %% matrix contains all 3 coordiaten of observed points (each column is a point)
    
sx = 3;   tx = 5;       %% seed and bias for genearate x-coordiaten
sy = 1;   ty = -3;      %% seed and bias for genearate y-coordiaten
sz = 0.5; tz = -2;      %% seed and bias for genearate z-coordiaten

X(1, :) = sx * randn(1, n) + tx;
X(2, :) = sy * randn(1, n) + ty;
X(3, :) = sz * randn(1, n) + tz;

w1 = 60;                %% weight for x
w2 = 30;                %% weight for y
w3 = 0;                 %% weight for z

R1 = [cosd(w1) -sind(w1) 0; sind(w1) cosd(w1) 0; 0 0 1]; %[1/2 v3/2 0; -v3/2 1/2 0; 0 0 1]
R2 = [cosd(w2) 0 sind(w2); 0 1 0; -sind(w2) 0 cosd(w2)]; %[v3/2 0 1/2; 0 1 0; -1/2 0 v3/2]
R3 = [1 0 0; 0 cosd(w3) -sind(w3); 0 sind(w3) cosd(w3)]; %[1 0 0; 0 1 0; 0 0 1]

X = R3 * R2 * R1 * X;

% Hauptkomponenten bestimmen (Eigenwerte und Eigenvektoren der
% Kovarianzmatrix der Punktmenge berechnen)

% TODO
X = X';
DV = mean(X); % durchschnitt vektor
DM = X - repmat(DV, size(X, 1), 1);      % differentiale Matrix
C = cov(DM)  ;                  % covarianz Matrix
% C = 0;
% for i = 1:n
%     diff_vektor = diff_matrix(:, i) - durschnitt_vektor;
%     C = C + diff_vektor * diff_vektor';
% end
% C = C / n-1;

% V: Eigenvektor, D: Eigenwert(located on the diagonal of the matrix)
[V, D] = eig(C);

% Hauptachsen (Eigenvektoren) plotten und deren Länge mit dem zugehörigen
% Eigenwert gewichten

% TODO


figure(1);
plot3(X(:, 1), X(:, 2), X(:, 3), 'xb'); axis equal;
hold on
plot3([DV(1) DV(1)+D(1,1)*V(1,1)], [DV(2) DV(2)+D(1,1)*V(2,1)], [DV(3) DV(3)+D(1,1)*V(3,1)], 'r');
hold on;
plot3([DV(1) DV(1)+D(2,2)*V(1,2)], [DV(2) DV(2)+D(2,2)*V(2,2)], [DV(3) DV(3)+D(2,2)*V(3,2)], 'r');
hold on;
plot3([DV(1) DV(1)+D(3,3)*V(1,3)], [DV(2) DV(2)+D(3,3)*V(2,3)], [DV(3) DV(3)+D(3,3)*V(3,3)], 'r');
hold on;


% Projektion auf eine der Hauptachsen über Skalarprodukt
% Tipp: Eigenvektoren haben die Länge 1

% TODO
index_projekted_axis = [ 2, 3];   % choose the Hauptachsen to be projected on, index 3 got the largest Eigenvalue
VN = V(:, index_projekted_axis); 
VT = pinv(VN);
e = 0;                           % mittleren quadratischen Rekonstruktionfehler
for i = 1:n
    p = X(i, :);
    
    alpha_projected = (p - DV)* VN;                     % nenner unnotwendig, cuz eigenvektor hat Length = 1; alpha_projected := projected point to choosen Hauptachse
    p_reconstructed = alpha_projected * VT + DV;        % for Teilaufgabe e,f
    e = e + (norm(p_reconstructed - p))^2;
    
    plot3(p_reconstructed(1), p_reconstructed(2), p_reconstructed(3), 'or');
    hold on;
end

hold off;
title(['Visualisierung der Hauptachsen mit Rekonstruktionfehler = ', num2str(e/(n-1))]);
% TODO
% combined above

% mittlerer quadratischer Rekonstruktionsfehler

% TODO
e = e / (n-1);
