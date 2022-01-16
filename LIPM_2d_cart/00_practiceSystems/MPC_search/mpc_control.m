function [T, q] = mpc_control(q0, T, P, um, c1, c2, C)
    %% MPC Controller
    dt = T(2) - T(1);
    up = [0; linspace(-um,um,1000)'];  % inputs to consider
    q = NaN(length(T), length(q0));
    q(1,:) = q0;
    for i = 2:length(T)
        
        % MPC Loop
        c = Inf;  % reset every loop
        for j = 1:length(up)
            % solve for states at next state inputs (unrefined)
%             dqc = statespace([q(i-1,1:4)'; up(j)], c1, c2);
%             qc = q(i-1,1:4) + P*dt*dqc(1:4)';
            [~, qc] = ode45(@(t,qc) statespace(qc,up(j),c1,c2),...
                0:dt:P*dt, q(i-1,1:4)'); %, odeset('AbsTol',1e-3));

            % calculate cost
%             Cp = C([qc, q(i-1,6), up(j)]);
            for k = 1:P
                Cp = sum(C(qc(P+1,:)));
            end
            
            % compare new costs
            if (Cp < c)
                c = Cp;
                % add optimized cost-state to output matrix
                q(i,:) = [qc(2,:)'; q(i-1,6); up(j); c]; 
            end
        end % end of MPC
        
    end
end