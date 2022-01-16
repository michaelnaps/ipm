function figid = animation_cart(q, T, m, L)
    %% body parameters.
    m1 = m(1); m2 = m(2);
    L1 = L(1); L2 = L(2);
    
    %% unpacking
    % adj = pi/2;
    thetaList = q(:,1);
    cartList = q(:,3);
    
%     CoM = map_CoM(q,m,L);
%     xCoM = CoM(:,1);
%     yCoM = CoM(:,2);
    
    %% Delay
    dt = T(2) - T(1);

    %% animation
    figure('Position', [0 0 700 800]);
    hold on
    for iFrame = 1:length(T)
        theta = thetaList(iFrame);
        cart = cartList(iFrame);

        xcart = cart;
        ycart = 0;
        xpend = xcart + L2*cos(theta);
        ypend = ycart + L2*sin(theta);

        plot(xcart, ycart,'.','LineWidth',3); hold on;
        plot([xcart-1.0 xcart+1.0], [ycart-0.5 ycart-0.5], 'k', 'LineWidth', 3); hold on;
        plot([xcart+1.0 xcart+1.0], [ycart-0.5 ycart+0.5], 'k', 'LineWidth', 3); hold on;
        plot([xcart+1.0 xcart-1.0], [ycart+0.5 ycart+0.5], 'k', 'LineWidth', 3); hold on;
        plot([xcart-1.0 xcart-1.0], [ycart+0.5 ycart-0.5], 'k', 'LineWidth', 3); hold on;
        
        plot([xcart xpend], [ycart ypend], 'b', 'LineWidth', 3); hold on;

        axis equal; % do axis equal before mentioning the xlim ylim
        xlim([min(cartList)-2 max(cartList)+2]);
        ylim([-3/2*L2 3/2*L2]);
        pause(dt/10);
        
        hold off
    end
end

