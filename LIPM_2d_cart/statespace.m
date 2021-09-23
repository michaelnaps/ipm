function [dx] = statespace(q, u)
    mc = 10;
    mb = 1;
    l = 1;
    g = -9.81;
    
    x1 = q(1);
    x2 = q(2);
    x3 = q(3);
    x4 = q(4);
    
    dx = [x2; 0; x4; 0];
    
    dx(2) = u / (mc + mb);    
    dx(4) = (x2 * x4 * sin(x3) - g * cos(x3)) / l;
end