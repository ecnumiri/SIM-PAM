clc,clear all,close all

img_wf(:,:,1) = imread('.\ear\data\SPI_1_wf.tif');
img_wf(:,:,2) = imread('.\ear\data\SPI_2_wf.tif');
pixelSize1 = 0.82; % 例如 65 nm / pixel
[FRCvalue1,freq1] = frc_analysis(img_wf(:,:,1), img_wf(:,:,2), pixelSize1);

pixelSize2 = 0.41;
img_sim_re(:,:,1) = imread('.\ear\data\SPI_1_SIM.tif');
img_sim_re(:,:,2) = imread('.\ear\data\SPI_2_SIM.tif');
[FRCvalue2,freq2] = frc_analysis(img_sim_re(:,:,1), img_sim_re(:,:,2), pixelSize2);

close all
figure;
hold on;
blueColor = [0 0.4470 0.7410];
redColor  = [0.8500 0.3250 0.0980];
curve1(:,1) = FRCvalue1;
curve1(:,2) = freq1;
curve2(:,1) = FRCvalue2;
curve2(:,2) = freq2;
plot(curve2(:,2), curve2(:,1), ...
    'Color', redColor, ...
    'LineWidth', 3);
plot(curve1(:,2), curve1(:,1), ...
    'Color', blueColor, ...
    'LineWidth', 3);
ax = gca;
ax.FontSize = 18;    
xticklabels([]);
yticklabels([]);
xlim([0 1.3])
box on;
xticks(0:0.5:1.5);   % x 轴每 5 μm 显示一个刻度
yticks(0:0.5:1.5); % y 轴每 10 显示一个刻度

%%
%% ===== 根据FRC结果画频率环（每组挑一张图） =====
th = 1/7;

% 找到首次下降到1/7的位置
idx1 = find(FRCvalue1 < th, 1, 'first');
idx2 = find(FRCvalue2 < th, 1, 'first');

if isempty(idx1)
    error('WF的FRC曲线没有下降到1/7，无法画频率环');
end
if isempty(idx2)
    error('SIM的FRC曲线没有下降到1/7，无法画频率环');
end

fc1 = freq1(idx1);   % WF cutoff frequency
fc2 = freq2(idx2);   % SIM cutoff frequency

% 取每组的第一张图
img1 = double(img_wf(:,:,1));
img2 = double(img_sim_re(:,:,2));

% 去直流
img1 = img1 - mean(img1(:));
img2 = img2 - mean(img2(:));

% FFT
F1 = fftshift(fft2(img1));
F2 = fftshift(fft2(img2));

[M1,N1] = size(img1);
[M2,N2] = size(img2);

% 频率坐标（单位：1/um）
fx1 = ((0:N1-1) - floor(N1/2)) / (N1*pixelSize1);
fy1 = ((0:M1-1) - floor(M1/2)) / (M1*pixelSize1);

fx2 = ((0:N2-1) - floor(N2/2)) / (N2*pixelSize2);
fy2 = ((0:M2-1) - floor(M2/2)) / (M2*pixelSize2);

% 画圆
theta = linspace(0, 2*pi, 500);
xc1 = fc1*cos(theta);
yc1 = fc1*sin(theta);

xc2 = fc2*cos(theta);
yc2 = fc2*sin(theta);

figure('Color','w','Position',[200 200 1000 420]);

%% ========== Inferno Colormap ==========
% MATLAB R2019没有内置inferno，这里使用采样颜色插值生成

infernoAnchor = [
    0.0015  0.0005  0.0139
    0.0423  0.0281  0.1411
    0.1293  0.0473  0.2908
    0.2383  0.0366  0.3964
    0.3415  0.0623  0.4294
    0.4412  0.0993  0.4316
    0.5409  0.1347  0.4151
    0.6401  0.1714  0.3811
    0.7357  0.2159  0.3302
    0.8224  0.2752  0.2661
    0.8943  0.3534  0.1936
    0.9470  0.4492  0.1153
    0.9784  0.5579  0.0349
    0.9879  0.6753  0.0653
    0.9746  0.7977  0.2063
    0.9476  0.9174  0.4107
    0.9884  0.9984  0.6449
];

infernoMap = interp1( ...
    linspace(0,1,size(infernoAnchor,1)), ...
    infernoAnchor, ...
    linspace(0,1,256), ...
    'linear');

%% ========== 绘图参数 ==========

figure('Color','w','Position',[200 200 1000 420]);
%% ========== WF ==========
subplot(1,2,1);

imagesc(fx1, fy1, log1p(abs(F1)));

axis image;
axis xy;
hold on;

xlim([min(fx1), max(fx1)]);
ylim([min(fy1), max(fy1)]);

% 截止频率环
plot(xc1, yc1, 'c-', 'LineWidth', 2);

% 去除所有文字、刻度及数字，保留边框
set(gca, 'XTick', [], 'YTick', [], ...
         'XColor', 'k', 'YColor', 'k', ...
         'LineWidth', 1.2);

box on;

%% ========== SIM ==========
subplot(1,2,2);

imagesc(fx2, fy2, log1p(abs(F2)));

axis image;
axis xy;
hold on;

% 截止频率环
plot(xc2, yc2, 'c-', 'LineWidth', 2);

% 去除所有文字、刻度及数字，保留边框
set(gca, 'XTick', [], 'YTick', [], ...
         'XColor', 'k', 'YColor', 'k', ...
         'LineWidth', 1.2);

box on;

%% ========== 统一 Inferno Colormap ==========
colormap(gcf, infernoMap);