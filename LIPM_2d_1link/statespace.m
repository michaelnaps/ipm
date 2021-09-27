function dq = statespace(th, tao)
    m = 100;    % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
    
    q1 = th(1);
    q2 = th(2);
    
    dq = [q2; 
        (tao - m * g * l * sin(q1)) / (m * l^2)];
end