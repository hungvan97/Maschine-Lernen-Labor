clear all;

data = load ('test_data_clustering.mat');
X = data.X4;
w = ones(length(X),1);
[L, ~] = kmeans(X, w, 3);
plotClusterResults(X, L);
elbowMethod(X, 1, 10);
