%% Project: LIPM_3d_1link
%  Complexity: 3D with Single Link
%  Created by: Michael Napoli
%  Created on: 10/5/2021

%  Purpose: Simulate a linear inverted pendulum model with
%       3-DOF and actuated by the ground connection. Create
%       conrol system to reach equilibrium at theta = pi/2.

clc;clear;
close all;

% time span and adjustment angle
T = 30;
adj = pi/2;

% initial state space
% order: 
q0 = [pi/4+adj, 0, pi/2+adj, 0.1, 0];

% nonlinear state space solver
% damper is same for both angle directions
[t, q] = ode45(@(t,q) statespace(q,0,0,50), [0 T], q0);

% animation - theta
n = length(q(:,1));
animation([q(:,1)-adj, zeros(n,1), q(:,2), zeros(n,1)]', 0.01, 1);

% % animation - azimuth
% n = length(q(:,3));
% animation([q(:,3)-adj, zeros(n,1), q(:,4), zeros(n,1)]', 0.01, 2);

% % Theta
% figure(3)
% hold on
% yyaxis left
% plot(t, q(:,1));
% yyaxis right
% plot(t, q(:,2));
% title('Theta')
% legend('Pos', 'Vel')
% hold off

% Azimuth
figure(4)
hold on
yyaxis left
plot(t, q(:,5));
yyaxis right
plot(t, q(:,4));
title('Azimuth')
legend('Pos', 'Vel')
hold off