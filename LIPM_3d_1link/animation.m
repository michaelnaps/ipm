function disp = animation(q,deltaT,fig)

if nargin < 2
    deltaT = 0.1;
end

l1 = 0.5;
l2 = 0.5;

n = size(q,2);
p1 = zeros(2,n); % center of cart position
p2 = zeros(2,n); % pole position
for i=1:n
    p1(:,i) = [l1*cos(q(1,i));l1*sin(q(1,i))];
    p2(:,i) = p1(:,i) + [l2*cos(q(1,i)+q(2,i));l2*sin(q(1,i)+q(2,i))];
    
    
end

disp = figure(fig);clf;
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
    
    pause(deltaT);
end


end

