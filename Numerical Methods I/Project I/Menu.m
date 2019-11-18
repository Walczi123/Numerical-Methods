% MENU
clear
clc
finish=8;  
control=1;
ex=0;

%default data %
A=ones(4)+10*eye(4);
A=hess(A);
Z=(1:4)';b=A*Z;
max_iter=100;
tol = 1e-6;

while control~=finish 

    control=menu('Menu', 'Change Hessenber matrix A', 'Change vector b','Change number of maximal iterations','Change tolerance','Display variables','Change example','Compute Ax=b','FINISH');

    switch control
        case 1
            A=input('A= ');
            A=Is_Hessenberg(A);
            
        case 2
            b=input('b= ');

        case 3
            max_iter=input('max iterations= ');

        case 4
            tol=input('tolerance= ');    
        case 5
            disp('A= ');disp(A)
            disp('b= ');disp(b)
            disp('max iterator= ');disp(max_iter)
            disp('tolerance= ');disp(tol)
            
        case 6
            if ex==0
                A=[4,2,3;3,-5,2;-2,3,8];
                A=hess(A);
                Z=[8;-14;27];b=A*Z;
            end
            if ex==1
                A=ones(4)+10*eye(4);
                A=hess(A);
                Z=(1:4)';b=A*Z;
            end 
            if ex==2
                A=[10,-1,2,0;-1,11,-1,3;2,-1,10,-1;0,3,-1,8];
                A=hess(A);
                Z=[1;2;3;4];b=A*Z;
                
            end
            if ex==3
                disp('Teraz')
                A=triu(ones(6),-1);               
                Z=[1;2;3;4;5;6];b=A*Z;
                
            end
            ex=ex+1;
            ex=mod(ex,4);
            
        case 7
            n=max(size(A));
            m=max(size(b));
            disp(n)
            disp(m)
            if m==n
                [result,iteration] = Jacobi_Method(A,b,max_iter,tol);
                err_x=norm(result-Z)/norm(Z);
                fprintf('After %d iteriations result is:\n',iteration);
                disp(result)
                fprintf('And error is equal: %d\n',err_x);               
            else
                fprintf('Iccorect size of A and b\n');
            end

        case 8
            disp('FINISH')
    end
end