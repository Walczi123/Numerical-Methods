function [x,k] = King(p,x0,tol,max_iter)
% [x,k] = King(p,x0,tol,max_iter)
% Finding a root of polynomial  w(x)=p(1) x^n+...+ p(n) x + p(n+1)
% by the King method

dx=tol+1;
k=0; x=0;

dp=polyder(p); % dp derivative of the polynomial p
while abs(dx)> tol && k<= max_iter 
    w=Horner(p,x0); %value of p(x0)
    if abs(w)<=tol
        x=x0; return;
    end
    
    dw=Horner(dp,x0);%value of p'(x0)
    if dw==0
        disp(' You divide by zero! ');
        return;
    end
    dx=w/dw;
    y=x0-dx;
    pyk=Horner(p,y);%p(yk)
    pxk=Horner(p,x0);%p(xk)
    dpxk=Horner(dp,x0);%p'(x0)
    dpyk=Horner(dp,y);%p'(yk)
    if dpyk==0 || dpxk==0 || pxk==0
        disp(' You divide by zero! ');
        return;
    end
    c=(pyk/pxk)^3; %(p(yk)/p(xk))^3
    b=pxk/dpxk; % p(xk)/p'(xk)
    a=pyk/dpyk;   % p(yk)/p'(yk)
    x=y-a-(b*c); %next value of x
    k=k+1;
    x0=x;
end
end