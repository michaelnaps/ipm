%% Environment Setup
clc;clear;
close all;

restoredefaultpath
addpath ../.

%% Variable Setup
dt_euler = 0.0025;
T_euler = 0:dt_euler:50*dt_euler;

dt_ode45 = 0.025;
T_ode45 = 0:dt_ode45:5*dt_ode45;

u = [3000; 2000; 1500];

c = [500; 500; 500];            % damping coefficients
m = [15; 15; 60];
L = [0.5; 0.5; 1];

th1_0 = [pi/2;0.0];             % link 1 position and velocity
th2_0 = [0.0; 2.0];             % link 2 position and velocity
th3_0 = [0.0; 0.0];             % link 3 position and velocity

q0 = [th1_0;th2_0;th3_0];

%% ODE Comparison Functions
% statespace(q, u, c, m, L)
tic
[~,q_ode45] = ode45(@(t,q) statespace(q,u,c,m,L), T_ode45, q0);
toc

tic
q_euler = ode_euler(50, dt_euler, q0, u, c, m, L);
toc

%% Plot results to compare
% velocity and position of link 1
figure('Position', [0 0 1400 800])
hold on
subplot(1,3,1)
hold on
plot(T_euler, q_euler(:,1))
plot(T_ode45, q_ode45(:,1))
hold off
ylabel('Pos [rad]')
xlabel('Time')
title('Link 1')
legend('euler', 'ode45')

% velocity and position of link 2
subplot(1,3,2)
hold on
plot(T_euler, q_euler(:,3))
plot(T_ode45, q_ode45(:,3))
hold off
ylabel('Pos [rad]')
xlabel('Time')
title('Link 2')
legend('euler', 'ode45')

% velocity and position of link 3
subplot(1,3,3)
hold on
plot(T_euler, q_euler(:,5))
plot(T_ode45, q_ode45(:,5))
hold off
ylabel('Pos [rad]')
xlabel('Time')
title('Link 3')
legend('euler', 'ode45')