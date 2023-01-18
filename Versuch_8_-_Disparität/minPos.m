function neighbor = minPos(weight, Cij, DTW, i, j)
    %   z.B.: M(i,j) = 1 -> Minimum links oben:        C(i,j) + D(i-1,j-1) ist minimal
    %         M(i,j) = 2 -> Minimum oben:       weight*C(i,j) + D(i-1,j)   ist minimal
    %         M(i,j) = 3 -> Minimum links:      weight*C(i,j) + D(i,  j-1) ist minimal
    neighbor = [Inf, Inf, Inf];
    if i-1 > 0
        neighbor(2) = weight*Cij + DTW(i-1, j);
        if j-1 > 0
            neighbor(1) = Cij + DTW(i-1, j-1);
        end
    else
        neighbor(2) = Inf; %weight*Cij;
        if i == 1 && j == 1
            neighbor(1) = Cij; 
        end
    end
    if j-1 > 0
        neighbor(3) = weight*Cij + DTW(i, j-1);
    else 
        neighbor(3) = Inf; %weight*Cij;
    end
    
end