function [x_final, r, iter] = SOR(A,b,x0,w,tol,nmax) 
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end;
    x = zeros(2,n);
    x(1,1:n) = x0(1:n);
    iter = 0;
    % the same thing that for jacobi or gs but with diferent aproach
    mask1 = tril(ones(n), -1);
    mask2 = triu(ones(n), 1);

    for k = 1:nmax
        iter = iter +1;
        for j = 1:n
            x(2, j) = (1-w)*x(1,j) + (w/A(j,j))*(b(j) - x(2,:)*(A(j, :).*mask1(j, :))'-  x(1,:)*(A(j, :).*mask2(j, :))');
        end
       
        r(iter, :) = b - A*x(1,:)';
        x_final =  x(2,:);
        if  norm(r(iter, :)) < norm(tol*b), return, end 
        x(1,:) = x(2,:);
        x(2,:) = zeros(1,n);

    end

end
