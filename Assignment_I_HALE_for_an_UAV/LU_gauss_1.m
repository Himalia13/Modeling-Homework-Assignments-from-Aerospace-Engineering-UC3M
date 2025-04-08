function [x] = LU_gauss_1(A, b)
    %What we are doing here is just checking the dimensions and making sure it si a square matrix
    [n, m] = size(A);
    if n ~= m, error('Not square!'); end
    %We are using a diferent tipe of LU in wich the one with ones is L but is aplying Gaussian Elimination also
    L = eye(n);
    U = A;
    for k = 1:n-1
        %For this part L is just trivial but U simply substrats the L term multiplied by its respective U term in each element of its row, better explained in the report
        if U(k, k) == 0, error('Zero division!!!!!!!!!'); end
        L(k+1:n, k) = U(k+1:n, k) / U(k, k);
        U(k+1:n, :) = U(k+1:n, :) - L(k+1:n, k) * U(k, :);
    end
    % I like this one!!!

    % Solves a linear system using LU decomposition
    % First solves Ly = b, then Ux = y
    
    [y] = substitution(b, L, n);
    [x] = substitution(y, U, n);
end
