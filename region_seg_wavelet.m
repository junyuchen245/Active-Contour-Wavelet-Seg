%% Author: Junyu Chen
clear all; close all

addpath('./wavelet_transform/')
[h0, f0, h1, f1]=wavelet_filters('o1');
%% load image and groundtruth
load('osads.wl.n1.1.mat')
img = out;
load('voimask_d.mat')
truth = out;
load('cortbone_d.mat')
truth_cort = out;
load('trab_truth_d.mat')
truth_trab = out;
truth_bone = truth_trab + truth_cort;
truth_bone(truth_bone>0) = 1;
truth_bone = reshape(double(truth_bone(:,102,:)),250,192);
MASKimg_les = load('voimask.mat');
MASKimg_les = MASKimg_les.out;
MASKimg_les(MASKimg_les ~= 0) = 1;
MASKimg_les = imresize3(MASKimg_les,0.5,'nearest');
MASKimg_les = reshape(double(MASKimg_les(:,102,:)),250,192);
truth = reshape(double(truth(:,102,:)),250,192);
img = reshape(double(img(:,102,:)),250,192);
figure; imshow(img,[]);
%% cropping initial image
%figure;
%[J, rect_1] = imcrop(img,[]);

load('rect_1.mat') % load pre-selected image region
load('img.mat'); % load pre-selected image region
load('rect.mat'); % loading initial contour
I = imresize(J,[80 80]);
%% create initial contour
m = zeros(size(I));
m(rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3)) = 1;

%% crop truth images
%truth
truth_bone = imcrop(truth_bone,rect_1);
truth_bone = imresize(truth_bone,[80 80],'nearest');
%truth = imcrop(truth,rect_1);
truth_les = imcrop(MASKimg_les,rect_1);
truth_les = imresize(truth_les,[80 80],'nearest');

%% normalization
max_val = max(I(:));
%J = imadjust(I./max_val,[],[],0.5); % gamma correction
J = I./max_val;
J = J.*max_val;


feature_vec = [];
for i = -1:size(J,1)-2
    for j = -1:size(J,2)-2
        J_trans = imtranslate(J,[-i, -j]);
        dx=dwt2d(J_trans,h0,h1,3);
        feature_i = [dx(1,1);dx(11,1);dx(1,11);dx(11,11)];
        tmp = dx(21:22,1:2);
        feature_i = [feature_i; tmp(:)];
        tmp = dx(1:2,21:22);
        feature_i = [feature_i; tmp(:)];
        tmp = dx(21:22,21:22);
        feature_i = [feature_i; tmp(:)];
        tmp = dx(41:44,1:4);
        feature_i = [feature_i; tmp(:)];
        tmp = dx(1:4,41:44);
        feature_i = [feature_i; tmp(:)];
        tmp = dx(41:44,41:44);
        feature_i = [feature_i; tmp(:)];
        feature_vec = [feature_vec feature_i];
    end
end
%% weighting parameters for low frequency info
q = 0.75;


feature_vec(1:4,:) = abs(feature_vec(1:4,:)).^q;
%feature_vec(1,:) = abs(feature_vec(1,:)).^q;

%% show images
figure;
subplot(1,2,1)
imshow(J,[]);
hold on; contour(m,'r'); %contour(truth_bone,'b')
subplot(1,2,2)
imshow(I,[]);
hold on; contour(m,'r'); %contour(truth_bone,'b')

%% apply ACWE
[seg,tmp] = region_seg(J, m, 250, 0.2, true, feature_vec'); %-- Run segmentation

figure; imshow(seg,'initialmagnification',1000,'displayrange',[]); title(['q = ',num2str(q)]);
hold on; contour(truth_bone,'b');contour(truth_les,'r');


