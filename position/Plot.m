figure;
hold on;
grid on;
axis equal;

%% Ve tung tac tu
for i = 1:n
    % Chi so x va y cua tac tu i
    ix = 2*i - 1;
    iy = 2*i;

    % Quy dao
    plot(p(ix,:), p(iy,:), '-');

    % Vi tri dau
    plot(p(ix,1), p(iy,1), 'rx', ...
        'MarkerSize',10,...
        'LineWidth',2);

    % Vi tri cuoi
    plot(p(ix,t_end), p(iy,t_end), 'bx', ...
        'MarkerSize',10,...
        'LineWidth',2);

end

xlabel('x');
ylabel('y');

title('Mo phong dieu khien doi hinh');

legend('Quy dao','Vi tri dau','Vi tri cuoi');