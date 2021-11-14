%% Project: Linear Inverted Pendulum Model
%  Complexity: 3 Links (actuated at ground)
%  Created by: Michael Napoli
%  Created on: 11/5/2021

%  Purpose: Model and control a 3-link
%           pendulum via the model predictive
%           control (MPC) architecture.

clc;clear;
close all;


%% Cost Function
Cq = {
      @(qc) (pi/2-qc(1))^2;  % cost of position of Link 1
      @(qc) (0.0 -qc(3))^2;  % cost of position of Link 2
      @(qc) (0.0 -qc(5))^2;  % cost of position of Link 3
     };


%% Variable Setup
% establish state space vectors and variables
P = 10;                   % prediction horizon [s]
dt = 0.05;                % change in time
T = 0:dt:20;              % time span
th1_0 = [pi/4;0.0];       % link 1 position and velocity
th2_0 = [0.0; 0.0];       % link 2 position and velocity
th3_0 = [0.0; 0.0];       % link 3 position and velocity
um = [1000; 500; 250];    % maximum input to joints
c = [10; 10; 10];         % damping coefficients

% create initial states
q0 = [
      th1_0;th2_0;th3_0;...       % initial joint states
      zeros(length(um),1);...     % return for inputs
      zeros(length(Cq),1);...     % return for cost
      0                           % iteration count
     ];


%% Implementation
tic
[~, q] = mpc_control(P, T, q0, um, c, Cq, 1e-6);
toc


%% Graphing and Evaluation
fprintf("Final Input at Link 1 ------------- %.4f [Nm]\n", q(length(q),7))
fprintf("Final Input at Link 2 ------------- %.4f [Nm]\n", q(length(q),8))
fprintf("Final Input at Link 3 ------------- %.4f [Nm]\n", q(length(q),9))
fprintf("Final Position of Link 1 ---------- %.4f [rad]\n", q(length(q),1))
fprintf("Final Velocity of Link 1 ---------- %.4f [rad/s]\n", q(length(q),2))
fprintf("Final Position of Link 2 ---------- %.4f [rad]\n", q(length(q),3))
fprintf("Final Velocity of Link 2 ---------- %.4f [rad/s]\n", q(length(q),4))
fprintf("Final Position of Link 3 ---------- %.4f [rad]\n", q(length(q),5))
fprintf("Final Velocity of Link 3 ---------- %.4f [rad/s]\n", q(length(q),6))
fprintf("Average Number of Iterations ------ %.4f [n]\n", sum(q(:,13))/length(q));

% velocity and position of link 1
figure('Position', [0 0 1400 800])
hold on
subplot(2,3,1)
yyaxis left
plot(T, q(:,1))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,2))
ylabel('Vel [rad/s]')
xlabel('Time')
title('Link 1')
legend('Pos', 'Vel')

% velocity and position of link 2
subplot(2,3,2)
yyaxis left
plot(T, q(:,3))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,4))
ylabel('Vel [rad/s]')
xlabel('Time')
title('Link 2')
legend('Pos', 'Vel')

% velocity and position of link 3
subplot(2,3,3)
yyaxis left
plot(T, q(:,5))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,6))
ylabel('Vel [rad/s]')
xlabel('Time')
title('Link 3')
legend('Pos', 'Vel')

% plot input on link 1
subplot(2,3,4)
plot(T, q(:,7))
title('Input on Link 1')
ylabel('Input [Nm]')
xlabel('Time')

% plot input on link 2
subplot(2,3,5)
plot(T, q(:,8))
title('Input on Link 2')
ylabel('Input [Nm]')
xlabel('Time')
hold off

% plot input on link 3
subplot(2,3,6)
plot(T, q(:,9))
title('Input on Link 3')
ylabel('Input [Nm]')
xlabel('Time')
hold off

% plot cost of link 1
figure('Position', [0 0 1400 400])
hold on
subplot(1,3,1)
plot(T, q(:,10))
title('Cost of Link 1')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% plot cost of link 2
subplot(1,3,2)
plot(T, q(:,11))
title('Cost of Link 2')
ylabel('Cost [unitless]')
xlabel('Time')

% plot cost of link 3
subplot(1,3,3)
plot(T, q(:,12))
title('Cost of Link 3')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% % animation of 3-link pendulum
% animation_3link(q, T, 3);