function [dq] = statespace(th, u, c)
    m1 = 10;
    m2 = m1;
    l = 1;
    g = 9.81;
    
    q1 = th(1);
    q2 = th(2);
    q3 = th(3);
    q4 = th(4);
    
    dq = [q2; 0; q4; 0];
    
%     dq(2) = (u - l * m2 * q4 - m1 * g * cos(q1)...
%         - m2 * g * cos(q1 + q3)) / (l * (m1 + m2));
%     
%     dq(4) = (-q2 - g * cos(q1 + q3)) / (l * m2);

    den = l * (2 * m1 + m2 - m2 * cos(2 * q1 - 2 * q3));
    
    dq(2) = (-g * (2 * m1 + m2) * sin(q1) - m2 * g * sin(q1 - 2 * q3)...
        - 2 * sin(q1 - q3) * m2 * (q4^2 * l + q2^2 * l * cos(q1 - q3)))...
        / den;
    
    dq(4) = (2 * sin(q1 - q3) * (q2^2 * l * (m1 + m2) + g * (m1 + m2) * cos(q1)...
        + q3^2 * l * m2 * cos(q1 - q3)))...
        / den;
end