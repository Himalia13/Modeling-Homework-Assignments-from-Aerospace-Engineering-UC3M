% Assignment 2 
% Andrés Velázquez Vela
% 100525970
% G45

clear; clc; close all;
Config(); % to load latex config

load('data.mat');  % CL and E
% N = 81

% Task 1: Least squares
t1 = evalc('tic;x_ls = LSfit(CL, E);toc;');

% Task 2: Error minimization , gradient descent
x0 = [1; 10; -10; 1];  
t = 1e-1;           
maxIt = 1e6;      
t2 = evalc('tic;x_gd = minError(CL, E, x0, t, maxIt);toc;'); 

% Define CL_lin for plotting
CL_lin = linspace(0, 3, 81);


% Compute curves
E_ls = x_ls(1) + x_ls(2)*CL_lin + x_ls(3)*CL_lin.^2 + x_ls(4)*CL_lin.^3;
E_gd = x_gd(1) + x_gd(2)*CL_lin + x_gd(3)*CL_lin.^2 + x_gd(4)*CL_lin.^3;

Output(CL_lin, E_ls, E_gd, CL, E, x_ls, x_gd,t1,t2)

function Output(CL_lin, E_ls, E_gd, CL, E, x_ls, x_gd, t1,t2)

    try
       
        % Load the screen size to create a good figure
        screen_size = get(0, 'ScreenSize');
        width = screen_size(3);
        height = screen_size(4);
        
        % Create the figure
        totalfig = figure( 'Position', [screen_size(3)*0.03, screen_size(4)*0.05, screen_size(3)*0.94, screen_size(4)*0.85], 'Color', 'white', 'NumberTitle', 'off', 'Name', 'Aerodynamic Efficiency Fits');
        sgtitle('Polynomial Fits for Aerodynamic Efficiency', 'FontSize', 20, 'Interpreter', 'latex');
        
        subplot('Position', [0.05, 0.1, 0.4, 0.1]);
        
        title('Coeficients for both methoths.', 'FontSize', 12);
        
        columnNames = {'c_0', 'c_1', 'c_2', 'c_3'};
        rowNames = {'LS', 'GD'};
        
        uitable('Data', arrayfun(@(x) sprintf('%.8f', x), [x_ls, x_gd]', 'UniformOutput', false), 'ColumnName', columnNames, 'RowName', rowNames, 'Units', 'normalized', 'Position', [0.05, 0.1, 0.4, 0.062], 'ColumnWidth', {0.08625* screen_size(3), 0.08625* screen_size(3), 0.08625* screen_size(3), 0.08625* screen_size(3)});
        
        axis off;
        
        % Combined
        subplot('Position', [0.05, 0.3, 0.4, 0.6]);
        plot(CL, E, 'o', 'DisplayName', 'Data', 'MarkerSize', 5);
        hold on;
        plot(CL_lin, E_ls, '-', 'Color', [0.8, 0.1, 0.1], 'DisplayName', 'LS Fit', 'LineWidth', 1.5);
        plot(CL_lin, E_gd, '-', 'Color', [0.5, 0, 0.5], 'DisplayName', 'GD Fit', 'LineWidth', 1.5);
        xlabel('Lift Coefficient ($C_L$)', 'Interpreter', 'latex');
        ylabel('Efficiency ($E$)', 'Interpreter', 'latex');
        title('Combined Polynomial Fits', 'Interpreter', 'latex');
        legend('Location', 'best', 'Interpreter', 'latex');
        grid on;
        set(gca, 'FontSize', 12);
        
        % Least Squares Fit
        subplot('Position', [0.55, 0.5625, 0.4, 0.3375]);
        plot(CL, E, 'o', 'DisplayName', 'Data', 'MarkerSize', 5);
        hold on;
        plot(CL_lin, E_ls, '-', 'Color', [0.8, 0.1, 0.1], 'DisplayName', 'LS Fit', 'LineWidth', 1.5);
        xlabel('Lift Coefficient ($C_L$)', 'Interpreter', 'latex');
        ylabel('Efficiency ($E$)', 'Interpreter', 'latex');
        title('Least Squares Polynomial Fit', 'Interpreter', 'latex');
        legend('Location', 'best', 'Interpreter', 'latex');
        grid on;
        set(gca, 'FontSize', 12);
        
        % Gradient Descent
        subplot('Position', [0.55, 0.15, 0.4, 0.3375]);
        plot(CL, E, 'o', 'DisplayName', 'Data', 'MarkerSize', 5);
        hold on;
        plot(CL_lin, E_gd, '-', 'Color', [0.5, 0, 0.5], 'DisplayName', 'GD Fit', 'LineWidth', 1.5);
        xlabel('Lift Coefficient ($C_L$)', 'Interpreter', 'latex');
        ylabel('Efficiency ($E$)', 'Interpreter', 'latex');
        title('Gradient Descent Polynomial Fit', 'Interpreter', 'latex');
        legend('Location', 'best', 'Interpreter', 'latex');
        grid on;
        set(gca, 'FontSize', 12);
        
        annotation('textbox', [0.1, 0.02, 0.8, 0.05], 'String', 'As you can see both methods produce almost the same coeficients.','HorizontalAlignment', 'center','EdgeColor', 'none', 'Interpreter', 'latex');
        
    catch % if plotting does not work
    
        close all;
        figure;
        plot(CL, E, 'o', 'DisplayName', 'Data', 'MarkerSize', 5);
        hold on;
        plot(CL_lin, E_ls, '-', 'Color', [0.8, 0.1, 0.1], 'DisplayName', 'LS Fit', 'LineWidth', 1.5);
        plot(CL_lin, E_gd, '-', 'Color', [0.5, 0, 0.5], 'DisplayName', 'GD Fit', 'LineWidth', 1.5);
        xlabel('Lift Coefficient ($C_L$)', 'Interpreter', 'latex');
        ylabel('Efficiency ($E$)', 'Interpreter', 'latex');
        title('Combined Polynomial Fits', 'Interpreter', 'latex');
        legend('Location', 'best', 'Interpreter', 'latex');
        grid on;
        set(gca, 'FontSize', 12);
    
    end
    
    %  coeff for Task 1
    fprintf('Task 1 - Least Squares Coefficients:\n');
    fprintf('c0 = %.6f, c1 = %.6f, c2 = %.6f, c3 = %.6f\n', x_ls);
    fprintf(t1);
    
    % coeff for Task 2
    fprintf('\nTask 2 - Gradient Descent Coefficients:\n');
    fprintf('c0 = %.6f, c1 = %.6f, c2 = %.6f, c3 = %.6f\n', x_gd);
    fprintf(t2);
    
    
    % Compare 
    diff = x_ls - x_gd;
    fprintf('\nDifference (LS - GD):\n');
    fprintf('Δc0 = %.6e, Δc1 = %.6e, Δc2 = %.6e, Δc3 = %.6e\n', diff);

end