function C = cost(P, dt, q0, u, c, m, L, Cq)
    % calculate the state over the desired prediction horizon
    % with constant input
    [~, qc] = ode45(@(t,q) statespace(q, u, c, m, L), 0:dt:P*dt, q0);
    
    % sum of cost over the prediction horizon states
    C = zeros(size(u));
    for i = 1:P+1
        C = C + Cq(qc(i,:));
    end
end