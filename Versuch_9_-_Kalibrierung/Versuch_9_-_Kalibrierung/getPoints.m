function [X] = getPoints(img)
    
    X = zeros(8, 2);
    
    % Plot
    h = figure();
    imshow(img);
    
    % setze Punkte
    while 1
        % Klicken
        [x, y, button] = ginput(1);
        
        % Klick auswerten
        if ~isempty(button)
            switch button
                case 1
                    % Lösche nächsten Punkt
                    if x >= 1 && x <= size(img, 2) && y >= 1 && y <= size(img, 1)
                        dists = dist([x, y], X');
                        [~, ind] = min(dists);
                        X(ind, :) = [0, 0];
                    end
                case 3
                    % Abbruch
                    break;
                case {49, 50, 51, 52, 53, 54, 55, 56, 57}
                    % Zahl 1-8
                    if x >= 1 && x <= size(img, 2) && y >= 1 && y <= size(img, 1)
                        X(button-48, :) = [x, y];
                    end
            end
        end
        
        % Plot
        imshow(img);
        hold on;
        ind = find(any(X, 2));
        plot(X(ind, 1), X(ind, 2), 'xr', 'MarkerSize', 20, 'LineWidth', 3);
        text(X(ind, 1), X(ind, 2), cellstr(num2str(ind)), 'VerticalAlignment', 'bottom', 'Color', 'red', 'FontSize', 20, 'FontWeight', 'bold');
        hold off;
    end
    
    close(h)
end
