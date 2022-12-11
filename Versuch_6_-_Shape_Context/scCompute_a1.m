data = load('ShapeContextData.mat');

number = 3;
for i=1:length(data.label_train)
    if data.label_train(i) == number
        zif = data.train_data(:, :, i);
        break;
    end
end

nPoints = 100;
X = getEdgePoints(zif, nPoints);
P = [0.5,0.5];
nBinsTheta = 20;
nBinsR = 5;
rMin = 0.05;
rMax = 0.95;

% 1a
SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax);

figure(1);
subplot(1,3,1),imshow(zif),title('Bild der Ziffer');
subplot(1,3,2),plot(X(:,1),X(:,2), 'bx'),title('Menge der bestimmten Randpunkte');
subplot(1,3,3)
