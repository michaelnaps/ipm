function dq = mpc_control(q, P, c1, c2)
    %% Setup
    mc = 100;  % [kg]
    mb = 10;   % [kg]
    l = 1;     % [m]
    g = 9.81;  % [m/s^2]
    
    % Measured/Retained Values
    q1 = q(1);   % not needed for computations
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);


    %% MPC Controller
    u0 = q(5);  % from previous iteration
    u_mpc = ((u0-500):25:(u0+500))';  % inputs to consider
    
    % cost function: linear quadratic regulator (based on error)
    %          cart vel.     ang. pos.      ang. vel.     prev. input
    C = @(qc) (0-qc(2))^2 + (pi-qc(3))^2 + (0-qc(4))^2 + (qc(6)-qc(5))^2;
    
    % loop for iteration checks
    c = Inf;
    u = NaN;
    for i = 1:length(u_mpc)
        
        [t,q_mpc] = ode45(@(t,q) statespace(q,c1,c2), 0:P/2:P, [q(1:4); u_mpc(i)]);
        
        % end of prediction horizon
        qc = [q_mpc(2,:)'; u_mpc(i)];
        % check/compare cost of run
        if C(qc) < c
            u = u_mpc(i);
            c = C(qc);
        end
        
    end

    
    %% State Space
    dq = [
         (q2);
         (u - c1 * q2 + mb * sin(q3) * (l * q4^2 - g * cos(q3)))...
               / (mc + mb * sin(q3)^2);               
         (q4);
         (-u * cos(q3) - mb * l * sin(q3) * cos(q3)...
               - (mc + mb) * g * sin(q3) - c2 * l * q4)...
               / (l * (mc + mb * sin(q3)^2));
         (u);
         (c)  % for plotting
         ];
end