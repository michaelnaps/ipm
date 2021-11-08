function dq = statespace(q, u, c1, c2)
    %% Setup
    l1 = 1;   l2 = 1;       % [m]
    m1 = 10;  m2 = 10;      % [kg]
    g = 9.81;               % [m/s^2]
    
    u1 = u(1);
    u2 = u(2);
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    %% State Space
    den = l1*(2*m1 + m2 - 2*cos(2*q1 - 2*q3));
    
    dq = [
         (q2);
         (u1 - c1*q2*l1 - g*(2*m1 + m2) * sin(q1) - m2*g*sin(q1-2*q3)...
          - 2*sin(q1-q3)*m2*(q4^2*l2 + q2^2*l1*cos(q1-q3))) / den;
         (q4);
         (u2 - c2*q4 + 2*sin(q1-q3)*(q2^2*l1*(m1 + m2) + g*(m1 + m2)*cos(q1)...
          + q4^2*l2*m2*cos(q1 - q3))) / den;
         ];
end

