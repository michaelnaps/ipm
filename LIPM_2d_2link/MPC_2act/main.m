%% Project: Linear Inverted Pendulum Model
%  Complexity: 2 Links (actuated at ground)
%  Created by: Michael Napoli
%  Created on: 11/5/2021

%  Purpose: Model and stabilize an actuated
%           linear inverted pendulum system made 
%           up of two connected rods.
%
%           The system will be contrtolled via
%           the torque at both pendulum joints.

clc;clear;
close all;


%% Cost Function
%           ang pos.        ang. vel.        cart pos.
% Cq = {
%       @(qc) (10*cos(pi)-10*cos(qc(1))).^2; % + (0-qc(4)).^2; % + (pd-qc(1))^2;
%       @(qc) (10*cos(0.)-10*cos(qc(3))).^2;
%      };

Cq = {
      @(qc) (pi -qc(1)).^2;     % cost of position of Link 1
      @(qc) (0.0-qc(3)).^2;  % cost of position of Link 2
     };

 
%% Variable Setup
% establish state space vectors and variables
P = 4;                    % prediction horizon
dt = 0.05;                % change in time
T = 0:dt:10;              % time span
th1_0 = [pi; 2.3];        % cart position and velocity
th2_0 = [0.; 0.0];        % angular position and velocity
um = [1000; 1000];        % maximum input to joints
% minimum maximum inputs for full range ~ [400 300]

% create initial states
q0 = [
        th1_0;th2_0;...             % joint states
        zeros(length(um),1);...     % return for inputs
        zeros(length(Cq),1);...     % return for cost
        0                           % iteration count
     ];

% Damping Coefficients
% (interesting behavior when c1 < 20)
c1 = 50;
c2 = c1;


%% Implementation
tic
[T, q] = mpc_control(P, T, q0, um, c1, c2, Cq, 1e-6);
toc


%% Graphing and Evaluation
fprintf("Final Input at Link 1 ------------- %.4f [N]\n", q(length(q),5))
fprintf("Final Input at Link 2 ------------- %.4f [N]\n", q(length(q),6))
fprintf("Final Position of Link 1 ---------- %.4f [m]\n", q(length(q),1))
fprintf("Final Velocity of Link 1 ---------- %.4f [m/s]\n", q(length(q),2))
fprintf("Final Position of Link 2 ---------- %.4f [rad]\n", q(length(q),3))
fprintf("Final Velocity of Link 2 ---------- %.4f [rad/s]\n", q(length(q),4))
fprintf("Average Number of Iterations ------ %.4f [n]\n", sum(q(:,9))/length(q));

% percent overshoot
PO = (abs(max(q(:,1)) / q(length(q),1)) - 1)*100;
fprintf("Percent Overshoot on Link 1 ------- %.4f [%%]\n", PO)

% velocity and position of cart
figure('Position', [0 0 1400 800])
hold on
subplot(2,2,1)
yyaxis left
plot(T, q(:,1))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,2))
ylabel('Vel [rad/s]')
xlabel('Time')
title('Link 1')
legend('Pos', 'Vel')

% angular position and velocity of pendulum
subplot(2,2,2)
yyaxis left
plot(T, q(:,3))
ylabel('Pos [rad]')
yyaxis right
plot(T, q(:,4))
ylabel('Vel [rad/s]')
xlabel('Time')
title('Link 2')
legend('Angular Position', 'Angular Velocity')

% plot input variable
subplot(2,2,3)
plot(T, q(:,5))
title('Input on Link 1')
ylabel('Input [Nm]')
xlabel('Time')

% plot cost from mpc controller
subplot(2,2,4)
plot(T, q(:,6))
title('Input on Link 2')
ylabel('Input [Nm]')
xlabel('Time')
hold off

% plot cost of link 1
figure('Position', [0 0 700 400])
subplot(1,2,1)
plot(T, q(:,7))
title('Cost of Link 1')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% plot cost of link 2
subplot(1,2,2)
plot(T, q(:,8))
title('Cost of Link 2')
ylabel('Cost [unitless]')
xlabel('Time')
hold off

% % animate link motion
% animation_2link(q, dt);