function [L, ctr] = kmeans(X, w, k)
    % X: eingang Datenpunkt, w: Gewicht, k: Anzahl Clusterzentren
    % L is 1-d array which has size equal to number of input X, element is
    % the class number
    % z.B: L = {1, 4, 5, 3, 7}
    
    
    % TODO
    
    % 1.1. choose randomly k point in Eingangdaten X 
    seed = randsample(X(:, 1),k);                               % seed now contains k choosen data-point
    % 1.2. assign k point to k cluster centrum
    L = zeros(1, length(X));                                    % array of cluster, contains index of data-point
    [~, idx_seed] = ismember(seed, X(:, 1));           
    ctr = X(idx_seed, :);                                       % array of centroid
                                                                  

    % 2. assign cluster to every element of input X
    while true 
        L_old = L;
        for i = 1:length(X)
            L1_dist = X(i, :) - ctr;
            L2_dist = zeros(length(ctr(:, 1)), 1);
            for j = 1:length(L1_dist(:, 1))
                L2_dist(j) = norm(L1_dist(j, :));
            end
           
            [~, idx] = min(L2_dist);%% minimum of distance for each point in pic to each point in cluster array
            L(i) = idx; % idx: index của cluster, mà tại đó dist -> X(i) min
        end
        
        % 6. in case nothing change
        if L_old == L
            break
        end
        
        % Update centroid
        for i = 1:k
            for j = 1:length(X(1, :))
                ctr(i, j) = sum(X(L==i, j).*w(L==i))/sum(w(L==i));
            end
        end 
    end
end