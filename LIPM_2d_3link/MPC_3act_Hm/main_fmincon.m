%% Project: Linear Inverted Pendulum Model
%  Complexity: 3 Links (actuated at ground)
%  Created by: Michael Napoli
%  Created on: 11/5/2021

%  Purpose: Model and control a 3-link
%           pendulum via the model predictive
%           control (MPC) architecture.

clc;clear;
close all;

restoredefaultpath
addpath ../.
addpath ../03_fmincon
% addpath ../04_fmincon_nP


%% Cost Function
th1d =  pi/4;
th2d =  pi/2; 
th3d = -pi/4;
veld = 0;
Cq = @(q) [
      100*((cos(th1d) - cos(q(1)))^2 + (sin(th1d) - sin(q(1)))^2) + (veld - q(2))^2;% + 5e-8*(du(1))^2;  % cost of Link 1
      100*((cos(th2d) - cos(q(3)))^2 + (sin(th2d) - sin(q(3)))^2) + (veld - q(4))^2;% + 1e-7*(du(2))^2;  % cost of Link 2
      100*((cos(th3d) - cos(q(5)))^2 + (sin(th3d) - sin(q(5)))^2) + (veld - q(6))^2;% + 5e-7*(du(3))^2;  % cost of Link 3
     ];


%% Variable Setup
% parameters for mass and length
m = [15; 15; 60];
L = [0.5; 0.5; 1];
% establish state space vectors and variables
P = 4;                          % prediction horizon [time steps]
dt = 0.025;                     % change in time
T = 0:dt:10;                    % time span
th1_0 = [pi/2;0.0];             % link 1 position and velocity
th2_0 = [0.0; 2.0];             % link 2 position and velocity
th3_0 = [0.0; 0.0];             % link 3 position and velocity
um = [3000; 2000; 1500];        % maximum input to joints
c = [500; 500; 500];            % damping coefficients

% create initial states
q0 = [
      th1_0;th2_0;th3_0;...       % initial joint states
      zeros(size(um));...         % initial inputs
      0;
      0;
      0
     ];


%% Implementation
[~, q] = mpc_control(P, T, q0, um, c, m, L, Cq);

%% Calculate Center of Mass for Animation
CoM = map_CoM(q, m, L);

%% Linear Calc. Time Trend
[a0, a1, err] = linear_ls(q(:,11), q(:,12));
itertime = @(n) a1*n + a0;

%% Graphing and Evaluation
fprintf("Total Runtime: -------------------- %.4f [s]\n", sum(q(:,12)))
fprintf("Final Input at Link 1 ------------- %.4f [Nm]\n", q(length(q),7))
fprintf("Final Input at Link 2 ------------- %.4f [Nm]\n", q(length(q),8))
fprintf("Final Input at Link 3 ------------- %.4f [Nm]\n", q(length(q),9))
fprintf("Final Position of Link 1 ---------- %.2fpi [rad]\n", q(length(q),1)/pi)
fprintf("Final Velocity of Link 1 ---------- %.4f [rad/s]\n", q(length(q),2))
fprintf("Final Position of Link 2 ---------- %.2fpi [rad]\n", q(length(q),3)/pi)
fprintf("Final Velocity of Link 2 ---------- %.4f [rad/s]\n", q(length(q),4))
fprintf("Final Position of Link 3 ---------- %.2fpi [rad]\n", q(length(q),5)/pi)
fprintf("Final Velocity of Link 3 ---------- %.4f [rad/s]\n", q(length(q),6))
fprintf("Average Number of Iterations ------ %.4f [n]\n", sum(q(:,11))/length(q));

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

% plot input on link 3
subplot(2,3,6)
plot(T, q(:,9))
title('Input on Link 3')
ylabel('Input [Nm]')
xlabel('Time')
hold off

% calculation time of bisection
figure('Position', [0 0 700 800])
hold on
subplot(2,1,1)
plot(T, q(:,12))
title('Calculation time of fmincon')
ylabel('Calculation Time [s]')
xlabel('Runtime [s]')

% calculation time vs. iteration count
subplot(2,1,2)
hold on
plot(q(:,11), q(:,12), '.', 'markersize', 10)
fplot(itertime, [0 max(q(:,11))+2])
hold off
title('fmincon Time vs. Iteration Count')
ylabel('Calculation Time [s]')
xlabel('Iteration Count [n]')
hold off

% % animation of 3-link pendulum
% animation_3link(q, T, m, L);