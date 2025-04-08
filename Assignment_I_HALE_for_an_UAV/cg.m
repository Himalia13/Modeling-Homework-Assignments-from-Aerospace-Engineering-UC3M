function [x, rvector, it] = cg(A,b,x0,parameters)
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    x = x0;
    it = 0;

    r = zeros(n,2);
    r(:,1) = b -A*x;
    p = r(:,1);
    for k = 0:parameters.maxit-1
        it = it +1;
        w = A*p;
        alpha = dot(p, r(:,1))/dot(p, w);
        x = x + alpha*p;
        r(:,2) = r(:,1) - alpha*w;
        rvector(it,:) = r(:,2);
        if norm(r(:,2)) < parameters.tol*norm(b), 
            return
        else
            beta = dot(r(:,2), r(:,2))/dot(r(:,1), r(:,1));
            p = r(:,2) + beta*p;
        end
        r(:,1) = r(:,2);
    end
    

end