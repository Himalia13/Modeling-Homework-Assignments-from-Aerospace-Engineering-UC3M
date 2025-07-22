function [scaled_lambdas, dts] = Iterative_Lambda(maxIter, tol, scaled_lambdas, lambdas, dts)
    % Iterative process to ensure eigenvalues are within the stability region
    for i = 1:maxIter
        stable = true;
        for j = 1:length(lambdas)
            if abs(scaled_lambdas(j) + 1) > 1 + tol % Stability Condition
                stable = false;
                break;
            end
        end
        if stable
            break;
        else 
            dts = dts/2; % Reduce timestep and scale the eigenvalues
            scaled_lambdas = lambdas*dts;
        end
    end
end