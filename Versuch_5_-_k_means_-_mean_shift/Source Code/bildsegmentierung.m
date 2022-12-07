% 1. Load pic

I=imread('./bilder/lena.png');
figure(1), subplot(1,2,1),imshow(I),title('Original');

[yI,xI]=size(I);

% 2. Load histogramm Pic
figure(2),imhist(I), title('Histogram');
gray_value = imhist(I);                              %Weight's Datenpunkt
X=0:255;                                             %1d 0-255 Datenpunkt
X=X';

% 3. Apply k-mean
k = input('Choose number of cluster: ');
[L, ctr] = kmeans(X, gray_value, k);

% 4. Segementation
I_double = double(I);
I_flag=zeros(yI,xI);                                % check whether pixel is assigned to cluster or not
for h=1:k
    pix_value = find(L==h);                         % find all pixel-value, which belong to pixel in cluster h
    for i=1:yI
        for j=1:xI
            if (I_flag(i,j)==0) && (I_double(i,j)>=pix_value(1)-1) && (I_double(i,j)<pix_value(length(pix_value)))
                I_flag(i,j) = 1;
                I_double(i,j)= ctr(h);              % assign pixel to cluster
            end
        end
    end
end

% 5. Result
I_uint8=uint8(I_double);
figure(1),subplot(1,2,2),imshow(I_uint8),title(['k-means, k = ' num2str(k)]);
disp([num2str(k), ' cluster that have following gray-value at the center']); ctr
