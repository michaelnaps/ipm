function dq = statespace(q, c, kp, ki, kd)
    m = 10;     % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
        
    q1 = q(1);   % [rad]
    q2 = q(2);   % [rad/s]
    e0 = q(3);   % previous error term
    ui0 = q(5);  % previous value of integrator
    
    % error
    e = (pi/2 - q1);  % sin(1/2 * (q1 + pi));
    de = e0 - e;
    
    % proportional controller
    up = kp * e;
    
    % integral controller
    ui = ui0 + ki * (e - e0);

    % derivatice controller
    ud = kd * de;
    
    % total input
    u = up + ui + ud;
    
    dq = [
         (q2); 
         (u - c * l * q2 - m * l * g * cos(q1)) / (m * l)
         (e);   % return for next iteration
         (up);  % for plotting only
         (ui)   % return for next iteration
         ];
end