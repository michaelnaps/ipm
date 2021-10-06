function [dq] = statespace(q, u, c1, c2)
    mc = 1000;
    mb = 100;
    l = 1;
    g = 9.81;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % Proportional Gain (from 1-link system)
    kp = 0; %sin(1/2 * (q3 + pi));
    
    dq = [(q2);
          (kp * u - c1 * q2) / (mc + mb); 
          (q4); 
          (q2 * q4 * sin(q3) - c2 * l * q4...
             - mb * l * g * sin(q3)) / (mb * l);
          (kp)];
end