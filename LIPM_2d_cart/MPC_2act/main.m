%% Project: Linear Inverted Pendulum Model
%  Complexity: Cart and Pendulum Model with 2 Control Points
%  Created by: Michael Napoli
%  Created on: 11/8/2021

%  Purpose: Model and stabilize an actuated
%           linear inverted pendulum system made up
%           of a pendulum connected to a moving 
%           cart.
%
%           The system will be contrtolled via
%           input on the cart and pendulum joint.

clc;clear;
close all;


%% Variable Setup
% establish state space vectors and variables
P = 4;                      % prediction horizon
dt = 0.05;                  % change in time
T = 0:dt:10;                % time span
s0  = [0.; 0.0];            % cart position and velocity
th0 = [pi; 1.5];            % angular position and velocity
q0 = [s0;th0;0;0;0;0;0];    % initial state space
um = [1000; 1000];          % maximum input change

% Damping Coefficients
% (interesting behavior when c1 < 20)
c1 = 50;
c2 = 2*c1;

%% Cost Function
pd = 10;  % desired final position of cart
Cq = {
      @(qc) (pd-qc(1)).^2;  % cost of cart loc.
      @(qc) (pi-qc(3)).^2;  % cost of pendulum loc.
     };

%% Implementation
% solve for time dependent solution
tic
[T, q] = mpc_control(P, T, q0, um, c1, c2, Cq, 1e-6);
toc

%% Graphing and Evaluation
fprintf("Final Input on Cart ------------- %.4f [N]\n", q(length(q),5))
fprintf("Final Input at Pendulum --------- %.4f [N]\n", q(length(q),6))
fprintf("Final Position of Cart ---------- %.4f [m]\n", q(length(q),1))
fprintf("Final Velocity of Cart ---------- %.4f [m/s]\n", q(length(q),2))
fprintf("Final Position of Pendulum ------ %.4f [rad]\n", q(length(q),3))
fprintf("Final Velocity of Pendulum ------ %.4f [rad/s]\n", q(length(q),4))
fprintf("Average Number of Iterations ---- %.4f [n]\n", sum(q(:,9))/length(q));

% percent overshoot
PO = (abs(max(q(:,3)) / q(length(q),3)) - 1)*100;
fprintf("Percent Overshoot on Pendulum --- %.4f [%%]\n", PO)

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
title('Input on Cart')
ylabel('Input [N]')
xlabel('Time')

% plot cost from mpc controller
subplot(2,2,4)
plot(T, q(:,6))
title('Input on Pendulum')
ylabel('Input [Nm]')
xlabel('Time')
hold off

% plot cost of Pendulum
figure('Position', [0 0 700 400])
subplot(1,2,1)
plot(T, q(:,7))
title('Cost of Cart Pos.')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% plot cost of link 2
subplot(1,2,2)
plot(T, q(:,8))
title('Cost of Pendulum')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% % animate link motion
% adj = pi/2;
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1), q(:,4)-adj, zeros(n,1)]', dt);