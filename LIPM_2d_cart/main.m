%% Project: Linear Inverted Pendulum Model
%  Complexity: 1 Link and Cart (actuated at cart)
%  Created by: Michael Napoli
%  Created on: 1/16/2022
%
%  Purpose: Model and control a cart and
%           pendulum system via the model predictive
%           control (MPC) architecture.

restoredefaultpath

clc;clear;
close all;

addpath ./01_primary
addpath ./02_newtons

%% External Disturbance Testing
push = [];

position = [
     0.00, 0.00;
     1.25, 3.00
    ];

%% Mass, Length, Height and Angle Constants
% parameters for mass and length
m = [100; 10];
L = [0.0; 2.0];  % cart L always 0

%% Cost Function
qd0 = [pi/2; 0.00; position(1,2); 0.00];
Cq = @(qd, q, du) [
      100*(qd(1) - q(1))^2 + (qd(2) - q(2))^2 + 1e-7*(du(1))^2;                                           % cost of Cart
      100*((cos(qd(3)) - cos(q(3)))^2 + (sin(qd(3)) - sin(q(3)))^2) + (qd(4) - q(4))^2 + 1e-7*(du(2))^2;  % cost of Link
     ];

%% Variable Setup
% establish state space vectors and variables
P = 4;                          % prediction horizon [time steps]
dt = 0.025;                     % change in time
T = 0:dt:10;                    % time span
pos_0 = [qd0(1); qd0(2)];       % cart position and velocity
th_0 =  [qd0(3); 0.0];          % link position and velocity
um = [3000; 0];                 % maximum input to link and cart
c = [500; 500];                 % damping coefficients

% create initial states
q0 = [
      pos_0;th_0;                 % initial joint states
      0; 0;                       % initial inputs
      0;                          % return for cost
      0;                          % iteration count
      0                           % runtime of opt. function
     ];

%% Implementation
eps = 1e-6;
[~, q] = mpc_control(P, T, q0, um, c, m, L, Cq, qd0, eps, position, push);

%% Calc. Time Trend
N = length(q(:,8));
[a] = polynomial_fit(q(2:N,8), q(2:N,9), 3);
nntime = @(n) a(4)*n.^3 + a(3)*n.^2 + a(2)*n + a(1);
err = sum((q(2:N,9) - nntime(q(2:N,8))).^2);

%% Graphing and Evaluation
fprintf("Total Runtime: -------------------- %.4f [s]\n", sum(q(:,9)))
fprintf("Final Input at Cart ------------- %.4f [Nm]\n", q(length(q),5))
fprintf("Final Input at Link ------------- %.4f [Nm]\n", q(length(q),6))
fprintf("Final Position of Cart ---------- %.4fpi [rad]\n", q(length(q),1)/pi)
fprintf("Final Velocity of Cart ---------- %.4f [rad/s]\n", q(length(q),2))
fprintf("Final Position of Link ---------- %.4fpi [rad]\n", q(length(q),3)/pi)
fprintf("Final Velocity of Link ---------- %.4f [rad/s]\n", q(length(q),4))
fprintf("Average Number of Iterations ------ %.4f [n]\n", sum(q(:,8))/length(q));

% velocity and position of cart
figure('Position', [0 0 1400 800])
hold on
subplot(2,2,1)
yyaxis left
plot(T, q(:,1))
ylabel('Pos [m]')
yyaxis right
plot(T, q(:,2))
ylabel('Vel [m/s]')
xlabel('Time [s]')
title('Cart')
legend('Pos', 'Vel')

% velocity and position of link
subplot(2,2,2)
yyaxis left
plot(T, q(:,3))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,4))
ylabel('Vel [rad/s]')
xlabel('Time [s]')
title('Link')
legend('Pos', 'Vel')

% plot input on cart
subplot(2,2,3)
plot(T, q(:,5))
title('Input on Cart')
ylabel('Input [N]')
xlabel('Time [s]')

% plot input on link
subplot(2,2,4)
plot(T, q(:,6))
title('Input on Link')
ylabel('Input [Nm]')
xlabel('Time [s]')
hold off

% Cost vs. Time [s]
figure('Position', [0 0 1400 400])
plot(T, q(:,7))
title('Cost Trend')
ylabel('Cost')
xlabel('Time [s]')

% calculation time of Newtons Method
figure('Position', [0 0 700 800])
hold on
subplot(2,1,1)
plot(T, 1000*q(:,9))
title('Calculation time of Newtons Method')
ylabel('Calculation Time [ms]')
xlabel('RunTime [s]')

% calculation time vs. iteration count
nrange = 0:0.1:max(q(:,8))+1;
subplot(2,1,2)
hold on
plot(q(:,8), 1000*q(:,9), '.', 'markersize', 10)
plot(nrange, 1000*nntime(nrange))
hold off
title('Newtons Method Time [s] vs. Iteration Count')
ylabel('Calculation Time [ms]')
xlabel('Iteration Count [n]')
hold off

% % animation of cart and pendulum
% animation_cart(q, T, m, L);