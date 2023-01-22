function face = prepareFace()
    %% Bild laden
    img = im2double(rgb2gray(imread('screenshot.png')));
    
    %% ROI markieren
    figure(1);
    imshow(img);
    h = drawrectangle;
    pos = h.Position;
    
    %% Bild interpolieren
    img2 = img(pos(2):pos(2)+pos(4), pos(1):pos(1)+pos(3));
    
    [m, n] = size(img2);
    [Y, X] = meshgrid(1:n, 1:m);
    [Yn, Xn] = meshgrid(linspace(1, n, 92), linspace(1, m, 112));
    
    face = interp2(X', Y', img2', Xn, Yn);
    imshow(face);
end