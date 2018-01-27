close all;
clear all;
clc;
format long;

sum = double(imread('tm_ch3_summer.tif'));figure; imagesc(sum); colormap gray;title('Summer Image');
win = double(imread('tm_ch3_winter.tif'));figure; imagesc(win); colormap gray;title('Winter Image');
hsum = hist(sum(:), 0:255);figure; bar(hsum);title('Histogram for Summer Image');
hwin = hist(win(:), 0:255);figure; bar(hwin);title('Histogram for Winter Image');
thsum = cumsum(hsum);figure;plot(thsum);title('Cumulative histogram for Summer Image');
thwin = cumsum(hwin);figure;plot(thwin);title('Cumulative histogram for Winter Image');

% define the lookup table
lut = thsum - thsum;
... (fill)
    
    x = length(hwin);
    for i = 1:x
        y = x-1; 
        flag = 1;
        while (flag == 1)
            nhist(i) = y;
            y = y-1;
            if (y>=0 && thwin(i)<=thsum(y+1))
                flag=1;
            else
                flag=0;
            end
        end
    end
    

figure; plot(lut);

% create new image with new intensity
nwin = win - win;
... (to be filled)
    
    [rows,cols] = size(win);
    for i = 1:rows
        for j = 1:cols
            nwin(i,j) = nhist(win(i,j)+1);       
        end
    end

figure; imagesc(nwin);colormap gray;title('Winter Image with contrast according to Summer Image');
hnwin = hist(nwin(:), 0:255); figure; bar(hnwin);title('Histogram of Winter Image with contrast according to Summer Image');