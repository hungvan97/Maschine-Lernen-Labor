function HC = histCost_a2(SCx, SCy) % 1 for testing, 1 for training
% SCx, SCy: 5(r_group)x50(theta_group)x50(layer)
% Chi^2-Test zum Vergleich zweier Histogramme
    
    % TODO
    HC = mean_chi(SCx, SCy) + mean_chi(SCy, SCx);
    
    function meanChi = mean_chi(SCx, SCy)
        x = size(SCx, 3);
        y = size(SCy, 3);
        sum_hist = zeros(x, y);
        sum_min = 0;
        sum_norm = 0;
        for i = 1:x
            for j = 1:y
                sum_hist(i, j) = histCost(SCx(:, :, i), SCy(:, :, j));
            end
            sum_min = sum_min + min(sum_hist(i, :));
            % sum_norm: https://math.stackexchange.com/questions/3044929/l2-norm-of-a-matrix-is-this-statement-true
            sum_norm = sum_norm + norm(SCx(:, :, i));
        end
        meanChi = sum_min / sum_norm;
    end
end
