function [] = animation_2link(q, dt)

adj = pi/2;
q_plot = [q(:,1)-adj, q(:,3), q(:,2), q(:,4)]';

if nargin < 2
    dt = 0.1;
end

l1 = 0.5;
l2 = 0.5;

n = size(q_plot,2);
p1 = zeros(2,n); % center of cart position
p2 = zeros(2,n); % pole position
for i=1:n
    p1(:,i) = [l1*cos(q_plot(1,i));l1*sin(q_plot(1,i))];
    p2(:,i) = p1(:,i) + [l2*cos(q_plot(1,i)+q_plot(2,i));l2*sin(q_plot(1,i)+q_plot(2,i))];
    
    
end

figure("Position", [0 0 700 800]);
hold on;

% axis off;
plot([-0.05,0.05],[0,0],'k-','LineWidth',2)




bar1 = plot([0,p1(1,i)],[0,p1(2,i)],'r-','LineWidth',3);
bar2 = plot([p1(1,i),p2(1,i)],[p1(2,i),p2(2,i)],'k-','LineWidth',3);
point1 = plot(p1(1,i),p1(2,i),'b.','MarkerSize',30);
point2 = plot(p2(1,i),p2(2,i),'b.','MarkerSize',30);

axis([-1.5 1.5 -1.5 1.5]);
axis('equal');
axis manual;

for i=1:n
    bar1.XData = [0,p1(1,i)];
    bar1.YData = [0,p1(2,i)];
    bar2.XData = [p1(1,i),p2(1,i)];
    bar2.YData = [p1(2,i),p2(2,i)];
    point1.XData = p1(1,i);
    point1.YData = p1(2,i);
    point2.XData = p2(1,i);
    point2.YData = p2(2,i);
    
    drawnow;
    
    pause(dt);
end


end

