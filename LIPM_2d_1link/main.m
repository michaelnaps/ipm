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
T = 100;                 % [s]
th0 = [pi/2, 0.1];     % joint pos and joint vel

% solve nonlinear state space
[t,q] = ode45(@(t,q) statespace(q,0), [0 T], th0);

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

% simulate process
n = length(q(:,1));
animation([q(:,1), zeros(n,1), q(:,2), zeros(n,1)]', 0.01)
