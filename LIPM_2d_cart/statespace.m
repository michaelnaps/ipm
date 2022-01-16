function dq = statespace(q, u, c, m, L)
    %% Setup
    m1 = m(1);  m2 = m(2);
    L1 = L(1);  L2 = L(2);
    g = 9.81;
    
    q1 = q(1);  q2 = q(2);
    q3 = q(3);  q4 = q(4);
    
    u1 = u(1); u2 = u(2);
    c1 = c(1); c2 = c(2);
    
    %% State Space
    dq = [
         (q2);
         (u1 - c1 * q2 + m2 * sin(q3) * (L2 * q4^2 - g * cos(q3)))...
               / (m1 + m2 * sin(q3)^2);               
         (q4);
         (u2 - m2 * L2 * sin(q3) * cos(q3)...
               - (m1 + m2) * g * sin(q3) - c2 * L2 * q4)...
               / (L2 * (m1 + m2 * sin(q3)^2));
         ];
end