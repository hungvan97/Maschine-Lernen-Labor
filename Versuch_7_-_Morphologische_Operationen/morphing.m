function vid = morphing(A, B, n)
  
    % Bestimme Distanztransformationen
    
    % TODO
    D_a = distanceTransform(A);
    D_b = distanceTransform(B);
    C = zeros(size(A));
    for i = 0:n
        % Bestimme interpolierte Maske C

        % TODO
        D_i = (1 - i/n)*D_a + D_b*i/n;
%         for j = 1:size(C, 1)
%             for k = 1:size(C, 2)
%                 if D_i(j, k) <= 0
%                     C(j, k) = 1;
%                 end
%             end
%         end
        C = D_i<=0;
        imshow(C);
        vid(i+1) = getframe();
    end
end
