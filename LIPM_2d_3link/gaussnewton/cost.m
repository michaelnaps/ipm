function [C, J] = cost(P, dt, q0, u, c, m, L, Cq, Jq)
    % calculate the state over the desired prediction horizon
    % with constant input
    [~, qc] = ode45(@(t,q) statespace(q, u, c, m, L), 0:dt:P*dt, q0);
    
    % sum of cost over the prediction horizon states
    C = zeros(size(Cq));
	J = zeros(size(Jq));
    for i = 1:length(Cq)
        for k = 1:P+1
            C(i) = C(i) + Cq{i}(qc(k,:));
            
            for j = 1:length(Jq(1,:))
                J(i,j) = J(i,j) + Jq{i,j}(qc(k,:));
            end
        end
    end
end