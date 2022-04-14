%% Project: Linear Inverted Pendulum Model
%  Complexity: Single Link
%  Created by: Michael Napoli
%  Created on: 9/22/2021

%  Purpose: Simulate a linear inverted pendulum model with
%       1-DOF and actuated by the ground connection. Create
%       conrol system to reach equilibrium at theta = pi/2.

clc;clear;
close all;

addpath ../.

% animation adjustment and time span
T = 5;      % [s]

% initial conditions and tracking variables for gains
q0 = [-0.1;0;0;0];  % joint pos and joint vel

% solve nonlinear state space
[T,q] = ode45(@(t,q) statespace_lapm(q,0,1), [0 T], q0);

% % simulate process
m = 10;  H = 1;
animation_lapm(q, T, m, H);
