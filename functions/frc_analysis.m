function [frc_curve,freq] = frc_analysis(img1, img2, pixelSize)

% =========================
% FRC analysis for 2 images
% =========================
% img1, img2 : two reconstructed SIM images
% pixelSize  : physical pixel size (e.g. um/pixel)
% =========================

img1 = double(img1);
img2 = double(img2);

% ensure same size
assert(all(size(img1)==size(img2)), 'Images must have same size');

% remove DC
img1 = img1 - mean(img1(:));
img2 = img2 - mean(img2(:));

% Fourier transform
F1 = fftshift(fft2(img1));
F2 = fftshift(fft2(img2));

[M, N] = size(img1);
cx = floor(N/2)+1;
cy = floor(M/2)+1;

% frequency grid
[x, y] = meshgrid(1:N, 1:M);
r = sqrt((x-cx).^2 + (y-cy).^2);

r = round(r);

maxR = min(cx, cy);

frc_curve = zeros(maxR,1);

for i = 1:maxR
    
    mask = (r == i);
    
    if sum(mask(:)) == 0
        frc_curve(i) = NaN;
        continue;
    end
    
    num = sum(F1(mask).*conj(F2(mask)));
    den = sqrt(sum(abs(F1(mask)).^2) * sum(abs(F2(mask)).^2));
    
    frc_curve(i) = abs(num / den);
end

% frequency axis
freq = (0:maxR-1) / (maxR * pixelSize);

% plot FRC curve
figure;
plot(freq, frc_curve, 'LineWidth', 2);
xlabel('Spatial frequency (1/um)');
ylabel('FRC');
title('FRC Analysis');
grid on;

% 1/7 threshold line (common criterion)
hold on;
yline(1/7, '--r', '1/7 threshold');

% estimate resolution
idx = find(frc_curve < 1/7, 1);
if ~isempty(idx)
    resolution = 1 / freq(idx);
    fprintf('Estimated resolution: %.3f um\n', resolution);
else
    fprintf('No crossing found for 1/7 threshold.\n');
end

end