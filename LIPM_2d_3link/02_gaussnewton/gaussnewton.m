function [u, C, n] = gaussnewton(P, dt, q0, u0, um, c, m, L, Cq, eps, tstep)
    %% Gauss Newton Method to Solve for Next Input
    %  notation: subscript 'c' - current
    %            subscript 'n' - next
    
    % constraints
    umin = -um;
    umax = um;
    
    % initial guess is set to previous input
    uc = u0;
    Cc = cost(P, dt, q0, uc, c, m, L, Cq);
    Jc = cost_jacobian(Cc, P, dt, q0, uc, c, m, L, Cq);
    un = uc;  Cn = Cc;

    count = 1;
    while (sum(Cc > eps) > 0)
        un = uc - (Cc\Jc)';
        
        for i = 1:length(uc)
            if (un(i) > umax(i))
                un(i) = umax(i);
            elseif (un(i) < umin(i))
                un(i) = umin(i);
            end
        end
        
        Cn = cost(P, dt, q0, un, c, m, L, Cq);
        Jc = cost_jacobian(Cn, P, dt, q0, un, c, m, L, Cq);
        
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
        
        uc = un;  Cc = Cn;
    end
    
    % iteration break
    if (count == 1000)
        fprintf("ERROR: Optimization exited - 1000 iterations reached:\n")
        fprintf("Time: %0.3f\n", tstep)
        for i = 1:length(un)
            fprintf("ui%i = %.3f  uf%i = %.3f\n", i, u0(i), i, un(i))
        end
        for i = 1:length(un)
            fprintf("u%i,0 = %.3f  u%i,1 = %.3f  Cc%i,0 = %.3f  Cc%i,1 = %.3f\n",...
                    i, uc(i), i, un(i), i, Cc(i), i, Cn(i))
        end
        fprintf("\n")
    elseif (count > 35)
        fprintf("ERROR: Bad initial guess - iterations: %i\n", count)
        fprintf("Time: %0.3f\n", tstep)
        for i = 1:length(un)
            fprintf("ui%i = %.3f  uf%i = %.3f\n", i, u0(i), i, un(i))
        end
        fprintf("\n")
    end

    u = un;
    C = Cn;
    n = count;
end