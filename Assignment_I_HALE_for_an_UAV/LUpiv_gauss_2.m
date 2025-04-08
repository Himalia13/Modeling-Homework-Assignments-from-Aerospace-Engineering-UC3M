function [x] = LUpiv_gauss_2(A, b)
    %What we are doing here is just checking the dimensions and making sure it si a square matrix
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    L = eye(n);
    U = A;
    P = eye(n);
    for k = 1:n-1
        [~, maxIndex] = max(abs(U(k:n, k)));
        maxIndex = maxIndex + k - 1;
        if maxIndex ~= k
            % An easy way to swap rows
            U([k, maxIndex], :) = U([maxIndex, k], :);
            P([k, maxIndex], :) = P([maxIndex, k], :);
            %Find the max and impose a condition
            if k > 1, L([k, maxIndex], 1:k-1) = L([maxIndex, k], 1:k-1); end
        end
        %pivoting
        L(k+1:n, k) = U(k+1:n, k) / U(k, k);
        U(k+1:n, :) = U(k+1:n, :) - L(k+1:n, k) * U(k, :);
    end

    % Solves a linear system using LU decomposition
    % First solves Ly = b, then Ux = y
    
    [y] = substitution(P*b, L, n);
    [x] = substitution(y, U, n);
end
