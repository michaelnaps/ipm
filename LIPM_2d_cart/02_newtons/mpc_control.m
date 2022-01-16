function [T, q] = mpc_control(P, T, q0, um, c, m, L, Cq, thd, eps, position, push)
    %% Setup
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = q0';
    
    %% Simulation Loop
    for i = 2:length(T)        
        % Calculate Optimal Input and Next State
        tic
        [u, C, n] = newtons(P, dt, q(i-1,1:4)', q(i-1,5:6)', um, c, m, L, Cq, thd, eps);
        t = toc;
        qc = modeuler(P, dt, q(i-1,1:4)', u, c, m, L, 'Main Simulation Loop');
        
        % Add Values to State Matrix
        q(i,:) = [qc(2,:), u', C, n, t];

    end
    
end