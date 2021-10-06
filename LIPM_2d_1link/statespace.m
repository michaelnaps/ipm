function dq = statespace(th, c, kp)
    m = 100;    % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
        
    q1 = th(1);
    q2 = th(2);
    
    % error (for proportional gain component)
    e = sin(1/2 * (q1 + pi));
    
    dq = [q2; 
         (kp * e - c * l * q2 - m * l * g * sin(q1)) / (m * l)
         (kp * e)];
end