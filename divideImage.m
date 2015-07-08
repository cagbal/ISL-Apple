function [ I_out ] = divideImage( I, opt)
%DIVIDEIMAGE This function divides image into pieces as specified in input
%arguements and scale each piece to original image
%
% Input:
% I: Image
% opt: option can be 'four'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Cagatay Odabasi                             %
%                        cagatayodabasi91@gmail.com                       %
%                       Intelligent Systems Labratory                     %
%                           Bogazici University                           %                        
%                                08.07.2015                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(opt, 'four')
    I_tmp(:,:,:,1) = I(1:size(I,1)/2, 1 : size(I,2)/2,: ); % 1st piece
    
    I_tmp(:,:,:,2) = I(1:size(I,1)/2 ,...
        size(I,2)/2 + 1 : size(I,2),: ); % 2nd piece
    
    I_tmp(:,:,:,3) = I(size(I,1)/2 + 1: size(I,1),...
        1 : size(I,2)/2,: ); % 3rd piece
    
    I_tmp(:,:,:,4) = I(size(I,1)/2 + 1 : size(I,1) ,...        
        size(I,2)/2 +1 : size(I,2),: ); % 4th piece
    
    % Scale the images 
    I_out(:,:,:,1) = imresize(I_tmp(:,:,:,1),size(I,1)/size(I_tmp,1));
    I_out(:,:,:,2) = imresize(I_tmp(:,:,:,2),size(I,1)/size(I_tmp,1));
    I_out(:,:,:,3) = imresize(I_tmp(:,:,:,3),size(I,1)/size(I_tmp,1));
    I_out(:,:,:,4) = imresize(I_tmp(:,:,:,4),size(I,1)/size(I_tmp,1));
end

end

