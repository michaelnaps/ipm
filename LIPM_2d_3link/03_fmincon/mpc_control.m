function [T, q] = mpc_control(P, T, q0, um, c, m, L, Cq, Jq, eps)
    %% MPC Controller
    options = optimoptions('fmincon','Display','off');
    dt = T(2) - T(1);
    q = NaN(length(T), 9);
    q(1,:) = q0(1:9,:)';
    for i = 2:length(T)
        
        u = fmincon(@(u) cost(P,dt,q(i-1,1:6),u,c,m,L,Cq),q(i-1,7:9),[],[],[],[],-um,um,[],options);
        [~, qc] = ode45(@(t,q) statespace(q,u,c,m,L), 0:dt:P*dt, q(i-1,1:6));
        q(i,:) = [qc(2,:), u];
        
    end
end