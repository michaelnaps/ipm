function [u, C, n] = newtonraphson(P, dt, q0, u0, um, c, m, L, Cq, eps)
    %% Gauss Newton Method to Solve for Next Input
    %  notation: subscript 'c' - current
    %            subscript 'n' - next

    % constraints
    umin = -um;
    umax = um;
    
    % initial guess is set to previous input
    a = 1;
    brk = 0;
    uc = u0;
    Cc = cost(P, dt, q0, uc, c, m, L, Cq, 'Initial Cost Calculation');
    Jc = cost_jacobian(P, dt, q0, uc, c, m, L, Cc, Cq);
    un = uc;  Cn = Cc;

    count = 1;
    while (Cc > eps)
        udn = a*(Jc/Cc)
        un = uc - udn;

        for i = 1:length(uc)
            if (un(i) > umax(i))
                un(i) = umax(i);
            elseif (un(i) < umin(i))
                un(i) = umin(i);
            end
        end
        
        Cn = cost(P, dt, q0, un, c, m, L, Cq, "Optimization Loop (iter: " + count + ")");
        Jn = cost_jacobian(P, dt, q0, un, c, m, L, Cn, Cq);
        
        Cdn = abs(Cn - Cc);
        count = count + 1;
        
        if (sum(udn < eps) == length(udn))
            brk = 1;
            break;
        end
        
        if (Cdn < eps)
            brk = 2;
            break;
        end

        if (count == 1000)
            brk = -1;
            break;
        end

        uc = un;  Cc = Cn;  Jc = Jn;
    end
    
    % iteration break
    if (count == 1000)
        fprintf("ERROR: Optimization exited - 1000 iterations reached.\n")
    end

    fprintf("Input found: u1 = %.3f  u2 = %.3f  u3 = %.3f  (%i)  (%i)\n", un, count, brk)

    u = un;
    C = Cn;
    n = count;
end