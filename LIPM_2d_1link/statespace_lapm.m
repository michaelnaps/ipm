function ddq = statespace_lapm(q, u, H)
    %% constant variables
    m = 10;  g = -9.81;

    %% state variable setup
    x  = q(1);  L  = q(2);
    dx = q(3);  dL = q(4);

    u = 100*(-x);

    ddq = [
        L/(m*H);
        u + m*g*x;
    ];

    ddq = [dx; dL; ddq(1); ddq(2)];

    return;
end