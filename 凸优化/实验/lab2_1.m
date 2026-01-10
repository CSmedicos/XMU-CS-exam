% 定义函数和导数
f1 = @(x) exp(x) - x.^2 + 3*x + 4;
df1 = @(x) exp(x) - 2*x + 3;

% 牛顿法迭代
x0 = -1; % 初始猜测
tol = 1e-6; % 容忍度
maxIter = 100; % 最大迭代次数
for i = 1:maxIter
    x1 = x0 - f1(x0)/df1(x0);
    if abs(x1 - x0) < tol
        break;
    end
    x0 = x1;
end
fprintf('Solution for the first equation: x = %.6f\n', x1);

% 定义函数和导数
f2 = @(x) 6*sin(x) + 5*x - 2;
df2 = @(x) 6*cos(x) + 5;

% 牛顿法迭代
x0 = 0.5; % 初始猜测
tol = 1e-6; % 容忍度
maxIter = 100; % 最大迭代次数
for i = 1:maxIter
    x1 = x0 - f2(x0)/df2(x0);
    if abs(x1 - x0) < tol
        break;
    end
    x0 = x1;
end
fprintf('Solution for the second equation: x = %.6f\n', x1);

% 定义函数和导数
f3 = @(x) 5*x + log(x) - 10000;
df3 = @(x) 5 + 1/x;

% 牛顿法迭代
x0 = 100; % 初始猜测
tol = 1e-6; % 容忍度
maxIter = 100; % 最大迭代次数
for i = 1:maxIter
    x1 = x0 - f3(x0)/df3(x0);
    if abs(x1 - x0) < tol
        break;
    end
    x0 = x1;
end
fprintf('Solution for the third equation: x = %.6f\n', x1);