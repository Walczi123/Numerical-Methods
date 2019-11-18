% MENU
clear
clc
finish=9;  
control=1;

%default data %
a=[1,-2,5];
p=poly(a);
tol=1e-10;
max_iter=100;
n=-2.5;
m=5.5;
interval=linspace(n,m);
x0=3;
%example counter
ex=0;

while control~=finish 

    control=menu('Menu', 'Change the complex polynomial', 
    'Change initial x0','Change error tolerance',
    'Change number of maximal iterations','Change interval of plot',
    'Change example','Display variables','Compute root of the polynomial',
    'FINISH');

    switch control
        case 1
            a=input('p(x)= ');
            p=poly(a);

        case 2
            x0=input('x0= ');
        case 3
            tol=input('tolerance= ');

        case 4
            max_iter=input('max_iter= ');    
        
        case 5
            n=input('start= ');
            m=input('end= ');
            interval=linspace(n,m);
            
        case 6
            if ex==0
                a=ones(1,6);
                p=poly(a);
                tol=1e-10;
                max_iter=100;
                n=0;
                m=2;
                interval=linspace(n,m);
                x0=3;
            end
            if ex==1
                a=randn(1)+2i;
                p=poly(a);
                tol=1e-10;
                max_iter=100;
                n=-2;
                m=2;
                interval=linspace(n,m);
                x0=-1;
            end 
            if ex==2
                a=[1:25];
                p=poly(a);
                tol=1e-10;
                max_iter=100;
                n=0;
                m=25;
                interval=linspace(n,m);
                x0=1000;
                
            end
            if ex==3
                a=[1,-2,5];
                p=poly(a);
                tol=1e-10;
                max_iter=100;
                n=-2.5;
                m=5.5;
                interval=linspace(n,m);
                x0=3;
                
            end
            ex=ex+1;
            ex=mod(ex,4);
        
        case 7
            disp('p(x)= ');disp(p)
            disp('x0= ');disp(x0)
            disp('max_iter= ');disp(max_iter)
            disp('tolerance= ');disp(tol)
            fprintf('interval of plot = [%d,%d]\n',n,m);
            
        case 8
            [root,k]= King(p,x0,tol,max_iter);
            fprintf('King method after %d iterations returns 
            value root = %d\n',k,root);
            fprintf('and value of the polynomial for root = %d\n',
            Horner(p,root));
            f=@(s) Horner( p , s );
            plot(interval, f(interval)), xlabel('x'), ylabel('p(x)'), 
            title('p(x) Graph'),
            grid on, axis equal

        case 9
            disp('FINISH')
    end
end