function [ apf_modified, path ] = findPath( apf, minima, x, y )
%findPATH modifies the APF by multiplying it with a 2D Gaussian
%   2D Gaussian is used to get a clear path between objects with respect
%   to their distance to current fovea.
% Input:
% apf : artificial potential function
% minima : centroids of contours
% initial x
% initial y
% Output:
% modified_apf
% path : path to follow
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

% initialize path
path = [];

% initialize fixation points
fixation_points = [x, y];

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


hold on
i = 0;
while(1)
    % Optimization
    [FX, FY] = gradient(apf_modified);
    
    % calculate the difference of x and y
    dx = 2*sign(FX(round(y),round(x)));
    dy = 2*sign(FY(round(y),round(x)));
    
    % update the coordinates
    x = x + dx;
    y = y + dy;
    
    % add new coordinates to path
    path = [path; x,y];
    
    
    %imagesc(apf_modified);
    %title('modified APF')
    %hold off
    
    %hold on
    
    plot(x,y,'r.')
    
    i = i + 1;
    
    % control the end of the algorithm
    if (i >= 3)
        if ((path(end, 1) == path(end-2,1)) && ...
                (path(end, 2) == path(end-2,2)))
            
            % a new fixation point is found
            
            % prevent double hit to a same fixation point
            if (~ismember( [x-40:x+40; y-40:y+40 ]',fixation_points, 'rows' ))
                
                % inhibit it by subtracting a 2D Gaussian
                % and try to search a new fixation point
                % calculate the 2D gaussian
                gauss = gaussian(a, b, x, y, sigma);
                
                % subtract the gaussian
                apf_modified = apf_modified - gauss;
                
                % add new fixation points to database
                fixation_points = [fixation_points; x, y];
            end
            
            
        end
    end
    
    
end

end


