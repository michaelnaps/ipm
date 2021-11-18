function [] = animation_3link(q, T, L, CoM)
    %% body parameters. 
    L1 = L(1); L2 = L(2); L3 = L(3);
    
    %% unpacking
    % adj = pi/2;
    theta1List = q(:,1);
    theta2List = q(:,3);
    theta3List = q(:,5);
    
    xCoM = CoM(:,1);
    yCoM = CoM(:,2);
    
    %% Delay
    dt = T(2) - T(1);

    %% animation
    figure('Position', [0 0 700 800]);
    hold on
    for iFrame = 1:length(T)
        th1 = theta1List(iFrame);
        th2 = theta2List(iFrame);
        th3 = theta3List(iFrame);

        xAnkle = 0; yAnkle = 0;
        xKnee = xAnkle + L1*cos(th1); yKnee = yAnkle + L1*sin(th1);
        xHip = xKnee + L2*cos(th1+th2); yHip = yKnee + L2*sin(th1+th2);
        xHead = xHip + L3*cos(th1+th2+th3); yHead = yHip + L3*sin(th1+th2+th3);

        plot([xAnkle xKnee],[yAnkle yKnee],'r','linewidth',3); hold on;
        plot([xKnee xHip],[yKnee yHip],'b','linewidth',3); hold on;
        plot([xHip xHead],[yHip yHead],'color',[0.4660 0.6740 0.1880],'linewidth',3); hold on;
        plot(xCoM(iFrame), yCoM(iFrame), '.', 'color', [0 0 0], 'markersize', 30); hold on;

        plot([-L1/2 L1/2],[0 0],'color',[0 0 0],'linewidth',2);

        axis equal; % do axis equal before mentioning the xlim ylim
        xlim([-(L1+L2) (L1+L2)]); ylim([-(L1+L2+L3+0.5) (L1+L2+L3+0.5)]);
        pause(dt/10);
        
        hold off
    end
end