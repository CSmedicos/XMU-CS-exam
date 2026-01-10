% % 初始化
% x = 3;
% y = 4;
% max_iter = 100;
% tol = 1e-6;
% 
% for iter = 1:max_iter
%     % 定义目标函数
%     z = 4 * x^2 + y^2 + 5;
% 
%     % 计算梯度
%     grad_x = 8 * x;
%     grad_y = 2 * y;
% 
%     % 计算Hessian矩阵
%     hess = [8, 0; 0, 2];
% 
%     % 计算牛顿步
%     delta = hess \ [-grad_x; -grad_y];
% 
%     % 更新x和y
%     x = x + delta(1);
%     y = y + delta(2);
% 
%     % 检查收敛
%     if norm([-grad_x; -grad_y]) < tol
%         break;
%     end
% end
% 
% % 输出结果
% fprintf('Minimum found at x = %.4f, y = %.4f\n', x, y);
% fprintf('Function value at minimum = %.4f\n', 4 * x^2 + y^2 + 5);

% 初始化
x = 2;
y = 2;
max_iter = 100;
tol = 1e-6;
P=[x,y]';
for iter = 1:max_iter
    % 定义目标函数
    z = x * y + y^2;
    
    % 计算梯度
    grad= [y,x+2*y]';
    
    % 计算Hessian矩阵
    hess = [0,1; 1, 2];
    
    P=P-inv(hess)*grad;
    
    x=P(1)
    y=P(2)
    % 计算新的函数值
    z = x * y + y*y
    
  
end


