function neighbor = addNeighbor(DTW, i, j)
    neighbor = [];
    if i-1 > 0
        neighbor = [neighbor, DTW(i-1, j)]; % top
        if j-1 > 0
            neighbor = [neighbor, DTW(i-1, j-1)]; %top left
        end
    end
    if j-1 > 0
            neighbor = [neighbor, DTW(i, j-1)]; % left
    end 
    if isempty(neighbor)
        neighbor = 0;
    end
    
end