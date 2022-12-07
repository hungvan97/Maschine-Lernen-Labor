clear all;

data = load ('test_data_clustering.mat');
X = data.X5;

L = kmeans(X, 1, 4);
plotClusterResults(X, L);