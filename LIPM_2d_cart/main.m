%% Project: LIPM_2d_cart
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
T = 10;                  % time span
s = [0; 0];             % cart position and velocity
th = [pi/2; 0.1];      % angular position and velocity
q0 = [s; th];           % state space

% solve for time dependent solution
[t, q] = ode45(@(t, q) statespace_sol(q, 0), [0 T], q0);

% plot angular and linear velocities
figure(1)
hold on
plot(t, q(:,1))
plot(t, q(:,2))
title('Cart Profile')
legend('Cart Position', 'Cart Velocity') 
hold off

figure(2)
hold on
plot(t, q(:,3))
plot(t, q(:,4))
title('Angular Profile')
legend('Angular Position', 'Angular Velocity') 
hold off