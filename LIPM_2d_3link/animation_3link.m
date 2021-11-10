function [] = animation_3link(q, t, k)
    %% body parameters. 
    % 1 = shank, 2 = thigh, 3 = torso/upper body
    % meant to be roughly plausible, while being somewhat round numbers :)
    L1 = 2; L2 = 2; L3 = 2;
    
    %% unpacking
    adj = pi/2;
    theta1List = q(:,1)-adj;
    theta2List = q(:,3);
    theta3List = q(:,5);

    % with no controller, the simulation will be generally chaotic: 
    % deterministic non-periodic motion with sensitive dependence on initial
    % conditions
    
    dt = t(2) - t(1);
    numFrames = length(t);

    %% animation
    figure(k);
    hold on
    for iFrame = 1:numFrames
        th1 = theta1List(iFrame);
        th2 = theta2List(iFrame);
        th3 = theta3List(iFrame);

        xAnkle = 0; yAnkle = 0;
        xKnee = xAnkle + L1*cos(th1); yKnee = yAnkle + L1*sin(th1);
        xHip = xKnee + L2*cos(th1+th2); yHip = yKnee + L2*sin(th1+th2);
        xHead = xHip + L3*cos(th1+th2+th3); yHead = yHip + L3*sin(th1+th2+th3);

        plot([xAnkle xKnee],[yAnkle yKnee],'r','linewidth',3); hold on;
        plot([xKnee xHip],[yKnee yHip],'b','linewidth',3); hold on;
        plot([xHip xHead],[yHip yHead],'color',[0.1 0.3 1],'linewidth',3); hold on;

        plot([-1 1],[0 0],'color',[0 0 0],'linewidth',2);

        axis equal; % do axis equal before mentioning the xlim ylim
        xlim([-(L1+L2) (L1+L2)]); ylim([-(L1+L2+L3+0.5) (L1+L2+L3+0.5)]);
        pause(dt);
        
        hold off
    end
end