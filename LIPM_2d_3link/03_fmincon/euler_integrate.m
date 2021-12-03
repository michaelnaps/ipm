function [q] = euler_integrate(P, dt, q0, u, c, m, L)
    %% Initialize Arrays
    q = zeros(P+1, length(q0));
    dq = zeros(P, length(q0));

    %% Enter Euler Loop
    q(1,:) = q0';
    for i = 1:P
        dq(i,:) = statespace(q(i,:), u, c, m, L);
        q(i+1,:) = q(i,:) + (dt)*dq(i,:);
    end
end

