function [Cb] = cost_barrier(q, mu)
    wmax = 3;

    Cineq = [
         (wmax - q(2));
         (wmax - q(4));
         (wmax - q(6));
        ];

    Cb = mu * (-log(Cineq));
end

