function [J] = cost_jacobian(C, P, dt, q0, u, c, m, L, Cq)
    %% Setup
    J = Inf(size(u));
    du = 0.1;

    for i = 1:length(u)
        un = u;
        un(i) = u(i) - du;

        Cn = cost(P, dt, q0, un, c, m, L, Cq);

        J(i) = (C - Cn) / du;
    end
end

