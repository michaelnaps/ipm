%% Finite Difference Method Testing
%  Created by: Michael Napoli
%  Created on: 12/22/2021

clc;clear;
close all;

addpath ../.

%% Cost Function
th1d = pi/2;
th2d = 0.0; 
th3d = 0.0;
veld = 0;
Cq = @(q) [
      100*(th1d - q(1))^4 + (veld - q(2))^4;  % + 5e-8*(du(1))^4;  % cost of Link 1
      100*(th2d - q(3))^4 + (veld - q(4))^4;  % + 1e-7*(du(2))^4;  % cost of Link 2
      100*(th3d - q(5))^4 + (veld - q(6))^4;  % + 5e-7*(du(3))^4;  % cost of Link 3
     ];

%% Variable Setup
% parameters for mass and length
m = [15; 15; 60];
L = [0.5; 0.5; 1];
% establish state space vectors and variables
P = 4;                          % prediction horizon [time steps]
dt = 0.025;                     % change in time
T = 0:dt:10;                    % time span
th1_0 = [pi/4;0.0];             % link 1 position and velocity
th2_0 = [0.0; 0.0];             % link 2 position and velocity
th3_0 = [0.0; 0.0];             % link 3 position and velocity
um = [3000; 2000; 1500];        % maximum input to joints
c = [500; 500; 500];            % damping coefficients

% create initial states
q0 = [
      th1_0;th2_0;th3_0;...       % initial joint states
      zeros(size(um));...         % initial inputs
      0;                          % return for cost
      0;                          % iteration count
      0                           % runtime of opt. function
     ];

%% Use fmincon for Jacobian Comparison
options = optimoptions('fmincon','Display','iter-detailed');
[u, C, eflag, o, ~, G_fmincon] = fmincon(@(u) cost(P,dt,q0(1:6),u,c,m,L,Cq,'fmincon'),q0(7:9),[],[],[],[],-um,um,[],options);
eflag
G_fmincon

%% Jacobian Calculation
[G_cost, h] = costgradient_2pc(P, dt, q0(1:6), u, c, m, L, Cq, 1e-4)
[G_cost2, h] = costgradient_4pc(P, dt, q0(1:6), u, c, m, L, Cq, 1e-4)