function dq = statespace(q, c, kp, ki)
    m = 10;     % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
        
    q1 = q(1);   % [rad]
    q2 = q(2);   % [rad/s]
    e0 = q(3);   % previous error term
    ui0 = q(5);  % previous value of integrator
    
    % error
    e = (pi - q1) / pi;  % sin(1/2 * (q1 + pi));
    
    % proportional controller
    up = kp * e;
    
    % integral controller
    ui = ui0 + ki * (e - e0);
    
    % total input
    u = up + ui;
    
    dq = [
         (q2); 
         (u - c * l * q2 - m * l * g * sin(q1)) / (m * l)
         (e);   % return for next iteration
         (up);  % for plotting only
         (ui)   % return for next iteration
         ];
end