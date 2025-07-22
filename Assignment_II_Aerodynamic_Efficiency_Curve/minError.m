function x = minError(Cl, E, x0, t, maxIt)
    % minError - Minimizes error function using gradient descent qnd backtracking

    A = [ones(size(Cl)), Cl, Cl.^2, Cl.^3];  % 81 x 4
    e = @(x) sum((A*x - E).^2); %Error func
    grad_e = @(x) 2 * A' * (A*x - E);      % gradient

    % parameters
    alpha_max = 1;    % Initial step size
    beta = 0.5;       % It is specified as to be 1/2 in the curvefitting notes
    sigma = 1e-4;         % not defined, i have choose 1e-4 as in the notes

    % Initialize
    x = x0; k = 0;

    % Gradient descent loop
    while norm(grad_e(x)) > t && k < maxIt
        alpha = alpha_max;                   % Steat at alpha = 1

        % Backtracking line search
        while e(x - alpha * grad_e(x)) > e(x) - sigma * alpha * norm(grad_e(x))^2
            alpha = beta * alpha;            % Reduce step size
            if alpha < 1e-10; break; end %prevent a loop
        end

        % Update
        x = x - alpha * grad_e(x);
        k = k + 1;
    end
    if k >= maxIt; fprintf('Max it (%d) reached.', maxIt);end
end