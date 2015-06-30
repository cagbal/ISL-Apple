function [ minima ] = removeDuplicateMinimum( minima, threshold )
%REMOVEDUPLICATEMINIMUM Detects minumum closer than a threshold and removes
% one of them from set
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        %
%                                25.06.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%*****************************NEEDS OPTIMIZATION***************************

j = 1;
i = 1;

while i <= length(minima)
    while j <=  length(minima)
        
        if ~(i == j)
            if(norm([minima(i).Centroid(1) minima(i).Centroid(2)]' - ...
                    [minima(j).Centroid(1) minima(j).Centroid(2)]') < threshold)
                minima(j) = [];
            end
        end
        
        j = j + 1;
    end
    
    j = 1;
    i = i + 1;
end

end

