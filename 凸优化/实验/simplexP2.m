function [fval, Xb]=simplexP2(A, b, C)
%design a loop to run the simplex procedure
%define matrix B
%define matrix N
%define Cb， Cn
    [m, n] = size(A); % m 行 n 列
    B=A(:,end-m+1:end)
    N=A(:,1:end-m)
    Cn=C(:,1:end-m)
    Cb=C(:,end-m+1:end)
    k=1
    [B,N,b]= simplex(B,Cb,N,Cn,b);
    Cb =[0,0,0];
    Cn=-C*N*inv(B)
    [B,N,b]=simplex(B,Cb,N,Cn,b);
    fval = Cb;

end