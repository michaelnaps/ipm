%% Project: LIPM_2d_2link
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

%% Task 2(a): simulation of the dynamics equation
T  = 10;                % time span

% initial variables, vertical rod
th1_0 = [pi/2; 0];      % angle 1 - position and vel.
th2_0 = [0; 0.01];      % angle 2 - position and vel.
th0 = [th1_0; th2_0];   % state space

% solve nonlinear function using ode45
[t, q] = ode45(@(t, q) statespace(t, q), [0 T], th0);

% plot values for theta 1 and 2
% theta 1
figure(1)
hold on
plot(t, q(:,1))
plot(t, q(:,3))
title('Angular Position')
legend('Theta1', 'Theta2')
hold off

% theta 2
figure(2)
hold on
plot(t, q(:,2))
plot(t, q(:,4))
title('Angular Velocity')
legend('Theta1', 'Theta2')
hold off

% run animation for double-arm inverted pendulum
% animation(q', 0.01);
% animation([q(:,1), q(:,3), q(:,2), q(:,4)]', 0.01);