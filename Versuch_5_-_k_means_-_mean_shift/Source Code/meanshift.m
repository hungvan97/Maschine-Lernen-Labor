function [L, C] = meanshift(X, d, vis)
% Meanshift für n-dimensionale Punkte
%
% Eingabe: X   - n-dimensionale Datenpunkte (mxn-Array)
%          d   - Durchmesser
%          vis - Visualisierung alle vis Iterationen
% Ausgabe: L   - Label (mx1-Array)
%          C   - Clusterzentren (kxd Array)

    if vis > 0
        plot(X(:, 1), X(:, 2), 'xr');
        hold on;
    end

    % mean shift für alle Punkte
    centroids = zeros(size(X));
    for it = 1:size(X, 1)
        c = X(it, :);
        while true
            c_alt = c;
    
            % finde Punkte im Umkreis von d
            dists = dist(X, c');
            c = mean(X(dists < d, :), 1);
    
            if mod(it, vis) == 0
                plot([c(1), c_alt(1)], [c(2), c_alt(2)]);
            end
    
            if c == c_alt
                break;
            end
        end
    
        centroids(it, :) = c;
    
        if mod(it, vis) == 0
            plot(c(1), c(2), '.g', 'MarkerSize', 20);
            drawnow;
        end
    end
    
    if vis > 0
        hold off;
    end
    
    % vereinige ähnliche Centroids zu Clustern
    % Idee: fasse alle Centroids zusammen, die weniger Abstand als d/2 zueinander haben
    [unique_centroids, ~, map_points] = unique(centroids, 'rows');
    dists = dist(unique_centroids, unique_centroids') < d / 2;
    
    % bestimme zusammenhängende Centroids (Breitensuche)
    map_centroids = zeros(size(unique_centroids, 1), 1);
    cluster_id = 1;
    while true
        next_ind = find(map_centroids == 0, 1); % nächster bisher nicht zugeordneter Centroid
        if isempty(next_ind)
            break;
        end
        map_centroids(next_ind) = cluster_id;
    
        close = find(dists(:, next_ind) == 1 & map_centroids == 0); % Indizes bisher nicht gematchter Centroids mit Abstand < d/2
        while ~isempty(close)
            next_ind = close(1);
            map_centroids(next_ind) = cluster_id;
            close(1) = [];
    
            close = union(close, find(dists(:, next_ind) == 1 & map_centroids == 0));
        end
        cluster_id = cluster_id + 1;
    end
    
    % mappe Punkte auf zusammengefügte Centroids/Cluster
    L = map_centroids(map_points);
    
    % berechne Clusterzentren aus den geshifteten Centroids
    C = zeros(max(map_centroids), size(X, 2));
    for it = 1:max(map_centroids)
        C(it, :) = mean(unique_centroids(map_centroids == it, :), 1);
    end
end
