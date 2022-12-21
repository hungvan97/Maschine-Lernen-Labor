data = load("shapes.mat");
M = data.spirale;   % M: M0 mask
D = distanceTransform(M);
figure;
imagesc(D), colorbar, axis off ;



