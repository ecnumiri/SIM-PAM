%% PLOT
clc, clear all
high_crop = norm1(imread('.\melanin\Stack.tif',1));
low_crop =  norm1(imread('.\melanin\Stack.tif',2));
x = [245 258];  % 列坐标
y = [401 420];   % 行坐标

figure(1)
imagesc(high_crop)
hold on 
plot(x, y, 'r-', 'LineWidth', 2);
figure(2)
imagesc(low_crop)
hold on 
plot(x, y, 'r-', 'LineWidth', 2);

profile_values1 = norm1(improfile(high_crop, x, y));
profile_values2 = norm1(improfile(low_crop, x, y));

figure(3)
dx3 = 0.820;   
x3 = (0:length(profile_values1)-1) * dx3;
blueColor = [0 0.4470 0.7410];
redColor  = [0.8500 0.3250 0.0980];

plot(x3, profile_values2, 'd', ...
    'MarkerSize', 7, ...
    'LineWidth', 1.5, ...
    'MarkerFaceColor', 'none', ...
    'MarkerEdgeColor', blueColor, ...
    'LineStyle', 'none');
hold on;
plot(x3, profile_values1, 'o', ...
    'MarkerSize', 7, ...
    'LineWidth', 1.5, ...
    'MarkerFaceColor', redColor, ...
    'MarkerEdgeColor', redColor, ...
    'LineStyle', 'none');
hold on;

xfit = linspace(min(x3),max(x3),1000);
pp = csaps(x3, profile_values1,0.986);
yfit1 = fnval(pp, xfit);
yfit2 = interp1(x3,profile_values2,xfit,'spline');
h1 = plot(xfit,yfit2,'--',...
    'Color',blueColor,...
    'LineWidth',3);
h2 = plot(xfit,yfit1,'-',...
    'Color',redColor,...
    'LineWidth',3);

xlim([min(x3) max(x3)]);
ylim([min([profile_values1; profile_values2]) max([profile_values1; profile_values2])+0.28]);
xticks(min(x3):5:max(x3)+1);   
yticks(min([profile_values1; profile_values2]):0.5:max([profile_values1; profile_values2]));
xticklabels([]);
yticklabels([]);
ax = gca;
ax.FontSize = 18;     
box on;