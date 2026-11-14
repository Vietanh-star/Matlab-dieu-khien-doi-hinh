clear;
clc;
close all;

%% =========================================================
% 4 DRONE BAO QUANH MUC TIEU
% Dieu khien dua tren vector huong
%
% Drone 1 ----- Drone 2
%    |          |
%    |    X     |
%    |          |
% Drone 3 ----- Drone 4
%
% Them duong cheo 1 - 4
%% =========================================================

global n E g_des kb ks kc target s_ref

%% So drone
n = 4;

%% =========================================================
% DO THI LIEN KET
%% =========================================================

% 4 canh hinh vuong + 1 duong cheo

E = [1 2;
     1 3;
     2 4;
     3 4;
     1 4];

m = size(E,1);

%% =========================================================
% VI TRI MUC TIEU
%% =========================================================

target = [0;0];

%% =========================================================
% DOI HINH MONG MUON SAU KHI GIAN RA
%
% Tam tai (0,0)
% Nua canh = 6 m
%% =========================================================

a_ref = 6;

P_star = [-a_ref   a_ref;     % Drone 1
           a_ref   a_ref;     % Drone 2
          -a_ref  -a_ref;     % Drone 3
           a_ref  -a_ref];    % Drone 4

%% =========================================================
% TINH CAC VECTOR HUONG MONG MUON
%% =========================================================

g_des = zeros(m,2);

for k = 1:m

    i = E(k,1);
    j = E(k,2);

    zij_star = (P_star(j,:) - P_star(i,:))';

    g_des(k,:) = (zij_star/norm(zij_star))';

end

%% =========================================================
% THONG SO DIEU KHIEN
%% =========================================================

% He so giu hinh dang bang vector huong
kb = 1.5;

% He so dieu khien kich thuoc
ks = 0.8;

% He so dua trong tam ve muc tieu
kc = 1.0;

%% Kich thuoc mong muon

% Khoang cach moi drone den tam trong hinh vuong
s_ref = sqrt(2)*a_ref;

%% =========================================================
% VI TRI BAN DAU - DOI HINH CO NHO
%% =========================================================

a0 = 2;

P0 = [-a0-0.2    a0+0.1;
       a0+0.3    a0-0.2;
      -a0+0.2   -a0-0.3;
       a0-0.1   -a0+0.2];

%% Vector trang thai

% p =
% [x1
%  y1
%  x2
%  y2
%  x3
%  y3
%  x4
%  y4]

p0 = P0';
p0 = p0(:);

%% =========================================================
% MO PHONG
%% =========================================================

tspan = 0:0.05:20;

[t,p] = ode45(@control_law,tspan,p0);

%% Chuyen vi de dung trong Plot
p = p';

%% =========================================================
% VE KET QUA
%% =========================================================

Plot(t,p);