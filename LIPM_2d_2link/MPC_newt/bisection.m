function [u, C, n] = bisection(P, dt, q0, um, c1, c2, Cq, eps)
    %% Bisection Method to Solve for Input
    ua = -um;
    ub =  um;
    uave = zeros(length(um), 1);
    
    Ca = cost(P, dt, q0, ua, c1, c2, Cq);
    Cb = cost(P, dt, q0, ub, c1, c2, Cq);
    Cave = cost(P, dt, q0, uave, c1, c2, Cq);
    du = Inf(length(Cq), 1);
    count = 1;
    while (sum(du > eps) == length(du))
        
        if (sum(Cave) < eps)
            break;
        end
        
        for i = 1:length(Cq)
            
            if (du(i) < eps)
                break;
            end

            if(Ca(i) < Cb(i))
                ub(i) = uave(i);
                Cb(i) = Cave(i);
                du(i) = abs(ua(i)-uave(i));
            else
                ua(i) = uave(i);
                Ca(i) = Cave(i);
                du(i) = abs(ub(i)-uave(i));
            end
            
        end
        uave = (ua + ub) ./ 2;
        Cave = cost(P, dt, q0, uave, c1, c2, Cq);
        count = count + 1;
        
        if (count > 1000)
            fprintf("ERROR: Bisection exited - 1000 iterations reached:\n")
            for i = 1:length(Cq)
                fprintf("u%i = %.3f  C%i = %.3f  dC%i = %.3f\n",...
                        i, uave(i), i, Cave(i), i, du(i))
            end
            fprintf("\n")
            break;
        end

    end

    u = uave;
    C = Cave;
    n = count;
end