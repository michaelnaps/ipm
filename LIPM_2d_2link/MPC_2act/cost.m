function C = cost(P, dt, q0, u1, u2, c1, c2, Cq)
    % calculate the state over the desired prediction horizon
    %   with constant input
    [~, qc] = ode45(@(t,q) statespace(q,u1,u2,c1,c2), 0:dt:P*dt, q0);
    
    % sum of cost over the prediction horizon states
    C = 0;
    for i = 1:P+1
        C = C + Cq(qc(i,:));
    end
end