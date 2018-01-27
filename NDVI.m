clc;
clear all;
close all;

ch1 = double(imread('TM-Berlin99_ch1.tif')); figure; imagesc(ch1); colormap gray;
ch2 = double(imread('TM-Berlin99_ch2.tif')); figure; imagesc(ch2); colormap gray;
ch3 = double(imread('TM-Berlin99_ch3.tif')); figure; imagesc(ch3); colormap gray;

%% NDVI
dif = ch3 - ch2;
sum = ch3 + ch2;

rows = size(sum,1);
cols = size(sum,2);

% test if sum ne 0 (division by zero)
for i = 1:rows
    for j = 1:cols
        if sum(i,j)==0
            sum(i,j) = 0.1;
        end
    end
end


ndvi = dif-dif;
for i = 1:rows
    for j = 1:cols
        ndvi(i,j) = dif(i,j)/sum(i,j);
    end
end

figure;
imagesc(ndvi);
colormap(gray);

%% Split NDVI

% number of pixels that can get black value
black = 0;

for i = 1:rows
    for j = 1:cols
        if ndvi(i,j)<=0.03
            ndvi(i,j) = 0;
            black = black + 1;
        else
            ndvi(i,j) = 1;
        end
    end
end

map = [0,0,0;0,1,0];

figure;
imagesc(ndvi);
colormap(map);