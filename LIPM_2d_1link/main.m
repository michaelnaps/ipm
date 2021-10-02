%% Project: Linear Inverted Pendulum Model
%  Complexity: Single Link
%  Created by: Michael Napoli
%  Created on: 9/22/2021

%  Purpose: Simulate a linear inverted pendulum model with
%       1-DOF and actuated by the ground connection. Create
%       conrol system to reach equilibrium at theta = pi/2.

clc;clear;
close all;

% time span and initial state variables
adj = pi/2;             % for animation function adjustment [rad]
T = 60;                 % [s]
th0 = [pi/2+adj, 0.01];    % joint pos and joint vel

% solve nonlinear state space
[t,q] = ode45(@(t,q) statespace(q,1000,50), [0 T], th0);

% % angular position
% figure(1)
% hold on
% plot(t, q(:,1));
% title('Angular Position')
% hold off
% 
% % angular velocity
% figure(2)
% hold on
% plot(t, q(:,2));
% title('Angular Velocity')
% hold off

% % proportional gain vs. angular position
% figure(3)
% hold on
% plot(t, q(:,3))
% title('Proportional Gain Plot')
% xlabel('Time [s]')
% ylabel('Gain [Kp]')
% hold off

% % simulate process
n = length(q(:,1));
animation([q(:,1)-adj, zeros(n,1), q(:,2)-adj, zeros(n,1)]', 0.01)
