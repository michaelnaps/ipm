function [u1, u2, C] = bisection(P, dt, q0, um1, um2, c1, c2, Cq, e)
    %% Bisection Method to Solve for Input
    ua = -[um1; um2];
    ub =  [um1; um2];
    uave = [0; 0];
    
    Ca = cost(P, dt, q0, ua, c1, c2, Cq);
    Cb = cost(P, dt, q0, ub, c1, c2, Cq);
    Cave = cost(P, dt, q0, uave, c1, c2, Cq);
    dC = Inf;
    while (dC > e)
        
        if (Cave < eps)
            break;
        end

        if(abs(Ca-Cave) < abs(Cb-Cave))
            ub = uave;
            Cb = Cave;
            dC = abs(Ca-Cave);
        else
            ua = uave;
            Ca = Cave;
            dC = abs(Cb-Cave);
        end

        uave = (ua + ub) / 2;
        Cave = cost(P, dt, q0, uave, c1, c2, Cq);

    end

    u1 = uave;
    u2 = um2;
    C = Cave;
end