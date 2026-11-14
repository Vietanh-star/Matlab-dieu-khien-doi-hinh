function dpdt = control_law(t,p)

global n E g_des kb ks kc target s_ref

%% Khoi tao
dpdt = zeros(2*n,1);

%% =========================================================
% CHUYEN VECTOR p THANH MA TRAN TOA DO
%% =========================================================

P = reshape(p,2,n)';

% P =
%
% [x1 y1
%  x2 y2
%  x3 y3
%  x4 y4]


%% =========================================================
% 1. DIEU KHIEN DOI HINH DUA TREN VECTOR HUONG
%% =========================================================

for k = 1:size(E,1)

    i = E(k,1);
    j = E(k,2);

    %% Vi tri hai drone

    pi = P(i,:)';
    pj = P(j,:)';

    %% Vector vi tri tu i den j

    zij = pj - pi;

    %% Vector huong mong muon

    gij_star = g_des(k,:)';

    %% =====================================================
    % MA TRAN CHIEU
    %
    % Pg = I - g*g'
    %% =====================================================

    Pg = eye(2) - gij_star*gij_star';

    %% =====================================================
    % SAI LECH VUONG GOC VOI HUONG MONG MUON
    %% =====================================================

    eij = Pg*zij;

    %% =====================================================
    % LUAT DIEU KHIEN VECTOR HUONG
    %% =====================================================

    ui =  kb*eij;
    uj = -kb*eij;

    %% Tac dong len drone i

    dpdt(2*i-1:2*i) = ...
        dpdt(2*i-1:2*i) + ui;

    %% Tac dong len drone j

    dpdt(2*j-1:2*j) = ...
        dpdt(2*j-1:2*j) + uj;

end


%% =========================================================
% 2. TINH TRONG TAM DOI HINH
%% =========================================================

centroid = mean(P,1)';

%% =========================================================
% 3. GIU TRONG TAM DOI HINH TAI MUC TIEU
%% =========================================================

u_center = -kc*(centroid-target);

for i = 1:n

    dpdt(2*i-1:2*i) = ...
        dpdt(2*i-1:2*i) + u_center;

end


%% =========================================================
% 4. DIEU KHIEN KICH THUOC DOI HINH
%
% Vector huong khong xac dinh kich thuoc.
% Vi vay can bo sung thanh phan co/gian.
%% =========================================================

R = zeros(n,2);

for i = 1:n

    R(i,:) = P(i,:) - target';

end

%% Kich thuoc hien tai

s = 0;

for i = 1:n

    s = s + R(i,:)*R(i,:)';

end

s = sqrt(s/n);


%% =========================================================
% TAO VAN TOC CO / GIAN
%% =========================================================

if s > 1e-6

    scale_error = s_ref - s;

    for i = 1:n

        ri = R(i,:)';

        u_scale = ...
            ks * scale_error/s * ri;

        dpdt(2*i-1:2*i) = ...
            dpdt(2*i-1:2*i) + u_scale;

    end

end

end