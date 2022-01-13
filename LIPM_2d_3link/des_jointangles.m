function [thd] = des_jointangles(L, h)
    %% Length and Height Parameters
    l1 = L(1); l2 = L(2); l3 = L(3);
    
    h1 = (h - l3)/2;
    h2 = h1;
    h3 = l3;
    
    %% Calculate Necessary Angles
    thd = zeros(size(L));
    
    thd(1) = asin(h1/l1);
    thd(2) = pi - 2*thd(1);
    thd(3) = -1/2*thd(2);
end

