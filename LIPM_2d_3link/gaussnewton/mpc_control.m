function [T, q] = mpc_control(P, T, q0, um, c, Cq, Jq, eps, m, L)    
    %% MPC Controller
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    for i = 2:length(T)
        
        [u, C, n] = gaussnewton(P, dt, q(i-1,1:6), um, c, Cq, Jq, eps, m, L);
        [~, qc] = ode45(@(t,q) statespace(q, u, c, m, L), 0:dt:P*dt, q(i-1,1:6));
        q(i,:) = [qc(2,:), u', C', n];
        
    end
end