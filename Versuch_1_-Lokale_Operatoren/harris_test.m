% Testet den Harris-Corner-Detektor.
I = imread('.\bilder\blox.gif');
ecken = harrisCorner(I, 1, 4, 1e6);

% Darstellung
figure(1); clf;
subplot(121); imshow(I);
subplot(122); imshow(I);

hold on;        % ermoeglicht weitere Objekte in die figure zu zeichnen

% Ecken markieren
% Hinweis: Bilder werden in Matlab als Array in einem ij-Koordinatensystem
% dargestellt, mit dem Nullpunkt in der linken, oberen Ecke. Die i-Achse
% verläuft senkrecht, die j-Achse waagerecht.


    % TODO
plot(ecken(:,2),ecken(:,1), 'r*');

hold off;

%%
I = imread('.\bilder\rectangles.png');
ecken = harrisCorner(I, 5, 4, 1e3);

% Darstellung
figure(2); clf;
subplot(221); imshow(I);
subplot(222); imshow(I);

hold on;        

% Ecken markieren
    % TODO
plot(ecken(:,2),ecken(:,1), 'r*');

hold off;