function HC = histCost(SCx, SCy) % 1 for testing, 1 for training
% Chi^2-Test zum Vergleich zweier Histogramme
    
    % TODO
    %HC = 0.5 * sum(sum((SCx - SCy).^2 ./ (SCx + SCy))); <= nenner = 0 at
    %some point, don't use this.
    
    [m, n] = size(SCx);
    HC = 0;
    for i = 1:m
        for j = 1:n
            if (SCx(i, j) + SCy(i, j)) ~= 0
                HC = HC + 0.5*(SCx(i, j) - SCy(i, j))^2/(SCx(i, j) + SCy(i, j));
            end
        end
    end
end
