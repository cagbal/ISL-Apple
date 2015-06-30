clear all
close all 
clc 

tic 


I = imread('483454389_3b90aa495d_b.jpg');

sal_map = TDApple(I); 

minima = findMinima(sal_map);

% threshold for distance of two minima
threshold_minima = 100;

% preprocessing 
minima = removeDuplicateMinimum( minima, threshold_minima );

[apf_modified, path,  fixation_points] = ...
    findPath(sal_map, minima, 500, 50, 45, I);

toc