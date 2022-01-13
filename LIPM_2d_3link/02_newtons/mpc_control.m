function [T, q] = mpc_control(P, T, q0, um, c, m, L, Cq, eps, h, push)
    %% Setup
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = push_pendulum(q0, T(1), push);
    
    %% Simulation Loop
    for i = 2:length(T)
        
        % Adjust Cost Function if Applicable
        Cq = adjust_Cq(T(i), L, Cq, h);
        
        % Calculate Optimal Input and Next State
        tic
        [u, C, n] = newtons(P, dt, q(i-1,1:6)', q(i-1,7:9)', um, c, m, L, Cq, eps);
        t = toc;
        qc = modeuler(P, dt, q(i-1,1:6)', u, c, m, L, 'Main Simulation Loop');
        
        % Push Pendulum if Applicable
        qnew = push_pendulum(qc(2,:), T(i), push);
        
        % Add Values to State Matrix
        q(i,:) = [qnew, u', C, n, t];

    end
    
end