function ddq = statespace_lapm(q, u, H)
    %% constant variables
    dt = 0.01;
    m = 10;  g = -9.81;
    
    %% input variables
    ua = u(1);  L = u(2);

    %% state variable setup
    x  = q(1);  Lc  = q(2);
    dx = q(3);  dLc = q(4);

    ddq = [
        L/(m*H) - Lc/(m*H);
        ua + m*g*x;
    ];

    ddq = [dx; dLc; ddq(1); ddq(2)];

    return;
end