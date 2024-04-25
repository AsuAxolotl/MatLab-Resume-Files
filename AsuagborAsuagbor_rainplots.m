%AsuagborAsuagbor_rainplots.m
%ENGR1140 Asuagbor Asuagbor, 2/27/2024
%Rainfall Data Analysis
clear; close all; clc; format short;
rain_data=readmatrix('Rainy.xlsx'); %read the rain data
rainfall=rain_data(1:32,2:13);
quarterly_rainfall(1:32,1)= sum(rainfall(1:32,1:3),2);
quarterly_rainfall(1:32,2)= sum(rainfall(1:32,4:6),2);
quarterly_rainfall(1:32,3)= sum(rainfall(1:32,7:9),2);
quarterly_rainfall(1:32,4)= sum(rainfall(1:32, 10:12),2);
average_quarterly_rainfall=mean(quarterly_rainfall,1);
disp('Average quarterly rainfall (inches) 1990-2021')
disp(' Jan-Mar Apr-Jun Jul-Sept Oct-Dec')
disp(average_quarterly_rainfall);
%Bar plot of average quarterly rainfall
figure(1);
bar(1:4,average_quarterly_rainfall, 'b');
set(gca,'xtick',1:4,'xticklabel',{'Quarter 1','Quarter 2','Quarter 3','Quarter 4'});
title('Average Quarterly Rainfall for Athens GA');
ylabel('Rainfall (inches)');
axis([0,5,0,16]);
%Pie chart of average quarterly rainfall
figure(2);
pie(average_quarterly_rainfall); colormap jet;
title('Percent Annual Rainfall by Quarter, for Athens GA');
legend('Quarter 1','Quarter 2','Quarter 3','Quarter 4');
%Line plot of total rainfall for each year
figure(3)
rain_tot_by_year= sum(rainfall,2);
years=[1990:1:2021]; %vector of years 1990-2021
plot(years,rain_tot_by_year,'b*-');
set(gca,'xtick',1990:3:2021)
xlabel('Year');
ylabel('Total rainfall (inches)');
title('Yearly rainfall for Athens GA')