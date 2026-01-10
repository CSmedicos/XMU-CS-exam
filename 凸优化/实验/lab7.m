%% 1. 收益率样本协方差矩阵（用最近 12 个月数据）
price = [ 
    251.06 1672.0 120.76;
    209.14 1676.6 141.56;
    229.69 1815.2 171.35;
    243.66 1846.1 143.15;
    259.85 1942.8 209.43;   
    258.95 1845.4 226.98;
    253.81 2000.4 279.65;
    246.48 1992.2 289.10;
    230.41 1995.5 397.70;
    242.83 1929.5 424.13;
    266.06 1978.8 465.07;
    260.71 1967.1 485.09;
    250.28 1847.2 447.82;
    250.84 1987.5 423.25];  % 2023-11
ret = price(2:end,:) ./ price(1:end-1,:) - 1;   % 10×3 收益率矩阵
Sigma = cov(ret)*2;                               % 3×3 协方差矩阵
disp(cov(ret))
%% 2. 优化参数
r = mean(ret);      % 确保 1x3

profit   = 500;          % 目标收益 ≥ 500
budget  = 1e4;           % 总资金 ≤ 10 000 元
f       = zeros(3,1);    % 二次项 0.5*x'*Sigma*x
A       = [-r; 1 1 1];  % 约束矩阵
b       = [-profit; budget];
lb      = [0;0;0];
ub      = [];

%% 3. 求解
options = optimoptions('quadprog','Display','final');
[x, fval] = quadprog(Sigma, f, A, b, [], [], lb, ub, [], options)

%% 4. 结果输出
fprintf('最优资金分配（元）：\n');
disp(x)
disp(sum(x))

fprintf('组合预期收益：%.2f %\n', (r * x));
fprintf('组合方差：%.4f\n', fval);


%% 5.新模型的参数
r = mean(ret);      % 确保 1x3
profit   = 500;          % 目标收益 ≥ 500
budget  = 1e4;           % 总资金 ≤ 10 000 元

u_vec    = (1:10)*1e-3;  % 1×10
profit_v = nan(size(u_vec));  % 用来存每次的 profit
loss_v=nan(size(u_vec));
for k = 1:10
    u=k*(1e-3);
    Sigma = cov(ret)*2*u;                               % 3×3 协方差矩阵
    f       = -r';    % 二次项 0.5*x'*Sigma*x
    A       = [1 1 1];  % 约束矩阵
    b       = [budget];
    lb      = [0;0;0];
    ub      = [];

    [x, fval] = quadprog(Sigma, f, A, b, [], [], lb, ub, [], options)
    fprintf('最优资金分配（元）：\n');
    disp(x)
    disp(sum(x))

    fprintf('profit：%.2f %\n', (r * x));
    fprintf('组合方差：%.4f\n', fval);
    profit_v(k) = r*x;   % 记录本次期望收益
    loss_v(k)=u*x'*cov(ret)*x

end
%% 3. 画图
figure;
plot(u_vec, profit_v, 'b-o','LineWidth',1.2);
hold on;
plot(u_vec, loss_v, 'r-s','LineWidth',1.2);

xlabel('u');
ylabel('期望收益 profit');
legend('profit','loss')
title('不同 u 下的最优组合期望收益');
grid on;


