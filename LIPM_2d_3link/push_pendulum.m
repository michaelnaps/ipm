function [qnew] = push_pendulum(q0, T, push)

    if (isempty(push))
        qnew = q0;
        return;
    end

    for i = 1:length(push(:,1))
        if (push(i,1) == T)
            qnew = q0;
            qnew(2*push(i,2)) = qnew(2*push(i,2)) + push(i,3);
            return;
        end
    end

    qnew = q0;
    return;

end