function [ sal_map ] = TDApple( I )
%TDApple Top Down Apple Color Saliency Feature Detector
%   This function becomes minimum on Apples. For detailed explanation plz
%   refer to: 
%   Artificial potential functions based camera movements and visual
%   ehaviors in attentive robots
% However, this function makes the saturation value of the pixels 2 in
% order  to saliency map to eliminate the sky. 
% Input: 
% RGB image in numeric format
% Output:
% saliency map 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        %
%                                25.06.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%format long

% define the target hue value of apple
hue_target = 0;  % stands for red

% tolerance to zero 
tol = 0.1;

% convert RGB image to HSV
I_hsv = rgb2hsv(I);

% Create a gaussian filter
G = fspecial('gaussian',[5 5],2);

% apply gaussian blur on H value to reduce sharp changes between colors
I_hsv(:,:,1) = imfilter(I_hsv(:,:,1),G,'same');

% calculate Top Down Color Saliency Map
sal_map = (1 + (I_hsv(:,:,1) - hue_target).^2); 

% find the pure white values like shining sun by looking at saturation
[i,j] = find(I_hsv(:,:,2) < tol);

% make 0 each of the highly satured pixels 
for ii = 1 : length(i)
    sal_map(i(ii),j(ii)) = 0;
end

% normalize the map between 0 and 1
sal_map = sal_map ./ max(max(sal_map));

end

