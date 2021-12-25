function [H] = cost_hessian(P, dt, q0, u0, u, c, m, L, Cq, h)
    %% Setup
    N = length(u);
    H = zeros(N);
    
    %% Finite Difference Method (H = hessian)
    for i = 1:N
        un1 = u;
        up1 = u;

        un1(i) = u(i) - h;
        up1(i) = u(i) + h;

        Hn1 = cost_gradient(P, dt, q0, u0, un1, c, m, L, Cq, h);
        Hp1 = cost_gradient(P, dt, q0, u0, up1, c, m, L, Cq, h);

        Hn = (Hp1 - Hn1)/(2*h);

%         un2 = u;
%         up2 = u;
% 
%         un2(i) = u(i) - 2*h;
%         up2(i) = u(i) + 2*h;
% 
%         Hn2 = cost_gradient(P, dt, q0, u0, un2, c, m, L, Cq, h);
%         Hp2 = cost_gradient(P, dt, q0, u0, up2, c, m, L, Cq, h);
% 
%         Hn = (Hn2 - 8*Hn1 + 8*Hp1 - Hp2)/(12*h);
        
        H(i,:) = Hn';
    end
end