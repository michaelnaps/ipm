function dq = statespace(th, u, c)
    m = 100;    % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
        
    q1 = th(1);
    q2 = th(2);
    
    % Proportional Gain Component
    kp = sin(1/2 * (q1 + pi));
    
    dq = [q2; 
         (kp * u - c * l * q2 - m * l * g * sin(q1)) / (m * l)
         (kp * u)];
end