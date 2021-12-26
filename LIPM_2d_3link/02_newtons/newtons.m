function [u, C, n, brk] = newtons(P, dt, q0, u0, um, c, m, L, Cq, eps)
    %% Setup - Initial Guess, Cost, Gradient, and Hessian
    N = length(um);
    uc = u0;
    Cc = cost(P, dt, q0, u0, uc, c, m, L, Cq, "NN Initial Cost");
    un = uc;  Cn = Cc;

    %% Loop for Newton's Method
    count = 1;
    brk = 0;
    while (Cc > eps)
        % gradient and hessian of the current input
        g = cost_gradient(P, dt, q0, u0, uc, c, m, L, Cq, 1e-3, "NN Initial Gradient");
        H = cost_hessian(P, dt, q0, u0, uc, c, m, L, Cq, 1e-3, "NN Initial Hessian");

        % calculate and add the next Newton's step
        un = uc - H\g;

        % compute new values for cost, gradient, and hessian
        Cn = cost(P, dt, q0, u0, un, c, m, L, Cq, "NN Next Cost");
        udn = abs(un - uc);
        count = count + 1;

        % first order optimality break
        if (sum(g < eps) == N)
            % fprintf("First Order Optimality break. (%i)\n", count)
            brk = 1;
            break;
        end

        % change in input break
        if ((udn < eps) == N)
            % fprintf("Change in input break. (%i)\n", count)
            brk = 2;
            break;
        end

        % maximum iteration break
        if (count == 1000)
            fprintf("ERROR: Iteration break. (%i)\n", count)
            fprintf("udn1 = %.3f  udn2 = %.3f  udn3 = %.3f\n", udn)
            fprintf("u1 = %.3f  u2 = %.3f  u3 = %.3f\n", un)
            fprintf("g1 = %.3f  g2 = %.3f  g3 = %.3f\n", g)
            brk = -1;
            break;
        end

        % update current variables for next iteration
        uc = un;
    end

    if (brk == 0)
        % fprintf("Zero cost break. (%i)\n", count)
    end
        
    % check boundary constraints
    for i = 1:N
        if (un(i) > um(i))
            un(i) = um(i);
        elseif (un(i) < -um(i))
            un(i) = -um(i);
        end
    end

    %% Return Values for Input, Cost, and Iteration Count
    u = un;
    C = Cn;
    n = count;
end

