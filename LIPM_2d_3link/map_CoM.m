function CoM = map_CoM(q, m, L)
    %% Parameters
    q1 = q(:,1);  q3 = q(:,3);  q5 = q(:,5);
    m1 = m(1);    m2 = m(2);    m3 = m(3);
    L1 = L(1);    L2 = L(2);    L3 = L(3);
    
    %% Calculate CoM Positions
    CoM = zeros(length(q(:,1)), 2);
    for i = 1:length(q(:,1))
        th1 = q1(i);
        th2 = q3(i);
        th3 = q5(i);
        
        xAnkle = 0; yAnkle = 0;
        
        xKnee = 2*xAnkle + 1/2*L1*cos(th1);
        yKnee = 2*yAnkle + 1/2*L1*sin(th1);
        
        xHip = 2*xKnee + 1/2*L2*cos(th1+th2);
        yHip = 2*yKnee + 1/2*L2*sin(th1+th2);
        
        xHead = 2*xHip + 1/2*L3*cos(th1+th2+th3);
        yHead = 2*yHip + 1/2*L3*sin(th1+th2+th3);
        
        CoM(i,1) = (m1*xKnee + m2*xHip + m3*xHead) / (m1 + m2 + m3);
        CoM(i,2) = (m1*yKnee + m2*yHip + m3*yHead) / (m1 + m2 + m3);
    end
end

