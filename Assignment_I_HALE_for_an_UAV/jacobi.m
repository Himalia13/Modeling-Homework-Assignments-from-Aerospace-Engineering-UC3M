function [x_final, r, iter] = jacobi(A, b, x0, tol, nmax)
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    x = zeros(2, n); %we initialize a 2 row solution vector
    x(1, 1:n) = x0(1:n); % The first row of x substituted by x0
    iter = 0;

    mask1 = ~eye(n); % we use it to delete the main diagonal elements in the sumatory

    for k = 1:nmax
        iter = iter + 1;
        for j = 1:n
            x(2, j) = (1/A(j,j))*(b(j) - x(1,:)*(A(j,:)' .* mask1(:,j)));
        end
        r(iter, :) = b - A*x(2,:)'; % Just compute the mod
        x_final = x(2,:);
        if norm(r(iter, :)) < tol*norm(b), return, end
        x(1,:) = x(2,:); %update the rows
    end
    x_final = x(2,:); % if it not reaches the desired tolerrance
end