function [dq] = statespace(q, c, kp, ki)
    mc = 100;  % [kg]
    mb = 10;   % [kg]
    l = 1;     % [m]
    g = 9.81;  % [m/s^2]
    
    % Measured/Retained Values
    q1 = q(1);   % not needed for computations
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    e0 = q(5);   % previous error term
    ui0 = q(7);  % previous value of integrator
    
    % PI Controller
    e = (pi - q3) / pi;        % error
    up = kp * e;               % proportional gain
    ui = ui0 + ki * (e - e0);  % integral gain
    ud = 0;                    % derivative gain
    u = up + ui + ud;          % total input
    
    % State Space and Controller Variables
    dq = [
         (q2);
         (u + mb * sin(q3) * (l * q4^2 - g * cos(q3)))...
               / (mc + mb * sin(q3)^2);
         (q4);
         (-u * cos(q3) - mb * l * sin(q3) * cos(q3)...
               - (mc + mb) * g * sin(q3)...
               - c * l * q4)...
               / (l * (mc + mb * sin(q3)^2));
         (e);   % return for next iteration
         (up);  % for plotting only
         (ui)   % return for next iteration
         ];
end