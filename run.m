clear all
close all 
clc 

tic 

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

I = imread('lots_of_apple.jpeg');


% Resize the image because the algorithm is optimized for 1024x768 images
I = imresize(I,768/size(I,1));

sal_map = TDApple(I); 

minima = findMinima(sal_map, disk_size);

% preprocessing 
%minima = removeDuplicateMinimum( minima, threshold_minima );

[apf_modified, path,  fixation_points] = ...
    findPath(sal_map, minima, initial_xy(1), initial_xy(2), sigma, gamma, I);

toc