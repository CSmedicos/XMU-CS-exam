% %% 1. 指数函数  f(x)=exp(2x)  x∈[-5,5]
% x1 = linspace(-5,5,500);
% y1 = exp(2*x1);
% figure; plot(x1,y1,'LineWidth',1.8); title('f(x)=e^{2x}'); grid on;
% 
% %% 2. 幂函数  f(x)=x^{1.1}  x∈(0,5]
% x2 = linspace(0.01,5,500);   % 避开 0
% y2 = x2.^1.1;
% figure; plot(x2,y2,'LineWidth',1.8); title('f(x)=x^{1.1}'); grid on;
% 
% %% 3. 幂函数  f(x)=x^{0.5}  x∈(0,5]
% y3 = x2.^0.5;
% figure; plot(x2,y3,'LineWidth',1.8); title('f(x)=x^{0.5}'); grid on;
% 
% %% 4. 绝对值幂  f(x)=|x|^{1.5}  x∈[-5,5]
% x4 = linspace(-5,5,500);
% y4 = abs(x4).^1.5;
% figure; plot(x4,y4,'LineWidth',1.8); title('f(x)=|x|^{1.5}'); grid on;
% 
% %% 5. 对数函数  f(x)=ln(x)  x∈(0,50]
% x5 = linspace(0.01,50,500);
% y5 = log(x5);
% figure; plot(x5,y5,'LineWidth',1.8); title('f(x)=ln(x)'); grid on;
% 
% %% 6. 负熵函数  f(x)=x log_2(x)  x∈(0,10]
% x6 = linspace(0.01,10,500);
% y6 = x6.*log2(x6);
% figure; plot(x6,y6,'LineWidth',1.8); title('f(x)=xlog_2(x)'); grid on;
% %% 对 f(x)=x 2的透视投影
% % 透视投影函数 g(x,t)=tf(x/t)
% % g(x)=x^2/t
% [x,t] = meshgrid(linspace(-2,2,100), linspace(0.01,10,100));
% g = x.^2 ./ t;          % g(x,t) = x^2 / t
% figure; surf(x,t,g); shading interp;
% xlabel('x'); ylabel('t'); zlabel('g(x,t)');
% title('Perspective of f(x)=x^2');
% %% 对 f(x)=−log(x) 的透视投影
% [x,t] = meshgrid(linspace(0.01,2,100), linspace(0.01,10,100));
% g = -t .* log(x./t);    % g(x,t) = -t log(x/t)
% figure; surf(x,t,g); shading interp;
% xlabel('x'); ylabel('t'); zlabel('g(x,t)');
% title('Perspective of f(x)=-log(x)');
%% 在凸分析里，共轭函数（也叫 Fenchel 共轭）定义为：
% f∗(y)=sup(yx−f(x))（ x∈R)
% 它描述了线性函数 yx 与 f(x) 之间的最大差距，本身一定是凸函数，无论 f 是不是凸。
% %% 1. 对 f(x) = x² 的共轭函数
% y = linspace(-5,5,500);
% f_conj = y.^2 / 4;          % f*(y) = y^2/4
% figure; plot(y,f_conj,'LineWidth',2);
% xlabel('y'); ylabel('f^*(y)');
% title('Conjugate of f(x)=x^2');
% grid on;
% %% 2. 对 f(x) = x log x 的共轭函数
% y = linspace(-5,5,500);
% f_conj = exp(y - 1);        % f*(y) = e^{y-1}
% figure; plot(y,f_conj,'LineWidth',2); % 用 log 坐标更直观
% xlabel('y'); ylabel('f^*(y)');
% title('Conjugate of f(x)=xlogx');
% grid on;
% %% cos(x) 的共轭
% % 解析式（可推导）：
% % f*(y) = y·arccos(y) − √(1−y²)，定义域 y∈[−1,1]
% y = linspace(-1,1,500);
% fstar = y.*acos(y) - sqrt(1-y.^2);
% figure; plot(y,fstar,'LineWidth',2); grid on;
% xlabel('y'); title('f^*(y) for f(x)=cos(x)');
% %% sin(x) 的共轭
% % 解析式：
% % f*(y) = y·arcsin(y) + √(1−y²)，定义域 y∈[−1,1]
% fstar = y.*asin(y) + sqrt(1-y.^2);
% figure; plot(y,fstar,'LineWidth',2); grid on;
% xlabel('y'); title('f^*(y) for f(x)=sin(x)');
%% e^{−x^2/2} 的共轭
% 解析式：
% f*(y) = -y log y + y，定义域 y>0
syms x
syms y
f=y*x-exp(-x*x/2)==0
x_sol=solve(f,x)
% 把符号表达式转成函数句柄
x_func = matlabFunction(x_sol(1), 'Vars', y);  % 选第一个解

% 构造 y 的数值数组
y_vals = linspace(0.01, 3, 500);

% 对每个 y 求对应的 x 值
x_vals = arrayfun(@(yi) double(x_func(yi)), y_vals);

% 计算 fstar 值
fstar = y_vals .* x_vals - exp(-x_vals.^2/2);

figure; plot(y_vals,fstar,'LineWidth',2); grid on;
xlabel('y'); title('f^*(y) for f(x)=e^{-x}');