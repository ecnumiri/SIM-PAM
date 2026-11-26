%% ====== 基本参数 ======
clear all;clc;close all;
addpath (genpath('.\functions\Hadamard-single-pixel-imaging-main'))
addpath (genpath('.\functions\saveastiff-master\'))
filename = '.\ball\data\data_bin';      % 你的数据文件()名
channelCount = 1;                   % 双通道
bin=3;
round_num=1;
round_num_sim = 9;
npixels=64; 
T=6;

% records_num=ceil(2*npixels*npixels/100)*100;
% records_num_effective=2*npixels*npixels;

records_num_effective=2*npixels*npixels;
records_num=records_num_effective;
records_length=512;  % pre+post
method = 'fwht';

N=npixels*npixels;
dim = log2(npixels);
nStep=2;

nStep = 2;
% Get the order matrix
PathMat = zigzag(npixels);
nCoeft = npixels^2;

%% ====== 读取原始二进制 ======
data = zeros(records_length,channelCount*records_num);
cha = zeros(records_length,records_num, round_num);
chb = zeros(records_length,records_num, round_num);
chA = zeros(records_num_effective,round_num);
chB = zeros(records_num_effective,round_num+1);
target = zeros(npixels,npixels,3,3);
% target_result = zeros(npixels,npixels,round_num_sim);
b=zeros(npixels*bin,npixels*bin,round_num_sim);
for roi = 1:4
    for i = 1:round_num_sim
        i
        for m = 1:3
            for n = 1:3
                for j =1:round_num
                    filename_cat=[filename,num2str(bin),'_fwht_npixel',num2str(npixels),'_T',num2str(T),'_roi',num2str(roi),'_i',num2str(i),'_mn',num2str(m),num2str(n),'.bin'];
                    % filename_cat=[filename,num2str(bin),'_fwht_npixel',num2str(npixels),'_T',num2str(T),'_roi',num2str(roi),'_i',num2str(i),'_mn',num2str(m),num2str(n),'_j',num2str(j),'.bin'];
                    fprintf('%s\n',filename_cat);
                    fid = fopen(filename_cat, 'rb');
                    % fprintf(['round_',num2str(j),'\n']);
                    
                    if fid == -1
                        error('无法打开文件 %s', filename_cat);
                    end
                    raw = zeros(channelCount*records_length*records_num,1);
                    raw = fread(fid, 'uint16');  % 仍然按16bit读取
                    fclose(fid);
                    raw = bitshift(raw, -4);
                    
                        %% ====== 归一化 交错分离通道 ======
                    data(:,:) = reshape(raw, records_length, []);  % N×2
                    % data(:,:) = data(:,[11:end 1:10]);
                    % data(:,:,j) = data(:,[9:end 1:8],j);
                    % data=(data-2048)/2048;
                    % cha(:,1:records_num,j) = data(:,1:2:end,j);
                    % cha = cha(:,1:end-(records_num-records_num_effective),:);
                    % chb(:,1:records_num,j) = data(:,2:2:end,j);
                    % chb = chb(:,1:records_num_effective,:);
                    % [chA(:,j),index] = max(cha(:,:,j),[],1);
                    % 
                    % tmp(:,1:records_num,j) = data(:,1:2:end);
                    % cha = tmp(:,1:end-(records_num-records_num_effective),:);
                    % chA(:,j) = mean(cha(:,:,j),1);
                    % chA(:,j) = (chA(:,j)-min(chA(:,j)))/max(chA(:,j)-min(chA(:,j)));
                    % chB(:,j) = mean(chb(:,:,j),1);
                    % for kk = 1:records_num_effective
                    %     % chB(kk,j) = max(chb(index(kk)-10:index(kk)+10,kk,j),[],1);
                    %     chB(kk,j) = max(chb(6509-10:6509+10,kk,j),[],1);
                    % end
                    % figure(1)
                    % subplot(2,2,1),plot(chA(:,j))
                    % subplot(2,2,2),plot(cha(:,1,j)),subplot(2,2,3),plot(cha(:,2,j)),subplot(2,2,4),plot(cha(:,3,j))
                    % figure(2)
                    % subplot(2,2,1),plot(chB(:,j))
                    % subplot(2,2,2),plot(chb(:,1,j)),subplot(2,2,3),plot(chb(:,2,j)),subplot(2,2,4),plot(chb(:,3,j))
                    % figure(3)
                    % imagesc(chb(:,:,j))
                    % Get the path matrix

                    % cha(:,1:records_num,j) = data(:,1:2:end,j);
                    cha(:,1:records_num,j) = data(:,1:end,j);
                    cha = cha(:,1:end-(records_num-records_num_effective),:);
                    % chb(:,1:records_num,j) = data(:,2:2:end,j);
                    % chb = chb(:,1:records_num_effective,:);
                    [chA(:,j),index] = max(cha(210:220,:,j),[],1);
                    
                    % tmp(:,1:records_num,j) = data(:,1:2:end);
                    % cha = tmp(:,1:end-(records_num-records_num_effective),:);
                    % chA(:,j) = mean(cha(:,:,j),1);
                    % chA(:,j) = (chA(:,j)-min(chA(:,j)))/max(chA(:,j)-min(chA(:,j)));
                    % chA = norm1(chA-(2048));
                    for iCoeft = 1:nCoeft
                         [iRow, jCol] = find(PathMat == iCoeft);
                        for iStep = 1:nStep
                            IntensityMat(iRow,jCol,iStep,j) = chA(2*(iCoeft-1)+iStep,j);
                        end
                    end
                end
                    %% 求解
                    % M(:,j) = M(:,j)-0.01;
                    % M(:,j) = M(:,j)/max(abs(M(:,j)));
                    % Reconstruct object
                switch lower(method)
                    case 'fwht'
                        IntensityMat(:,:,:,j) = mean(IntensityMat,4);
                        fprintf('Using FWHT reconstruction...\n');
                        [target(:,:,m,n,i), spec] = getHSPIReconstruction( IntensityMat(:,:,:,end), nStep );
                        target(:,:,m,n,i) = target(:,:,m,n,i)*chA(1);
                    case 'tval3'
                        fprintf('Using TVAL reconstruction...\n');
            
                        opts.mu = 2^8;
                        opts.beta = 2^5;
                        opts.tol = 1E-3;
                        opts.maxit = 300;
                        opts.TVnorm = 1;
                        opts.disp = false;
                        opts.TVL2 = true;
                        [target(:,:,j), ~] = TVAL3(Ht, M(:,j), npixels, npixels, opts);
                        target = abs(target);
                    otherwise
                        error('Unknown method: choose "fwht" or "tval".');
    
                    % target(target<0) = 0;
                    % target(:,:,j) = normalize_matrix(target(:,:,j));
                    % figure(1)
                    % subplot(round_num,round_num_sim,(j-1)*round_num_sim+i);
                    % plot(chB(:,j)),title(sprintf('No. %d, j = %d', i, j))
                end
                figure(2)
                subplot(9,round_num_sim,(n+3*(m-1)-1)*(round_num_sim)+i);
                target(target<0)=0;
                fprintf('\n====No. %d, mn = %d%d====\n', i, m,n)
                imagesc(target(:,:,m,n,i));title(sprintf('No. %d, mn = %d%d', i, m,n))
                % a(:,:,m,n,i)=target(:,:,m,n);
            end
        end
    
        for m=1:3
            for n=1:3
                b(m:3:end,n:3:end,i)=target(:,:,m,n,i);
                b(m:3:end,n:3:end,i)=target(:,:,m,n,i);
                b(m:3:end,n:3:end,i)=target(:,:,m,n,i);
            end
        end
        figure(3)
        subplot(3,3,i)
        imagesc(b(:,:,i))
        % imshow(b,[])
    
        % %% 求解
        % 
        % switch lower(method)
        %     case 'fwht'
        %         fprintf('Using FWHT mean reconstruction...\n');
        %         IntensityMat(:,:,:,j+1) = mean(IntensityMat,4);
        %         [target(:,:,j+1), spec] = getHSPIReconstruction( IntensityMat(:,:,:,end), nStep );
        % 
        %     case 'tval'
        %         fprintf('Using TVAL reconstruction...\n');
        % 
        %         opts.mu = 2^8;
        %         opts.beta = 2^5;
        %         opts.tol = 1E-3;
        %         opts.maxit = 300;
        %         opts.TVnorm = 1;
        %         opts.disp = false;
        %         opts.TVL2 = true;
        %         [target(:,:,j+1), ~] = TVAL3(Ht, M(:,j+1), npixels, npixels, opts);
        % 
        %     otherwise
        %         error('Unknown method: choose "fwht" or "tval".');
        % end
        % % % [target_avera] = reshape((1/N)*Ht'*M(:,j+1),[2^dim 2^dim]);
        % % target_avera(target_avera<0)=0;
        % % target_avera = normalize_matrix(target_avera);
        % % target(:,:,round_num+1) = target_avera;
        % %  % imagesc(target(:,:,end))
        % 
        %     %% ====== 绘图 ======
        % for j = 1:round_num+1
        %     figure(3)
        %     subplot(round_num+1,round_num_sim,(j-1)*round_num_sim+i);
        %     plot(chB(:,j));title(sprintf('No. %d, j = %d', i, j))
        %     figure(4)
        %     subplot(round_num+1,round_num_sim,(j-1)*round_num_sim+i);
        %     imagesc(IntensityMat(:,:,1,j));title(sprintf('No. %d, j = %d', i, j))
        % 
        %     target_norm(:,:,j) = target(:,:,j);
        %     target_norm(target_norm<0) = 0;
        %     target_norm(1,1,j) = 0;
        %     target_norm(:,:,j) = normalize_matrix(target_norm(:,:,j));
        % 
        %     figure(5)
        %     subplot(round_num+1,round_num_sim,(j-1)*round_num_sim+i);
        %     imagesc(target_norm(:,:,j));title(sprintf('No. %d, j = %d', i, j))
        % end
        % target_result(:,:,i) = target_norm(:,:,round_num+1);
    end
    savefile=strcat('.\ball\sub\orig\roi_',num2str(roi),'.tif');
    options.overwrite = false;
    saveastiff(b(:,:,:),savefile,options);
end

