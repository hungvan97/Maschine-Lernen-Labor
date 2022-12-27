function D = myWindowDisparity(imgLeft, imgRight, maxDisparity, windowSize, method)
    
    % TODO
    for i = 1:size(imgLeft, 1)-windowSize+1
        for j = 1:size(imgLeft, 2)-windowSize+1
            % Extract the current window(block) from left image
            windowLeft = imgLeft(i:i+windowSize-1, j:j+windowSize-1);
                
            minDist = Inf;
            minDisparity = 0;
            
            % recht Bild schrittweise nach link geschoben
            for k = 0:min(maxDisparity, j)-1
                windowRight = imgRight(i:i+windowSize-1, j-k:j-k+windowSize-1);
                
                switch method
                    case "SAD"
                        dist = sum(sum(abs(windowLeft(:) - windowRight(:))));
                    case "SSD"
                        dist = sum(sum((windowLeft(:) - windowRight(:)).^2));
                    case "NCC"
                        meanLeft  = mean(windowLeft(:));
                        meanRight = mean(windowRight(:));
                        zahler = sum(sum((windowLeft - meanLeft).*(windowRight - meanRight))).^2;
                        nenner = sum(sum((windowLeft - meanLeft).^2)).*sum(sum((windowRight - meanRight).^2));
                        dist = 1 - zahler/nenner;                    
                end 
                
                if dist < minDist
                    minDist = dist;
                    minDisparity = k;
                end
                
                % Set the disparity value for the current pixel
                D(i:i+windowSize-1, j:j+windowSize-1) = minDisparity;
            end
        end
    end    
end