bf = im2double(imread('im1.png'));
if size(bf,3)>1
  bf = rgb2gray(bf);
end
k = 3;
%%
thetas = [0, pi/6,pi/3,pi/2,2*pi/3,5*pi/6];
sigmas = [1, 3, 6];
sigma_num = size(sigmas,2);
theta_num = size(thetas,2);
%% gaussian blur
s0 = gaussian2dconv(bf,6);
%%imagesc(gaussianed);
figure
img = mat2gray(downsample(s0,2^k));
s0_d = im2double(img);
h = imshow(img);
str = sprintf('piano1-s0-1.jpg');
title(str);
saveas(h, str);
%%
s1 = zeros([size(bf,1) size(bf,2) sigma_num theta_num]);
s1_d = zeros([size(s0_d,1) size(s0_d,2) sigma_num theta_num]);
count=1;
for i = 1:sigma_num
  for j = 1:theta_num
    [rea,ima] = morlet2dconv(bf, sigmas(i), thetas(j));
%     %% real-part fig
%     figure
%     % g = subplot(rows,cols * 2, (i-1) * 2 * cols + 2 * j - 1);
%     h = imshow(mat2gray(rea));
%     str = sprintf('piano-%.2fpi,%d,re.jpg', thetas(j)/pi, sigmas(i));
%     title(str);
%     saveas(h, str);
%     %% img-part fig
%     figure
%     % subplot(rows,cols*2,(i-1)*2*cols+2*j);
%     str = sprintf('piano-%.2fpi,%d,im.jpg', thetas(j)/pi, sigmas(i));
%     h = imshow(mat2gray(ima));
%     title(str);
%     saveas(h, str);
    %%
    s1(:,:,i,j)=sqrt(rea.^2 + ima.^2);
    % subplot(rows,cols*2,(i-1)*2*cols+2*j);
    str = sprintf('piano1-s1-%d-%d-%.2fpi.jpg', count, sigmas(i), thetas(j)/pi);
    count = count + 1;
    img = imresize(mat2gray(gaussian2dconv(s1(:,:,i,j),6)),0.125);
%   img = imresize(img,0.125);
    s1_d(:,:,i,j) = im2double(img);
    h = imshow(img);
    title(str);
    saveas(h, str);
  end
end
%
s2 = zeros([size(bf,1) size(bf,2) sigma_num theta_num theta_num]);
s2_d = zeros([size(s1_d,1) size(s1_d,2) sigma_num theta_num theta_num]);
count = 1;
for k = 1:theta_num
    for i = 1:sigma_num
        for j = 1:theta_num 
            [rea,ima] = morlet2dconv(s1(:,:,i,j), sigmas(3), thetas(k));
            s2(:,:,i,j,k) = sqrt(rea.^2 + ima.^2);
            %%           
            str = sprintf('piano1-s2-%d-%d-%.2f-%d-%.2f.jpg', count, sigmas(3), thetas(k)/pi, sigmas(i), thetas(j)/pi);
            count = count +1;
            img = imresize(mat2gray(gaussian2dconv(s2(:,:,i,j,k),6)),0.125);
%           img = imresize(img,0.125);
            s2_d(:,:,i,j,k) = im2double(img);
            h = imshow(img);
            title(str);
            saveas(h, str);
        end
    end
end