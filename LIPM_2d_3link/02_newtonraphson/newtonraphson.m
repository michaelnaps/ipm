function [u, C, n, brk] = newtonraphson(P, dt, q0, u0, um, c, m, L, Cq, eps)
    %% Setup
    a = 1;
    N = length(um);
    uc = u0;
    Cc = cost(P, dt, q0, uc, c, m, L, Cq, 'NNR Initial Cost');
    gc = cost_gradient4pc(P, dt, q0, uc, c, m, L, Cq, 1e-3);
    un = uc;  Cn = Cc;

    count = 1;
    brk = 0;
    while (Cc > eps)
        udn = gc/Cc;
        un = uc - a*udn;
        
        % check boundary constraints
        for i = 1:N
            if (un(i) > um(i))
                un(i) = um(i);
            elseif (un(i) < -um(i))
                un(i) = -um(i);
            end
        end

        Cn = cost(P, dt, q0, un, c, m, L, Cq, 'NNR Initial Cost');
        gn = cost_gradient4pc(P, dt, q0, un, c, m, L, Cq, 1e-3);

        Cdn = abs(Cn - Cc);  % not used currently
        count = count + 1;

        if (sum(gn < eps) == N)
            fprintf("First Order Optimality break. (%i)\n", count)
            brk = 1;
            break;
        end

        if (count == 1000)
            fprintf("ERROR: Iteration break. (%i)\n", count)
            brk = -1;
            break;
        end

        uc = un;  Cc = Cn;  gc = gn;
    end

    if (brk == 0)
        fprintf("Zero cost break. (%i)\n", count)
    end

    u = un;
    C = Cn;
    n = count;

    fprintf("u1 = %.3f  u2 = %.3f  u3 = %.3f\n", u)
end

