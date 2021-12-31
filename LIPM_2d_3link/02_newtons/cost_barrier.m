function [Cb] = cost_barrier(q, mu)
    wmax = 3;

    Cineq = [
         (q(2)/wmax)^20;
         (q(4)/wmax)^20;
         (q(6)/wmax)^20;
        ];

    Cb = mu*Cineq;
end

