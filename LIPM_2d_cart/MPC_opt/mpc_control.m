function [T, q] = mpc_control(q0, T, P, um, c1, c2, C)
    %% MPC Controller
    dt = T(2) - T(1);
    up = [-um; um];  % input constraints
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    
    fmincon(@(q) cost(q), 0, [], [], [], [], [], [],...
        @(u) statespace(q,u,c1,c2))
end