function [q] = ode_euler(P, dt, q0, u, c, m, L)
    %% Initialize Arrays
    q = zeros(P+1, length(q0));

    %% Enter Modified Euler Loop
    q(1,:) = q0';
    for i = 1:P
        % calculation low approximation
        dq1 = statespace(q(i,:), u, c, m, L)';
        
        % calculate high approximation
        qeu = q(i,:) + dq1*dt;
        dq2 = statespace(qeu, u, c, m, L)';
        
        % use average of dq approximations
        q(i+1,:) = q(i,:) + 1/2*(dq1 + dq2)*dt;

        if (sum(isnan(q(i+1,:))) > 0)
            fprintf("ERROR: statespace() returned NaN for inputs.\n\n")
            break;
        end
    end
end

