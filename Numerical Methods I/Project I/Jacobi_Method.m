function [x,k] = Jacobi_Method(A,b,max_iterations,tolerance)
% Jacobi's method for Ax=b


n=max(size(A));
x0=zeros(n,1);
x=x0;
dx=tolerance+1;
k=0; 

I=eye(n);
D=diag(diag(A));
B=I-D\A;
rho_B=max(abs(eig(B)));
fprintf('Spectral radius of A is equal %f \n',rho_B); 
cond_A=cond(A);
fprintf('Condition number of A is equal %f \n',cond_A); 


d=diag(A);
if ~all(d)
    disp('Diagonal element of A is equal to 0!');
    return;
end

while norm(dx)> tolerance && k<= max_iterations 
       for i=1:n
          s=b(i);   %i-th element of vector b
          m=1;
          if i>=2
              m=i-1;            
          end
          for j=[m:i-1,i+1:n]
              s=s-A(i,j)*x0(j);     %bi- Sum(from 1 to n without j) * aij * x0j
          end
          x(i)=s/A(i,i);    %xi= s/aii
       end
  
      dx=x-x0;  %compute diference between x and x0
      k=k+1;    %next iteration
      x0=x;     %save x as x0   
end
k=k-1;
end
