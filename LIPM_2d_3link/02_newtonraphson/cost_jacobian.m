function [J] = cost_jacobian(P, dt, q0, u, c, m, L, C, Cq)
    %% Setup
    J = zeros(size(u));
    du = 0.1;

    for i = 1:length(u)
        up1 = u;

        up1(i) = u(i) + du;

        Cp1 = cost(P, dt, q0, up1, c, m, L, Cq, 'Jacobian Calculation');

        J(i) = (Cp1 - C) / du;
    end
end

