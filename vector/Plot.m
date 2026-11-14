function Plot(t,p)

global n E target

%% =========================================================
% TACH TOA DO
%% =========================================================

N = length(t);

X = zeros(N,n);
Y = zeros(N,n);

for i = 1:n

    X(:,i) = p(2*i-1,:)';
    Y(:,i) = p(2*i,:)';

end


%% =========================================================
% VE DO THI
%% =========================================================

figure(1);
clf;

hold on;
grid on;
box on;


%% =========================================================
% 1. VE QUY DAO CAC DRONE
%% =========================================================

for i = 1:n

    plot(X(:,i),Y(:,i), ...
        'LineWidth',1.5);

end


%% =========================================================
% 2. VI TRI BAN DAU
%% =========================================================

h_start = plot(X(1,:),Y(1,:), ...
    'rx', ...
    'MarkerSize',12, ...
    'LineWidth',3);


%% =========================================================
% 3. VI TRI CUOI
%% =========================================================

h_end = plot(X(end,:),Y(end,:), ...
    'bx', ...
    'MarkerSize',12, ...
    'LineWidth',3);


%% =========================================================
% 4. VE CAC CANH DOI HINH CUOI
%% =========================================================

for k = 1:size(E,1)

    i = E(k,1);
    j = E(k,2);

    %% Duong cheo 1-4 ve net dut

    if (i == 1 && j == 4)

        plot([X(end,i) X(end,j)], ...
             [Y(end,i) Y(end,j)], ...
             'k--', ...
             'LineWidth',1.5);

    else

        plot([X(end,i) X(end,j)], ...
             [Y(end,i) Y(end,j)], ...
             'k-', ...
             'LineWidth',1.5);

    end

end


%% =========================================================
% 5. VE KHU VUC MUC TIEU
%% =========================================================

theta = linspace(0,2*pi,100);

r_target = 1.5;

xc = target(1) + r_target*cos(theta);
yc = target(2) + r_target*sin(theta);

plot(xc,yc,'r--','LineWidth',1.5);

text(target(1),target(2), ...
    'Muc tieu', ...
    'HorizontalAlignment','center', ...
    'FontWeight','bold');


%% =========================================================
% 6. GHI TEN DRONE
%% =========================================================

for i = 1:n

    text(X(end,i), ...
         Y(end,i)+0.5, ...
         ['Drone ',num2str(i)], ...
         'HorizontalAlignment','center');

end


%% =========================================================
% 7. LEGEND
%% =========================================================

h_traj = plot(X(:,1),Y(:,1), ...
    'b-', ...
    'LineWidth',1.5);

legend([h_traj h_start h_end], ...
       {'Quy dao', ...
        'Vi tri co vao', ...
        'Vi tri gian ra'}, ...
       'Location','northeast');


%% =========================================================
% NHAN TRUC
%% =========================================================

xlabel('x (m)');
ylabel('y (m)');

title('Mo phong doi hinh drone bao quanh muc tieu');


%% =========================================================
% GIOI HAN DO THI
%% =========================================================

axis equal;

xmin = min(X(:));
xmax = max(X(:));

ymin = min(Y(:));
ymax = max(Y(:));

xlim([xmin-2 xmax+2]);
ylim([ymin-2 ymax+2]);

hold off;

end