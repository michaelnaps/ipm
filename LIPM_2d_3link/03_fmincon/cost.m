function Ct = cost(P, dt, q0, u, c, m, L, Cq)
    %% Cost of Constant Input
    % calculate the state over the desired prediction horizon
%     [~, qc] = ode45(@(t,q) statespace(q, u, c, m, L), 0:dt:P*dt, q0);
    qc = ode_euler(P, dt, q0, u, c, m, L);
    
    % sum of cost of each step of the prediction horizon
    C = zeros(size(u'));
    for i = 1:P+1
        C = C + Cq(qc(i,:));
    end
    Ct = sum(C);
end