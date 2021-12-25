function Cs = cost(P, dt, q0, u0, u, c, m, L, Cq, loc)
    %% Cost of Constant Input
    % calculate the state over the desired prediction horizon
    qc = modeuler(P, dt, q0, u, c, m, L, loc);
    
    % sum of cost of each step of the prediction horizon
    du = (u0 - u);
    C = zeros(size(L));
    for i = 1:P+1
        C = C + Cq(qc(i,:), du);
    end
    Cs = sum(C);
end