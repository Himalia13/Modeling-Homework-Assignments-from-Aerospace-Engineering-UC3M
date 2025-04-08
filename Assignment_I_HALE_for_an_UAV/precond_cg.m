function [x, rvector, it] = precond_cg(A,b,x0,parameters)
    [n, m] = size(A);
    if n ~= m, error('Square matrix!!!'); end
    x = x0;
    it = 0;

    r = b -A*x;
    vector_a = 1./diag(A);
    Pinv = diag(vector_a);
    h = Pinv*r;
    p = h;
    delta = [dot(r,h), 0];
    bdelta = dot(b, Pinv*b);

    for k = 0:parameters.maxit-1
        it = it +1;
        w = A*p;
        alpha = delta(1)/dot(p, w);
        x = x + alpha*p;
        r = r - alpha*w;
        h = Pinv*r;
        delta(2) = dot(r,h);
        rvector(it,:) = r;
        if delta(2) < parameters.tol^2*bdelta
            return
        else
            p = h + delta(2)*p/delta(1);
        end
        delta(1) = delta(2);
    end
    

end