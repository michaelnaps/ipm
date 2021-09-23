function [dq] = statespace(th, tao)
    m1 = 10;
    m2 = 10;
    l = 1;
    g = 9.81;
    
    q1 = th(1);
    q2 = th(2);
    q3 = th(3);
    q4 = th(4);
    
    dq = [q2; 0; q4; 0];
    
    dq(2) = (tao - l * m2 * q4 - m1 * g * cos(q1)...
        - m2 * g * cos(q1 + q3)) / (l * (m1 + m2));
    
    dq(4) = (-q2 - g * cos(q1 + q3)) / (l * m2);
end