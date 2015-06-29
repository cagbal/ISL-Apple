clear all
close all 
clc 

tic 

 I = imread('483454389_3b90aa495d_b.jpg');

sal_map = TDApple(I); 

minima = findMinima(sal_map);

findPath(sal_map, minima);

toc