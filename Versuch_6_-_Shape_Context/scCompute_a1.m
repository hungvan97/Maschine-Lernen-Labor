data = load('ShapeContextData.mat');

number = 3;
for i=1:length(data.label_train)
    if data.label_train(i) == number
        zif = data.train_data(:, :, i);
        break;
    end
end

% add Parameter for scComputer
nPoints = 50;
% zif = data.train_data(:, :, i);
X = getEdgePoints(zif, nPoints);
P = [0.5,0.5];
nBinsTheta = 20;
nBinsR = 5;
rMin = 0.01;
rMax = 0.3;


% scCompute
SC = scCompute(P, X, nBinsTheta, nBinsR, rMin, rMax);

% plot
figure(1);
%PLOT ORIGINAL
subplot(2,2,1),imshow(zif),title('Original Bild');

%PLOT RAND
subplot(2,2,2), title('Menge der bestimmten Randpunkte');
gca;
hold on;
plot(X(:,1),X(:,2), 'bx');

% draw circles
th = 0 : pi / 50 : 2 * pi;
xunit = cos(th);
yunit = sin(th);
r_group = logspace(log10(rMin), log10(rMax), nBinsR);
for i=1:length(r_group)
    line(xunit * r_group(i) + P(1), ...
                    yunit * r_group(i) + P(2), ...
        'LineStyle', '-', 'Color', 'r', 'LineWidth', 1);
end

% draw spokes
th = (1:nBinsTheta) * 2*pi / nBinsTheta;
cs = [cos(th);zeros(1,size(th,2))];
sn = [sin(th);zeros(1,size(th,2))];
line(rMax*cs + P(1), rMax*sn + P(2),'LineStyle', ':', ...
    'Color', 'k', 'LineWidth', 1);

axis equal;
axis on;
hold off;

% PLOT HISTOGRAM
subplot(2,2,[3 4]),imagesc(SC),colormap(gray),colorbar,xlabel('theta'),ylabel('r'),title('Shape Context Deskriptor - Histogram');
