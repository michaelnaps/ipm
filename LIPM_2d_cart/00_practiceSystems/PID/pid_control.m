function [dq] = pid_control(q, c1, c2, kp, ki, kd, tau, range)
    %% Setup
    qd = pi;
    t = 0.1;   % [s], time span
    mc = 100;  % [kg]
    mb = 10;   % [kg]
    l = 1;     % [m]
    g = 9.81;  % [m/s^2]
    
    % Measured/Retained Values
    q1 = q(1);   % not needed for computations
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    q3_0 = q(9);
    
    %% PI Controller
    e0 = q(5);                          % previous error
    ui0 = q(7);                         % previous integral input
    ud0 = q(8);                         % previous derivative input
    e = (qd-q3);                        % error
    up = kp*e;                          % proportional gain
    ui = ui0 + ki*t/2*(e - e0);         % integral gain
    ud = kd*2/(2*tau-t)*(q3-q3_0)...    % derivative gain
       + ud0*(2*tau-t)/(2*tau+t);
    
    % integrator clamp?
    
    % total input
    u = up + ui + ud;
    % input limits
    if u > range
        u = range;
    elseif u < -range
        u = -range;
    end
    
    %% State Space and Controller Variables
    dq = [
         (q2);
         (u - c1 * q2 + mb * sin(q3) * (l * q4^2 - g * cos(q3)))...
               / (mc + mb * sin(q3)^2);               
         (q4);
         (-u * cos(q3) - mb * l * sin(q3) * cos(q3)...
               - (mc + mb) * g * sin(q3)...
               - c2 * l * q4)...
               / (l * (mc + mb * sin(q3)^2));
         (e);   % return for next iteration
         (up);  % for plotting only
         (ui);  % return for next iteration
         (ud);  % return for next iteration
         (q3)
         ];
end