function L = kmeans(X, w, k)
    % X: eingang Datenpunkt, w: Gewicht, k: Anzahl Clusterzentren
    % L is 1-d array which has size equal to number of input X, element is
    % the class number
    % z.B: L = {1, 4, 5, 3, 7}
    
    
    % TODO
    
    % 1.1. choose randomly k point in Eingangdaten X 
    seed = randsample(X(:, 1),k);                               % seed now contains k choosen data-point
    % 1.2. assign k point to k cluster centrum
    L = zeros(1, length(X));                                        % array of cluster, contains index of data-point
    [~, idx_seed] = ismember(seed, X(:, 1));
    ctr = [X(idx_seed, 1) X(idx_seed, 2)];                      % array of centroid

    % 2. assign cluster to every element of input X
    while true 
        L_old = L;
        for i = 1:length(X)
            [~, idx] = min((X(i,1)-ctr(:, 1)).^2 + (X(i,2)-ctr(:, 2)).^2);           %% minimum of distance for each point in pic to each point in cluster array
            % idx: index của cluster, mà tại đó dist -> X(i) min
            L(i) = idx;     
        end
        
        % 6. in case nothing change
        if L_old == L
            break
        end
        
        % Update centroid
        for i = 1:k
            ctr(i, 1) = mean(X(L == i, 1));
            ctr(i, 2) = mean(X(L == i, 2));
        end 
    end
    ctr
end