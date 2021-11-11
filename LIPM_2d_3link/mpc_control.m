function [T, q] = mpc_control(P, T, q0, um, c, Cq, eps)    
    %% MPC Controller
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    for i = 2:length(T)
        
        [u, C, n] = bisection(P, dt, q(i-1,1:6), um, c, Cq, eps);
        [~, qc] = ode45(@(t,q) statespace(q, u, c), 0:dt:1, q(i-1,1:6));
        q(i,:) = [qc(2,:), u', C', n];
        
    end
end