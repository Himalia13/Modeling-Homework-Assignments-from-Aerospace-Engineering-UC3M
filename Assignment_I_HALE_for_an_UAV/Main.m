
clear; clc;
Config(); % to load latex config

sys1 = struct('A1', load('Matrices/A1.mat'), 'b1',load('Matrices/b1.mat')); %Just a fancy way to load the system

fprintf('\n==========================================================\n');
fprintf(' 1.1. Solving Linear System Using LU Decomposition\n');
fprintf('==========================================================\n\n');

%LU

[x1] = LU_gauss_1(sys1.A1.A, sys1.b1.b);

fprintf('Solution vector x1:\n');
fprintf('-----------------\n');
for i = 1:length(x1)
    fprintf('  x1(%d) = %12.6f\n', i, x1(i));
end
fprintf('\n');

fprintf('Step 2: Residual |b1 - A1*x1|...\n');
residual1 = max(abs(sys1.b1.b - sys1.A1.A * x1));
fprintf('Maximum absolute residual: %e\n\n', residual1);

fprintf('Step 3: Residual vs tolerance (10^-10)...\n');
tolerance = 1e-10;
if residual1 < tolerance
    fprintf(' - Residual (%e) is BELOW 10^-10.\n', residual1);
    fprintf(' - Accurate solution.\n');
else
    fprintf(' - Residual (%e) is ABOVE 10^-10.\n', residual1);
    fprintf(' - Not acurate.\n');
end
fprintf('\n');


fprintf('\n==========================================================\n');
fprintf(' 1.2. Solving Linear System Using LU Decomposition and Pivoting\n');
fprintf('==========================================================\n\n');

%Pivoting

[x2] = LUpiv_gauss_2(sys1.A1.A, sys1.b1.b);

fprintf('Solution vector x1:\n');
fprintf('-----------------\n');
for i = 1:length(x2)
    fprintf('  x1(%d) = %12.6f\n', i, x2(i));
end
fprintf('\n');

fprintf('Step 2: Residual |b1 - A1*x1|...\n');
residual2 = max(abs(sys1.b1.b - sys1.A1.A * x2));
fprintf('Maximum absolute residual: %e\n\n', residual2);

fprintf('Step 3: Residual vs tolerance (10^-10)...\n');
tolerance = 1e-10;
if residual2 < tolerance
    fprintf(' - Residual (%e) is BELOW 10^-10.\n', residual2);
    fprintf(' - Accurate solution.\n');
else
    fprintf(' - Residual (%e) is ABOVE 10^-10.\n', residual2);
    fprintf(' - Not acurate.\n');
end
fprintf('\n');

sys2 = struct('A2', load('Matrices/A2.mat'), 'b2',load('Matrices/b2.mat'));

fprintf('\n==========================================================\n');
fprintf(' 2.1. Solving Linear System Using jacobi and Gauss Seidel\n');
fprintf('==========================================================\n\n');

%Jacobi

[x_final1, r1, iter1] = jacobi(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,1e-9,100); 

