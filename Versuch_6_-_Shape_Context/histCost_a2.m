function HC = histCost_neu(sc1,sc2)
% Chi^2-Test zum Vergleich zweier Histogramme
   m=size(sc1,3);
   n=size(sc2,3);
   Tmp=zeros(m,n);
   norm1=0;
   norm2=0;
   for i=1:m
       for j=1:n
           Tmp(i,j)=histCost(sc1(:,:,i),sc2(:,:,j));
       end
   end
   sum1=0;
   for i=1:m
       sum1=sum1+min(Tmp(i,:));
       norm1=norm1+norm(sc1(:,:,i));
   end
   sum2=0;
   for i=1:n
       sum2=sum2+min(Tmp(:,i));
       norm2=norm2+norm(sc2(:,:,i));
   end
   HC=sum1/norm1+sum2/norm2;
    
end