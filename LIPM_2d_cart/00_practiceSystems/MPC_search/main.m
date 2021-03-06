%% Project: Linear Inverted Pendulum Model
%  Complexity: Cart (actuated by cart movement)
%  Created by: Michael Napoli
%  Created on: 9/13/2021

%  Purpose: Model an underactuated linear inverted 
%           pendulum system connected to a moving
%           block with the goal of reaching equilibrium
%            by adjusting the force applied to said
%           block.

clear;
close all;


%% Setup
% establish state space vectors
um = 1000;                % maximum input change
dt = 0.1;                 % change in time
T = 0:dt:20;              % time span
P = 4;                    % prediction horizon
s0 = [0; 0];              % cart position and velocity
th0 = [pi; 3.1];          % angular position and velocity
q0 = [s0;th0;0;0;0];      % initial state space

% Damping Coefficients
c1 = 50;
c2 = 2*c1;

% Desired Final Position (cart)
% pd = 1;

%% Cost Function
% linear quadratic regulator (based on error)
%          ang pos.       cart pos.      ang. vel.     prev. input
C = @(qc) (pi-qc(3))^2; % + (pd-qc(1))^2; % + (qc(5)-qc(6))^2;

%% Implementation
% solve for time dependent solution
tic
[T, q] = mpc_control(q0, T, P, um, c1, c2, C);
toc

%% Graphing and Evaluation
disp("Final Input on Cart: " + q(length(q),5) + " [N]")
disp("Final Position of Cart: " + q(length(q),1) + " [m]")
disp("Final Velocity of Cart: " + q(length(q),2) + " [m/s]")
disp("Final Position of Pendulum: " + q(length(q),3) + " [rad]")
disp("Final Velocity of Pendulum: " + q(length(q),4) + " [rad/s]")

% percent overshoot
PO = (abs(max(q(:,3)) / q(length(q),3)) - 1)*100;
disp("Percent Overshoot: " + PO + " [%]")

% velocity and position of cart
figure('Position', [0 0 1400 800])
hold on
subplot(2,2,1)
yyaxis left
plot(T, q(:,1))
ylabel('Position [m]')
yyaxis right
plot(T, q(:,2))
ylabel('Velocity [m/s]')
title('Cart Profile')
legend('Pos', 'Vel')

% angular position and velocity of pendulum
subplot(2,2,2)
yyaxis left
plot(T, q(:,3))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,4))
ylabel('Vel [rad/s]')
title('Angular Profile')
legend('Angular Position', 'Angular Velocity')

% plot input variable
subplot(2,2,3)
plot(T, q(:,6))
% plot(t, q(:,5)-um)
% plot(t, q(:,5)+um)
title('Input vs. Time')
ylabel('Input [N]')
xlabel('Time')

% plot cost from mpc controller
subplot(2,2,4)
plot(T, q(:,7))
title('Cost')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% % animate link motion
% adj = pi/2;
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1), q(:,4)-adj, zeros(n,1)]', dt);