fprintf('\n=== Jacobi Method Results ===\n');
fprintf('Solution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x_final1);
disp('    ');
fprintf('Residual norm: %.2e\n', norm(r1(iter1,:)));
fprintf('Number of iterations: %d\n', iter1);
fprintf('=============================\n');

%Gausss_Seidel

[x_final2, r2, iter2] = Gauss_Seidel(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,1e-9,100); 

 fprintf('\n=== Gauss Method Results ===\n');
fprintf('Solution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x_final2);
disp('    ');

fprintf('Residual norm: %.2e\n', norm(r2(iter2,:)));
fprintf('Number of iterations: %d\n', iter2);
fprintf('=============================\n');

fprintf('\n==========================================================\n');
fprintf(' 2.2. Solving Linear System Using SOR\n');
fprintf('==========================================================\n\n');

[w_best,w,spectral_rad] = Best_Omega(sys2.A2.A2); % To calc the spectral rad vs omega

[x3, r3, iter3] = SOR(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,w_best,1e-9,100); 
fprintf('\n=============================');
fprintf('\nSolution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x3);
disp('    ');         
fprintf('Residual Norm = %d\n', norm(r3(iter3,:)))
fprintf('Number of iterations: %d for omega = %d\n', iter3, w_best);
fprintf('\n=============================');


fprintf('\n==========================================================\n');
fprintf(' 2.3. Solving Linear System Using Descent CG and Cg with preconditioner\n');
fprintf('==========================================================\n\n');

parameters =  struct('tol', 1e-9, 'maxit', 1000);

%Descent

[x4, r4, iter4] = Descent(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,parameters);
fprintf('\n=============================');
fprintf('\nSolution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x4);
disp('    ');         
fprintf('Residual Norm = %d\n', norm(r4(iter4,:)))
fprintf('Number of iterations: %d\n', iter4);
fprintf('\n=============================');

%Conjugate Gradient

[x5, r5, iter5] = cg(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,parameters);

fprintf('\n=============================');
fprintf('\nSolution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x5);
disp('    ');         
fprintf('Residual Norm = %d\n', norm(r5(iter5,:)))
fprintf('Number of iterations: %d\n', iter5);
fprintf('\n=============================');

%Preconditioner

[x6, r6, iter6] = precond_cg(sys2.A2.A2,sys2.b2.b2,0 * sys2.b2.b2,parameters);

fprintf('\n=============================');
fprintf('\nSolution vector (x):\n');
disp('    ');
fprintf('\t%.6f\n', x6);
disp('    ');         
fprintf('Residual Norm = %d\n', norm(r6(iter6,:)))
fprintf('Number of iterations: %d\n', iter6);
fprintf('\n=============================');

try % Same as in python

    %Load the screen size to create a good figure
    screen_size = get(0, 'ScreenSize');
    width = screen_size(3);
    height = screen_size(4);

    %the figure
    totalfig = figure(...
        'Position', [screen_size(3)*0.05, screen_size(4)*0.05, screen_size(3)*0.9, screen_size(4)*0.775], ...
        'Color', 'white', ... 
        'NumberTitle', 'off', ... 
        'Name', 'Plots' ...
    );
    sgtitle('All Plots', 'FontSize', 20);

    subplot('Position', [0.05 0.1 0.6 0.8]);

    % Create semilog plot of residual norms
    hold on;
    semilogy(1:iter1, vecnorm(r1,2,2),'Color', [0, 0.2, 0.5], 'DisplayName', 'Jacobi');
    semilogy(1:iter2, vecnorm(r2,2,2),'Color', [0.8, 0.1, 0.1], 'DisplayName', 'Gauss-Seidel');
    semilogy(1:iter3, vecnorm(r3,2,2), 'Color', [0, 0.6, 0.2], 'DisplayName',  'SOR (w=1.040)');
    semilogy(1:iter4, vecnorm(r4,2,2), 'Color', [0.9, 0.6, 0], 'DisplayName', 'Descent');
    semilogy(1:iter5, vecnorm(r5,2,2), 'Color', [0.5, 0, 0.5], 'DisplayName', 'Conjugate Gradient');
    semilogy(1:iter6, vecnorm(r6,2,2), 'Color', [0.1, 0.7, 0.9], 'DisplayName', 'Precond. CG');


    grid on;

    legend({'Jacobi', 'Gauss-Seidel', 'SOR $(\omega=1.041$)', 'G-Descent', 'C-G', 'C-G-Precond'}, 'Location', 'northeast');
    title('Evolution of \( r = b_2 - A_2 x \) vs iter.');

    xlabel('Iterations', 'Interpreter', 'latex');
    ylabel('$ r = b_2 - A_2 x $', 'Interpreter', 'latex');

    set(gca, 'YScale', 'log')

    subplot('Position', [0.7 0.55 0.25 0.35]);%plot of rho vs omega

    hold on;
    plot(w, spectral_rad, 'Color', [0, 0.2, 0.5], 'LineWidth', 2); 

    grid on;

    legend({'$\rho (A)$'}, 'Location', 'northeast');
    title('optimal value of $\omega$');

    xlabel('$\omega$', 'Interpreter', 'latex');
    ylabel('$\rho (A)$', 'Interpreter', 'latex');


    subplot('Position', [0.7 0.1 0.25 0.35]);

    title('Iterations needed to reach tolerance of $10^{-9}$');

    data = {
    iter1, iter2, iter3, iter4, iter5, iter6;
    };

    %To create a table in the subplot position :)
    columnNames = {'Jacobi', 'Gauss-Seidel', 'SOR', 'Steepest Descent', 'CG', 'precondCG'};

    % UiTable works fine
    t = uitable('Data', data, 'ColumnName', columnNames, 'Units', 'normalized', 'Position', [0.7 0.1 0.25 0.35]);

    axis off;

catch % If the previous doesent work

    figure(1);

    % Create semilog plot of residual norms
    hold on;
    % Create semilog plot of residual norms
    hold on;
    semilogy(1:iter1, vecnorm(r1,2,2),'Color', [0, 0.2, 0.5], 'DisplayName', 'Jacobi');
    semilogy(1:iter2, vecnorm(r2,2,2),'Color', [0.8, 0.1, 0.1], 'DisplayName', 'Gauss-Seidel');
    semilogy(1:iter3, vecnorm(r3,2,2), 'Color', [0, 0.6, 0.2], 'DisplayName',  'SOR (w=1.040)');
    semilogy(1:iter4, vecnorm(r4,2,2), 'Color', [0.9, 0.6, 0], 'DisplayName', 'Descent');
    semilogy(1:iter5, vecnorm(r5,2,2), 'Color', [0.5, 0, 0.5], 'DisplayName', 'Conjugate Gradient');
    semilogy(1:iter6, vecnorm(r6,2,2), 'Color', [0.1, 0.7, 0.9], 'DisplayName', 'Precond. CG');


    grid on;

    legend({'Jacobi', 'Gauss-Seidel', 'SOR $(\omega=1.041$)', 'G-Descent', 'C-G', 'C-G-Precond'}, 'Location', 'northeast');
    title('Evolution of \( r = b_2 - A_2 x \) vs iter.');

    xlabel('Iterations', 'Interpreter', 'latex');
    ylabel('$ r = b_2 - A_2 x $', 'Interpreter', 'latex');

    set(gca, 'YScale', 'log')

    figure(2);

    hold on;
    plot(w, spectral_rad, 'Color', [0, 0.2, 0.5], 'LineWidth', 2); 

    grid on;

    legend({'$\rho (A)$'}, 'Location', 'northeast');
    title('optimal value of $\omega$');

    xlabel('$\omega$', 'Interpreter', 'latex');
    ylabel('$\rho (A)$', 'Interpreter', 'latex');

end




