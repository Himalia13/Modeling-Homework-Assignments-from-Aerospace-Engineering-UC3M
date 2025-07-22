function ItdeltaT(dts, u0, t,dX)
    % Generate Delta t values: dts * 2^k up to 2045 * dts
    k_values = 0:11; % 2^11 = 2048
    dt_values = dts * 2.^k_values;
    
    % Initialize structure to store results
    results = struct();
    
    for i = 1:length(dt_values)
        dt = dt_values(i);
        [X_temp, t_temp] = ODErk4(u0, t, dt, dX);
    
        % Store results
        results(i).dt = dt;
        results(i).t = t_temp;
        results(i).X = X_temp;
    end
    % Save results to a .mat file
    save('rk4_results.mat', 'results');
end