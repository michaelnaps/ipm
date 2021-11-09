function [u, C, n] = bisection(P, dt, q0, um, c1, c2, Cq, eps)
    %% Bisection Method to Solve for Input
    ua = -um;
    ub =  um;
    uave = zeros(length(um), 1);
    
    Ca = cost(P, dt, q0, ua, c1, c2, Cq);
    Cb = cost(P, dt, q0, ub, c1, c2, Cq);
    Cave = cost(P, dt, q0, uave, c1, c2, Cq);
    dC = [Inf; Inf];
    count = 1;
    while (sum(dC > eps) == length(dC))
        
        if (sum(Cave) < eps)
            break;
        end
        
        for i = 1:length(Cq)
            
            if (dC(i) < eps)
                break;
            end

            if(Ca(i) < Cb(i))
                ub(i) = uave(i);
                Cb(i) = Cave(i);
                dC(i) = abs(Ca(i)-Cave(i));
            else
                ua(i) = uave(i);
                Ca(i) = Cave(i);
                dC(i) = abs(Cb(i)-Cave(i));
            end
            
        end
        
        uave = (ua + ub) ./ 2;
        Cave = cost(P, dt, q0, uave, c1, c2, Cq);
        count = count + 1;
        
        if (count > 1000)
            fprintf("ERROR: Bisection method diverged at 1000 iterations:\n")
            fprintf("u1  = %.3f    u2  = %.3f\n", uave(1), uave(2))
            fprintf("C1  = %.3f    C2  = %.3f\n", Cave(1), Cave(2))
            fprintf("dC1 = %.3f    dC2 = %.3f\n\n", dC(i), dC(i))
            break;
        end

    end

    u = uave;
    C = Cave;
    n = count;
end