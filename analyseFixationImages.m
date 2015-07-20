function [  ] = analyseFixationImages( I_f, disk_size)
%analyseFixationImages analyses the fixation point images
% Input:
% I_f: cell array that contains fixation point images
% disk_size: of morphological closing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        
%                                13.06.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initialize number of apples 
apple_qty = 0;

for i = 1 : size(I_f,2)
    % apply apple detection to each fixation point
    sal_map = TDApple(I_f{i});
    
    % create new figure
    %figure
    
    % find the minima of for apple detection
    minima = findMinima(sal_map, disk_size);
    
    % count the apples
    apple_qty = apple_qty + size(minima,1);
    
    %figure 
    
    %imshow(sal_map)
end

% create the string to print result
str_to_write = sprintf('%d apples found!', apple_qty);

% print result
disp(str_to_write)

end

