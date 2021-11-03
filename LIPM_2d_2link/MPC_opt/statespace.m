function dq = statespace(q, u, c1, c2)
    %% Setup
    m1 = 1.0;% kg
    m2 = 1.0;% kg
    I1 = 0.1;
    I2 = 0.1;
    l1 = 0.5;
    l2 = 0.5;
    r1 = l1/2;
    r2 = l2/2;
    g = 9.81;%

    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    %% State Space Equations
    a = I1 + I2 + m1*r1^2 + m2*(l1^2 + r2^2);
    b = m2*l1*r2;
    c = I2 + m2*r2^2;

    M = [a + 2*b*cos(q2), c + b*cos(q2);
        c + b*cos(q2), c];

    C = [-b*sin(q2)*q3*q4 - b*sin(q2)*(q3+q4)*q4;
        b*sin(q2)*q3^2];

    G = [m1*r1*g*cos(q1) + m2*g*(l1*cos(q1) + r2*cos(q1+q2));
        m2*g*r2*cos(q1+q2)];

    U = [-c1*q2; u-c2*q4];

    ddq = M\(U - C - G);

    dq = [q3;q4;ddq];
    dq = [dq(1); dq(3); dq(2); dq(4)];

end

