clear;clc;

folder='.\melanin\data\results';
files=dir(fullfile(folder,'*WF.tif'));
% 提取文件名中的数字
num=zeros(length(files),1);
for i=1:length(files)
    name=files(i).name;
    % 找数字
    temp=regexp(name,'\d+','match');
    num(i)=str2double(temp{1});
end
% 按数字排序
[~,idx]=sort(num);
files=files(idx);
% 读取
N=length(files);
imgs=cell(N,1);
for i=1:N
    fprintf('%d : %s\n',i,files(i).name);
    imgs{i}=norm1(double(imread(fullfile(folder,files(i).name))));
end

%% 参数
img_size=384;
overlap=76;
step=img_size-overlap;

% 输出大小
out_size_y = 3*img_size-2*overlap;
out_size_x = 4*img_size-3*overlap;

result=zeros(out_size_y,out_size_x);
weight=zeros(out_size_y,out_size_x);
%% 生成单张图权重模板
W = ones(img_size,img_size);
% 水平方向羽化
wx=ones(1,img_size);
% 左右76像素渐变
wx(1:overlap)=linspace(0,1,overlap);
wx(end-overlap+1:end)=linspace(1,0,overlap);
% 垂直方向羽化
wy=ones(img_size,1);
wy(1:overlap)=linspace(0,1,overlap)';
wy(end-overlap+1:end)=linspace(1,0,overlap)';
% 二维权重
W=wy*wx;
%% 拼接 3×4
for k=1:12
    % 当前图位置
    row=floor((k-1)/4);
    col=mod(k-1,4);

    y=row*step+1;
    x=col*step+1;

    img=imgs{k};

    % 加权累积
    result(y:y+img_size-1,x:x+img_size-1) = ...
        result(y:y+img_size-1,x:x+img_size-1)+img.*W;

    weight(y:y+img_size-1,x:x+img_size-1) = ...
        weight(y:y+img_size-1,x:x+img_size-1)+W;
end

%% 归一化
result=result./weight;

figure;
imagesc(result);
axis image;
colormap hot;

% imwrite((result),'stitched_feather.tif');