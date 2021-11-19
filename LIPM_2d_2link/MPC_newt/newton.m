function [u, C, n] = newton(P, dt, q0, um, ug, c1, c2, Cq, Jq, eps)
    %% Variable Setup
    ucurr = ug;
    unext = ug;
    du = Inf(length(Cq), 1);
    
    count = 1;
    while (sum(du > eps) == length(du))
        ucurr = unext;
        [Ccurr, Jcurr] = cost(P, dt, q0, ucurr, c1, c2, Cq, Jq);
        unext = ucurr - Ccurr * Inv(Jcurr);

        if (sum(Ccurr)/3 < eps)
            break;
        end
        
        % check for broken input constraints
        for i = 1:length(um)
            if (unext(i) > um(i)) 
                unext(i) = um(i);
            elseif (unext(i) < -um(i))
                unext(i) = -um(i);
            end
        end
        
        du = abs(ucurr - unext);
        count = count + 1;
        
        if (count > 1000)
            fprintf("ERROR: Bisection exited - 1000 iterations reached:\n")
            for i = 1:length(Cq)
                fprintf("u%i = %.3f  C%i = %.3f  dC%i = %.3f\n",...
                        i, ucurr(i), i, Ccurr(i), i, du(i))
            end
            fprintf("\n")
            break;
        end
    end
    
    u = ucurr;
    C = Ccurr;
    n = count;
end