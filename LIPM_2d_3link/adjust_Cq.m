function [Cq_new] = adjust_Cq(T, L, Cq, h)
    
    Cq_new = Cq;

    if (length(h(:,1)) == 1)
        return;
    end
    
    for i = 1:length(h(:,1))
        if (h(i,1) == T)
            veld = 0;
            thd = des_jointangles(L, h(i,2));
            Cq_new = @(q, du) [
                  100*((cos(thd(1)) - cos(q(1)))^2 + (sin(thd(1)) - sin(q(1)))^2) + (veld - q(2))^2 + 1e-7*(du(1))^2;  % cost of Link 1
                  100*((cos(thd(2)) - cos(q(3)))^2 + (sin(thd(2)) - sin(q(3)))^2) + (veld - q(4))^2 + 1e-7*(du(2))^2;  % cost of Link 2
                  100*((cos(thd(3)) - cos(q(5)))^2 + (sin(thd(3)) - sin(q(5)))^2) + (veld - q(6))^2 + 1e-7*(du(3))^2;  % cost of Link 3
                 ] + cost_barrier(q, 1, 10);
            return;
        end
    end
    
end

