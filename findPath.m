function [ apf_modified ] = findPath( apf, minima )
%findPATH modifies the APF by multiplying it with a 2D Gaussian 
%   2D Gaussian is used to get a clear path between objects with respect
%   to their distance to current fovea. 
% Input: 
% apf : artificial potential function 
% minima : centroids of contours
% Output: 
% modified_apf
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        %
%                                25.06.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sigma 
sigma = 25;

% initialize 
apf_modified = zeros(size(apf, 1), size(apf,2));

% Multiply each minimum with 2D Gaussian function
for i = 1 : length(minima)
    % Create meshgrid
    [a, b] = meshgrid([1 : size(apf,2)], [1 : size(apf,1)]);
    
    % calculate the 2D gaussian 
    gauss = gaussian(a,b, minima(i).Centroid(1),...
        minima(i).Centroid(2),sigma);
    
    apf_modified = apf_modified + gauss;
end

figure
imagesc(apf_modified);
title('modified APF')

end


