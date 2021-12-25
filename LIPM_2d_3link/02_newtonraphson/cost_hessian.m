function [H] = cost_hessian(P, dt, q0, u, c, m, L, Cq, h)
    % call function from main program (not nested)
    % pass the newest gradient to the function
    % call gradient function 3x to create properly sized matrix for hessian
    %% Setup
    N = length(u);
    H = zeros(N);
    
    for i = 1:N
        un1 = u;
        up1 = u;

        un1(i) = u(i) - h;
        up1(i) = u(i) + h;

        gn1 = cost_gradient(P, dt, q0, un1, c, m, L, Cq, h);
        gp1 = cost_gradient(P, dt, q0, up1, c, m, L, Cq, h);

        gn = (gp1 - gn1)/(2*h);

%         un2 = u;
%         up2 = u;
% 
%         un2(i) = u(i) - 2*h;
%         up2(i) = u(i) + 2*h;
% 
%         gn2 = cost_gradient(P, dt, q0, un2, c, m, L, Cq, h);
%         gp2 = cost_gradient(P, dt, q0, up2, c, m, L, Cq, h);
% 
%         gn = (gn2 - 8*gn1 + 8*gp1 - gp2)/(12*h);
        
        H(i,:) = gn';
    end
end