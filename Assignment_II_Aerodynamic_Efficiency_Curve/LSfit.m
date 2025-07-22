function x = LSfit(Cl, E)
    % LSfit - We calculate a 3rd degree poly using least squares solving the normal equation
    A = [ones(size(Cl)), Cl, Cl.^2, Cl.^3];  % 81 x 4
    % Solve normal equations: A'A x = A'E => Mx = b
    M = A' * A;         % 4 x 4
    b = A' * E;         % 4 x 1
    % Solve
    x = M \ b;    %output coeficients 
end