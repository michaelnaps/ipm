function dq = mpc_control(q, T)
    %% Setup
    qd = [NaN, 0, pi, 0];  % desired values
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
    u0 = q(5);
    cost = [];
    
    % calculate the cost with each possible input
    for i = 1:100
        for j = 1:100
            C = @(u) (qd(2)-q2)^2 + (qd(3)-q3)^2 + (qd(4)-(4))^2 + (u-u0)^2;
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
         (u)
         ];
end