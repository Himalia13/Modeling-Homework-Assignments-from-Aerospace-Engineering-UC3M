function [x_final, r, iter] = Gauss_Seidel(A,b,x0,tol,nmax) 
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    x = zeros(2,n); %we initialize a 2 row solution vector
    x(1,1:n) = x0(1:n);  % The first row of x substituted by x0
    iter = 0;

    mask1 = tril(ones(n), -1); % Just fancy ways to get a mask for the sumatories
    mask2 = triu(ones(n), 1);

    for k = 1:nmax
        iter = iter +1;
        for j = 1:n
            x(2, j) = (1/A(j,j))*(b(j) - x(2,:)*(A(j, :).*mask1(j, :))'-  x(1,:)*(A(j, :).*mask2(j, :))');
        end
        % actually same as jacobi
        r(iter, :) = b - A*x(1,:)';
        x_final =  x(2,:);
        if  norm(r(iter, :)) < norm(tol*b), return, end 
        x(1,:) = x(2,:);
    end

end