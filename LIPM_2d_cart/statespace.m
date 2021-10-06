function [dq] = statespace(q, u, c)
    mc = 100;
    mb = 10;
    l = 1;
    g = 9.81;
    
    q1 = q(1);  % not needed for computations
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % Proportional Gain (from 1-link system)
    kp = 1; %sin(1/2 * (q3 + pi));
    
    dq = [
          (q2);
          (u + mb * sin(q3) * (l * q4^2 - g * cos(q3)))...
                / (mc + mb * sin(q3)^2);
          (q4);
          (-u * cos(q3) - mb * l * sin(q3) * cos(q3)...
                - (mc + mb) * g * sin(q3)...
                - c * l * q4)...
                / (l * (mc + mb * sin(q3)^2));
          (kp * u)
         ];
end