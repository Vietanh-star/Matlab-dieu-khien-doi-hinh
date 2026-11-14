clc;
clear;
close all;

global p_d L

%% So tac tu
n = 6;
%% Khoi tao vi tri ban dau ngau nhien
p0 = 10*rand(2*n,1);
%% Tao ma tran Laplace
L = n*eye(n) - ones(n,n);
%% Vi tri doi hinh mong muon
% Moi hang la [x,y] cua mot tac tu
P_d = [9  5;
       7  8.464;
       3  8.464;
       1  5;
       3  1.536;
       7  1.536];
%% Chuyen ma tran thanh vector
p_d = P_d';
p_d = p_d(:);
%% Goi phuong trinh vi phan ode45
[t,p] = ode45(@control_law, 0:0.1:20, p0);
%% Chuyen vi de xu ly
p = p';
%% So buoc mo phong
t_end = length(t);
%% Ve ket qua
Plot