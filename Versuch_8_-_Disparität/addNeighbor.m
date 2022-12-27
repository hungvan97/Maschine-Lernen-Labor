function neighbor = addNeighbor(DTW, i, j)
    neighbor = [];
    if i-1 > 0
        neighbor = [neighbor, DTW(i-1, j)];
        if j-1 > 0
            neighbor = [neighbor, DTW(i-1, j-1)];
        end
    end
    if j-1 > 0
            neighbor = [neighbor, DTW(i, j-1)];
    end 
    if isempty(neighbor)
        neighbor = 0;
    end
end