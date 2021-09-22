function [dq] = statespace(th, tao)
    m1 = 10;
    m2 = 10;
    l = 1;
    g = -9.81;
    
    q1 = th(1);
    q2 = th(2);
    q3 = th(3);
    q4 = th(4);
    
    dq = [q2; 0; q4; 0];
    
    dq(2) = (g * sin(q1) - sqrt(2) * q4^2 * sin(q1 + q3) / m1...
        - l * m2 * g * cos(q1) / m1 + tao) / l;
    
    T = -sqrt(2) * l * q4^2 * sin(q1+q3) - l * m2 * g * cos(q3);
    U = 2 * sqrt(2) * l * (cos(q1+q3) + 1);
    dq(4) = T / U;
end