clear all; close all; clc;
iris_data=dlmread('iris_dataset.dat');
%Shuffle the dataset%
iris_data_shuffle=iris_data(randperm(150),:);
data_len=size(iris_data,1);
X=iris_data_shuffle(:,1:4);
y=iris_data_shuffle(:,5);
n = length(X);

m1=mean(X(:,1));
m2=mean(X(:,2));
m3=mean(X(:,3));
m4=mean(X(:,4));

mm=[m1 m2 m3 m4];
M = repmat(mm,n,1);

XM=X-M;
[eigvec_org eigval_org] = eig(cov(XM)); 
eigvec = fliplr(eigvec_org);  % largest evector on 1st col 
eigval = flipud(diag(eigval_org)); 
PC=XM*eigvec;
eigval % largest evalue on top 
%Calculate Covariance of each classes%


