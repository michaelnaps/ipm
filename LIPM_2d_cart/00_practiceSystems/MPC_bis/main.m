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


%% Variable Setup
% establish state space vectors and variables
P = 4;                    % prediction horizon
dt = 0.1;                 % change in time
T = 0:dt:20;              % time span
s0 = [0; 0];              % cart position and velocity
th0 = [pi; 0.5];          % angular position and velocity
q0 = [s0;th0;0;0];        % initial state space
um = 1000;                % maximum input change

% Damping Coefficients
% (interesting behavior when c1 < 20)
c1 = 50;
c2 = 2*c1;

% Desired Final Position (cart)
% pd = 1;

%% Cost Function
%           ang pos.        cart pos.         ang. vel.
pd = 4;
Cq = @(qc) (pi-qc(3)).^2; % + (pd-qc(1))^2; % + (0-qc(4)).^2;

%% Implementation
% solve for time dependent solution
tic
[T, q] = mpc_control(P, T, q0, um, c1, c2, Cq, 1e-6);
t_opt = toc;

%% Graphing and Evaluation
fprintf("Final Input on Cart ----------------- %.4f [N]\n", q(length(q),5))
fprintf("Final Position of Cart -------------- %.4f [m]\n", q(length(q),1))
fprintf("Final Velocity of Cart -------------- %.4f [m/s]\n", q(length(q),2))
fprintf("Final Position of Pendulum ---------- %.4f [rad]\n", q(length(q),3))
fprintf("Final Velocity of Pendulum ---------- %.4f [rad/s]\n", q(length(q),4))

% percent overshoot
PO = (abs(max(q(:,3)) / q(length(q),3)) - 1)*100;
fprintf("Percent Overshoot ------------------- %.4f [%%]\n", PO)

% comparison to MPC search speed
t_search = 22.230988;
PI = t_search / t_opt;
fprintf("Percent Improvement from Search ----- %.4fx\n\n", PI)

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
plot(T, q(:,5))
title('Input vs. Time')
ylabel('Input [N]')
xlabel('Time')

% plot cost from mpc controller
subplot(2,2,4)
plot(T, q(:,6))
title('Cost')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% % animate link motion
% adj = pi/2;
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1), q(:,4)-adj, zeros(n,1)]', dt);