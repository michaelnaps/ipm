function Ct = cost(P, dt, q0, u, c, m, L, Cq)
    %% Cost of Constant Input
    % calculate the state over the desired prediction horizon
%     [~, qc] = ode45(@(t,q) statespace(q, u, c, m, L), 0:dt:P*dt, q0);
    qc = euler_integrate(P, dt, q0, u, c, m, L);

%     u = reshape(u,3,4)
%     u = [...
%         u11, u12, u13, u14;...
%         u21, u22, u23, u24;...
%         u31, u32, u33, u34
%         ];
%     
%     qc(1,:) = q0;
%     dq = statestapce(qc(1,:),u(1,:),c,m,L);
%     qc(2,:) = qc(1,:) + dt*dq;
%     
%     dq = statestapce(qc(2,:),u(2,:),c,m,L);
%     qc(3,:) = qc(2,:) + dt*dq;
    
    % sum of cost of each step of the prediction horizon
    C = zeros(size(u));
    for i = 1:P+1
        C = C + Cq(qc(i,:));
    end
    Ct = sum(sum(C));
end