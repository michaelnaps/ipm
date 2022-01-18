function [q] = modeuler(P, dt, q0, u, c, m, L)
    %% Initialize Arrays
    q = Inf(P+1, length(q0));

    %% Modified Euler Method
    q(1,:) = q0';
    for i = 1:P
        dq1 = statespace(q(i,:), u, c, m, L)';   % high approximation
        qeu = q(i,:) + dq1*dt;
        dq2 = statespace(qeu, u, c, m, L)';      % low approximation
        q(i+1,:) = q(i,:) + 1/2*(dq1 + dq2)*dt;

        if (sum(isnan(q(i+1,:))) > 0)
            fprintf("ERROR: statespace() returned NaN for inputs.\n")
            fprintf("iteration(s): %i\n\n", i)
            break;
        end
    end
end

