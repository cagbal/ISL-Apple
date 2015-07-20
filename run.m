clear all
close all
clc

tic

warning('off','all')

% threshold for distance of two minima
threshold_minima = 100; %50 %100

% disk size of closing operation
disk_size = 5; % 5

% sigma of Gaussians
sigma = 50; %30; %45

% gamma : learning rate of gd
gamma = 1;

% initial x y position
initial_xy = [500, 50];

% 

I_fix = [];

I = imread('n12633994_6351.jpeg');

% Resize the image because the algorithm is optimized for 1024x768 images
I = imresize(I,768/size(I,1));

% Divide image into four same sized images
I_divided = divideImage(I,'four');

for i = 1 : size(I_divided,4)
    
    %figure 
    
    I_divided (:,:,1,i) = medfilt2(I_divided(:,:,1,i),[5 5]);
    I_divided (:,:,2,i) = medfilt2(I_divided(:,:,2,i),[5 5]);
    I_divided (:,:,3,i) = medfilt2(I_divided(:,:,3,i),[5 5]);
    
    
    subplot(2,2,i)
    
    
    %tic
    sal_map = TDApple(I_divided(:,:,:,i));
    
    minima = findMinima(sal_map, disk_size);    
    %toc
    % preprocessing
    minima = removeDuplicateMinimum( minima, threshold_minima );
    
    %figure
    [apf_modified, path,  fixation_points, I_fix, coverage] = ...
        findPath(sal_map, minima, initial_xy(1), initial_xy(2), sigma,...
        gamma, 1500, I_divided(:,:,:,i));
    
    analyseFixationImages( I_fix, disk_size)
    
    coverage
    
end

toc


