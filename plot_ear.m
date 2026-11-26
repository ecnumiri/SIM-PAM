    %% PLOT
    clc, clear all
    high_crop = norm1(imread('.\ear\data\Stack1.tif',2));
    low_crop =  norm1(imread('.\ear\data\Stack1.tif',1));
    % high_crop = imresize(high_crop,[346,346]);
    % low_crop = imresize(low_crop,[346,346]);
    x = [543*2 546*2];  % 列坐标
    y = [149*2 176*2];   % 行坐标
    
    figure(1)
    imagesc(high_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    figure(2)
    imagesc(low_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    
    % 提取沿线的灰度值
    profile_values1 = norm1(improfile(high_crop, x, y));
    profile_values2 = norm1(improfile(low_crop, x, y));
    
    figure(3)
    dx3 = 0.820;    % μm
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
    xticks(min(x3):20:max(x3)+1);   % x 轴每 5 μm 显示一个刻度
    yticks(min([profile_values1; profile_values2]):0.5:max([profile_values1; profile_values2])); % y 轴每 10 显示一个刻度
    xticklabels([]);
    yticklabels([]);
    % 设置坐标轴字体大小和加粗
    ax = gca;
    ax.FontSize = 18;      % 字体大小
    % ax.FontWeight = 'bold';% 字体加粗
    box on;
    % legend([h1 h2],{'          ', '        '}, ...
        % 'FontSize', 13, ...
        % 'Location', 'best', ...
        % 'Box', 'off');
    %% PLOT   2
    clc, clear all
    high_crop = norm1(imread('.\ear\data\Stack.tif',1));
    low_crop =  norm1(imread('.\ear\data\Stack.tif',2));
    x = [473 502];  % 列坐标
    y = [182 183];   % 行坐标
    
    figure(1)
    imagesc(high_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    figure(2)
    imagesc(low_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    
    % 提取沿线的灰度值
    profile_values1 = norm1(improfile(high_crop, x, y));
    profile_values2 = norm1(improfile(low_crop, x, y));
    
    figure(3)
    dx3 = 0.820;    % μm
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
    pp = csaps(x3, profile_values1,0.99);
    yfit1 = fnval(pp, xfit);
    yfit2 = interp1(x3,profile_values2,xfit,'spline');
    h1 = plot(xfit,yfit2,'--',...
        'Color',blueColor,...
        'LineWidth',3);
    h2 = plot(xfit,yfit1,'-',...
        'Color',redColor,...
        'LineWidth',3);
    
    xlim([min(x3) max(x3)]);
    ylim([min([profile_values1; profile_values2]) max([profile_values1; profile_values2])+0.25]);
    xticks(min(x3):10:max(x3)+1);   % x 轴每 5 μm 显示一个刻度
    yticks(min([profile_values1; profile_values2]):0.5:max([profile_values1; profile_values2])); % y 轴每 10 显示一个刻度
    xticklabels([]);
    yticklabels([]);
    % 设置坐标轴字体大小和加粗
    ax = gca;
    ax.FontSize = 18;      % 字体大小
    % ax.FontWeight = 'bold';% 字体加粗
    box on;
    % legend([h1 h2],{'          ', '        '}, ...
        % 'FontSize', 13, ...
        % 'Location', 'best', ...
        % 'Box', 'off');
    
        %% PLOT   3
    clc, clear all
    high_crop = norm1(imread('.\ear\data\Stack.tif',1));
    low_crop =  norm1(imread('.\ear\data\Stack.tif',2));
    x = [596 616];  % 列坐标
    y = [325 324];   % 行坐标
    
    figure(1)
    imagesc(high_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    figure(2)
    imagesc(low_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    
    % 提取沿线的灰度值
    profile_values1 = norm1(improfile(high_crop, x, y));
    profile_values2 = norm1(improfile(low_crop, x, y));
    
    figure(3)
    dx3 = 0.820;    % μm
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
    pp = csaps(x3, profile_values1,0.99);
    yfit1 = fnval(pp, xfit);
    yfit2 = interp1(x3,profile_values2,xfit,'spline');
    h1 = plot(xfit,yfit2,'--',...
        'Color',blueColor,...
        'LineWidth',3);
    h2 = plot(xfit,yfit1,'-',...
        'Color',redColor,...
        'LineWidth',3);
    
    xlim([min(x3) max(x3)]);
    ylim([min([profile_values1; profile_values2]) max([profile_values1; profile_values2])+0.25]);
    xticks(min(x3):5:max(x3)+1);   % x 轴每 5 μm 显示一个刻度
    yticks(min([profile_values1; profile_values2]):0.5:max([profile_values1; profile_values2])); % y 轴每 10 显示一个刻度
    xticklabels([]);
    yticklabels([]);
    % 设置坐标轴字体大小和加粗
    ax = gca;
    ax.FontSize = 18;      % 字体大小
    % ax.FontWeight = 'bold';% 字体加粗
    box on;
    % legend([h1 h2],{'          ', '        '}, ...
        % 'FontSize', 13, ...
        % 'Location', 'best', ...
        % 'Box', 'off');
    
    
            %% PLOT   4
    clc, clear all
    high_crop = norm1(imread('.\ear\data\Stack.tif',1));
    low_crop =  norm1(imread('.\ear\data\Stack.tif',2));
    x = [153 177];  % 列坐标
    y = [479 481];   % 行坐标
    
    figure(1)
    imagesc(high_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    figure(2)
    imagesc(low_crop)
    hold on 
    plot(x, y, 'r-', 'LineWidth', 2);
    
    % 提取沿线的灰度值
    profile_values1 = norm1(improfile(high_crop, x, y));
    profile_values2 = norm1(improfile(low_crop, x, y));
    
    figure(3)
    dx3 = 0.820;    % μm
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
    pp = csaps(x3, profile_values1,0.99);
    yfit1 = fnval(pp, xfit);
    yfit2 = interp1(x3,profile_values2,xfit,'spline');
    h1 = plot(xfit,yfit2,'--',...
        'Color',blueColor,...
        'LineWidth',3);
    h2 = plot(xfit,yfit1,'-',...
        'Color',redColor,...
        'LineWidth',3);
    
    xlim([min(x3) max(x3)]);
    ylim([min([profile_values1; profile_values2]) max([profile_values1; profile_values2])+0.25]);
    xticks(min(x3):10:max(x3)+1);   % x 轴每 5 μm 显示一个刻度
    yticks(min([profile_values1; profile_values2]):0.5:max([profile_values1; profile_values2])); % y 轴每 10 显示一个刻度
    xticklabels([]);
    yticklabels([]);
    % 设置坐标轴字体大小和加粗
    ax = gca;
    ax.FontSize = 18;      % 字体大小
    % ax.FontWeight = 'bold';% 字体加粗
    box on;
    % legend([h1 h2],{'          ', '        '}, ...
        % 'FontSize', 13, ...
        % 'Location', 'best', ...
        % 'Box', 'off');