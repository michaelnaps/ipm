%% Project: Linear Inverted Pendulum Model
%  Complexity: Cart (actuated by cart movement)
%  Created by: Michael Napoli
%  Created on: 9/13/2021

%  Purpose: Model an underactuated linear inverted 
%           pendulum system connected to a moving
%           block with the goal of reaching equilibrium
%            by adjusting the force applied to said
%           block.

clc;clear;
close all;

% establish state space vectors
adj = pi/2;
dt = 0.1;                 % change in time
T = 0:dt:60;              % time span
p = [dt; 2];                    % prediction horizon
s0 = [0; 0];              % cart position and velocity
th0 = [pi; 0.1];        % angular position and velocity
q0 = [s0; th0; 0; 0; 0];     % initial state space

% solve for time dependent solution
[t, q] = ode45(@(t,q) pid_control(q,50,50,1100,100,0), T, q0);

% final angle at end of simulation
disp("Final Velocity of Cart: " + q(length(q),2) + " [m/s]")
disp("Final Position of Pendulum: " + q(length(q),3) + " [rad]")
disp("Final Velocity of Pendulum: " + q(length(q),4) + " [rad/s]")

% % velocity and position of cart
% figure(1)
% hold on
% yyaxis left
% plot(t, q(:,1))
% ylabel('Position [m]')
% yyaxis right
% plot(t, q(:,2))
% ylabel('Velocity [m/s]')
% title('Cart Profile')
% legend('Pos', 'Vel')
% hold off

% % angular position and velocity of pendulum
% figure(2)
% hold on
% yyaxis left
% plot(t, q(:,3))
% ylabel('Pos [rad]')
% yyaxis right
% plot(t, q(:,4))
% ylabel('Vel [rad/s]')
% title('Angular Profile')
% legend('Angular Position', 'Angular Velocity') 
% hold off

% proportional input vs. time
figure(3)
hold on
plot(t, q(:,6))
title('Proportional Input Plot')
ylabel('Kp')
xlabel('Time [s]')
hold off

% integral input vs. time
figure(4)
hold on
plot(t, q(:,7))
title('Integral Input Plot')
ylabel('Ui')
xlabel('Time [s]')
hold off

% % plot input variable
% figure(5)
% hold on
% plot(t, q(:,6)+q(:,7))
% title('Input')
% ylabel('Input vs. Time')
% xlabel('Time')
% hold off

% % animate link motion
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1),...
%              q(:,4)-adj, zeros(n,1)]', T(2)-T(1));