%% Environment Setup
clc;clear;
close all;

restoredefaultpath
addpath ../.

%% Variable Setup
dt = 0.025
T = 0:dt:20;

c = [500; 500; 500];            % damping coefficients
m = [15; 15; 60];
L = [0.5; 0.5; 1];

th1_0 = [pi/2;0.0];             % link 1 position and velocity
th2_0 = [0.0; 2.0];             % link 2 position and velocity
th3_0 = [0.0; 0.0];             % link 3 position and velocity

q0 = [th1_0;th2_0;th3_0];

%% ODE Comparison Functions
% statespace(q, u, c, m, L)
[~,q_ode45] = ode45(@(t,q) statespace(q,[0;0;0],c,m,L), T, q0);
q_euler = ode_euler(20/dt, dt, q0, [0;0;0], c, m, L);