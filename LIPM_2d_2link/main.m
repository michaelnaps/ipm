%% Project: Linear Inverted Pendulum Model
%  Complexity: 2 Links (actuated at ground)
%  Created by: Michael Napoli
%  Created on: 9/14/2021

%  Purpose: Model and stabilize an underactuated
%           linear inverted pendulum system made up
%           of two connected rods.
%
%           The system will be contrtolled via
%           the torque input on the bottom rod.

clc;clear;
close all;

% time span
T = 30;
adj = pi/2;

% initial variables, vertical rod
th1_0 = [pi/2+adj; 0];      % angle 1 - position and vel.
th2_0 = [0+adj; 0.1];       % angle 2 - position and vel.
th0 = [th1_0; th2_0];   % initial state space values

% solve nonlinear function using ode45
[t, q] = ode45(@(t, q) statespace(q,0,10), [0 T], th0);

% % plot values for theta 1 and 2
% % theta 1
% figure(1)
% hold on
% plot(t, q(:,1))
% plot(t, q(:,3))
% title('Angular Position')
% legend('Theta1', 'Theta2')
% hold off
% 
% % theta 2
% figure(2)
% hold on
% plot(t, q(:,2))
% plot(t, q(:,4))
% title('Angular Velocity')
% legend('Theta1', 'Theta2')
% hold off

% run animation for double-arm inverted pendulum
% animation(q', 0.01);
animation([q(:,1)-adj, q(:,3), q(:,2)-adj, q(:,4)]', 0.01);