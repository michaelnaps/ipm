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
    u_mpc = (u0-10):1:(u0+10);  % inputs to consider
    
    % cost function
    %          cart vel.     ang. pos.      ang. vel.     prev. input
    C = @(qc) (0-qc(2))^2 + (pi-qc(3))^2 + (0-qc(4))^2 + (qc(5)-qc(6))^2;
    
    % loop for iteration checks
    qt = q';
    c = Inf;  % set to Inf so that first value is auto set
    u = NaN;  % to check if input is assigned properly
    for i = 1:length(u_mpc)
        [t, qt] = ode45(@(t,q) statespace(q,c1,c2), 0:0.5:P, [qt(1:4),u_mpc(i)]);

        % check for lowest value input
        q_mpc = [qt(length(qt(:,1)),:), u_mpc(i)];  % final state
        if C(q_mpc) < c
            u = q_mpc(5);
            c = C(q_mpc);
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