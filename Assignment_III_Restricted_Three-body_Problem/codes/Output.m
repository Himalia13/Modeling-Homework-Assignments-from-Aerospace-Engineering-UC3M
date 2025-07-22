function Output(A, complex, theta, scaled_lambdas_Ex21, dts_Ex21, scaled_lambdas_Ex22,  dts_Ex22, t_eu, X_eu, t_rk4, X_rk4, dts5, u0, t,dX, toc1, toc2)

    try

        % Load the screen size to create a good figure
        fprintf('Loading Screen Size.\n')
        screen_size = get(0, 'ScreenSize');
        width = screen_size(3);
        height = screen_size(4);

        % Create the figure

        fprintf('Creating Figure 1.\n')
        totalfig1 = figure( 'Position', [screen_size(3)*0.03, screen_size(4)*0.05, screen_size(3)*0.94, screen_size(4)*0.85], 'Color', 'white', 'NumberTitle', 'off', 'Name', 'Part 1');
        sgtitle('Part 1, 2 and 3', 'FontSize', 20, 'Interpreter', 'latex');

        % Before Stability
        subplot('Position', [0.05, 0.5, 0.37*height/width, 0.37]);
 
        plot(real(complex), imag(complex), 'k');
        hold on;
                
        scatter(real(scaled_lambdas_Ex21), imag(scaled_lambdas_Ex21),'g', 'filled') % Plot eigenvalues
        line([0 0], [-1.1 1.1], 'LineStyle', ':', 'Color', 'k', 'LineWidth', 1.5)
        xlabel('Real Part'); ylabel('Imaginary Part');
        title('Eigenvalues with $\Delta t^{*} = 1$ vs. Euler Stability Region');
        grid on; axis equal;
        fill([-2.1 0.1 0.1 -2.1], [-1.1 -1.1 1.1 1.1], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        xlim([-2.1 0.1])
        ylim([-1.1 1.1])
        
        fill(-1 + cos(theta), sin(theta), 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        set(gca, 'FontSize', 12);
        
        % After Stability
        subplot('Position', [0.05, 0.05, 0.37*height/width, 0.37]);

        plot(real(complex), imag(complex), 'k');
        hold on;
        
        scatter(real(scaled_lambdas_Ex22), imag(scaled_lambdas_Ex22),'g', 'filled') % Plot eigenvalues
        line([0 0], [-1.1 1.1], 'LineStyle', ':', 'Color', 'k', 'LineWidth', 1.5)
        xlabel('Real Part'); ylabel('Imaginary Part');
        title('Eigenvalues Scaled by Time Step Small Enough for Stability ');
        grid on; axis equal;
        fill([-2.1 0.1 0.1 -2.1], [-1.1 -1.1 1.1 1.1], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        xlim([-2.1 0.1])
        ylim([-1.1 1.1])
        
        fill(-1 + cos(theta), sin(theta), 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        set(gca, 'FontSize', 12);
       
        %X-Y velocity and position plots
        subplot('Position', [0.1 + 0.37*height/width, 0.53, 0.25*height/width, 0.25]);plot(t_eu,X_eu(1,:)); title('x position');
        xlabel('Time (t)');
        ylabel('x-Coordinate')
       subplot('Position', [0.1 + 0.37*height/width, 0.14, 0.25*height/width, 0.25]); plot(t_eu,X_eu(2,:)); title('x velocity');
        xlabel('Time (t)');
        ylabel('x-Velocity')
        subplot('Position', [0.1 + 0.7*height/width, 0.53, 0.25*height/width, 0.25]); plot(t_eu,X_eu(3,:)); title('y position');
        xlabel('Time (t)');
        ylabel('y-Coordinate')
        subplot('Position', [0.1 + 0.7*height/width, 0.14, 0.25*height/width, 0.25]); plot(t_eu,X_eu(4,:)); title('y velocity');
        xlabel('Time (t)');
        ylabel('y-Velocity')

        % Plot the trajectory in the xy plane
         subplot('Position', [0.68, 0.3, 0.5*height/width, 0.5]);
        plot(X_eu(1,:),X_eu(3,:),'b-'); 
        axis([-1.5 1 -1.5 1.5]);
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        grid on;
        title('Trajectory of Third Body (Euler)');
        set(gca, 'FontSize', 12);

        annotation('textbox', [0.68, 0.01, 0.5*height/width, 0.2], 'String', 'The figure shows the stabilization of eigenvalues through time-step refinement, the time evolution of the third body state variables, and its resulting stable 2D trajectory under the explicit Euler method.','HorizontalAlignment', 'center','EdgeColor', 'none', 'Interpreter', 'latex');
    
        fprintf('Creating Figure 2.\n')
        totalfig2 = figure( 'Position', [screen_size(3)*0.03, screen_size(4)*0.05, screen_size(3)*0.94, screen_size(4)*0.8], 'Color', 'white', 'NumberTitle', 'off', 'Name', 'Part 2');
        sgtitle('Part 4, 5 and 6', 'FontSize', 20, 'Interpreter', 'latex');
        
        subplot('Position', [0.1, 0.1, 0.7*height/width, 0.8]);
        plot(X_eu(1,:), X_eu(3,:), 'b-', X_rk4(1,:), X_rk4(3,:), 'r-');
        axis([-1.5 1.5 -1.5 1.5]);
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        title('Trajectory of Third Body: Euler vs. RK4 for $\Delta t^* =  7.62939 \times 10^{-6}$');
        legend('Euler', 'RK4');
        grid on;

        subplot('Position', [0.55, 0.55, 0.7*height/width, 0.35]);
        % Load the for time 
        fprintf('Loading .mat.\n')
        try; load('rk4_results.mat');catch; ItdeltaT(dts5, u0, t,dX); load('rk4_results.mat');end
        
        dt_all = [results.dt];
        N = length(results);
        
        cmap = jet(N);
        hold on;
   
        % Plot the trayectories
        for i = 1:N
            plot(results(i).X(1, :), results(i).X(3, :), 'Color', cmap(i, :));
        end
        hold off;
        axis([-2.7 2.7 -1.5 1.5]);
        grid on;
        
        colormap(jet);
        cb = colorbar;
        
        %Calculate index for the colorbar
        if N >= 2
            index = [1, ceil(N/2), N];
        else
            index = 1;
        end
        tick_positions = (index - 1) / (N - 1);
        
        tick_labels = num2str(dt_all(index)', '%.4f');
        set(cb, 'Ticks', tick_positions, 'TickLabels', tick_labels);
        
        % Colorbar label
        cb.Label.String = '\Delta t';
        
        xlabel('$x$');
        ylabel('$y$');
        title('RK4 with $\Delta t$ Variable');

        %task 6
        fprintf('Recomputing for task 6.\n')
        subplot('Position', [0.55, 0.1, 0.7*height/width, 0.35]);
        dt_large = dts5 * 2.^8; % Use largest Delta t from Task 5
        toc11 = evalc('tic;[X_eu_large, t_eu_large] = ODEexplicitEuler(u0, t, dt_large, dX);toc;');
        toc22 = evalc('tic;[X_rk4_large, t_rk4_large] = ODErk4(u0, t, dt_large, dX);toc;');
        
        plot(X_eu_large(1,:), X_eu_large(3,:), 'b-', X_rk4_large(1,:), X_rk4_large(3,:), 'r-');
        hold on
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        title(['Trajectory with $\Delta t = 0.0019531$: Euler vs. RK4']);
        legend('Euler', 'RK4');
        grid on;
        axis([-23 23 -15 15]);
        hold off
        
    catch % if plotting does not work

        % close all;
        figure
        plot(real(complex), imag(complex), 'k');
        hold on;
        
        % After Stability
        
        scatter(real(scaled_lambdas_Ex21), imag(scaled_lambdas_Ex21),'g', 'filled') % Plot eigenvalues
        line([0 0], [-1.1 1.1], 'LineStyle', ':', 'Color', 'k', 'LineWidth', 1.5)
        xlabel('Real Part'); ylabel('Imaginary Part');
        title('Eigenvalues with $\Delta t^{*} = 1$ vs. Euler Stability Region');
        grid on; axis equal;
        fill([-2.1 0.1 0.1 -2.1], [-1.1 -1.1 1.1 1.1], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        xlim([-2.1 0.1])
        ylim([-1.1 1.1])
        
        fill(-1 + cos(theta), sin(theta), 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        figure
        plot(real(complex), imag(complex), 'k');
        hold on;
        
        scatter(real(scaled_lambdas_Ex22), imag(scaled_lambdas_Ex22),'g', 'filled') % Plot eigenvalues
        line([0 0], [-1.1 1.1], 'LineStyle', ':', 'Color', 'k', 'LineWidth', 1.5)
        xlabel('Real Part'); ylabel('Imaginary Part');
        title('Eigenvalues Scaled by Time Step Small Enough for Stability ');
        grid on; axis equal;
        fill([-2.1 0.1 0.1 -2.1], [-1.1 -1.1 1.1 1.1], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
        xlim([-2.1 0.1])
        ylim([-1.1 1.1])
        
        fill(-1 + cos(theta), sin(theta), 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
        
        figure
        plot(t_eu,X_eu(1,:)); title('x position');
        xlabel('Time (t)');
        ylabel('x-Coordinate')
        figure; plot(t_eu,X_eu(2,:)); title('x velocity');
        xlabel('Time (t)');
        ylabel('x-Velocity')
        figure; plot(t_eu,X_eu(3,:)); title('y position');
        xlabel('Time (t)');
        ylabel('y-Coordinate')
        figure; plot(t_eu,X_eu(4,:)); title('y velocity');
        xlabel('Time (t)');
        ylabel('y-Velocity')

        figure
        plot(X_eu(1,:),X_eu(3,:),'b-'); 
        axis([-1.5 1 -1.5 1.5]);
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        grid on;
        title('Trajectory of Third Body (Euler)');
        set(gca, 'FontSize', 12);

        figure
        plot(X_eu(1,:), X_eu(3,:), 'b-', X_rk4(1,:), X_rk4(3,:), 'r-');
        axis([-1.5 1.5 -1.5 1.5]);
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        title('Trajectory of Third Body: Euler vs. RK4 for $\Delta t^* =  7.62939 \times 10^{-6}$');
        legend('Euler', 'RK4');
        grid on;

        figure
        % Load the for time 
        try; load('rk4_results.mat');catch; ItdeltaT(dts5, u0, t,dX); load('rk4_results.mat');end
        
        dt_all = [results.dt];
        N = length(results);
        
        cmap = jet(N);
        hold on;
   
        % Plot the trayectories
        for i = 1:N
            plot(results(i).X(1, :), results(i).X(3, :), 'Color', cmap(i, :));
        end
        hold off;
        axis([-1.5 1.5 -1.5 1.5]);
        grid on;
        
        colormap(jet);
        cb = colorbar;
        
        %Calculate index for the colorbar
        if N >= 2
            index = [1, ceil(N/2), N];
        else
            index = 1;
        end
        tick_positions = (index - 1) / (N - 1);
        
        tick_labels = num2str(dt_all(index)', '%.4f');
        set(cb, 'Ticks', tick_positions, 'TickLabels', tick_labels);
        
        % Colorbar
        cb.Label.String = '\Delta t';
        
        xlabel('$x$');
        ylabel('$y$');
        title('RK4 with $\Delta t$ Variable');


        dt_large = dts5 * 2.^8; % Use largest Delta t from Task 5
        [X_eu_large, t_eu_large] = ODEexplicitEuler(u0, t, dt_large, dX);
        [X_rk4_large, t_rk4_large] = ODErk4(u0, t, dt_large, dX);
        figure;
        plot(X_eu_large(1,:), X_eu_large(3,:), 'b-', X_rk4_large(1,:), X_rk4_large(3,:), 'r-');
        hold on
        xlabel('x-Coordinate');
        ylabel('y-Coordinate');
        title(['Trajectory with $\Delta t = 0.0019531$: Euler vs. RK4']);
        legend('Euler', 'RK4');
        grid on;
        axis([-15 15 -15 15]);
        hold off


    end

    fprintf('\n\n |.............................. Exercise 1 ..............................|\n\n')
    disp('Matrix A:');
    disp(A);
    disp('Vector B (as a function handle):');
    disp('B = @(u1, u2) [0; -nmu*(u1 + mu)/D1(u1, u2) - mu*(u1 - nmu)/D2(u1, u2); 0; -nmu*u2/D1(u1, u2) - mu*u2/D2(u1, u2)];');
    disp('System dX/dt (as a function handle):');
    disp('dX = @(X) A*X(:) + B(X(1), X(3))'';');

    fprintf('\n\n |.............................. Exercise 2 ..............................|\n\n')
    
    fprintf('The Stable lambdas are:\n')
    for i = 1:length(scaled_lambdas_Ex22)
        fprintf('    %d    %.15f    %.15f\n', i, real(scaled_lambdas_Ex22(i)), imag(scaled_lambdas_Ex22(i)));
    end

    fprintf('\n\n |.............................. Exercise 3 ..............................|\n\n')
    
    fprintf('Time of computing Explicit Euler is:\n')
    fprintf(toc1)

    fprintf('\n\n |.............................. Exercise 4 ..............................|\n\n')
    
    fprintf('Time of computing Range Kuta is:\n')
    fprintf(toc2)

    fprintf('\n\n |.............................. Exercise 5 ..............................|\n\n')

    fprintf('The highest ∆t that will give reasonably good results is %.6f \n', dts5 * 2.^8)

    fprintf('\n\n |.............................. Exercise 6 ..............................|\n\n')
    
    fprintf('Time of computing Explicit Euler (∆t = %.6f) is:\n', dts5 * 2.^8)
    fprintf(toc11)
    
    fprintf('Time of computing Range Kuta (∆t = %.6f) is:\n', dts5 * 2.^8)
    fprintf(toc22)


end
