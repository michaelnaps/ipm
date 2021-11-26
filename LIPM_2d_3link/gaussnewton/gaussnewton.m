function [u, C, n] = gaussnewton(P, dt, q0, u0, um, c, Cq, Jq, eps, m, L)
    %% Gauss Newton Method to Solve for Next Input
    %  notation: subscript 'c' - current
    %            subscript 'n' - next
    
    % constraints
    umin = -um;
    umax = um;
    
    % initial guess is set to previous input
    uc = u0;
    [Cc, Jc] = cost(P, dt, q0, uc, c, Cq, Jq, m, L);
    un = uc;  Cn = Cc;

    count = 1;
    while (sum(Cc > eps) > 0)
        un = uc - Jc\Cc;
        
        % check constraints
        for i = 1:length(uc)
            if (un(i) > umax(i))
                un(i) = umax(i);
            elseif (un(i) < umin(i))
                un(i) = umin(i);
            end
        end
        
        udn = abs(un - uc);
        if (sum(udn < eps) == length(udn))
            fprintf("Change in input break. ")
            fprintf("iterations: %.0f\n", count)
            for i = 1:length(Cq)
                fprintf("u%i = %.3f  Cc%i = %.3f  Jc%i,%i = %.3f\n",...
                    i, uc(i), i, Cc(i), i, i, Jc(i,i))
            end
            fprintf("\n")
            break;
        end

        if (count == 1000)
            break;
        end

        [Cn, Jc] = cost(P, dt, q0, un, c, Cq, Jq, m, L);
        uc = un;  Cc = Cn;
        count = count + 1;
    end
    
    % iteration break
    if (count == 1000)
        fprintf("ERROR: Optimization exited - 1000 iterations reached:\n")
        for i = 1:length(Cq)
            fprintf("u%i = %.3f  Cc%i = %.3f  Jc%i,%i = %.3f\n",...
                    i, uc(i), i, Cc(i), i, i, Jc(i,i))
        end
        fprintf("\n")
    end

    u = un;
    C = Cn;
    n = count;
end