function [u, C, n] = gaussnewton(P, dt, q0, u0, um, c, m, L, Cq, Jq, eps)
    %% Gauss Newton Method to Solve for Next Input
    %  notation: subscript 'c' - current
    %            subscript 'n' - next
    
    % constraints
    umin = -um;
    umax = um;
    
    % initial guess is set to previous input
    uc = u0;
    [Cc, Jc] = cost(P, dt, q0, uc, c, m, L, Cq, Jq);
    un = uc;  Cn = Cc;

    ui = [0;0;0];
    for i = 1:length(uc)
        if (abs(uc(i)) < eps && Cc(i) > eps)
            ui(i) = 1;
        end
    end

    count = 1;
    while (sum(Cc > eps) > 0)
        un = uc - (Cc\Jc)';
        
        % check constraints
        for i = 1:length(uc)
            if (un(i) > umax(i))
                un(i) = umax(i);
            elseif (un(i) < umin(i))
                un(i) = umin(i);
            end
        end

        [Cn, Jc] = cost(P, dt, q0, un, c, m, L, Cq, Jq);
        count = count + 1;

        if (count == 1000)
            break;
        end
        
        udn = abs(un - uc);
        if (sum(udn < eps) == length(udn))
            break;
        end

        Cdn = abs(Cn - Cc);
        if (sum(Cdn < eps) == length(Cdn))
            break;
        end

        uc = un;  Cc = Cn;
    end
    
    % iteration break
    if (count == 1000)
        fprintf("ERROR: Optimization exited - 1000 iterations reached:\n")
        for i = 1:length(Cq)
            fprintf("u%i,0 = %.3f  u%i,1 = %.3f  Cc%i,0 = %.3f  Cc%i,1 = %.3f\n",...
                    i, uc(i), i, un(i), i, Cc(i), i, Cn(i))
        end
        fprintf("\n")
    end

    if (ui)
        fprintf("ERROR: Bad initial guess - iterations: %i\n", count)
        for i = 1:length(ui)
            if (ui(i))
                fprintf("ui%i = %.3f  uf%i = %.3f\n", i, u0(i), i, un(i))
            end
        end
        fprintf("\n")
    end

    u = un;
    C = Cn;
    n = count;
end