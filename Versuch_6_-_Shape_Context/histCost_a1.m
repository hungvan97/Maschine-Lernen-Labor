data = load('ShapeContextData.mat');

% number = 1;
% for j = 1:2
%     for i=1:length(data.label_train)
%         if data.label_train(i) == number
%             zif(j) = data.train_data(:, :, i);
%             continue
%         end
%     end
% end

zif1 = data.train_data(:, :, 5);
zif2 = data.train_data(:, :, 13);

% add Parameter for scComputer
nPoints = 50;
X1 = getEdgePoints(zif1, nPoints);
X2 = getEdgePoints(zif2, nPoints);
P = [0.5,0.5];
nBinsTheta = 20;
nBinsR = 5;
rMin = 0.01;
rMax = 0.3;

% scCompute
SC1 = scCompute(P, X1, nBinsTheta, nBinsR, rMin, rMax);
SC2 = scCompute(P, X2, nBinsTheta, nBinsR, rMin, rMax);

% plot
zif = group2compare(zif1, zif2);
X = group2compare(X1, X2);
SC = group2compare(SC1, SC2);

count = 1;
figure(1);
for j = 1:2
    % PLOT ORIGINAL
    subplot(2,3,count),imshow(zif{j}),title('Original Bild');
    count = count + 1;
    % PLOT RAND
    subplot(2,3,count), title('Menge der bestimmten Randpunkte');
    gca;
    hold on;
    plot(X{j}(:,1),X{j}(:,2), 'bx');

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
    count = count + 1;
    % PLOT HISTOGRAM
    subplot(2,3,count),imagesc(SC{j}),colormap(gray),colorbar,xlabel('theta'),ylabel('r'),title('Shape Context Deskriptor - Histogram');
    count = count + 1;
end

% compute the Difference between 2 histogram
hc_diff = histCost(SC{1}, SC{2});
disp(['Different between 2 histogram is: ', num2str(hc_diff)]);
if hc_diff < 0.4
    disp('Quite similar, huh!!');      % got this result when compare two "3" at image 5, 9 
else
    disp('Not so similar');         % got this result when compare two "1" at image 2, 3 (or 2, 7)
end

% helper function
function input_group = group2compare(input1, input2)
    input_group = cell(1, 2);
    input_group{1} = input1;
    input_group{2} = input2;
end


