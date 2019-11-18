function M = Is_Hessenberg(A)
% Is A a Hessenber matrix
M=hess(A);
[m,n]=size(A);
if m~=n
    disp('Your matrix is not a Hassenberg')
    return;
end
Z=zeros(n);
C=tril(A,-2);
if ~isequal(Z,C)
    disp('Your matrix is not a Hassenberg')   
    return;
end
M=A;
end

