function C = cost(P, dt, q0, u, c, Cq)
    % calculate the state over the desired prediction horizon
    % with constant input
    [~, qc] = ode45(@(t,q) statespace1(q, u, c), 0:dt:P*dt, q0);
    
    % sum of cost over the prediction horizon states
    C = zeros(length(Cq), 1);
    for i = 1:length(Cq)
        for j = 1:P+1
            C(i) = C(i) + Cq{i}(qc(j,:));
        end
    end
end