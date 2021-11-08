function C = cost(P, dt, q0, u, c1, c2, Cq)
    % calculate the state over the desired prediction horizon
    %   with constant input
    [~, qc] = ode45(@(t,q) statespace(q,u,c1,c2), 0:dt:P*dt, q0);
    
    % sum of cost over the prediction horizon states
    C = zeros(1, length(Cq));
    for i = 1:length(Cq)
        for j = 1:P+1
            C(i) = C(i) + Cq(i)(qc(j,:));
        end
    end
end