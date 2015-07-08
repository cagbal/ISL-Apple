function [ apf_modified, path,  fixation_points] = findPath( apf,...
    minima, x, y,...
    sigma, gamma_usr, I )
%findPATH modifies the APF by multiplying it with a 2D Gaussian
%   2D Gaussian is used to get a clear path between objects with respect
%   to their distance to current fovea.
% Input:
% apf : artificial potential function
% minima : centroids of contours
% initial x
% initial y
% sigma : variance of Gaussian
% gamma_usr : learning rate
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
    gauss = (minima(i).Area^1.3)*gaussian(a,b, minima(i).Centroid(1),...
        minima(i).Centroid(2),sigma);
    
    
    apf_modified = apf_modified + gauss;
end


 figure
 imagesc(apf_modified);
% imagesc(I);
% title('modified APF')
%
%
hold on

% set gamma as user desired value
gamma = gamma_usr;

i = 0;
while(1)    
    % Optimization
    [FX, FY] = gradient(apf_modified);
    
    % calculate the difference of x and y
    dx = gamma*2*sign(FX(round(y),round(x)));
    dy = gamma*2*sign(FY(round(y),round(x)));
    
    % if energy function is stuck
    if dx == 0 && dy == 0
        dx = 2*sign(~(x > size(FX,2)/2)-0.5);
        dy = 2*sign(~(y > size(FX,1)/2)-0.5);
    elseif i > 4 
        if path(end - 3) == path(end-1) 
            dx = - dx_prev;
            dy = - dy_prev;
        elseif norm([FX(round(y),round(x)) FY(round(y),round(x))]) < 10e-19
            dx = 2*sign(~(x > size(FX,2)/2)-0.5);
            dy = 2*sign(~(y > size(FX,1)/2)-0.5);
        else
            % set gamma as user desired value
            gamma = gamma_usr;
        end
    end
   
    % update the coordinates
    x = x + dx;
    y = y + dy;
    
    % add new coordinates to path
    path = [path; x,y];
    %imagesc(apf_modified);
    %title('modified APF');
    
    hold on
    
    plot(x,y,'b.', 'MarkerSize', 4)
    
    %hold off
    
    i = i + 1;
    
    for j = 1 : length(minima)
        if norm([x y]' - minima(j).Centroid') < 5
                  
            if (~ismember( [minima(j).Centroid(1), minima(j).Centroid(2) ],...
                    fixation_points, 'rows' ))
                % inhibit it by subtracting a 2D Gaussian
                % and try to search a new fixation point
                % calculate the 2D gaussian
                gauss = minima(j).Area.^1.3*gaussian(a, b,...
                    minima(j).Centroid(1), minima(j).Centroid(2), sigma);
                
                
                % subtract the gaussian
                apf_modified = apf_modified - gauss;
                
                % add new fixation points to database
                fixation_points = [fixation_points;...
                    minima(j).Centroid(1), minima(j).Centroid(2)];
                
                % Draw a rectangle 
                rectangle('Position',...
                    [fixation_points(end,1) - 20,...
                    fixation_points(end,2) - 20, 40 40]);
            end
        end
    end
    
    % save the previous dx and dy values
    dx_prev = dx;
    dy_prev = dy;
end

end


