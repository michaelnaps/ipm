function [dq] = statespace(q, u)
    mc = 10;
    mb = 1;
    l = 1;
    g = 9.81;
    
    x1 = q(1);
    x2 = q(2);
    x3 = q(3);
    x4 = q(4);
    
    ddq = [u / (mc + mb);
          (x2 * x4 * cos(x3) - g * cos(x3))/(l + 1)];

    dq = [x2; ddq(1); x4; ddq(2)];
end