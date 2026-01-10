function [fval, Xb] = simplex(A, b, C)
    % A: 系数矩阵
    % b: 约束条件的右侧常数项
    % C: 成本向量
    %define matrix B
    %define matrix N
    %define Cb, Cn
    % 初始化一个标志变量，用于控制循环
    exitLoop = true;
    [m, n] = size(A); % m 行 n 列
    B=A(:,end-m+1:end)
    N=A(:,1:end-m)
    Cn=C(:,1:end-m)
    Cb=C(:,end-m+1:end)
    while exitLoop
      % 计算 B^-1 * b 和 B^-1 * N
      B_inv = inv(B);
      tmp=Cb*B_inv;
      k=zeros(1,n-m);
      % 遍历 N 的每一列
      for j = 1:n-m
          % 计算 Cb * B^-1 * N_j - Cn_j
          k(j) = tmp * N(:, j) - Cn(j);
      end
      % 找到 k 中的最小值
      [value, idx] = min(k)
      if value>=0
        exitLoop = false;
      else
      % b_bar = B_inv * b;
      b_bar= B_inv *b;
      NK = N(:, idx); % 获取 N 的第 idx 列，并将其赋值给 NK
      yk=B_inv *NK;
      %计算r
      fractions=b_bar./yk;
      % 初始化最小值和索引
      minValue = inf; % 初始化为无穷大
      minIndex = 0; % 初始化索引为0
      % 遍历数组，找到非负数的最小值及其索引
      for i = 1:length(fractions)
            if fractions(i) >= 0 && fractions(i) < minValue
                minValue =fractions(i);
                minIndex = i;
            end
      end
      r=minIndex;
      disp("minvalue=")
      disp(minValue);
      disp("r=")
      disp(r);

      % 交换 B 的第 r 列和 N 的第 idx 列
      temp = B(:, r);
      B(:, r) = N(:, idx);
      N(:, idx) = temp;
      disp(B);
      disp(N);

      temp=Cb(:,r);
      Cb(:,r)=Cn(:,idx);
      Cn(:,idx)=temp;
      disp(Cb);
      disp(Cn);
      end
    end
    Xb=inv(B)*b
    fval=Cb*Xb
      % Repeat
     % 1. Find out xk
     % 2. Find out r
     % 3. Swap-in xk and Swap-out X_Br
     % 4. Swap ck into Cb, swap-out Cr to Cn
end