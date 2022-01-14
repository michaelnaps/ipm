function [thd_new] = pend_height(T, L, thd, height)
    
    thd_new = thd;

    if (length(height(:,1)) == 1)
        return;
    end
    
    for i = 1:length(height(:,1))
        if (height(i,1) == T)
            thd_new = des_jointangles(L, height(i,2));
            return;
        end
    end
    
end

