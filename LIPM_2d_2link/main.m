clc;clear;
close all;

%% Task 2(a): simulation of the dynamics equation
q0 = [pi/2; 0]; % joint angles
dq0 = [0.01;0.0];% joint velocties
x0 = [q0; dq0];  % states = [joint angles; joint velocities]
T  = 10;         % time span
[t, x] = ode45(@(t,x)dynFunc(x,0),[0 T], x0); % u=0

% run animation for double-arm inverted pendulum
animation(x',0.01)