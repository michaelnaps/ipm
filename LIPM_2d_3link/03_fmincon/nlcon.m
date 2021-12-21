function [c, ceq] = nlcon(P, dt, q0, u, c, m, L)
    wmax = 5;

    qn = modeuler(P, dt, q0, u, c, m, L);

    c = [
         abs(qn(2)) - wmax;
         abs(qn(4)) - wmax;
         abs(qn(6)) - wmax
        ];
    ceq = [];
end