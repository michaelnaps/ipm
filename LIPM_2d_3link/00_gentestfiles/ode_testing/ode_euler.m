function [q] = ode_euler(P, dt, q0, u, c, m, L)
    %% Initialize Arrays
    q = Inf(P+1, length(q0));

    %% Euler Method
    q(1,:) = q0';
    for i = 1:P
        dq = statespace(q(i,:), u, c, m, L)';
        q(i+1,:) = q(i,:) + dq*dt;

        if (sum(isnan(q(i+1,:))) > 0)
            fprintf("ERROR: statespace() returned NaN for inputs.\n")
            fprintf("iteration(s): %i\n\n", i)
            break;
        end
    end
end

