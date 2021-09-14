function [dq] = statespace(th, tao)
    m1 = 5;
    m2 = 10;
    l = 1;
    g = 9.81;
    
    q1 = th(1);
    q2 = th(2);
    q3 = th(3);
    q4 = th(4);
    
    dq = [q2; 0; q4; 0];
    
    dq(2) = (1/m1) * (tao + g * (m1 * sin(q1) - m2 * sin(q1))...
        - (l* q4^2 * sin(q1-q3) / sqrt(2 * (1 + cos(q1-q2)))));
    
    T = 2 * sqrt(2) * l * sqrt(1 + cos(q1-q3));
    U = l * q4^2 * sin(q1-q3) / sqrt(2 * (1 + cos(q1-q3))) - m2 * g * l * cos(q3);
    dq(4) = T / U;
end