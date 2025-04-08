function [w_best,w,spectral_rad] = Best_Omega(A)
    
    w= linspace(1,2,1e3); %range of values for w
    spectral_rad  = zeros(size(w)); % matrix storing the eigs
    
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
    
    for i = 1:length(w)        
        % Just the sor iteration matrix
        M = (D + w(i)*L)\((1 - w(i))*D - w(i)*U);
        
        % built in function to compute the eigs
        spectral_rad(i) = max(abs(eig(M)));
    end
    
    % we just find the lowest omega
    [~, best] = min(spectral_rad);
    w_best = w(best);

end