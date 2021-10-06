%% Project: Linear Inverted Pendulum Model
%  Complexity: Cart (actuated by cart movement)
%  Created by: Michael Napoli
%  Created on: 9/13/2021

%  Purpose: Model an underactuated linear inverted 
%           pendulum system connected to a moving
%           block with the goal of reaching equilibrium
%           by adjusting the force applied to said
%           block.

clc;clear;
close all;

% establish state space vectors
adj = pi/2;
T = 30;                  % time span
s = [0; 0];            % cart position and velocity
th = [pi/2+adj; 0];    % angular position and velocity
q0 = [s; th; 0];            % initial state space

% solve for time dependent solution
[t, q] = ode45(@(t, q) statespace_sol(q,0,50), [0 T], q0);

% velocity of cart
figure(1)
hold on
yyaxis left
plot(t, q(:,2))
yyaxis right
plot(t, q(:,1))
title('Cart Profile')
legend('Cart Velocity', 'Cart Position')
hold off

% angular position and velocity of pendulum
figure(2)
hold on
yyaxis left
plot(t, q(:,3))
yyaxis right
plot(t, q(:,4))
title('Angular Profile')
legend('Angular Position', 'Angular Velocity') 
hold off

% % proportional gain vs. angular position
% figure(3)
% hold on
% plot(q(:,5), q(:,1))
% title('Proportional Gain Plot')
% xlabel('Kp * Torque [Nm]')
% ylabel('Angle [rad]')
% hold off

% % animate link motion
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1), q(:,4)-adj, zeros(n,1)]', 0.01);