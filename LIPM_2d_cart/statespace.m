function [dq] = statespace(q, u, c)
    I = 10;
    mc = 100;
    mb = 10;
    l = 1;
    g = 9.81;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % Proportional Gain (from 1-link system)
    kp = 1; %sin(1/2 * (q3 + pi));
    
    den = mc * mb * l^2 + I * (mc + mb);
    
    dq = [(q2);
          (kp * u * (mb * l^2 + I) - q3 * mb^2 * g * l^2 ... 
                - q2 * c * (mb * l^2 + I)) / den;
          (q4);
          (mb * l - mb * g * l * (mc + mb) - mb * l * c) / den;
          (kp * u)
         ];
end