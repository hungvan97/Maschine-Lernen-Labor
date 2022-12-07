clear all;

data = load ('test_data_clustering.mat');
X = data.X3;
w = ones(length(X),1);
[L, ~] = kmeans(X, w, 2);
plotClusterResults(X, L);
elbowMethod(X, 1, 10);
