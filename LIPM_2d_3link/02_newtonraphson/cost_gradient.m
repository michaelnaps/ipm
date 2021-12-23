function [J, h] = cost_gradient(P, dt, q0, u, c, m, L, Cq, eps)
    %% Setup
    Jc = Inf;
    J = zeros(size(u));

    h = 1;
    for i = 1:length(u)
        dJ = Inf;

        while (dJ > eps)
            un1 = u;
            up1 = u;
    
            un1(i) = u(i) - h;
            up1(i) = u(i) + h;
    
            Cn1 = cost(P, dt, q0, un1, c, m, L, Cq, 'Gradient u(i-1)');
            Cp1 = cost(P, dt, q0, up1, c, m, L, Cq, 'Gradient u(i+1)');
            
            Jn = (Cp1 - Cn1)/(2*h);
            dJ = abs(Jn - Jc);
            Jc = Jn;
            h = h/10;
        end
        
        J(i) = Jn;
    end

    h = 10*h;
end

