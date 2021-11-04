function [T, q] = mpc_control(P, T, q0, um1, um2, c1, c2, Cq, e)
    %% MPC Controller
    dt = T(2) - T(1);
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    for i = 2:length(T)
        
        [u1, u2, C] = bisection(P, dt, q(i-1,1:4), um1, um2, c1, c2, Cq, e);
        [~, qc] = ode45(@(t,q) statespace_test(q, u, c1, c2), 0:dt:P*dt, q(i-1,1:4));
        q(i,:) = [qc(2,:)'; u1; u2; C];
        
    end
end