function [dq] = statespace(q, u, c)
    mc = 100;
    mb = 10;
    l = 1;
    g = 9.81;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % Proportional Gain (from 1-link system)
    kp = sin(1/2 * (q1 + pi));
    
    dq = [q2; 0; q4; 0];
    
    dq(2) = kp * u / (mc + mb);   
    dq(4) = (q2 * q4 * sin(q3) - c * l * q4 - mb * l * g * sin(q3)) / ((mc + mb) * l);
end