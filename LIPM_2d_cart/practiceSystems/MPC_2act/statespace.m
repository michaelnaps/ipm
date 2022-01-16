function dq = statespace(q, u, c1, c2)
    %% Setup
    % Constants
    mc = 100;  % [kg]
    mb = 10;   % [kg]
    l = 1;     % [m]
    g = 9.81;  % [m/s^2]
    
    u1 = u(1);  % input to cart
    u2 = u(2);  % input to pendulum
    
    % Current State Values
    q1 = q(1);   % not needed for computations
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    %% State Space
    dq = [
         (q2);
         (u1 - c1 * q2 + mb * sin(q3) * (l * q4^2 - g * cos(q3)))...
               / (mc + mb * sin(q3)^2);               
         (q4);
         (u2 - mb * l * sin(q3) * cos(q3)...
               - (mc + mb) * g * sin(q3) - c2 * l * q4)...
               / (l * (mc + mb * sin(q3)^2));
         ];
end