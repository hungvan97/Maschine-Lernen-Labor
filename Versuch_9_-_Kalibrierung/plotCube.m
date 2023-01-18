function plotCube(X)

    faces = [1, 2, 4, 3; ... % gelb
             3, 4, 8, 7; ... % cyan
             1, 3, 7, 5; ... % rot
             2, 4, 8, 6; ... % magenta
             1, 2, 6, 5; ... % blau
             6, 5, 7, 8];    % grün
    
    cdata(:, :, 1) = [1, 0, 1, 1, 0, 0];
    cdata(:, :, 2) = [1, 1, 0, 0, 0, 1];
    cdata(:, :, 3) = [0, 1, 0, 1, 1, 0];
    
    p = patch('Vertices', X, 'Faces', faces);
    
    set(p, 'FaceColor', 'flat', 'CData', cdata)
    
    axis equal; 
end