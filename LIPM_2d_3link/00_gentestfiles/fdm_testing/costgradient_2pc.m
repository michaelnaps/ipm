function [J, h] = costgradient_2pc(P, dt, q0, u, c, m, L, Cq, h)
    %% Setup
    J = zeros(size(u));

    %% Finite Difference Method (J = gradient)
    for i = 1:length(u)
        un1 = u;
        up1 = u;

        un1(i) = u(i) - h;
        up1(i) = u(i) + h;

        Cn1 = cost(P, dt, q0, un1, c, m, L, Cq, 'Gradient u(i-1)');
        Cp1 = cost(P, dt, q0, up1, c, m, L, Cq, 'Gradient u(i+1)');
        
        Jn = (Cp1 - Cn1)/(2*h);
        
        J(i) = Jn;
    end
end

