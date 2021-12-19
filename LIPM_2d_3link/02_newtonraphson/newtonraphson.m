function [u, C, n] = newtonraphson(P, dt, q0, u0, um, c, m, L, Cq, eps)
    %% Gauss Newton Method to Solve for Next Input
    %  notation: subscript 'c' - current
    %            subscript 'n' - next

    % constraints
    umin = -um;
    umax = um;
    
    % initial guess is set to previous input
    a = 1;
    uc = u0;
    Cc = cost(P, dt, q0, uc, c, m, L, Cq);
    Jc = cost_jacobian(P, dt, q0, uc, c, m, L, Cq);
    un = uc;  Cn = Cc;

    count = 1;
    while (sum(Cc > eps) > 0)
        un = uc - a*(Cc./Jc);
        
        Cn = cost(P, dt, q0, un, c, m, L, Cq);
        Jn = cost_jacobian(P, dt, q0, un, c, m, L, Cq);
        
        udn = abs(un - uc);
        Cdn = abs(Cn - Cc);
        count = count + 1;
        
        if (sum(udn < eps) == length(udn))
            break;
        end
        
        if (sum(Cdn < eps) == length(Cdn))
            break;
        end

        if (count == 1000)
            break;
        end

        uc = un;  Cc = Cn;  Jc = Jn;
    end

    for i = 1:length(uc)
        if (un(i) > umax(i))
            un(i) = umax(i);
        elseif (un(i) < umin(i))
            un(i) = umin(i);
        end
    end
    
    % iteration break
    if (count == 1000)
        fprintf("ERROR: Optimization exited - 1000 iterations reached:\n")
    end

    u = un;
    C = Cn;
    n = count;
end