%% 1. 数据
X = [3   5;
     5   6;
     6   2.3];        % 正类
% X = [4   6.5;
%      5   6;
%      4   1.2];        % 正类
Y = [1.5 3;
     2.5 1];          % 负类

nPos = size(X,1);     % 3
nNeg = size(Y,1);     % 2
n = 2;                % 特征维数

%% 2. 构造 QP 标准型
%  min  0.5*z'*H*z + c'*z
%  s.t. A*z <= b
%  z = [w1;w2;b]  (3×1)

H = diag([1 1 0]);    % 1/2*(w1^2+w2^2)  -> H = eye(2) 增广一维 0
c = zeros(3,1);       % 无一次项

% 不等式约束 A*z <= b
A = zeros(nPos+nNeg,3);
b = -ones(nPos+nNeg,1);

% 正类：w'*xi + b >= 1  <=>  -[xi 1]*[w;b] <= -1
for i = 1:nPos
    A(i,:) = -[X(i,:) 1];
end
% 负类：w'*yi + b <= -1  <=>  [yi 1]*[w;b] <= -1
for i = 1:nNeg
    A(nPos+i,:) = [Y(i,:) 1];
end




%% 3. 调用 quadprog
lb = [-Inf;-Inf;-Inf];   % w、b 均无下界
ub = [ Inf; Inf; Inf];
z0 = zeros(3,1);         % 初值（可缺省）

[z, fval] = quadprog(H, c, A, b, [], [], lb, ub, z0);

%% 4. 结果
w = z(1:2);
b = z(3);
fprintf('w = [%.4f; %.4f]\n', w);
fprintf('b = %.4f\n', b);
fprintf('目标函数值 (1/2*||w||^2) = %.4f\n', fval);

%% 2. 画图
figure; hold on; grid on; axis equal;

% 画样本点
scatter(X(:,1), X(:,2), 80, 'filled', 'MarkerFaceColor', 'b', 'DisplayName', 'Positive');
scatter(Y(:,1), Y(:,2), 80, 'filled', 'MarkerFaceColor', 'r', 'DisplayName', 'Negative');

% 计算决策直线范围
% x1_min = min([X(:,1); Y(:,1)]) - 0.5;
% x1_max = max([X(:,1); Y(:,1)]) + 0.5;
x1_min=0;
x1_max=10;
x1_plot = linspace(x1_min, x1_max, 200);

% 决策边界 w1*x1 + w2*x2 + b = 0  ->  x2 = -(w1*x1+b)/w2
x2_db = -(w(1)*x1_plot + b) / w(2);

% 间隔边界 w1*x1 + w2*x2 + b = ±1
x2_p1 = -(w(1)*x1_plot + b - 1) / w(2);   % +1
x2_m1 = -(w(1)*x1_plot + b + 1) / w(2);   % -1

plot(x1_plot, x2_db, 'k-', 'LineWidth', 2, 'DisplayName', 'Decision boundary');
plot(x1_plot, x2_p1, 'k--', 'LineWidth', 1.2, 'DisplayName', 'w^T x+b=+1');
plot(x1_plot, x2_m1, 'k--', 'LineWidth', 1.2, 'DisplayName', 'w^T x+b=-1');
xlim([0 7]);
ylim([0 7]);
% axline(0,'vertical');   % x₁=0
% axline(0,'horizontal'); % x₂=0
set(gca,'DataAspectRatio',[1 1 1]);   % 1:1 等比例
grid on; axis equal;                 % 重新确保等比例

xlabel('x_1'); ylabel('x_2');
title('Linear SVM result');
legend show;

% 保存图片
saveas(gcf, 'svm_result.png');