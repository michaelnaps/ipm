function dq = statespace(q, ut, ua, c)
    m = 100;
    l = 1;
    g = 9.81;
    
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    dq = [q2
         (ut - c * l * q2 - m * g * l * sin(q1)) / (m * l);
         (q4);
         (ua - c * l * q4 * sin(q1)) / (m * l * sin(q1))];
end