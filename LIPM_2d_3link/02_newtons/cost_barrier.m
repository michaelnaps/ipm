function [Cb] = cost_barrier(q, mu)
    wmax = 3;

    Cineq = [
         (wmax - q(2))^4;
         (wmax - q(4))^4;
         (wmax - q(6))^4;
        ];

    Cb = mu*Cineq;
end

