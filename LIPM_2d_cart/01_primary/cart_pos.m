function [qd_new] = cart_pos(T, qd, position)
    
    qd_new = qd;

    if (length(position(:,1)) == 1)
        return;
    end
    
    for i = 1:length(position(:,1))
        if (position(i,1) == T)
            qd_new(1) = position(i,2);
            return;
        end
    end
    
end