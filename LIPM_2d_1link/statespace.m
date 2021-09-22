function dq = statespace(th, tao)
    m = 10;     % [kg]
    l = 10;     % [m]
    g = 9.81;   % [m/s^2]
    
    q1 = th(1);
    q2 = th(2);
    
    dq = [q2; 
        1 / (m * l^2) * tao + (2 * g / l) * cos(q1)];
end