%
clear all;clc;
addpath '.\functions\Single-Pixel-Imaging-master'
addpath (genpath('..\Hadamard-single-pixel-imaging-main\'))
addpath (genpath('.\SIM_package\'))
%%
nRows = 768;
nCols = 1024;
nPixels = 128;
binning = 6;
nframes = 2*nPixels*nPixels;
nframes_full = ceil(nframes/100)*100;
extend = 6;
%% HT pattern Generation
% nStep = 2;
% % Get the order matrix
% PathMat = zigzag(nPixels);
% % Get the path matrix
% nCoeft = nPixels^2;
% tic;
% for iCoeft = 1:nCoeft
%      [iRow, jCol] = find(PathMat == iCoeft);
%     % Show fringe patterns and Capture
%     for iStep = 1:nStep
%         Ht(:,:,2*(iCoeft-1)+iStep) = getHadamardPattern(nPixels, iRow, jCol, -(-1)^iStep);
%         % IntensityMat(iRow,jCol,iStep) = sum(sum(Pattern .* InputImg));
%     end
% end
% % Ht = uint8(Ht * 255);
% save(['.\txt\Ht',num2str(nPixels),'.mat'],'Ht','-v7.3')
%% SIM pattern Generation
load(['.\txt\Ht',num2str(nPixels),'.mat']);
% A=pyAPI_GenSIM9Exp('D:\cpp\DAQ\test\test.tif', 'D:\cpp\DAQ\test\', 'D:\cpp\DAQ\SIM_package', nPixels*binning,T);
% A{10} = ones(nPixels*binning,nPixels*binning);
% Ht(:,:,nframes+1:nframes_full)=0;
% 
binning_ones = uint8(ones(binning));
for i = 1:nframes
    tmp = uint8(Ht(:,:,i));
    tmp1 = kron(tmp, binning_ones);
    Ht1(:,:,i) = tmp1;  % 每帧扩展到128×128
end
Ht1 = uint8(Ht1 * 255);
%% HT-SIM
pattern0 = zeros(nPixels*extend,nCols,nframes_full,'uint8');
% pattern0(2*nPixels+1:3*nPixels,(1024-nPixels)/2+1:(1024+nPixels)/2,1:nframes) = Ht;
pattern0(1:binning*nPixels,1:binning*nPixels,1:nframes) = Ht1;
pattern0 = pattern0(:,:, [end-4:end 1:end-5]);
pattern0(:,:,1:5) = repmat(pattern0(:,:,6),1,1,5);
% pattern1 = pattern0;
% pattern1(:,:,105:end) = 0;

% imshow(A{i},[])
% pattern1 = circshift(pattern1,[m n 0]);
fid = fopen(['./txt/pattern_seq_fwht_sim384_bin', num2str(binning),'_npixel',num2str(nPixels),'.txt'], 'w');
for j = 1:nframes_full
    frame = pattern0(:,:,j);
    %frame = H10catkron(:,:,i);
    fwrite(fid, frame', 'uint8');  % 写入一帧（转置以按行存储）
end
fclose(fid);