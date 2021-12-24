function [g, h] = cost_gradient4pc(P, dt, q0, u, c, m, L, Cq, h)
    %% Setup
    g = zeros(size(u));

    %% Finite Difference Method (g = gradient)
    for i = 1:length(u)
        un2 = u;
        un1 = u;
        up1 = u;
        up2 = u;

        un2(i) = u(i) - 2*h;
        un1(i) = u(i) - h;
        up1(i) = u(i) + h;
        up2(i) = u(i) + 2*h;

        Cn2 = cost(P, dt, q0, un2, c, m, L, Cq, 'Gradient u(i-2)');
        Cn1 = cost(P, dt, q0, un1, c, m, L, Cq, 'Gradient u(i-1)');
        Cp1 = cost(P, dt, q0, up1, c, m, L, Cq, 'Gradient u(i+1)');
        Cp2 = cost(P, dt, q0, up2, c, m, L, Cq, 'Gradient u(i+2)');
        
        gn = (Cn2 - 8*Cn1 + 8*Cp1 - Cp2)/(12*h);
        
        g(i) = gn;
    end
end

