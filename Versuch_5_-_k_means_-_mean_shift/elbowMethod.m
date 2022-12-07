function elbowMethod(X, kMin, kMax)
    wcss = zeros(kMax-kMin+1, 1);
    sum_wcss = sum(wcss);
    w = ones(length(X),1);
    for k=kMin:kMax
        [L, ctr] = kmeans(X, w, k);   
        for i = 1:k
            sum_wcss = sum_wcss + sum((X(L==i, 1)-ctr(i, 1)).^2+(X(L==i, 2)-ctr(i, 2)).^2);
        end
        wcss(k-kMin+1) = sum_wcss;
        sum_wcss = 0;
    end 
    figure(2);
    plot((kMin:kMax),wcss);
    title('Elbow Method');
    xlabel('k');
    ylabel('Distortion Score'); 
end

