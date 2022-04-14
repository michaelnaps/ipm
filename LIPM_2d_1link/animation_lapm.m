function [anim] = animation_lapm(q, T, m, H)    
    %% unpacking
    % adj = pi/2;
    L = H;  q1 = q(:,1);
    thetaList = real(acos(q1/H));
    
    %% Delay
    dt = T(2) - T(1);

    %% animation
    anim = figure('Position', [0 0 400 400]);
    hold on
    for i = 1:length(q(:,1))
        x = q1(i);
        th = thetaList(i);

        x0 = 0; y0 = 0;

        xlapm = x0 + x;
        ylapm = H;
        
        xtrue = x0 + L*cos(th);
        ytrue = y0 + L*sin(th);

        plot([x0 xlapm], [y0 ylapm], '--k', 'linewidth', 2.5); hold on;
        plot([x0 xtrue], [y0 ytrue], 'r', 'linewidth', 1.5); hold on;
        plot(xlapm, ylapm, 's', 'color', '#77AC30', 'markerfacecolor', '#77AC30', 'markersize', m); hold on;
        plot(xtrue, ytrue, 's', 'color', 'k', 'markerfacecolor', 'k', 'markersize', m/2); hold on;

        plot([-L/2 L/2], [0 0], 'color', [0 0 0], 'linewidth', 2);
        ylim([-L L] + 1/4*[-1 1]);  xlim([-L L] + 1/4*[-1 1]);
        hold off

        pause(dt);
    end
end