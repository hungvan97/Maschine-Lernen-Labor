clear all;

data = load ('test_data_clustering.mat');
X = data.X5;
w = ones(length(X),1);
% [L, ~] = kmeans(X, w, 2);
[L, C] = meanshift(X,10,0);
plotClusterResults(X, L);
% elbowMethod(X, 1, 10);
