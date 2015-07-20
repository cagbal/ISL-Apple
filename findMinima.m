function [ minima ] = findMinima( apf, disk_size)
%findMinima find local minimum points on artificial potential function
% by using morphological operations
%Input:
% 2D Artificial Potential Function
%Output:
% minima: coordinates of centroids of local minimum points of APF
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        %
%                                26.06.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% threshold for color tolerance
threshold = 0.10;

% apply threshold on apf to get rid of background
apf_bw = im2bw(1-apf, threshold);

% open the image
se = strel('disk',disk_size);
apf_bw = imclose(apf_bw, se);

% get the Connected Components of image
CC = bwconncomp(1- apf_bw);

% get the centroids of CC
minima = regionprops(CC,'Centroid', 'Area', 'BoundingBox');

% this will be commended out

%imagesc(apf_bw);

%axis off

%hold on

%for i = 1 : size(minima,1)
%    plot (minima(i).Centroid(1), minima(i).Centroid(2), '+b', 'MarkerSize' ,4)
%end

%imwrite(apf_bw, 'threshold.png');

end

