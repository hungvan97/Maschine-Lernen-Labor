function D = myDisparity(imgLeft, imgRight, maxDisparity)
    
    % TODO
    for i = 1:size(imgLeft, 1)
        for j = 1:size(imgLeft, 2)
            pixelLeft = imgLeft(i, j);
            
            minDist = Inf;
            minDisparity = 0;
            
            % recht Bild schrittweise nach link geschoben
            for k = 1:maxDisparity
                pixelRight = imgRight(i, j-k);
                dist = sqrt(pixelLeft^2 - pixelRight^2);
%                 dist = sqrt(sum(blockLeft(:).^2-blockRight(:).^2));
                
                if dist < minDist
                    minDist = dist;
                    minDisparity = k;
                end
                
                % Set the disparity value for the current pixel
                D(i, j) = minDisparity;
            end
        end
    end    
end