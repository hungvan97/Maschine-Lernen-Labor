function posMin = minPos(weight, Cij, DTW, i, j)
    neighbor = [Inf, Inf, Inf];
    if i-1 > 0
        neighbor(2) = weight*Cij + DTW(i-1,j);
        if j-1 > 0
            neighbor(1) = Cij + DTW(i-1,j-1);
        end
    end
    if j-1 > 0
            neighbor(3) = weight*Cij + DTW(i,j-1);
    end 
    
    [~, posMin] = min(neighbor);
    
end