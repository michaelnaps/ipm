function [anim] = animation_1link(q, T, m, L)    
    %% unpacking
    % adj = pi/2;
    theta1List = q(:,1);
    
    %% Delay
    dt = T(2) - T(1);

    %% animation
    anim = figure('Position', [0 0 400 400]);
    hold on
    for iFrame = 1:length(q(:,1))
        th1 = theta1List(iFrame);

        xAnkle = 0; yAnkle = 0;
        xKnee = xAnkle + L*cos(th1); yKnee = yAnkle + L*sin(th1);

        plot([xAnkle xKnee], [yAnkle yKnee], '--k', 'linewidth', 2); hold on;
        plot(xKnee, yKnee, 's', 'color', '#77AC30', 'markerfacecolor', '#77AC30', 'markersize', m); hold on;

        plot([-L/2 L/2], [0 0], 'color', [0 0 0], 'linewidth', 2);
        ylim([-L L]);  xlim([-L L]);
        hold off

        pause(dt);
    end
end