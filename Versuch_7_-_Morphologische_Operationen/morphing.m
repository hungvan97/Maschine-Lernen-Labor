function vid = morphing(A, B, n)
  
    % Bestimme Distanztransformationen
    
    % TODO
    
    for i = 0:n
        % Bestimme interpolierte Maske C
        
        % TODO
        
        imshow(C);
        vid(i+1) = getframe();
    end
end
