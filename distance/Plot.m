function Plot(t,p)

global n

%% ============================================
% TACH TOA DO CAC DRONE
%% ============================================

N = length(t);

X = zeros(N,n);
Y = zeros(N,n);

for i = 1:n
    X(:,i) = p(2*i-1,:)';
    Y(:,i) = p(2*i,:)';
end


%% ============================================
% VE QUY DAO
%% ============================================

figure(1);
clf;

hold on;
grid on;
box on;

%% Ve quy dao cua tung drone
for i = 1:n
    plot(X(:,i), Y(:,i), ...
        'LineWidth', 1.5);
end


%% ============================================
% VI TRI BAN DAU
%% ============================================

h_start = plot(X(1,:), Y(1,:), ...
    'rx', ...
    'MarkerSize', 12, ...
    'LineWidth', 3);


%% ============================================
% VI TRI CUOI
%% ============================================

h_end = plot(X(end,:), Y(end,:), ...
    'bx', ...
    'MarkerSize', 12, ...
    'LineWidth', 3);


%% ============================================
% TAO DUONG DAI DIEN CHO LEGEND
%% ============================================

h_traj = plot(X(:,1), Y(:,1), ...
    'b-', ...
    'LineWidth', 1.5);


%% ============================================
% NHAN TRUC VA TIEU DE
%% ============================================

xlabel('x (m)');
ylabel('y (m)');

title('Mo phong dieu khien doi hinh');


%% ============================================
% GIOI HAN TRUC
%% ============================================

% Khong hien thi gia tri am tren truc Y
ylim([0 8]);

% Gioi han truc X
% Tu dong theo quy dao, co them mot chut bien
xmin = min(X(:));
xmax = max(X(:));

xlim([xmin-1 xmax+1]);


%% ============================================
% LEGEND
%% ============================================

legend([h_traj, h_start, h_end], ...
       {'Quy dao', 'Vi tri dau', 'Vi tri cuoi'}, ...
       'Location', 'northeast');


%% ============================================
% DINH DANG DO THI
%% ============================================

set(gca, ...
    'FontSize', 11, ...
    'LineWidth', 1);

hold off;

end