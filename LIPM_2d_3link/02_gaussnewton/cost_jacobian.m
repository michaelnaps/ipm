function [J] = cost_jacobian(C, P, dt, q0, u, c, m, L, Cq)
    %% Setup
    J = Inf(size(u));
    du = 10;

    for i = 1:length(u)
        ul = u;
        uh = u;

        ul(i) = u(i) - du;
        uh(i) = u(i) + du;

        Cl = cost(P, dt, q0, ul, c, m, L, Cq);
        Ch = cost(P, dt, q0, uh, c, m, L, Cq);

        Cn = 1/2*(Cl + Ch);
        J(i) = (C - Cn) / du;
    end
end

