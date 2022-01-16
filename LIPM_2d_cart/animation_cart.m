function figid = animation_cart(q, T, m, L)
    %% body parameters.
    m1 = m(1); m2 = m(2);
    L1 = L(1); L2 = L(2);
    
    %% unpacking
    thetaList = q(:,1);
    cartList = q(:,3);
    
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

        plot([xcart-L2/2 xcart+L2/2], [ycart-L2/4 ycart-L2/4], 'k', 'LineWidth', 3); hold on;
        plot([xcart+L2/2 xcart+L2/2], [ycart-L2/4 ycart+L2/4], 'k', 'LineWidth', 3); hold on;
        plot([xcart+L2/2 xcart-L2/2], [ycart+L2/4 ycart+L2/4], 'k', 'LineWidth', 3); hold on;
        plot([xcart-L2/2 xcart-L2/2], [ycart+L2/4 ycart-L2/4], 'k', 'LineWidth', 3); hold on;
        
        plot([xcart xpend], [ycart ypend], 'b', 'LineWidth', 3); hold on;

        axis equal; % do axis equal before mentioning the xlim ylim
        xlim([min(cartList)-L2 max(cartList)+L2]);
        ylim([-3/2*L2 3/2*L2]);
        pause(dt/10);
        
        hold off
    end
end

