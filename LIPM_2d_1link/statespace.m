function dq = statespace(th, u)
    m = 100;    % [kg]
    l = 1;      % [m]
    g = 9.81;   % [m/s^2]
    
    q1 = th(1);
    q2 = th(2);
    
    dq = [q2; 
        (u - m * g * l * cos(q1)) / (m * l^2)];
        % - g / l * cos(q1)];
end