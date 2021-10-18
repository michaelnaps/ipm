function [up, ui, ud, e] = pid_control(qd, qa, kp, ki, kd, e0, ui0, t)
    %% PI Controller (no D established currently)
    e = (qd - qa);                     % error
    up = kp * e;                       % proportional gain
    ui = ui0 + ki * t / 2 * (e - e0);  % integral gain
    ud = kd;                           % derivative gain
end