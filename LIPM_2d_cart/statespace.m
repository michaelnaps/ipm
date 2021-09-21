function [dq] = statespace(q, u)
    mc = 10;
    mb = 1;
    l = 1;
    g = 9.81;
    
    x1 = q(1);
    x2 = q(2);
    x3 = q(3);
    x4 = q(4);
    
    dq = [x2; 0; x4; 0];
    dq(2) = u / mc - (mb / mc) * g * x3;
    dq(4) = u / (mc * l) + g / (mc * l) * (mc + mb) * x3;
end