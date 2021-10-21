%% Project: Linear Inverted Pendulum Model
%  Complexity: Cart (actuated by cart movement)
%  Created by: Michael Napoli
%  Created on: 9/13/2021

%  Purpose: Model an underactuated linear inverted 
%           pendulum system connected to a moving
%           block with the goal of reaching equilibrium
%            by adjusting the force applied to said
%           block.

clc;clear;
close all;

% establish state space vectors
adj = pi/2;
dt = 0.1;                       % change in time
T = 0:dt:60;                    % time span
p = [dt; 2];                    % prediction horizon
s0 = [0; 0];                    % cart position and velocity
th0 = [pi; 0.2];                % angular position and velocity
q0 = [s0; th0; 0; 0; 0; 0; 0];     % initial state space

% solve for time dependent solution
[T, q] = ode45(@(t,q) pid_control(q,50,50,1100,10,0,0,1000), T, q0);

% final angle at end of simulation
disp("Final Velocity of Cart: " + q(length(q),2) + " [m/s]")
disp("Final Position of Pendulum: " + q(length(q),3) + " [rad]")
disp("Final Velocity of Pendulum: " + q(length(q),4) + " [rad/s]")

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

% proportional input
subplot(2,2,3)
plot(T, q(:,6)+q(:,7)+q(:,8))
title('Total Input')
ylabel('U')
xlabel('Time [s]')
xlabel('Time')

% integral and derivative input
subplot(2,2,4)
yyaxis left
plot(T, q(:,6))
ylabel('Up')
yyaxis right
hold on
plot(T, q(:,7))
plot(T, q(:,8))
ylabel('Ui, Ud')
hold off
title('Input Variables')
xlabel('Time [s]')
legend('Proportional', 'Integral', 'Derivative')
hold off

% % animate link motion
% n = length(q(:,1));
% animation([q(:,3)-adj, zeros(n,1),...
%              q(:,4)-adj, zeros(n,1)]', T(2)-T(1));