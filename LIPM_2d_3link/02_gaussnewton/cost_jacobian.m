function [J] = cost_jacobian(P, dt, q0, u, c, m, L, Cq)
    %% Setup
    J = zeros(size(u));
    du = 0.1;

    for i = 1:length(u)
        un2 = u;
        un1 = u;
        up1 = u;
        up2 = u;

        un2(i) = u(i) - 2*du;
        un1(i) = u(i) - du;
        up1(i) = u(i) + du;
        up2(i) = u(i) + 2*du;
        
        Cn2 = cost(P, dt, q0, un2, c, m, L, Cq);
        Cn1 = cost(P, dt, q0, un1, c, m, L, Cq);
        Cp1 = cost(P, dt, q0, up1, c, m, L, Cq);
        Cp2 = cost(P, dt, q0, up2, c, m, L, Cq);

        J(i) = (Cn2 - 8*Cn1 + 8*Cp1 - Cp2) / (12*du);
    end
end

