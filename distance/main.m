clear;
clc;
close all;

%% =========================================================
%  6 DRONE TAO DOI HINH HANG NGANG
%  DIEU KHIEN DUA TREN KHOANG CACH
%% =========================================================

global n E D_des kd ky kAnchor y_ref

%% So drone
n = 6;

%% =========================================================
% DO THI KHOANG CACH
%
% Canh lien tiep: 10 m
% 1--2--3--4--5--6
%
% Canh cach 1 drone: 20 m
% 1---3, 2---4, 3---5, 4---6
%% =========================================================

E = [1 2;
     2 3;
     3 4;
     4 5;
     5 6;
     1 3;
     2 4;
     3 5;
     4 6];

%% Khoang cach mong muon tuong ung tung canh

D_des = [10;
         10;
         10;
         10;
         10;
         20;
         20;
         20;
         20];

%% He so dieu khien

kd = 0.002;

% Dua cac drone ve cung hang y = 5
ky = 1;

% Neo 2 drone dau/cuoi
kAnchor = 1;

y_ref = 5;

%% =========================================================
% VI TRI BAN DAU
%
% Cac drone tap trung gan goc toa do
%% =========================================================

P0 = [0.0  0.00;
      0.1  0.02;
      0.2  0.00;
      0.3  0.02;
      0.4  0.00;
      0.5  0.02];

%% Chuyen thanh vector cot

p0 = P0';
p0 = p0(:);

%% Thoi gian mo phong

tspan = 0:0.05:60;

%% Giai phuong trinh

[t,p] = ode45(@control_law,tspan,p0);

%% Chuyen vi de moi cot la mot thoi diem

p = p';

%% Ve ket qua

Plot(t,p);