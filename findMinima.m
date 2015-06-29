function [ minima ] = findMinima( apf )
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
threshold = 0.1;

% numerical differentiation
%[FY,FX] = gradient(apf);

% apply threshold on apf to get rid of background
apf_bw = im2bw(1-apf, threshold);

% open the image
se = strel('disk',5);
apf_bw = imclose(apf_bw, se);

% get the Connected Components of image
CC = bwconncomp(1- apf_bw);

% get the centroids of CC
minima = regionprops(CC,'Centroid');

% this will be commended out
imagesc(apf_bw);

title('Threshold APF');

end

