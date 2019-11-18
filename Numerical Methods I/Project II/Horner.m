function y = Horner(a,x)
% y = a(1)*x^(n-1) + .... + a(n-1)*x + a(n)
% Horner's scheme compute the value the polynomial with value of x

    n = max(size(a));
    y = 0;
    for k = 1 : n
            y = a(k) + x .* y;
    end   
end
