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
T = 30;      % [s]

% initial conditions and tracking variables for gains
q0 = [pi/2-1; 0; 0; 0; 0];  % joint pos and joint vel

% solve nonlinear state space
[T,q] = ode45(@(t,q) statespace(q,50,800,800,800), [0 T], q0);

% % simulate process
m = 10;  L = 1;
animation_1link(q, T, m, L);
