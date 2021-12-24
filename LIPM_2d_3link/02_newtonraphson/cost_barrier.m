function [Cb] = cost_barrier(q, mu)
    wmax = 3;

    Cineq = [
         abs(wmax - q(2));
         abs(wmax - q(4));
         abs(wmax - q(6));
        ];

    Cb = mu * (-log(Cineq));
end

