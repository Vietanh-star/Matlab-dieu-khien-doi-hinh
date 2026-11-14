function dpdt = control_law(t,p)

global n E D_des kd ky kAnchor y_ref

%% Khoi tao
dpdt = zeros(2*n,1);

%% Dua vector p thanh ma tran toa do

P = reshape(p,2,n)';

% P =
%
% [x1 y1
%  x2 y2
%  ...
%  x6 y6]


%% =========================================================
% 1. DIEU KHIEN KHOANG CACH
%% =========================================================

for k = 1:size(E,1)

    i = E(k,1);
    j = E(k,2);

    %% Vi tri 2 drone

    pi = P(i,:)';
    pj = P(j,:)';

    %% Vector vi tri tu j den i

    zij = pi - pj;

    %% Khoang cach binh phuong hien tai

    dij2 = zij' * zij;

    %% Khoang cach mong muon

    dij_star = D_des(k);

    %% Sai lech khoang cach

    eij = dij2 - dij_star^2;

    %% Luat dieu khien gradient

    ui = -kd * eij * zij;

    uj =  kd * eij * zij;

    %% Cong vao tung drone

    dpdt(2*i-1:2*i) = ...
        dpdt(2*i-1:2*i) + ui;

    dpdt(2*j-1:2*j) = ...
        dpdt(2*j-1:2*j) + uj;

end


%% =========================================================
% 2. GIU CAC DRONE TREN CUNG HANG y = 5
%% =========================================================

for i = 1:n

    yi = P(i,2);

    uy = -ky*(yi-y_ref);

    dpdt(2*i) = dpdt(2*i) + uy;

end


%% =========================================================
% 3. NEO DRONE 1 VA DRONE 6
%
% Drone 1: (0,5)
% Drone 6: (50,5)
%
% Hai drone bien giup xac dinh chieu cua hang ngang
%% =========================================================

%% Drone 1
x1 = P(1,1);

dpdt(1) = ...
    dpdt(1) - kAnchor*(x1-0);


%% Drone 6
x6 = P(6,1);

dpdt(11) = ...
    dpdt(11) - kAnchor*(x6-50);

end