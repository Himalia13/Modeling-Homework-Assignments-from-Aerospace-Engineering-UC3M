function [x, rvector, it] = Descent(A,b,x0,parameters)
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    x = x0;
    it = 0;
    %same method a in the diapos no need for explanation
    for k = 0:parameters.maxit-1
        r = b - A*x;
        it = it +1;
        rvector(it,:) = r;
        if norm(r) < parameters.tol*norm(b)
            return
        else
            alpha = (dot(r,r))/(dot(r,A*r));
            x = x + alpha*r;
            if it == parameters.maxit
                fprintf('No solution found')
            end

        end
    end


end