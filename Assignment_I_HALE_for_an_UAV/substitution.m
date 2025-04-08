function x1 = substitution(b1, A1, n)
    x1 = zeros(n, 1);
    if any(triu(A1, 1) ~= 0, 'all') % triu(A1, 1) ~= 0 extracts elements of the up diag, any, all just check for all of them to be diff from 0
        % Upper triangular sub
        for i = n:-1:1
            x1(i) = (b1(i) - A1(i, i+1:n) * x1(i+1:n)) / A1(i,i);% works fine
        end
    else
        % Lower triangular sub
        for i = 1:n
            x1(i) = (b1(i) - A1(i, 1:i-1) * x1(1:i-1)) / A1(i,i);
        end
    end
end