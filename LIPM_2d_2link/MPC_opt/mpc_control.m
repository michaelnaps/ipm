function [T, q] = mpc_control(P, T, q0, um, c1, c2, Cq, e)
    %% MPC Controller
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    for i = 2:length(T)
        
        [u, C] = bisection(P, dt, q(i-1,1:4), um, c1, c2, Cq, e);
        [~, qc] = ode45(@(t,q) statespace(q, u, c1, c2), 0:dt:P*dt, q(i-1,1:4));
        q(i,:) = [qc(2,:)'; u; C];
        
    end
end